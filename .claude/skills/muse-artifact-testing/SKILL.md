---
name: muse-artifact-testing
description: Verify a deliverable before returning it - use whenever a build is about to hand back a pdf/pptx/docx/xlsx/csv/md file or a web artifact link, or a task asks for validation, QA, or a visual check; run per-kind gates, render and inspect the fresh output, and scan for leftover placeholders before delivery.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/testing/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills 仓库 @38bbb45（非官方快照，github.com/win4r/MuseAI-Skills），上游技能名 `artifact_testing`。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/testing/SKILL.md`（45 行，无附属 references/ 目录）。
> - 本版为本地适配移植版：验收哲学（渲染后亲眼看、gate 先行、残留占位符扫描、三次修复失败即上报求助）原样保留；Muse 专用脚本路径与执行机制改为参考式表述并逐条标注，未发明任何本机不存在的命令。

## 本环境适配

上游依赖逐条对照（本地环境 = Windows + Claude Code + E:\AI-Station）：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `/opt/hatch/skills/artifacts/scripts/` 下 gate 脚本：`render_audit.mjs`、`validate_pdf.sh`、`validate_xlsx.py`、`assemble_deck.mjs` | 【Muse 环境专用】 | 本机不存在 `/opt/hatch` 路径；vendored 快照（`E:/AI-Station/06 技能/library/MuseAI-Skills/`）也只收录 SKILL.md 文本、未含 scripts/。本地等价做法：按正文各 Gate 的判定意图用本机工具自建检查——pdf 渲染成页图逐页目检、xlsx 用 Python openpyxl 读回校验、csv 用 Python `csv` 读回。脚本契约原文见 vendored 原件 `.../artifacts/testing/SKILL.md` 的 Gate 表。 |
| `muse.exec` 执行器 + `yield_ms` 让位机制 | 【Muse 环境专用】 | 本地用 Claude Code Bash 工具直接执行渲染命令（前台设足超时，或 run_in_background），成败以落盘的报告/图片文件为准，不依赖 yield 语义。 |
| `web_artifacts.build` / `web_artifacts.audit` 审计工具 | 【Muse 环境专用】 | 本地无此内置工具；web 交付物用本机浏览器截图/抓取手段（如 Chrome MCP）实现同样的 capture-and-look，规则照套本技能。 |
| 各 artifacts 子技能 `workflow.md` 指定的 gate 旗标（pdf、presentation 等） | 【Muse 环境专用】 | vendored 快照在 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/{pdf,presentation,document,spreadsheet,markdown}/` 收有对应上游 SKILL.md 文本可查证旗标含义。 |
| Muse 连接器 OAuth、Muse VM 机制 | 【Muse 环境专用】 | 本上游技能正文未出现这两类依赖，无需映射（逐条列出以示已核查、非遗漏）。 |

## 移植正文

以下忠实保留上游内容结构与实质，英文正文保持英文；会误导本机执行的指令保留原文并就地标注为参考式。

# Artifact verification

One home for verification across the artifact namespace. The rule every
kind shares: a deliverable is verified by looking at what the user will
see, freshly rendered, not by trusting the code that produced it. Never
return a link while a gate below fails; after three failed fix attempts,
report the specific failure and ask for direction instead of iterating.

## File kinds: gates, then eyes

| Kind | Gate |
|---|---|
| pdf | `render_audit.mjs` with the flags the pdf skill's `workflow.md` names, then `/opt/hatch/skills/artifacts/scripts/validate_pdf.sh` |
| presentation | `assemble_deck.mjs`, then `render_audit.mjs` with the flags `workflow.md` names |
| docx | render to PDF with headless LibreOffice (`soffice --headless --convert-to pdf`), then rasterize (`pdftoppm -jpeg -r 100`) |
| xlsx | `/opt/hatch/skills/artifacts/scripts/validate_xlsx.py` |
| csv / md | parse it back (csv: a Python `csv` read; md: read the file) |

> 【Muse 环境专用】表中 `/opt/hatch/...` 脚本与 `render_audit.mjs`、`assemble_deck.mjs` 均为 Muse 环境脚本，本机不存在——执行时按上方「本环境适配」表的本地等价做法落地同一判定意图。docx 行的 `soffice` / `pdftoppm` 是通用命令而非 Muse 专有，但本机执行前须先确认已安装。

The shared render engine is `/opt/hatch/skills/artifacts/scripts/render_audit.mjs`;
renders outlast `muse.exec`'s default yield, so size `yield_ms` past the expected
runtime and read the report file the flags name rather than trusting a
backgrounded command's silence. 【Muse 环境专用——本地等价：Bash 前台跑渲染并设足超时，结束后读落盘的报告文件再判定成败，不信任后台命令的沉默。】

**Then look.** Read every validation PNG or page image with fresh eyes - the
generating context sees what it expects, not what rendered. Check first for
text overflow or cut-off content, then overlaps, collisions, cramped or
uneven spacing, low-contrast text, and template decoration left behind.

**Placeholder scan.** Before returning, search the deliverable's text for
leftover scaffolding: TODO, lorem, placeholder, [insert, xxx runs, and
sample rows the user never asked for. Anything found is fixed, not shipped.

## Web artifacts

Web builds keep their own audit tools (`web_artifacts.build` and
`web_artifacts.audit` run the same capture engine with enforcement)【Muse
环境专用——本地用本机浏览器截图工具完成同样的 capture 与强制检查】; this
skill's render-fresh and placeholder rules apply to their output all the
same.
