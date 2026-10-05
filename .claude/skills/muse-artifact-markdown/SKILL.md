---
name: muse-artifact-markdown
description: Build or revise a plain markdown (.md) deliverable - notes, a README, meeting minutes, documentation, or text the user will edit or paste elsewhere - whenever the requested artifact kind is markdown; covers markdown formatting conventions and read-back verification.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/markdown/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> 本技能移植自微信文章《Meta Muse的68个Skills全貌曝光》所披露的 MuseAI-Skills 仓库（GitHub `win4r/MuseAI-Skills` @ `38bbb45a2c5a0f70de975f6387385770b9ad8aac`，非官方快照）中的 `opt/hatch/skills/artifacts/markdown/SKILL.md`。
> 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/markdown/`（vendored 原件；其引用的共享 references 与 testing 技能在同层 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/` 下）。
> 本版是面向 Claude Code 的本地适配移植版：上游正文的结构与实质全部保留（英文保持英文），仅将 Muse 专有工具与 `/opt/hatch` 路径改写为参考式表述并逐条标注，见下节。

## 本环境适配

| 上游依赖 | 本地映射 / 参考方式 |
|---|---|
| `muse.write`（append 模式分节追加）/ `muse.edit`（精准修改）【Muse 环境专用】 | Claude Code 的 Write（整文件写入）与 Edit（锚点替换；在文件末尾锚点处追加小节）工具，同样遵循"每次写入保持小块" |
| `/opt/hatch/skills/artifacts/references/markdown.md` 共享格式规则【Muse 环境专用】 | vendored 原件：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/references/markdown.md` |
| `/opt/hatch/skills/artifacts/testing/SKILL.md` 验证总纲【Muse 环境专用】 | vendored 原件：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/testing/SKILL.md`；markdown kind 的验证只有"读回全文"，本地用 Read 工具即可完成 |
| hatch_* CLI / gate 脚本（`render_audit.mjs`、`validate_pdf.sh` 等）【Muse 环境专用】 | 本技能不依赖任何 gate 脚本；它们属于上游 testing 技能为 pdf/presentation/xlsx 等 kind 定义的验收件，见上条 vendored 路径，仅作参考 |
| Muse 构建任务框架（"build task 的 artifact kind"、`<slug>.md` 位于项目根、manager 派发）与 Muse 连接器 OAuth / Muse VM 机制【Muse 环境专用】 | 本技能原文不直接调用 OAuth 或 VM；本地对应：主会话/Workflow 在用户要求产出或修订 .md 交付物时触发本技能，交付路径以任务约定为准（默认工作目录下 `<名称>.md`） |

# Markdown artifacts

A markdown deliverable is plain text written directly with the file tools:
append sections with the write tool in append mode, keep each write small,
and use the editor for surgical fixes. 【本地适配：原文为 `muse.write` append 模式 + `muse.edit`，本环境对应 Write/Edit 工具，见上表；"小块追加、精准修改"的纪律不变。】
There is no compile step; the file at `<slug>.md` in the project directory
root is the deliverable. 【本地适配：交付路径以任务约定为准，默认工作目录下的 `<名称>.md`。】

| Task | Read first |
|---|---|
| Formatting (tables, lists, emphasis, headings) | `/opt/hatch/skills/artifacts/references/markdown.md` (shared) 【本地映射：vendored 原件路径见上表】 |

Structure follows the content: real markdown headings, real list syntax,
tables only where rows and columns genuinely align. The file ships as the
user's own text, so no build scaffolding, no HTML unless the user asked
for it, and no trailing commentary that isn't part of the document.

## Verification

Follow `/opt/hatch/skills/artifacts/testing/SKILL.md` 【本地映射：vendored 原件路径见上表】:
read the finished file back in full before returning the link, checking
structure renders as intended and no placeholder or scratch content remains.
【本地适配：即交付前用 Read 工具完整读回全文自检；testing 技能的共享规则同样适用——占位符/脚手架残留（TODO、lorem、placeholder、[insert、示例行等）发现即修，不留进交付件；静态 .md 无需任何渲染 gate 脚本。】
