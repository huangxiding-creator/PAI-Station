---
name: muse-magic-moment
description: Turn a creator's talking-head or selfie recording into a shareable vertical "magic moment" clip that replays their story as synced chat bubbles, artifact cards, typing dots, emoji reactions and real widgets over their own preserved voiceover - trigger on "make a magic moment", "turn this video of me into...", "add the chat over my video", "retell what the assistant did for me", even when the words "magic moment" are never said. Locally this is a pipeline-design reference (story canon, conversation shape, visual grounding, review gates); the Muse renderer stack itself is vendored docs only.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/magic-moment/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

# Magic Moment（muse-magic-moment）

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》（https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg）→ MuseAI-Skills 仓库 @ `38bbb45a2c5a0f70de975f6387385770b9ad8aac`（非官方快照，仓库地址 https://github.com/win4r/MuseAI-Skills）。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/magic-moment/`（上游技能名 `magic-moment`；快照含 SKILL.md、INSTALL.md、`guide/` 六篇、`reference/` 四篇 + `reference/design-system/` 两个 HTML kit；`mm` CLI、`cmm/script.py`、install.sh、Optimistic 字体等运行件**不在**快照内，快照仅文档与设计资产）。
> - 本版是 Claude Code（E:/AI-Station）环境下的本地适配移植版：正文忠实保留上游英文内容与章节骨架；渲染基建一律标注【Muse 环境专用】仅作参考，分镜/素材组织/验收（review gate）方法学可按「本环境适配」的映射在本地执行。

## 本环境适配

上游渲染基建与 Muse 机制逐条列出如下，每条标注【Muse 环境专用】并给出本地映射或参考方式：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `./mm` CLI（transcribe / validate / preview / render / inspect / publish / webshots / snap / avatar / example） | 【Muse 环境专用】 | Muse VM 内置渲染/校验管线，快照未随附可执行件，本地**不可运行**。阶段映射：transcribe → 用户提供逐字稿或自选本地 ASR；validate / preview / inspect → 按下文「Pipeline guides」清单人工核对（screenplay 契约原文见 vendored `guide/screenplay.md`）；render / publish → 无本地等价物，渲染契约参考 vendored `reference/overlay-spec.md`。 |
| `/opt/hatch/skills/magic-moment/` 绝对路径 | 【Muse 环境专用】 | 只读快照位于 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/magic-moment/`；正文相对路径（`guide/…`、`reference/…`）一律相对该快照根解析。 |
| VM cell 镜像渲染栈（python3-pil/PIL 10.2、`/usr/bin` ffmpeg+ffprobe、spaces ts-runtime bundle 的 playwright-core、image-baked `/opt/meta-chromium/chrome`） | 【Muse 环境专用】 | 上游 INSTALL.md 明令禁止用 pip/npm/浏览器下载手工拼装替代栈；本地如需实验渲染思路可用本机 ffmpeg/浏览器，但不得视作上游契约。 |
| 转录链路（daemon sandbox API → inference-proxy → 宿主 ASR；cell ffmpeg 抽 16kHz 单声道、ffprobe 读时长） | 【Muse 环境专用】 | 本地无该服务；逐字稿作为输入。词级时间戳缺失时按上游规则处理：核对录像亲自定 beat 时间，不得假装旧 ASR 词与更正文本对齐。 |
| `install.sh` 校验脚本 + 开发机覆盖变量（MM_NODE、MM_PLAYWRIGHT_MODULES、JARVIS_CHROMIUM_BINARY、MM_FFMPEG） | 【Muse 环境专用】 | install.sh 不在快照内；依赖矩阵与「禁止手工安装」规则保留在 vendored `INSTALL.md` 供考证。 |
| Muse daemon 技能发现（内容哈希、免重启即生效） | 【Muse 环境专用】 | 本地为 Claude Code 技能发现机制（新会话/重扫描后生效）。 |
| `chat.read_messages` Muse 连接器（OAuth） | 【Muse 环境专用】 | 本地以会话历史/用户提供的聊天记录导出为「真实消息源」等价物；无 OAuth 需求。 |
| `~/workspace/.output/<name>/`、`~/workspace/your_files/` 工作区布局 | 【Muse 环境专用】 | 本地映射为用户指定输出目录（建议 `<工作目录>/.output/<run-name>/`）；`mm_transcript.json`、`script_review.json`、`resolved_screenplay.json`、`layout_review.json` 等文件命名契约照抄。 |
| Jarvis deploy 更新流（canonical runtime path = `/opt/hatch/skills/magic-moment/`） | 【Muse 环境专用】 | 本地无对应部署流；更新 = 替换快照目录 + 重装本技能。 |

> 本地注（全局）：正文出现的所有 `mm <subcommand>` 命令调用与 `~/workspace/...` 路径均为【Muse 环境专用】，在本地按上表映射作参考式执行（人工核对 / 等价工具），不要照字面在本机运行。

## 移植正文（upstream body）

# Magic Moment

The build is a guided pipeline; read the guides in order and follow them
exactly — this file is only the map.

1. `guide/story_and_canon.md` — transcribe the clip, ground every beat in
   the real work this VM actually did, and lock the fact sheet.
2. `guide/conversation_shape.md` — choose the exchanges and artifact reveals that carry the story.
3. `guide/visuals.md` — plan and preview the visuals. Match the component
   to the narrated action and give the actual artifact room to be seen.
4. `guide/screenplay.md` and `guide/timeline.md` — assemble beats.
5. `guide/screenplay_review.md` — the review gate before any render.

The look is owned by `reference/design.md` (doctrine) and
`reference/design-system/muse-moments-kit.html` (product components).
Use `reference/visual-storytelling.md` for diagram composition and motion. Card mechanics: `reference/card-spec.md`; renderer
contracts: `reference/overlay-spec.md`.

Tools: `./mm transcribe | validate | preview | render | inspect | publish | webshots | snap | avatar |
example`【Muse 环境专用，见上表映射】. Run `./mm webshots` first on any browser story: it copies the
browser's own captures of the pages it drove. Read and crop from them
before you rebuild those pages for the browser beat. `./mm snap`
captures artifacts and live pages.

## Component index

This index names every component in the kit so you can find one by capability.
Grep the label in
`reference/design-system/muse-moments-kit.html`
and copy that component's markup, which is the source of truth for the look;
`reference/design.md` owns how to copy, scale,
and adapt it. The kit's foundations (palette, type, rules) and its
thread-chrome section are renderer-drawn reference, not components to pick.

- Artifacts & documents
  - `web artifact · finished (hero)`: a page Muse built, as its real screenshot.
  - `fullstack app · resting (icon card, figma space icon)`: the app Muse built, at rest before the tap.
  - `fullstack app · tapped (a legit full web app)`: the tap beat that opens that app full screen.
  - `file card · shipping widget replica`: a document Muse produced, with the real file in the preview well.
  - `slides card · shipping widget replica`: a slide deck Muse produced.
  - `user upload chip · shipping replica`: a file the user uploaded, on the user side of the thread.
  - `completion card`: work finished when no other component covers what Muse did.
  - `external link · shipping widget replica`: a link Muse sent, unfurled with its hero and host.
- Media
  - `generated image · renders as-is`: an image Muse generated, on its own image beat.
  - `generated video · renders as-is`: a video Muse generated, on its own video beat.
  - `image picker · mobile canonical (2×2 + quote-reply)`: the user picking one of several generated images.
  - `music · found and playing`: a track or mix Muse found or made, playing.
  - `media library · organized`: photos or media Muse sorted into groups.
- Browser & shopping
  - `browser · rebuilt journey (one card, tap by default)`: a site Muse drove; author the browser beat's pages rather than copying this markup.
  - `skill task · status chip (no browser involved)`: a skill or connector did the work instead of the browser.
  - `web search · citations`: an answer Muse sourced from the web, with its citations.
  - `shopping results · shipping widget replica`: products Muse found, as the in-bubble result grid.
  - `purchase · order placed (canonical figma)`: an order Muse placed.
  - `browser · activity island (canonical figma)`: browser work in flight, as the floating glass island.
- Trust & security
  - `connect an account · in-chat link + disclosure sheet (canonical figma)`: the user connecting an account Muse needs.
  - `secure storage · log in details (figma canonical)`: the log-ins already held in secure storage.
  - `secure storage · add log in details (figma canonical)`: saving a new log-in to secure storage.
  - `sentinel · approval card (figma canonical)`: Muse asking permission before a sensitive action.
  - `secure form fill`: Muse filling a card number or password from secure storage.
- Communication
  - `texting on your behalf · message thread (send animates)`: a text Muse sent for the user, in a real message thread.
  - `email · triage + draft ready`: an inbox Muse triaged, with a draft waiting.
  - `email · draft in the real gmail composer (send animates)`: an email Muse drafted and sent from the Gmail composer.
  - `phone call · live + outcome`: a call Muse placed, live and then its result.
  - `audio pill · shipping widget replica`: a voice memo or audio clip in the thread.
- Automation & ambient
  - `scheduled tasks · agent list (canonical figma)`: the tasks Muse runs on a schedule.
  - `standing watch · ambient guardian`: Muse watching something over days, such as a price.
  - `proactive nudge · text_with_button replica`: an unprompted nudge with one call to action.
  - `option widget · dashed choices (shipping replica)`: the user picking one of several written choices.
  - `letter · shipping widget replica`: a letter Muse wrote.
  - `idea card · shipping widget replica`: one idea Muse surfaced, with its preview and its pill. `From your calls` is this card's meta line, not a component of its own.
  - `morning brief · feed edition (canonical figma)`: the morning feed edition Muse published. `Your day` and `Heads up` are section headers inside it, not components of their own.
  - `ideas · idea rows (canonical figma)`: the ideas list, with one row being chosen.
- Personal intelligence
  - `memory · recalled from weeks ago`: Muse acting on something the user said weeks earlier.
  - `memory · person page (markdown doc, product design)`: a person's memory page and its open threads.
  - `goals · goals surface (canonical figma)`: the user's goals list, with a subgoal checking off.
  - `goals · tracking check-in (canonical figma)`: a check-in on a habit Muse tracks.
  - `calendar · conflict resolved`: a calendar conflict Muse moved.
  - `device sync · flowing in`: the user's device data syncing in.
- Work & analysis
  - `deep research · multi-source report`: a multi-source report Muse researched.
  - `uploaded file · analyzed`: a document the user uploaded and Muse read.
  - `data analysis · chart from a spreadsheet`: numbers Muse charted from a spreadsheet.
  - `long thread · digest`: a long thread Muse condensed into decisions.
- Meta-capabilities
  - `subagents · fanning out in parallel`: work Muse ran across several helpers at once.
  - `wallet · muse wallet screen (canonical figma)`: the wallet screen and its payment methods.
  - `wallet · purchase approval (canonical figma)`: the user approving a purchase Muse is about to make.
  - `title card · chapter divider (canonical figma)`: a full-bleed chapter divider between story sections.

## Pipeline guides (condensed)

Each guide condensed to its load-bearing rules; the guide files above are the authority — 完整版见 vendored 原件 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/magic-moment/guide/<name>.md`。

### story_and_canon — preserve the source story

- Read the active request and its explicit corrections before selecting visuals. Use the supplied footage as the source. Preserve the full narration unless the user explicitly requests a shorter edit. Do not import unrelated music, styles, or sample gallery copy from earlier work.
- Preserve the ASR record; supply user corrections via the screenplay's `transcript_correction: {"text": ..., "source": ...}` object. Corrected words have no automatic word alignment — inspect the footage to establish beat times.
- Before layout, list the source claims in `script_review.json`: each claim's source span, actor, action, tense, evidence, and intended depiction. Preserve the difference between an offer, a plan, ongoing work, and a completed result (e.g. "has planned runs for the last couple months" ≠ "will plan runs for the next two months").
- Collect the actual messages and artifacts referenced by the story (upstream: `chat.read_messages`【Muse 环境专用】+ `~/workspace/your_files/`【Muse 环境专用】). Record observed details in the screenplay's `facts` object with their sources. Do not invent names, statistics, routes, approvals, transactions, or results to fill a component. An author-written fact sheet is not independent evidence.
- Use synthetic UI only to illustrate a supported claim when the original material is unavailable; describe its origin in the review. Do not operate an app, change a plan, send a message, or regenerate user data merely to manufacture a receipt.
- Mechanical validation checks structure and timing; review semantics yourself. Every depicted claim needs source support; every important narrated claim needs a depiction or an explicit decision to leave it in the voiceover. Never describe mechanical validation as proof of story fidelity.

### conversation_shape — conversation and pacing

- Show quoted messages with their actual wording; faithful paraphrases only when the source gives the meaning. Preserve speaker, intent, tense, and outcome; record which form each bubble uses in the review's depiction field.
- Show user requests and decisions the source actually contains. Do not invent a request or consent because a result exists; do not convert a retrospective story into a new live transaction. For ongoing assistance, show a standing request once.
- Use a bubble when it contributes an actual exchange; let an artifact stand alone when an invented conversation would distort the story. Do not turn the creator's praise into a Muse message.
- Choose the component after identifying the claim and its evidence. Reuse the same artifact with a different crop or state when the narration returns to it (show a run log as the run log, recommendations as recommendations). Component variety is optional and cannot change meaning.
- Keep copy short enough to read at phone size: roughly one second plus one second per three words per content bubble. Reduce copy or split a supported thought when it cannot fit its hold time.
- One focal visual at a time; keep only exchanges that add meaning beyond the narration; time each card to its narrated beat; leave breathing room between chapters; no closing bubble repeating the creator's conclusion.

### visuals — choose visuals from the evidence

- Pick the component from the index and the kit that depicts the supported action and state. Treat all gallery names, values, and sample copy as examples, never evidence.
- Prefer original media and captures of actual artifacts. Record `provenance: {"kind": "original-media|historical-capture|current-capture|reconstructed-ui|synthetic-illustration", "source": ...}` on each file-backed visual. A file path alone establishes neither authenticity nor historical state.
- Do not print verification labels ("actual artifact", "historical copy") on the video; write visible copy as the product would. Use a date or state label ("Planned") only when the source supports it; no "Live", sync badges, or completion animations without support. Omit an unsupported claim instead of covering it with a disclaimer.
- Write a short scene plan (each beat's visual focus, component, source, motion) and preview every card's initial/middle/final states at 360px width — including the tapped state — before a full render. Fix clipped text, crowded headings, and weak artifact reveals first.
- A mostly-prose artifact becomes a designed presentation of its supported content, saved as an artifact before capture; never shrink a full page into a card or invent data to make a chart interesting.
- `mm webshots`【Muse 环境专用】: match the source task, URL, and time to the narrated journey before using a capture; a browser beat requires an evidenced sequence of browser actions. `mm snap`【Muse 环境专用】: fresh browser context without the product's cookies/state; never click a mutation control to populate a screenshot; the renderer rejects silent truncation.
- Authoring rules: HTML and CSS only — no scripts, event handlers, iframes, or network dependencies; local media via absolute `file://` paths; `box-sizing: border-box`; let headings wrap rather than hide overflow; finite CSS actions finish within the beat, ambient loops continue. Cards self-contained at 1240px wide, ≥32px visible type, 56px primary line; ordinary cards 600px height budget, tap cards 1100px.
- Keep the automatic avatar entrance, pinned header, and closing celebration; verify face overlap visually (fixed overlay region, not automatic face detection).

### screenplay — dramatize the interaction, don't caption the narration

- This is the authoring step: turn the transcript into the two-party interaction the creator describes (their ask, the reply, what ran, what appeared). A video of only user bubbles is a failed screenplay. Screenplay contract and validator: `cmm/script.py`【Muse 环境专用，不在快照内；beat 契约摘要如下】.
- Beat types:
  - `bubble` speaker `user`: the creator's ask in send form ("Need a flight on Tuesday"), not the narration ("I just told it I needed a flight" is a caption). Convert, don't drop.
  - `bubble` speaker `muse`: the agent's reply — short, warm, action-forward, entity-bearing; reads like the agent texting in this thread. Personality changes wording, never claims; no creator narration or feelings inside it; no em-dashes in any bubble or chip.
  - `visual`: a receipt/status card or real image standing alone (rounded corners + drop shadow directly on the video, no white shell). `html` cards stay under ~600px at 1240 wide with a bare body. `image` = real image. `shell: true` re-opts into the white shell (rare); `hero: true` implies it for the final reveal. `tap: true` plays the tap emphasis (card lands, thread clears, card grows and centers): for hero items and live browser-driving cards; needs ≥3s with no other beat inside the tap window; 1100px authoring budget.
  - `browser`: one journey of the agent driving a site in a single beat (5–20s, taps by default): pages are simplified rebuilds of pages really driven, 1240px wide against a 640px fold; name the real screenshots in `reference`; every page but the last gets a `click` CSS selector; `address` = the real domain; at least two pages; do not animate the page (the renderer draws shell, cursor, click ring, swaps).
  - `video`: a real video artifact plays in-thread, muted (the voiceover keeps the audio); plays from `start` up to `end - start`, then holds its last frame.
  - `typing`: the three bouncing dots; end it exactly when the reply bubble starts.
  - `reaction`: an emoji tapback on a bubble's corner (`target` = that bubble's start); lands at least 0.4s after the bubble pops and always BEFORE the response; one or two per video.
- Sounds are automatic and directional (user send "swip", agent bubbles and cards "ding", reactions "plink"; typing silent). Chip beats are retired — work-in-flight is depicted by cards, never a spinner pill.
- Grounding is an upgrade, not a gate: real material (screen recording, thread files, images) satisfies its beat first and is reported as provenance `real`; missing material does not block the video.

### timeline — source and timing

- Keep the transcript's source digest, duration, original ASR text, and word timestamps in the run's `mm_transcript.json`; never edit the ASR file. Anchor each beat to the narrated claim it depicts; use word timestamps only when the wording is unchanged. Never show a result before the narration reaches it.
- Finite nonnegative `start`/`end`, each content beat within the measured source duration. The renderer preserves the source and appends the Muse close after the footage ends; do not cut off the speaker's conclusion to make room for it.
- `end` = end of the beat's active hold; content stays in the thread afterwards, pushed back along the arc, shrinking and fading. Coverage is informational, not a reason for filler.
- Allow a visual at least 0.8s after the preceding beat; answer a typing indicator with its supported reply bubble; at most three active beats at once; no new beat may enter during a tap.

### screenplay_review — review the exact build (the gate)

- Run `mm validate`【Muse 环境专用】→ read the normalized `resolved_screenplay.json` → copy the returned fingerprint into `script_review.json` only after reviewing that version. Review shape: `fingerprint`, `verdict`, per-claim rows (`beat`, `source_span`, `actor`, `action`, `tense: past|ongoing|planned|offered`, `evidence`, `depiction`) for every content beat, plus `source_coverage` explaining where each important source claim appears (including claims deliberately left in narration).
- Check speaker attribution, source support, temporal meaning, component choice, and timing for every bubble and visual. Reject invented instructions, approvals, successful syncs, statistics, and gallery sample copy. Fix, revalidate, and review the new fingerprint after any change.
- Render, then inspect every generated contact sheet and the exact returned video at phone scale: opening, each visual's initial/final states, every transition, taps, the creator's concluding words, the appended close; tiny text, clipping, duplicate messages, overlapping labels, replayed actions, face coverage; intelligible source audio; no background music unless explicitly requested.
- Review visual quality separately from factual correctness: at 360px width the focal content must read without pausing; reject artifact-as-thumbnail, audit labels in artwork, old cards obscuring the next scene. Record checked states in `layout_review.json` (`output_sha256` from the render manifest, `verdict`, `checked_states` time+observation rows). Render again after any repair; never post-process the checked MP4.
- `mm publish`【Muse 环境专用】only after both reviews pass; deliver only its `DONE` path; keep the run manifest as the provenance record.

## Install note (Muse VM only)【Muse 环境专用】

Nothing to install on a Muse VM: the tar ships code and fonts (~13MB), the rest ships with the VM image (PIL 10.2, ffmpeg/ffprobe, playwright-core bundle, `/opt/meta-chromium/chrome`, daemon ASR chain). `install.sh` verifies every leg idempotently; `--check` is a sub-second preflight. Never install pieces by hand — if the stack is incomplete, the VM image predates it: report setup impossible, do not improvise. Dev machines override via `MM_NODE`, `MM_PLAYWRIGHT_MODULES`, `JARVIS_CHROMIUM_BINARY`, `MM_FFMPEG`. Update only through the Jarvis deploy flow. 完整版见 vendored 原件 `INSTALL.md`。
