---
name: muse-artifact-pdf
description: Build, revise, or manipulate a fixed-layout PDF (report, guide, one-pager, printable) — use whenever a build task's artifact kind is pdf, a document build's output format is pdf, or the task reads, merges, splits, crops, or fills an existing PDF including fillable AcroForms; covers print-CSS HTML authoring, the render/geometry/validation gates, and existing-PDF work per the vendored Muse references.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/pdf/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

# muse-artifact-pdf

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills@38bbb45 非官方快照（github.com/win4r/MuseAI-Skills，commit `38bbb45a2c5a0f70de975f6387385770b9ad8aac`）。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/pdf/`（含 SKILL.md 与 `references/workflow.md`、`references/visual.md`、`references/existing-pdfs.md`）。
> - 本版是本地适配移植版：frontmatter 与「本环境适配」一节为新增；正文忠实保留上游结构与实质，仅把会误导本机执行的指令改为参考式表述并标注。

## 本环境适配

上游依赖逐条列出，标注【Muse 环境专用】并给出本地映射或参考方式：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `/opt/hatch/skills/...` 路径体系（Muse VM 内技能安装位） | 【Muse 环境专用】 | 映射到 vendored 快照 `E:/AI-Station/06 技能/library/MuseAI-Skills/`：下文所有 `/opt/hatch/...` 路径均在该根下解析；本技能原件在 `.../opt/hatch/skills/artifacts/pdf/` |
| `render_audit.mjs` 共享渲染引擎（`bun run` + Playwright + VM 预装 Chromium `/opt/meta-chromium/chrome`） | 【Muse 环境专用】 | 脚本未随快照附带，本机不存在；如需复刻 HTML→PDF+审计流水线，按 vendored `references/workflow.md` 记载的 flag 契约自行以 Playwright 实现，勿虚构本机可执行该脚本 |
| `validate_pdf.sh` 及其依赖 `pdfinfo`/`pdftoppm`/`pdftotext`/`fc-list`（poppler + fontconfig，VM 预装） | 【Muse 环境专用】 | 本机 Windows 未预装；如需等效验收先自装 poppler/fontconfig 或用等效工具，验收标准以 vendored `references/workflow.md` 为准 |
| `media.generate_image` 连接器（Muse OAuth 媒体生成，`output_dir: artifact_media_dir`） | 【Muse 环境专用】 | 本地无该连接器；插图改走本机已接入的图片渠道，产物仍按上游约定收进 `.src/media/` 后以 data URI 内嵌 |
| `$JARVIS_HOME` / `project_dir` / `workspace/your_files` 交付目录约定（Muse VM 工作区机制） | 【Muse 环境专用】 | 本地映射为当前任务自己的项目目录；`.src/` 源与 `<artifact-slug>.pdf` 产物的相对结构可照搬 |
| VM 字体栈（`fc-list` 先验；Noto/Liberation 可靠、DejaVu 缺失、禁外部字体导入） | 【Muse 环境专用】 | 本机字体环境不同：沿用「先用可用工具验证字体存在再写进 CSS」的规则本身，勿照抄 VM 字体清单 |
| hatch_* CLI 与 Muse 技能路由（如上游 frontmatter `metadata.includeInPrompt`） | 【Muse 环境专用】 | 本地由 Claude Code Skill 机制接管（按名加载 `muse-artifact-pdf`）；上游 metadata 字段不参与本地路由，故未搬运 |

## 移植正文（port of upstream body）

> 以下为上游正文忠实移植。`/opt/hatch/...` 路径按上表映射到 vendored 快照根读取；涉及 render/validate 脚本的指令为参考契约（本机无该脚本），非可直接执行的命令。

### PDF artifacts

A PDF is authored as HTML with print CSS and rendered through the
shared capture engine. The kept source under `.src/` is the editable truth
for every future revision; the PDF binary is always regenerated, never
patched.

| Task | Read first |
|---|---|
| Any PDF build or edit | `/opt/hatch/skills/artifacts/pdf/references/workflow.md` (the workflow: authoring, render, gates, validation loop) |
| Design and layout | `/opt/hatch/skills/artifacts/pdf/references/visual.md` |
| What the words say: outline, headings, tone, the prose read-back | `/opt/hatch/skills/artifacts/references/prose.md` (shared) |
| The document plots data | `/opt/hatch/skills/artifacts/references/charts.md` (shared) |
| Read, merge, split, or extract from an existing PDF; fill a PDF form | `/opt/hatch/skills/artifacts/pdf/references/existing-pdfs.md` |

以上五个 reference 文件均已随 vendored 快照落盘，本地可直接全文阅读（完整版见 vendored 原件目录 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/pdf/references/` 与 `.../artifacts/references/`）。

### Scripts

| Script | What it does |
|---|---|
| `/opt/hatch/skills/artifacts/scripts/render_audit.mjs` (shared) | Renders the HTML source to PDF and PNGs and runs the render gates; `workflow.md` names the flags |
| `/opt/hatch/skills/artifacts/scripts/validate_pdf.sh` | Integrity, page metadata, data-URI embedding, full rasterization; run until it passes |

（本地标注：这两个脚本未包含在 vendored 快照中，属【Muse 环境专用】的 Muse VM 资产；上表在本机仅作流水线契约参考——`workflow.md` 记载了 render 的全部 flag 与门禁语义，可作为自行实现等效 render_audit 流水线时的规格。）

### Verification

Follow `/opt/hatch/skills/artifacts/testing/SKILL.md`（本地映射：vendored `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/testing/SKILL.md`，已随快照落盘可读）: run the gates, then read every
validation PNG before returning a link.
