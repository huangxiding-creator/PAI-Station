---
name: muse-artifact-spreadsheet
description: Create, read, edit, fix, or clean spreadsheet files (.xlsx, .xlsm, .csv, .tsv) - use whenever a task's artifact kind is spreadsheet, or the task names a spreadsheet file and wants something done to or produced from it, including restructuring messy tabular data into a proper workbook; covers openpyxl generation, formulas and recalculation, editing existing workbooks, and the validation gates; not for deliverables that merely contain a table.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/artifacts/spreadsheet/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills 仓库 @38bbb45（非官方快照，github.com/win4r/MuseAI-Skills），上游技能名 `artifact_spreadsheet`。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/spreadsheet/`（SKILL.md 57 行 + references/formulas.md 67 行 + references/visual.md 61 行，均在本机可直读）。
> - 本版为本地适配移植版：交付规则、公式存活纪律、视觉与验收门语义原样保留；`/opt/hatch` 脚本路径与 Muse 执行机制改为参考式表述并逐条标注，未发明任何本机不存在的命令。

## 本环境适配

上游依赖逐条对照（本地环境 = Windows + Claude Code + E:\AI-Station）：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| `/opt/hatch/skills/artifacts/scripts/recalc_xlsx.py`（headless LibreOffice 原地重算，JSON 报全部公式错误格） | 【Muse 环境专用】 | 本机无 `/opt/hatch`；vendored 快照只收 SKILL.md 与 references/、未含 scripts/。本地实测：标准路径未装 LibreOffice，注册表在位 `Excel.Application` COM。需真重算门时用 pywin32 驱动 Excel 打开→强制重算→逐格读错误→保存，或先装 LibreOffice 后按 `soffice --headless` 语义自建；两者皆不可用时如实声明"未经重算"，不得假装通过。脚本 JSON 契约见 vendored `.../spreadsheet/references/formulas.md` 首节。 |
| `/opt/hatch/skills/artifacts/scripts/validate_xlsx.py`（读回校验：zip 完整性 / sheet 部件 / 非空格计数） | 【Muse 环境专用】 | 未随快照落盘。本地等价：openpyxl 读回——打开不抛异常即 zip 完整、枚举 sheet 名单、统计 populated cells，计数写进交付摘要；csv 交付物无读回校验（上游同规）。 |
| `muse.read`（转 markdown 分页速览，不带坐标） | 【Muse 环境专用】 | 本地：csv/tsv 直接 Read；xlsx 用 openpyxl 或 pandas dump 成文本速览。同样不带坐标，不可据以规划编辑。 |
| `/opt/hatch/skills/artifacts/spreadsheet/references/{formulas,visual}.md` | 路径映射 | vendored 原件在本机：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/spreadsheet/references/`，直接读（本文件末尾附两件浓缩版）。 |
| `/opt/hatch/skills/artifacts/testing/SKILL.md` 验收总纲 | 路径映射 | vendored 原件在 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/testing/SKILL.md`；本地另有已移植技能 `muse-artifact-testing`（Skill 工具可调）。 |
| `pip install --break-system-packages pandas` | 【Muse 环境专用】 | `--break-system-packages` 是 Muse Linux 的 PEP 668 解法；本地 Windows 在项目 venv 内直接 `pip install pandas`。 |
| `python3` 调用；`$JARVIS_HOME` / `project_dir` / `files/` 构建任务上下文（visual.md 校验块） | 【Muse 环境专用】 | 本地 bash PATH 未必有裸 `python`/`python3`，用本机在役 Python 3.11（venv 激活或绝对路径调用）；产物路径取当前任务实际输出目录；`.src/` 生成器目录惯例原样保留。 |
| 上游 frontmatter `metadata: { "includeInPrompt": false }` | 【Muse 环境专用】 | Claude Code 技能无此字段，弃用（触发全靠 description）。 |
| hatch_* CLI / Muse 连接器 OAuth / Muse VM 机制 | 【Muse 环境专用】 | 本上游技能正文未出现这三类依赖，无需映射（逐条列出以示已核查、非遗漏）。 |

## 移植正文

以下忠实保留上游内容结构与实质，英文正文保持英文；会误导本机执行的指令保留原文并就地标注（本地等价见上表）。

# Spreadsheet artifacts

An xlsx is generated with the preinstalled `openpyxl` library from a
generator script. Keep the generator under `.src/`: it is the editable
source for future revisions, and the binary is always regenerated from it.

| Task | Path |
|---|---|
| Create, or edit with formulas and formatting | `openpyxl` |
| Quick look at an existing sheet | `muse.read` (converted to markdown, paged); it carries no cell coordinates, so never plan edits from it【Muse 环境专用→本地：Read / pandas dump，见适配表】 |
| Read a workbook's model (formulas AND their values) | two `load_workbook` passes; see `/opt/hatch/skills/artifacts/spreadsheet/references/formulas.md`【本地 vendored：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/artifacts/spreadsheet/references/formulas.md`，浓缩版见下】 |
| Bulk or messy tabular data in or out | Python `csv` from the standard library; `pip install --break-system-packages pandas` when a task genuinely needs it【Muse 环境专用→本地：venv 内 `pip install pandas`】 |
| Design, structure, number formats, model conventions | `/opt/hatch/skills/artifacts/spreadsheet/references/visual.md`【本地 vendored 同目录，浓缩版见下】 |
| Formulas, recalculation, editing existing workbooks | `/opt/hatch/skills/artifacts/spreadsheet/references/formulas.md`【同上】 |

Requirements on every delivered workbook:

- Set a non-empty `workbook.properties.title` and a human-readable
  filename. Data enters the workbook from the build's gathered content
  only; a value you do not have is a blank cell or a question, never an
  invented number.
- Write formulas, never precomputed results: `sheet["B10"] = "=SUM(B2:B9)"`,
  not the Python-computed total. The sheet must recalculate when its
  inputs change.
- Follow the user's spec literally: their exact tab names, exact column
  headers, and the formula they spelled out. A redesign that computes
  something else fails, however elegant.
- Zero formula errors at delivery: run the recalculation gate below and
  fix what it names.
- Document assumptions and hardcoded numbers where the reader will see
  them (a cell comment or an adjacent labeled cell), citing the real
  source when one exists and saying plainly when the number came from the
  user.
- A workbook created for someone to fill in gets a short legend naming
  the cells to edit and one example row of realistic values; never add an
  example row to a file you were asked to edit.

## Scripts【Muse 环境专用→本地等价见适配表】

| Script | What it does |
|---|---|
| `/opt/hatch/skills/artifacts/scripts/recalc_xlsx.py` | Recalculates the workbook in place through headless LibreOffice and reports every formula-error cell as JSON; mandatory whenever the file contains formulas. `errors_found` exits 0: read the JSON, not the exit code |
| `/opt/hatch/skills/artifacts/scripts/validate_xlsx.py` | Opens the workbook read-back: zip integrity, sheet parts, populated-cell counts; do not deliver a link while it fails. A csv output gets no reader check |

## Verification

Run `recalc_xlsx.py` (when formulas exist), then `validate_xlsx.py`, then
follow `/opt/hatch/skills/artifacts/testing/SKILL.md`【本地：适配表映射的等价门 + `muse-artifact-testing` 技能】. A clean recalculation proves
the formulas evaluate, not that they are right: spot-check two or three
formulas pull the values you expect before building out a grid.

## 附 A：Formulas, recalculation, and editing existing workbooks（references/formulas.md 浓缩版；完整版见 vendored 原件）

### Why recalculation is mandatory

openpyxl writes a formula as a bare string with no cached value. Until a
real engine recalculates the file, every formula cell reads back as empty
to previewers, pandas, and `load_workbook(data_only=True)`: an
un-recalculated deliverable looks blank to the user. Run the recalc gate
after every save that touches formulas; it rewrites the file in place and
returns JSON with `status` (`success` or `errors_found`),
`total_formulas`, `total_errors`, and an `error_summary` naming error
cells (locations cap at 100 per error type with a `locations_truncated`
count, so trust `total_errors`, not the list length). `errors_found`
exits 0; an `error` key instead of a `status` means nothing was
recalculated. Never deliver while it reports errors, and never blame a
pre-existing error without proving it: load the original with
`data_only=True` and look at that cell first.

A workbook that links to another FILE is a special case: the linked file
is not on this machine, so its cells' cached values are the only data
present, and an openpyxl re-save strips them; recalculation then turns
each into an error. The recalc script refuses such files without
`--force`. Copy the linked cells' values out before saving over them.

### Choosing formulas that survive

The engine that recalculates here is LibreOffice, which implements fewer
functions than Excel; a function it cannot evaluate ships as a literal
`#NAME?`.

- Prefer the classic set: `SUM`, `SUMIFS`, `INDEX`, `MATCH`, `IFERROR`,
  `SUMPRODUCT`, and their generation.
- Post-2007 names are stored prefixed in the XML, and openpyxl writes your
  string verbatim, so write `_xlfn.TEXTJOIN`, `_xlfn.CONCAT`, `_xlfn.IFS`,
  `_xlfn.SWITCH`, `_xlfn.MAXIFS`, `_xlfn.MINIFS`; written bare each one
  yields `#NAME?`.
- Never use the spilling array functions: `XLOOKUP`, `XMATCH`, `SORT`,
  `FILTER`, `UNIQUE`, `SEQUENCE`. Even where an engine evaluates them, an
  openpyxl-written file carries no spill metadata, so only the top-left
  cell gets a value and the recalculation gate reads the truncated result
  as zero errors. Use `INDEX`/`MATCH` for lookups, and sort, filter, and
  de-duplicate in Python before writing cells.
- A formula the engine could not parse comes back lowercased in the file,
  a quick tell beside a `#NAME?`.
- Quote a sheet name containing a space in cross-sheet references:
  `='Assumptions Inputs'!$B$5`; unquoted it evaluates to an error.

### openpyxl gotchas

- Reading a model takes two loads: `data_only=True` gives cached values
  with the formulas gone; the default gives formula strings with no
  values. One pass cannot give both.
- `data_only=True` is destructive if you save: that in-memory workbook has
  no formulas left, so saving replaces every one with a literal.
- `data_only=True` on a file openpyxl just wrote returns `None`
  everywhere; recalculate first. A formula whose result is an empty string
  also reads back as `None`, so `None` alone proves nothing.
- Merged ranges: write the top-left anchor only; every other cell in the
  range is read-only.
- An `.xlsm` loses its macros unless loaded with `keep_vba=True`.

### Editing an existing workbook

The file's own conventions override every guideline here. Find its
designated input cells first (a distinct font color, fill, or shading
marks them), write only there, and leave every existing formula untouched.
Match the existing number formats and fonts rather than restyling.

## 附 B：Visual guidance（references/visual.md 浓缩版；完整版见 vendored 原件）

User-provided visual direction in the verbatim request or the parent
conversation is authoritative【Muse 环境专用字段 `verbatim_request`→本地即用户原话】. Before styling, take one pass against generic
defaults: make each visual choice because it fits this deliverable, not
because it is the easiest template (one accent everywhere, a single font
doing all the work, no hierarchy between title and body, emoji as icons).

- Do not apply a saved PDF theme unless the user asked for styling.
- Use a visible title, clear hierarchy, consistent spacing, and restrained
  color. Tables need readable headers, stable alignment, and number
  formats appropriate to their data.
- Charts, plots, maps, and other factual graphics are generated
  deterministically from their source data.

### Validation

Read the workbook back before returning its link:

```sh
# Muse 原文以 $JARVIS_HOME/<project_dir> 定位产物目录【Muse 环境专用】
# 本地：DIR 取当前任务实际输出目录，脚本调用换成本地等价门（见适配表）。
DIR="<本任务实际输出目录>"
python "/opt/hatch/skills/artifacts/scripts/validate_xlsx.py" \
  "$DIR/<file_name>.xlsx" --json-out "$DIR/.src/validate/xlsx.json"
```

- It exits non-zero on a file that is not a real workbook, a corrupt
  archive, or one whose sheets are all empty. Fix and rerun; do not
  deliver a link while it fails. Pass `--allow-empty` when a blank
  template is the request.
- Quote its sheet, cell, and formula counts in your summary. A `csv`
  output gets no reader check.

### Financial-model conventions

Defaults for models and calculators, unless the user says otherwise or an
existing file already does something else:

- Color code by role: blue text for hardcoded inputs and scenario levers,
  black for formulas, green for links to another sheet, red for links to
  another file, yellow fill for key assumptions and the cells the user
  should fill in.
- Number formats: currency `$#,##0` with the unit named in the header
  (`Revenue ($mm)`); negatives in parentheses and zeros rendered as a dash
  (`$#,##0;($#,##0);-`); percentages `0.0%` stored as fractions (`0.15`
  renders 15.0%, storing `15` renders 1500.0%); valuation multiples
  `0.0x`; years as text so `2024` never renders `2,024`.
- Structure: every assumption in its own labeled cell, referenced by the
  formulas that use it (`=B5*(1+$B$6)`, never `=B5*1.05`); formulas
  consistent across every projection period, since a lone hand-edited cell
  mid-row is the commonest silent error; guard denominators that can be
  zero.
- A professional default font throughout (the Muse cell ships Liberation
  Sans and Liberation Serif as the Arial and Times stand-ins【Muse
  环境专用字体栈→本地用 Arial/Times 或系统等价字体】).
