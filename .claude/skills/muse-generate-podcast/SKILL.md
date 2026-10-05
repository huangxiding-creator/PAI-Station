---
name: muse-generate-podcast
description: Use when composed spoken audio is needed — a podcast episode, audio briefing, or narrated summary with one or more voices (script writing, voice casting, cover art, feed publishing, recurring schedules); for reading supplied text aloud verbatim use a plain TTS tool instead.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/generate_podcast/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills@`38bbb45`（非官方快照）中的 `generate_podcast` 技能。
> 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/generate_podcast/`（含 `SKILL.md`、`references/save-to-spotify.md`、vendored `save-to-spotify/` CLI）。
> 本版为本地适配移植版：忠实保留上游章节结构与实质规则；凡依赖 Muse 环境方能执行的指令均标注【Muse 环境专用】并改为参考式表述，在本机照抄执行会失败。

## 本环境适配

上游依赖逐条映射（未特别说明者，参考件均相对 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/generate_podcast/`）：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `podcast-helper` CLI（generate/publish/manifest/save-to-spotify） | 【Muse 环境专用】 | 本机无此命令。合成、目录、封面、发布的全部逻辑定义见 vendored 原件；本机产出音频须先落实替代通道，不得假装该 CLI 存在 |
| `tts` 技能 / `tts synthesize-script`（上游合成引擎） | 【Muse 环境专用】 | 本机无该技能；下文脚本口语化编写规范与失败重试纪律仍完全适用 |
| Meta AI 语音目录 `avocado_v2:MAI_01/MAI_03`；全量目录 `/opt/hatch/skills/voice-selector/voice_source.json` | 【Muse 环境专用】 | 本地快照 `../voice-selector/` 仅含 SKILL.md/README.md，`voice_source.json` 运行时数据未随快照落地；语音 id 体系本机不适用，仅作选型方法参考 |
| 封面生成 `media-generation` 技能 / `media.generate_image` | 【Muse 环境专用】 | 本机无该技能；封面规则可映射到本机任意可用图像生成通道 |
| 兜底封面 `/opt/hatch/skills/generate_podcast/default-cover.jpg` | 【Muse 环境专用】 | 快照中亦未随附该图片文件，仅规则可参考 |
| `cron` 工具（Muse 任务体 JSON、`timeout_secs: 1800`） | 【Muse 环境专用】 | 本机映射：Claude Code `CronCreate` 工具（会话级提醒层）或 OS 级 `schtasks`（持久定时，本机既定纪律） |
| `sandbox://workspace/podcasts/{slug}/{slug}.mp3` 试听链接 | 【Muse 环境专用】 | 本机映射：产物 MP3 的本地绝对路径或 `file://` 链接 |
| `~/MEMORY.md` 主播名↔语音配对记忆 | 【Muse 环境专用】 | 本机映射：Claude Code auto-memory（`C:/Users/91216/.claude/projects/e--AI-Station/memory/MEMORY.md`） |
| Spotify 连接器 OAuth（Settings → Connections → Spotify）与 `save-to-spotify` CLI | 【Muse 环境专用】 | 本机无该连接器；CLI 与 connect flow 全文档见 `references/save-to-spotify.md`，vendored CLI 在 `save-to-spotify/vendor/` |
| RSS 公共发布通道及内容审核（`"blocked": true` 判定） | 【Muse 环境专用】 | Muse VM 机制，本机不存在；发布/订阅流程仅作参考 |
| `JARVIS_PRESENTATION_LOCALE` 环境变量 | 【Muse 环境专用】 | 本机无；语言选择规则照常按会话语言执行 |

# Generate Podcast（移植正文）

> 以下忠实移植自上游。所有 `podcast-helper`、`save-to-spotify` 命令与 `/opt/hatch/...` 路径均为【Muse 环境专用】、本机不存在，保留原文以承载流程与规则；本机执行前须先按上表落实替代通道。

## Purpose
Generate audio content — podcasts, audio briefings, narrated summaries, or any spoken audio. Use this skill for all generated audio, not just podcasts. The `podcast-helper` script handles synthesis, catalog management, cover art generation, and publishing.【Muse 环境专用】

## Workflow

### 1. Plan
- **Topic and angle**
- **Speaker names and voices** — **prefer the Meta AI voices by default** (the `MAI_01` and `MAI_03` catalog ids: Warm and Smooth); they are the recommended, production-quality set and the right pick most of the time. Default to Warm (`avocado_v2:MAI_01`) and Smooth (`avocado_v2:MAI_03`). When the topic, tone, or user request steers toward a different catalog voice — an accent, a character fit, or more distinct speakers — it's perfectly fine to pick it from the catalog. The full voice catalog is at `/opt/hatch/skills/voice-selector/voice_source.json`【Muse 环境专用】 — pick by the entry's display `name` and pass its `id` (colon form like `avocado_v2:MAI_01` is fine). Any number of speakers is supported. ("MAI" is the internal id prefix only — say "Meta AI voices" or display names to the user, never "MAI".)
- **Host names** — give each speaker a real first name (e.g. Alex, Jordan). These are the show's own character names, chosen by you and separate from the voice display names: never label a speaker with a voice name like "Warm" or "Smooth". **Remember the name you give each voice** — record the pairing in `~/MEMORY.md`【Muse 环境专用：本机用 auto-memory】 (e.g. "podcast host Alex = avocado_v2:MAI_01") and, before naming a new host, check there for a name you've already used for that voice. Reuse the same name whenever you use that voice again, so a given voice is always the same character to the user. For a **recurring series**, reuse the same host names and the same voice assignments in every episode so it sounds like the same show — pin them in the cron task body (see Scheduling).
- **Target length** — 5–15 minutes; ~130 words/minute
- **Avoid repeating past episodes** — before settling the topic and angle, run `podcast-helper manifest read`【Muse 环境专用】 and look at each recent episode's `topics` field (a short summary of what that episode already covered). Steer the new episode toward fresh material or a genuinely new angle rather than re-covering ground. This matters most for a recurring series.

### 2. Write the script
Write the full dialogue. Label each turn with the speaker name followed by a colon:
```
Alex: Welcome to the podcast. Today we're diving into async Rust.
Jordan: Great topic. Let's start with why async matters.
Alex: The big advantage is zero-cost abstractions...
```

Write the script to a file (e.g. `/tmp/script.txt`).

**The script goes directly to a TTS model — write it in spoken form.** The text will be read aloud exactly as written. Follow these guidelines:

- **Numbers**: write out in full — "one hundred thousand", "forty-two dollars and fifty cents", "three point five percent"
- **Times**: "ten o'clock A M", "three thirty P M", "noon", "midnight"
- **Years**: "twenty twenty-five", "nineteen ninety-nine"
- **Abbreviations**: spell out — "U S A", "A P I" (pronounceable acronyms like "NASA" can stay)
- **URLs**: simplify — "example dot com link" instead of raw URLs
- **Email**: "john at company dot com"
- **Lists/data**: convert to natural sentences, limit to top 3–5 items
- **Punctuation**: use commas for natural pauses. If a sentence runs long, split it into two *complete* sentences — do not clip it into fragments.
- **Never include**: stage directions like `(pause)`, sound effects, markup, emoji, citation numbers like `[1]`, math symbols, or visual separators like `---`

**Write complete, conversational sentences — not headlines.** Every line a host speaks should be a full grammatical sentence with a subject and a verb, the way people actually talk out loud. Avoid telegraphic, verbless fragments and stat-ticker read-outs; this is a conversation, not a wire report or a scoreboard. An occasional short line for emphasis ("Unbelievable.") is fine, but never string clipped fragments together.

- Avoid: `Second assist of the night for Messi. Two one Argentina. Full time. Heartbreak for England.`
- Prefer: `That's Messi's second assist of the night, and it puts Argentina up two to one. When the whistle went, it was heartbreak for England.`

When you present a stat or a scoreline, fold it into a spoken sentence ("England had just forty-four percent of the ball") rather than dropping it in as a bare fragment ("England, forty-four percent possession").

### 3. Generate

**Write a topics summary for dedup.** Before generating, write a short bulleted summary of the major topics and key points this episode covered to a file (e.g. `/tmp/topics.md`) and pass it with `--topics-file`. Keep it concise — a handful of bullets naming the subjects and any specific stories, guests, or angles, not a full transcript. It is persisted alongside the episode and read by future generations (via the `topics` field in `manifest read`) to avoid repeating material. Example:
```
- Async Rust fundamentals: futures, executors, zero-cost abstractions
- Tokio vs async-std tradeoffs
- Common pitfalls: blocking in async contexts, .await forgetting
```

**Default: generate only, do not publish.** Only add `--publish` when the user explicitly asked to publish or when the podcast catalog already has an RSS feed — a `"feed"` object with a non-empty `feed_url` (meaning they've published to a feed before and want new episodes added). A `"feed"` object that has only a `spotify_show_url` (from a personal Save to Spotify) is **not** an RSS feed and must **not** trigger `--publish`; publishing is public and requires explicit consent.

Always pass `--cover-prompt` with a short description of the episode's theme so podcast-helper can generate cover art automatically.

**Do not pass `--cover-image`.** Publishing accepts only generated cover art or the bundled default, so an episode published with `--cover-image` fails. Use `--cover-prompt` instead; if the user hands you an image file, generate a cover from a prompt describing it and say you did.

**Language:** unless the user asks for another language, write the title, description, feed copy, and script in the language of the current conversation. `podcast-helper` defaults synthesis to the request's `JARVIS_PRESENTATION_LOCALE`【Muse 环境专用】; pass `--language` only to honor an explicit user choice. Quality varies significantly across languages — English is highest quality; other languages can be rough (mispronunciations, accent), and some voices handle a given language better than others (try a different `--speaker` voice if one sounds wrong). Tell the user non-English audio may be imperfect.

**One-off episode**（命令为上游原文，【Muse 环境专用】）:
```sh
podcast-helper generate \
  --script /tmp/script.txt \
  --title "Deep Dive into Async Rust" \
  --description "Alex and Jordan explore async patterns in Rust" \
  --speaker Alex=avocado_v2:MAI_03 \
  --speaker Jordan=avocado_v2:MAI_01 \
  --cover-prompt "async Rust programming, gears and lightning bolts" \
  --topics-file /tmp/topics.md
```

**Cron/recurring episode** — pass `--series-id` matching the cron job ID so episodes in the same series share cover art: first episode generates the cover, subsequent episodes with the same `--series-id` reuse it. Same shape as above plus `--series-id daily-news`. If publishing, append `--publish --feed-title "Daily with Alex"` (only under the consent rules above).

Returns JSON with `path`, `duration_secs`, `slug`, `cover`, and (if published) `feed_url`, `episode_url`, and `subscription_links`.

### 4. Deliver to chat
Always present the title as plain text above the playable link:
```
{title}
[{title}](sandbox://workspace/podcasts/{slug}/{slug}.mp3)
```
【Muse 环境专用：`sandbox://` 链接本机改为产物 MP3 本地路径】

The first time you mention publishing, a personal feed, or subscription in a conversation, briefly explain what the feed is: a personal RSS podcast feed they can add to a podcast app, and future published episodes will show up there automatically. After that first explanation, use shorter wording.

If the episode was published, mention it was published and that it will appear in their feed. Note that published episodes are public.

After delivering, present applicable follow-ups:
1. **If not published:** "Want me to publish this to a personal podcast feed? It's an RSS feed you can add to Apple Podcasts, Overcast, Pocket Casts, or most other podcast players, and future published episodes will show up there automatically. Note: published episodes are public — anyone with the link can listen."
2. **If no cron job exists:** "Generate a new episode every day?"

### 5. Publish (if not done in step 3)

```sh
podcast-helper publish \
  --slug {slug} \
  --feed-title "Daily with Alex" \
  --feed-description "Daily news and tech updates"
```
（【Muse 环境专用】）Returns JSON with `feed_url`, `episode_url`, and `subscription_links`.

Public publishing is content-reviewed. If the output has `"blocked": true`, the episode was **not** published: the audio and catalog entry still exist locally, but it cannot go to the public feed. Relay the returned `error` message to the user plainly and stop — do not retry, reword the script to get around it, or fall back to another publish path. Saving to the user's own Spotify show is unaffected by this review.

Publishing unifies artwork across the show it publishes to — individual episode and series covers for that feed's episodes are replaced with its cover in the podcast catalog. Another feed's episodes keep their own artwork.

After publishing, always re-present the listen link and confirm publication, repeating that published episodes are public — anyone with the feed link can listen.

### 6. Subscribe (after publishing)
On the first episode published to a feed, present subscription links from the output JSON: the RSS feed URL for copy-paste, plus podcast-app protocol links (Apple Podcasts / Overcast / Pocket Casts). Explain: once added to a podcast app, future published episodes appear there automatically.

**Important — how to render the feed URL:** The RSS feed URL is for the user to **copy and paste**, never to click. Always present any published `https://` URL (feed URL, episode link) wrapped in backticks as code — inline `` `https://…` `` or inside a fenced code block. Never emit it as a bare URL (auto-linkifies on native clients) and never as a `[label](https://…)` markdown link; either may fail to open on native clients and invites a click instead of a copy. Do not offer direct episode download links. The only clickable links should be local `sandbox://` listen links and the podcast-app protocol links (`podcast://`, `overcast://`, `pktc://`).

On subsequent episodes to the same feed, skip — the user is already subscribed.

## Feed Organization

**Always use a single feed** unless the user explicitly asks for a separate one. Before publishing, run `podcast-helper manifest read`【Muse 环境专用】. `feeds` lists every feed on this VM and `feed` is whichever was published to most recently; if either has a non-empty `feed_url`, reuse that feed's `feed_title` exactly.

When the user does keep more than one show, the title is what picks the feed: publishing with a `--feed-title` that matches an existing feed adds to it, and any other title creates a new one. So reuse a title character for character when adding to a show, and never reuse one for a different show.

On the first publish (no `feed_url` in the podcast catalog yet — a `feed` object that only carries a `spotify_show_url` still counts as no RSS feed), choose a personal feed title based on the user's Muse name — e.g. "Today with Alex", "News with Alex".

## Add to your Spotify (personal, optional)
When the user explicitly asks to put a generated episode on their Spotify, use `podcast-helper save-to-spotify`【Muse 环境专用】 to add it to the user's **own** Spotify account. This is a personal save — NOT the public/subscribable RSS feed publishing above, and it does not use `--publish`. Only do this on an explicit request; do not offer it proactively.

1. **List shows / check connection:** `save-to-spotify --json shows`. If it fails with a token / "not connected" error, tell the user to connect Spotify in Settings → Connections → Spotify【Muse 环境专用】. Ask whether to reuse an existing show or create a new one; don't silently pick.
2. **Upload + record** with `podcast-helper save-to-spotify --slug {slug} [--show-id <id> | --new-show "<title>"] [--title ...] [--summary ...] [--image ...]` (confirm title, target show, and summary with the user first — this writes to their account; cover override must be JPEG/PNG ≤ 1 MB). Returns `episode_id`, `episode_uri`, `spotify_show_id`, `spotify_show_url`.
3. **Wait for readiness:** `save-to-spotify --json episodes status <episode-id> --wait`. Server-side processing takes a few minutes; a returned `episode_uri` means accepted. If stalled in NOT_READY, it's a Spotify-side delay — tell the user and retry later rather than polling indefinitely.
4. Tell the user it's on their Spotify and may take a few minutes to appear. Spotify show/episode ids and URIs are internal CLI handles: use for subsequent commands, never in user-facing responses.

For deletion, use the raw `save-to-spotify` CLI (not `podcast-helper`, `spotify-api`, or podcasters/creators.spotify.com): list shows, resolve by title, `episodes --show-id <id>` then `episodes delete <episode-id>`; `shows delete <show-id>` removes the whole show including episodes. Treat `{"status":"deleted"}` as accepted, poll inventory up to 60 seconds, confirm only once absent. Deleting the Spotify copy does not delete local audio or an RSS feed. 完整命令流见 vendored 原件 `references/save-to-spotify.md`。

## Cover Art

Cover art is handled automatically by `podcast-helper` during generation【Muse 环境专用】. You control it with two flags:

- **`--cover-prompt`** — a short description of the episode theme (e.g. "morning news briefing, sunrise and cityscape"). podcast-helper shells out to `media-generation`【Muse 环境专用】 to create a square icon-style image. Always provide this.
- **`--series-id`** — groups episodes that share the same cover art. Use the cron job ID for recurring episodes. Without this, each episode gets unique art.

| Scenario | Behavior |
|----------|----------|
| One-off episode | Unique cover generated per episode from `--cover-prompt` |
| Recurring/cron episode | First episode generates cover; subsequent episodes with same `--series-id` reuse it |
| Published episode | That feed's episode covers unified to its cover image |

**Fallback** when no `--cover-prompt` is provided: the bundled default cover【Muse 环境专用】. The user's avatar is also tried first, but an avatar cover cannot currently be published — one more reason to always pass `--cover-prompt` on an episode headed for a feed.

You do NOT need to call `media.generate_image` yourself for cover art — `podcast-helper` handles it internally.【Muse 环境专用】 `--cover-image` is not available right now (publishing takes only generated art or the bundled default); the flag still parses but an episode published with it fails, so do not use it.

## Scheduling
When a user asks for a recurring podcast, audio briefing, or scheduled audio content:

1. **Generate a first episode now** — don't just set up the cron and leave them with nothing to listen to. Generate and deliver the first episode immediately.
2. **Ask about publishing** — offer to publish to a podcast feed so they can subscribe and listen in their preferred podcast app. If they agree, publish the first episode and present subscription links.
3. **Then create the cron job** — set up the recurring schedule.

For recurring podcasts, create a cron job using the `cron` tool【Muse 环境专用：本机改用 CronCreate / schtasks】. **Always set `timeout_secs: 1800`**（上游约定；本机对应为超时上限参数）. Keep cron task descriptions concrete — include the topic angle, the fixed cast (host names and their voice ids, so every episode uses the same hosts and voices), `--series-id` matching the cron ID, instructions to review `manifest read` topics before choosing today's angle, writing `/tmp/topics.md` and passing `--topics-file` for future dedup, and whether to publish after generating. Cron runs follow whatever the task description says; if it says publish, publish without confirmation. 上游完整 cron 任务体 JSON 示例见 vendored 原件 SKILL.md「Scheduling」节。

## Utility Commands

For edge cases and manual operations【Muse 环境专用】, `podcast-helper` exposes sub-commands:

- `podcast-helper manifest read` — print the current podcast catalog
- `podcast-helper manifest add-episode --slug ... --title ... --duration-secs ... --path ... --chunk-count ...` — add episode
- `podcast-helper manifest update-episode --slug ... [--episode-url ...] [--feed-url ...]` — update episode
- `podcast-helper generate-slug --title "..."` — generate a kebab-case slug with today's date

## Listening to Existing Episodes
If the user asks to listen to a podcast, hear their podcast, or asks about their episodes, read the podcast catalog with `podcast-helper manifest read`【Muse 环境专用】 and present listen links for the relevant episodes: `[{title}](sandbox://workspace/podcasts/{slug}/{slug}.mp3)`（本机改为本地路径）. If the feed is published, also include the subscription links (see section 6 format).

## Operating Rules
1. Use voices from the catalog【Muse 环境专用】, referenced by their catalog `id`. Default to the Meta AI voices (`MAI_01` and `MAI_03`) most of the time, but pick another catalog voice when the topic, tone, or user request steers that way. Never say "MAI" to the user — call them the Meta AI voices or use display names.
2. If a chunk fails, `tts synthesize-script` stops【Muse 环境专用】 — do not deliver a partial episode. Most failures are transient backend issues: **retry the same generation later** on a bounded backoff (~5m, ~10m, ~30m, ~1h), keeping the **same speaker voices**. Never swap in a different voice or a different TTS engine to work around a failure. Schedule the retry rather than blocking, and tell the user you'll deliver the episode once synthesis recovers. **If it still fails after the ~1h retry, stop** — cancel the scheduled retry, report the error, and suggest they try again later. (A `... not allowed to use voiceID ...` error won't clear on retry — that voice id isn't permitted; pick another and regenerate. Auth or clear request errors likewise need a fix, not a retry.)
3. On first episode in a new feed, help the user subscribe. On subsequent episodes, skip.
4. **Cron runs:** Follow whatever the cron task description says. If it says to publish, publish without confirmation.
5. **Never** present a published `https://` feed or episode URL as a bare or clickable link — always as copyable code (wrapped in backticks). Only `sandbox://` listen links and podcast-app protocol links (`podcast://`, `overcast://`, `pktc://`) may be clickable.
