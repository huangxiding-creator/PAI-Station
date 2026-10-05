---
name: muse-artifact-presentation
description: Build or revise a slide-deck artifact (pptx by default; pdf or html on request) authored as per-slide HTML with a StylePlan theme, shared deck.css, deterministic assembly, and render gates. Use whenever a task's artifact kind is presentation, or the user asks for a deck, slides, or a presentation; also covers deck audits and PPTX export.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/presentation/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> 本技能移植自微信文章《Meta Muse的68个Skills全貌曝光》所介绍的上游仓库 MuseAI-Skills（github.com/win4r/MuseAI-Skills @ 38bbb45，非官方快照）中的 `opt/hatch/skills/artifacts/presentation/SKILL.md`。上游原件（含 `references/` 七篇附属文档）完整保存于 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/presentation/`。本文件是 Claude Code（E:/AI-Station）环境下的本地适配移植版：正文忠实保留上游结构与实质（英文正文保持英文），仅把依赖 Muse 运行时（/opt/hatch 路径、hatch_* 脚本、Muse 连接器、Muse VM 机制）的指令改为参考式表述并逐条标注；未随快照分发的脚本一律视为行为契约参考，不在本机臆造执行。

## 本环境适配

上游依赖逐条映射如下（下文"vendored"均相对 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/`）：

| # | 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|---|
| 1 | `/opt/hatch/bin/hatch-slide-style`（StylePlan 编译器） | 【Muse 环境专用】 | 未随快照分发（vendored `opt/hatch/bin/` 为空目录）。本地按 vendored `presentation/references/visual.md` 的规则产出 `style_plan.json`（字段契约见 `presentation/references/workflow.md` 首节），不得臆造"已编译"替代品 |
| 2 | `scripts/assemble_deck.mjs`（校验 manifest + 强制 CSS 作用域 + 产出合并文档；非零退出=不可交付） | 【Muse 环境专用】 | 脚本本体未随快照分发；行为契约见 vendored `presentation/references/workflow.md` 步骤 5/7。本地按同规则人工执行与自检（逐文件校验 id/顺序/data:URI/选择器作用域），产物 `.src/index.html` 视为生成物不手改 |
| 3 | `scripts/embed_deck_fonts.mjs`（webfont 子集内嵌进 deck.css；下载失败仅告警不阻塞） | 【Muse 环境专用】 | 未随快照分发。参考式：本地如需内嵌，自行以"下载字体→`@font-face`+data: URI 追加到 deck.css 末尾"等价实现，保留"失败降级为 fallback 字体并明说"的语义 |
| 4 | `scripts/render_audit.mjs`（shared；Chromium 渲染 + 跑验收门 + 出 PNG/PDF/报告） | 【Muse 环境专用】 | 未随快照分发。本地映射：headless Chromium（本机 Playwright/Chrome MCP 均可）逐页截 `section.slide` 为 PNG → 用 Read 工具逐张巡图；门指标（overflow/broken_images/cover_no_image/fill/restraint 等）按 workflow.md 步骤 8 语义人工判定，结论落盘成 report 文件再读 |
| 5 | `scripts/build_pptx.py` + `scripts/validate_pdf.sh`（PPTX 导出 / PDF 校验） | 【Muse 环境专用】 | 未随快照分发。参考式：由验证过的整页 PNG 拼 PPTX（通用依赖 `python-pptx`，本机未核实，用前先确认/自装），语义见 workflow.md 步骤 10（整图满幅、标题进演讲者备注）；PDF 分支仅显式要求时做 |
| 6 | `bun run`（上游 JS 运行时） | 【Muse 环境专用】 | 本机为 npm/node 生态；若自行补齐等价 mjs 脚本，用 node 运行，不臆装 bun |
| 7 | `$JARVIS_HOME` / `~/workspace` 路径约定与 build task 下发的 `project_dir`/`output_format`/`slide_count_target`（manager subagent 的任务信封） | 【Muse 环境专用】 | 本地直接用 `E:/AI-Station` 下的项目绝对路径；任务参数来自用户请求或编排层（Claude Code Agent/Workflow 工具），无 `~` 字面量陷阱则不必改写 |
| 8 | `media.generate_image` 与 image-search skill（Muse 连接器出图/搜图，`--require-generated-imagery` 靠其 sidecar 计数） | 【Muse 环境专用】 | 本地无此连接器。配图改用本机既有渠道或用户提供的素材；出图美术方向仍照 vendored `presentation/references/image-directive.md` 的艺术指导原则执行；无 sidecar 时对应验收门按 workflow.md 的"合法降旗"规则处理 |
| 9 | `muse.exec` 后台执行与 `yield_ms` 让道（Muse VM 机制，testing 技能提到渲染时长超默认 yield） | 【Muse 环境专用】 | 本地一律 Bash 前台运行并给足 timeout；结论以落盘报告文件为准，不靠后台沉默判成功 |
| 10 | `~/workspace/themes/` 主题库（theme.md 定义其 JSON schema） | 【Muse 环境专用】 | 本地如采用该 schema，主题 JSON 放本项目自建目录并自行记录路径；schema 本身见 vendored `presentation/references/theme.md` |

# Slide-deck artifacts（以下为移植正文）

A deck is authored as one standalone HTML file per slide plus a shared
`deck.css` and a `deck.json` manifest, assembled and gated deterministically,
then exported. The per-slide sources under `.src/slides/` are the editable
truth for every future revision; slide ids never renumber.

Three rules hold on every slide, before any reference is read. **Sentence case
everywhere** (including stat labels). Never use `text-transform:uppercase` or
`letter-spacing` on any text. No slide furniture: pills, subtitles, summary
lines, eyebrows, kickers, badges, chips, tags, and captions do not belong
anywhere on a slide. The cover is the deck title over its hero image and
nothing else.

## Read first

| Task | Read first（相对 vendored 根 `…/MuseAI-Skills/opt/hatch/skills/artifacts/`） |
|---|---|
| New deck | `presentation/references/workflow.md` plus the references it names |
| Edit an existing deck | `presentation/references/editing.md`, plus the references it names |
| Design and layout | `presentation/references/visual.md` |
| Theme generation or application | `presentation/references/theme.md` |
| Slides that plot data | `references/charts.md` (shared) |

## Scripts

【Muse 环境专用：下表脚本均未随快照分发，`/opt/hatch/bin/` 与 `scripts/` 在 vendored 仓内为空/缺失——此处仅保留上游行为契约作参考，见上方"本环境适配"表的本地映射。】

| Script (upstream path) | What it does |
|---|---|
| `/opt/hatch/bin/hatch-slide-style` | Compiles the StylePlan; a deck is never built on an invented substitute plan |
| `/opt/hatch/skills/artifacts/scripts/embed_deck_fonts.mjs` | Subsets and embeds webfonts into deck.css; a font that will not download warns, never blocks |
| `/opt/hatch/skills/artifacts/scripts/assemble_deck.mjs` | Validates slide files against the manifest, enforces CSS scoping, emits the combined document; non-zero exit is unshippable |
| `/opt/hatch/skills/artifacts/scripts/render_audit.mjs` (shared) | Renders slides and runs the deck gates; `workflow.md` names the flags |
| `/opt/hatch/skills/artifacts/scripts/build_pptx.py` | Exports the validated PNGs as the PPTX and carries each slide's title into its speaker notes as best-effort accessibility text; the daemon-side rebuild path preserves those notes after UI edits |

## Build loop (condensed; full version in vendored `presentation/references/workflow.md`)

The StylePlan is the sole styling authority for the deck: apply it verbatim
and never re-pick colors or fonts. Its fields: `archetype`, `theme`,
`palette` {paper, ink, primary, accent}, `fonts` {display, body}, `voice`,
`preferred_layouts`, `preferred_charts`, `required_content_blocks`,
`image_style`, `tone`/`weight`/`density`, `layout_plan` (one `{id, layout}`
per slide), `lockups` (the deck's two allowed text+image patterns), and
`css_variables` (the `:root` block to emit verbatim). `output_format` from
the brief drives what gets produced; when absent it is exactly `["pptx"]`.

1. **Set up.** Create `project_dir/.src/media/`, `.src/validate/`, `.src/slides/`.
   Author the deck one file per slide; assembly combines them into the
   `.src/index.html` that validation and every export read.
2. **Resolve the slide count once:** exact `slide_count_target`, or the
   **midpoint** (rounded down) of a range. Use this resolved count throughout.
3. **Plan.** Write `.src/deck_plan.md` grounded in the verbatim request and
   supplied content: title, audience, narrative arc, one bullet per slide
   matched to `layout_plan` (first = cover, last = closing, covering every
   `required_content_blocks` entry). Echo the user's stated constraints at the
   top. Commit to a cover hero plus at least 2 illustrative images, and
   palette-colored matplotlib charts for data.
4. **Set the design system.** Write `.src/slides/deck.css`: the StylePlan's
   `css_variables` as one `:root` block, then every shared rule — canvas,
   layout classes, the two `lockups`, the type scale. Never re-pick colors or
   fonts, never redefine a token per slide, write no font URL anywhere. Keep
   `.src/style_plan.json` so a later edit can recover the plan. Baseline page
   model: `@page { size: 13.333in 7.5in; margin: 0; }`,
   `* { box-sizing: border-box; print-color-adjust: exact; }`,
   `.slide { width: 13.333in; height: 7.5in; overflow: hidden; page-break-after: always; }`.
5. **Author one file per slide** at `.src/slides/<id>.html`: a standalone
   document linking only `deck.css`, holding exactly one
   `<section class="slide" id="<id>">`. `id` comes from `layout_plan`; keep it
   kebab-case, never `index` (reserved for the combined document), never
   renumber. Embed every final `<img>` and CSS `url(...)` asset as a `data:`
   URI; leave no external `http(s)://`, `file://`, or relative `.src/media`
   reference. A slide may add its own `<style>` for rules only it needs, and
   **every selector must be scoped to that slide's id** (`#<id> …`, including
   inside `@media`) — the combined document would otherwise restyle every
   other slide. Default canvas 16:9 at 13.333in × 7.5in (1280×720 @ 96 dpi).
   Then check: search each file for `#` colors and `rgb(` — the only legal
   hits are the slide's own `--hero-scrim-color` and `#fff` on a cover title
   over a photo; every other hit is a bug and becomes `var(--slide-*)` or
   `color-mix(in srgb, var(--slide-*) N%, transparent)`. Finally write
   `.src/slides/deck.json`: `{"main_title": "<title>", "slides": [{"id": "cover"}, …]}`
   — order only; assemble rewrites the derived fields.
6. **Source imagery and charts.** A real subject (company, product, place,
   person, logos) comes from image-search; a concept subject from
   `media.generate_image` per `image-directive.md`. 【Muse 环境专用连接器，
   本地改用本机渠道/用户素材，见适配表 #8。】 Cover hero must be a real
   image — never a CSS gradient or inline SVG. If the hero cannot be sourced
   or generated, or the brief asks for no imagery, update `deck_plan.md` first
   and document the replacement visual system. A brief forbidding SYNTHETIC
   imagery only closes the generate route: a real subject is still sourced.
   Build data charts as palette-colored matplotlib images so charts match the
   deck; never use image generation for charts, maps, tables, or factual
   diagrams; no decorative images on stat/statement slides.
7. **Fonts, then assemble — both mandatory before validation.** 【Muse 环境
   专用脚本，本地按契约参考执行，见适配表 #2/#3。】 Embed fonts first (the
   faces your `:root` tokens name, appended at the END of `deck.css`); a
   failed download warns and degrades to a fallback face, never blocks. Then
   assemble: it validates slide files against the manifest, enforces CSS
   scoping, and writes the self-contained `.src/index.html` (deck.css inlined,
   slides in `deck.json` order). Never hand-write or edit `.src/index.html` —
   the next assemble overwrites it. A finished deck has **no**
   `fonts.googleapis.com` reference, and that is correct; never add one back.
   A non-zero exit (locally: a failed contract check) means unshippable; fix
   the named file and re-run.
8. **Validate (mandatory loop, at most 3 iterations).** Render every slide to
   PNG and gate: `overflow` (content past its own client box — fix the named
   slide by reducing content, never by shrinking fonts), `broken_images`
   (embed real image bytes as `data:image`, not a tool's JSON result),
   `cover_no_image`, slide furniture / uppercase / letter tracking (restraint
   probe), under-filled top-packed slides (fill gate fails only when a slide
   is both under ~75% fill **and** top-packed; fix by distributing content
   over the full height or adding content — never by deleting `height` or
   switching to `min-height`), and missing generated imagery where required.
   **Advisories never gate** (`fonts.missing`, `plan.missing_slides` /
   `extra_slides`, `fonts.unused`). Flag-drop rules: drop
   `--require-cover-image` and `--require-generated-imagery` on the two
   documented no-imagery branches; drop `--require-generated-imagery` also on
   a chart-only or fully sourced deck, and on edits that regenerate nothing;
   drop `--require-restraint` on any in-place edit of a pre-existing deck.
   The PDF branch (`--pdf` + `validate_pdf.sh`) runs only when `pdf` is
   explicitly in `output_format`. 【Muse 环境专用门脚本，本地映射见适配表
   #4/#5。】 If a check fails: edit the per-slide files, re-assemble (step 7),
   re-render, re-validate. After 3 iterations, report the specific failure and
   ask for direction. Never return links until validation passes.
9. **Eyeball.** After the gates pass, read every generated PNG fresh and
   verify: rendered page count equals the resolved slide count; palette and
   fonts visibly applied; at least 3 distinct layouts when 5+ slides; the
   cover establishes the visual language; images render and match their
   claim; heroes legible; sufficient contrast; no missing images, blank
   slides, clipped or unreadable text, or repeated weak layouts; charts
   render correctly. (PNG filenames match `page-*.png`; do not assume a
   specific padding style.)
10. **Export and promote.** Promote each requested format to the slug root;
    files not in `output_format` stay under `.src/`. `pptx`: built from the
    validated PNGs by `build_pptx.py` — one full-bleed image per slide sized
    to the PNG aspect ratio, deck title set, each slide's title carried into
    speaker notes as best-effort accessibility text; requires `python-pptx`
    (install per the local Python environment — upstream's exact command is
    Muse-shell flavored). 【Muse 环境专用脚本，见适配表 #5。】 `pdf` / `html`:
    copy the validated PDF / the **assembled** `.src/index.html` to the slug
    root, only when explicitly requested; never promote the per-slide files —
    `.src/slides/` is deck source, not a deliverable. If `pptx` cannot be
    produced for a default deck, do not silently substitute PDF or HTML:
    report that PowerPoint export failed and ask whether PDF or HTML is
    wanted instead.
11. **Write `project_dir/meta.json`** after every requested output is
    verified at the slug root: `title`, one-line `description`,
    `type: "presentation"`, `primary_output` (priority `pptx > pdf > html`),
    `outputs` (only files that exist at the slug root **and** were explicitly
    requested), `slide_count` (count of validate PNGs), `thumbnail` (first
    validate PNG, stored slug-root-relative), `status: "complete"`. Compute
    dynamic fields from the final validation run's actual output, not cached
    values.

## Quality gate

A deck is not complete until it passes these checks (full version in vendored
`workflow.md`):

- Slide count equals the resolved slide count; clear narrative arc, not a
  stack of unrelated pages.
- At least 3 distinct slide layouts when the resolved count is 5+; at most
  `floor(count * 0.4)` slides are simple title-plus-bullets.
- Every non-appendix slide has a visual anchor: image, chart, timeline,
  diagram, callout system, or strong typographic composition.
- If imagery was requested/attempted/created, the slide files embed the
  selected images (`data:` URIs) and the validation PNGs visibly show them;
  unused generated files are deleted or documented with a rejection reason.
- The title slide establishes the deck's visual language immediately.
- Dense text is rewritten, split, or removed — never shrunk until unreadable.
- The PPTX, when produced, is exported from the validated rendered slides;
  no direct native-shape PPTX.
- Charts are palette-colored matplotlib; every claim is grounded in the
  provided source.
- The deck exists as per-slide source under `.src/slides/` and the combined
  `.src/index.html` was produced from it after the last edit, so the two agree.

## Verification

Follow the vendored `testing/SKILL.md` (see sibling skill `muse-artifact-testing`):
run the gates, then **look** — read every slide PNG fresh before returning a
link; the generating context sees what it expects, not what rendered. Check
first for text overflow or cut-off content, then overlaps, collisions, cramped
or uneven spacing, low-contrast text, and template decoration left behind.
**Placeholder scan** before returning: TODO, lorem, placeholder, `[insert`,
`xxx` runs, and sample rows the user never asked for — anything found is
fixed, not shipped. Never return a link while a gate fails; after three failed
fix attempts, report the specific failure and ask for direction instead of
iterating. 【Muse 环境专用：上游 `muse.exec` 后台渲染超默认 `yield_ms` 的告诫，
本地对应做法 = 前台跑足时长 + 读落盘报告，见适配表 #9。】
