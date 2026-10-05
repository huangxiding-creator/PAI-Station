---
name: muse-artifact-document
description: Create, read, edit, or manipulate Word documents (.docx) and Word templates (.dotx) - use whenever a build task's artifact kind is document with the default docx output, or the task mentions a Word doc / .docx / .dotx, extracts or reorganizes content from one, inserts or replaces images, does find-and-replace, or works with tracked changes (redlines) or comments; covers python-docx generation, raw OOXML editing of existing files, structure and formatting rules, and render verification. Not for PDFs, spreadsheets, or Google Docs.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/document/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills 仓库 @38bbb45（非官方快照，github.com/win4r/MuseAI-Skills），上游技能名 `artifact_document`。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/document/SKILL.md`（30 行；附属 `references/` 含 `visual.md`、`editing.md`，另引用共享 `.../artifacts/references/prose.md`、`markdown.md` 与 `.../artifacts/testing/SKILL.md`，均已随快照 vendored）。
> - 本版为本地适配移植版：生成工艺（`.src/` 发生器脚本、真结构不造假、渲染验收）原样保留；Muse 专用路径与机制改为参考式表述并逐条标注，未发明任何本机不存在的命令。

## 本环境适配

上游依赖逐条对照（本地环境 = Windows + Claude Code + E:\AI-Station）：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `/opt/hatch/skills/artifacts/document/references/visual.md`（设计与结构视觉规则） | 【Muse 环境专用】 | 本机无 `/opt/hatch`；读 vendored 原件 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/document/references/visual.md`。 |
| 共享参考 `/opt/hatch/skills/artifacts/references/prose.md`（文字层）与 `.../markdown.md`（内容格式层） | 【Muse 环境专用】 | vendored 原件在 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/references/` 下，按正文表格场景取用。 |
| `/opt/hatch/skills/artifacts/document/references/editing.md`（编辑既有 docx / 修订 / 批注 / 原始 XML 往返） | 【Muse 环境专用】 | vendored 原件 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/document/references/editing.md`；其中 `muse.read`、`soffice` 等指令见下两行的本地映射。 |
| `/opt/hatch/skills/artifacts/testing/SKILL.md` 渲染验收 gate | 【Muse 环境专用】 | vendored 原件 `.../opt/hatch/skills/artifacts/testing/SKILL.md`；本仓已有移植孪生技能 `E:/AI-Station/.claude/skills/muse-artifact-testing/SKILL.md`，验收时优先用它。 |
| `muse.read`（editing.md 中直接把 .docx 读成 markdown 的连接器原语） | 【Muse 环境专用】 | 本地无此原语；改用 python-docx 遍历结构（段落/表格/样式），需要扁平文本视图时由 python-docx 自行抽出。 |
| `muse.exec` + `yield_ms` 让位执行机制（经 testing gate 间接引入） | 【Muse 环境专用】 | 本地用 Claude Code Bash 工具执行（前台设足超时或 run_in_background），成败以落盘产物判定，不依赖 yield 语义。 |
| Muse VM 预装工具链假定：python-docx 预装、headless LibreOffice（`soffice`）、`pdftoppm` | 【Muse 环境专用】 | python-docx 已实证可用：`E:/AI-Station/.venv/Scripts/python.exe`（3.11.9，`import docx` 通过）。`soffice` / `pdftoppm` 本机 PATH 未见（2026-10-05 探测）——渲染验收前须先定位或安装，否则退化为 python-docx 结构读回 + 用户侧人工打开目检。 |
| Muse 连接器 OAuth、`hatch_*` CLI | 【Muse 环境专用】 | 本上游技能正文未出现这两类依赖，无需映射（逐条列出以示已核查、非遗漏）。 |

## 移植正文

以下忠实保留上游内容结构与实质，英文正文保持英文；会误导本机执行的指令保留原文并就地标注为参考式。

# Word-document artifacts

A docx is generated with the preinstalled `python-docx` library from a
generator script.【Muse 环境专用——"preinstalled" 是 Muse VM 假定；本地用
`E:/AI-Station/.venv` 的 python-docx（已实证）。】 Keep the generator under `.src/`: it is the editable
source for future revisions, and the binary is always regenerated from it.

| Task | Read first |
|---|---|
| Design and structure | `/opt/hatch/skills/artifacts/document/references/visual.md` |
| What the words say: outline, headings, tone, the prose read-back | `/opt/hatch/skills/artifacts/references/prose.md` (shared) |
| Content formatting (tables, lists, emphasis) | `/opt/hatch/skills/artifacts/references/markdown.md` (shared) |
| Edit an existing or uploaded .docx/.dotx, tracked changes, comments, extract/read content, legacy .doc | `/opt/hatch/skills/artifacts/document/references/editing.md` |

> 【Muse 环境专用】表中 `/opt/hatch/...` 路径本机不存在，读上表「本环境适配」列出的 vendored 原件对应位置（`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/` 下同名文件）。

Set a non-empty `document.core_properties.title`, use a human-readable
filename and visible title, and never fake structure: real numbering for
lists (never a literal bullet character), real heading styles for anything a
table of contents must see, a paragraph bottom border for a rule (never a
one-row table), and separate paragraphs instead of newlines inside a run.

## Verification

Follow `/opt/hatch/skills/artifacts/testing/SKILL.md`: render the document to PDF with
headless LibreOffice, rasterize with pdftoppm, and read every page image
before returning a link.【Muse 环境专用——本地改走移植孪生技能
`.claude/skills/muse-artifact-testing/SKILL.md` 的等价 gate；`soffice`/`pdftoppm`
本机未见，执行渲染前须先确认工具在位，缺位时按「本环境适配」表退化方案验收，不得跳过验收直接交付。】
