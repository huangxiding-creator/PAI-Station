
# 美化排版（beauty）

规整用户文档，使排版一致、干净、易读、美观。**不是**公文/论文等国标或单位模板的强制合规工具；**不是**按用户规范逐条匹配的 strict 排版。

## 额外的文件目录, 每个文件后附有功能说明，按需加载，不要一次性全部加载

```
wps-doc-aitypeset/
│
└── references/
   ├── doc_structure/                    ← 文档结构识别（A/B 源）
   │   ├── doc-element-recog.md          → doc_element_recog 结构识别（A 源）
   │   └── structure-reconciliation.md   → 双源结构合并（产出 formatList）
   │
   ├── beauty/                           ← 美观模式（beauty）执行细则
   │   ├── full-beauty.md                → full 模式 oplist 编排
   │   ├── incremental-beauty.md         → incremental 模式 baseline、fixList、oplist
   │   ├── beauty-default.yaml           → full 排版基线（对齐/缩进/间距）
   │   ├── beauty-type-scales.yaml       → full 字号配套（按文档类别）
   │   ├── beauty-palettes.yaml          → full 配色主题
   │   ├── beauty-theme-select.md        → full 主体风格选择（配色 + 字号配套）
   │
   └── tools/                            ← 工具能力说明
       ├── overview-format.md            → overview 输出解析（B 源）
       ├── wps_read_usage.md             → wps_read 工具用法
       ├── wps-toolcall-oplist.md        → oplist 写回相关 wps_toolcall_fmt op
       └── atomic-ops.md                 → 编排 oplist 的原子 Op 能力说明；编辑 oplist 之前必须先阅读
```

## 工作模式

| 工作模式 | 触发 | 规则来源 |
|---------|------|----------|
| **full**        | 全文格式很乱，找不到可参考的段落   | [full-beauty.md] + beauty-default + type-scales + beauty-palettes |
| **incremental** | 全文格式比较规整、**跨 role 有层次**，部分段落与众不同 | [incremental-beauty.md]（文档 baseline） |

## 工作流

```
0. Markdown 转换

1. 先调用 `wps_read → wps.overview()` → 检查 `skeleton` 是否含 `<table>` 元素
   - **有表格**：从 skeleton 提取所有 `<table data-id="X-Y">` 的 GCP，合并为一个 `gcpRange` → 调用 `wps_ai_table_style(gcpRange={start, end})对表格进行预排版`, 表格预排版后 **重新** `overview()` 采集 B 源，再进入 Step 2。
   - **无表格**：跳过表格预排版。**复用**本次 overview 结果作为 B 源，进入 Step 2。
2.  多源文档结构采集与合并 → formatList（细则见 `structure-reconciliation.md`）
3+4. 规整度评估 + oplist编排 + brief 摘要（同轮输出）
5. oplist_exec 落地写回  → open_typeset_session(recog_result: formatList + splitHints) → oplist_exec → close_typeset_session
```

### Step 0 — Markdown 转换

调用 `wps_toolcall_fmt("convert_markdown", "{}")`，将文档中的 Markdown 内容转为 Word 段落结构；后续 Step 1～5 均基于转换后的文档执行。
调用失败不重试，直接无视进入后续流程。

### Step 2 — 多源结构合并

此步会解决多源合并的所有冲突，后续需要文档结构时，直接读取本步输出的 `formatList`。  
**禁止**后续步骤再次去解析文档结构、解析结构冲突。

### Step 3+4 — 规整度评估与 oplist 编排（同轮输出）

#### 规整度评估

**注意**直接使用上一步产出 **`formatList`** & **overview**（style index + detail HTML）即可快速找到某类 role 的样式。

**判定顺序**（依次检查；1～3 全过则默认 incremental）：

1. 提取各级标题 baseline（一级～五级）：同类 role 至少 **≥50%** 视觉相同。  
   **无法**找到某级 baseline → **full**
2. 各级标题字号梯度：梯度过大，或多级标题完全同字号、无层次 → **full**  
   （仅有一级标题、无多级梯度问题 → **不算**失败）
3. 最低级标题 vs 正文（正文抽 3～5 个较长段落）：视觉无法区分（正文无加粗 & 标题加粗了 = 可以区分），或正文字号 **≥** 标题 → **full**
4. 上述 1～3 **均通过** → **incremental**（见下）。**局部**不一致（如 10pt vs 10.5pt 混用、个别对齐不同）不是改判 full 的理由；仅 baseline 抽不出、层次真无法区分时才用 **full**

**走 incremental 时**（1～3 已通过）：

- 加载 [incremental-beauty.md](beauty/incremental-beauty.md)，按其中流程完成 fixList 与 oplist 编排

**走 full 时**（满足任一）：

- 规则 1～3 任一失败  
- 全文找不到可参考 baseline（同 role 多数段样式分散、无众数）  
- 标题与正文**整体**假规整（同字号同加粗同 pStyle，结构能分清但视觉无层次）

**禁止**因「还想更干净一点」「想套 beauty-default」在 1～3 已通过时改判 full。  
**禁止**把 A/B 结构合并是否冲突当作 full/incremental 依据。

#### oplist编排需要按不同模式加载规则文件
  **full模式**一次性加载：
    beauty/full-beauty.md
    beauty/beauty-theme-select.md
    beauty/beauty-default.yaml
    beauty/beauty-type-scales.yaml
    beauty/beauty-palettes.yaml
  **incremental模式**只需要加载：beauty/incremental-beauty.md

- **禁止**用 `python_cell_exec` / 脚本组装、打印或校验规划 JSON——写脚本比填模板更慢，且易误判为写回步骤。
- **禁止**在 Step 3+4 落盘 oplist 文件；写回前按 `atomic-ops.md` §paramString 自检清单逐项勾选（括号闭合、引号转义在写入 `wps_toolcall_fmt` 前核对）。
- **禁止**在代码里换算 pt/twip/半磅。单位数值 **查** `atomic-ops.md` §单位约定速查表

#### 变更摘要 brief

1. **一句话结论** — 说清价值与范围，例如：「将在 **47 处** 统一正文字号为 12pt 并规范缩进，**删除 5 个**多余空段。」
2. **发现的问题** — 如字号混用、空段、层次不清。
3. **变更表** — 列 `变更类型 | 处数 | 现状 → 改后 | 示例位置`；按 **from→to 聚合**，禁止按 role 模板名罗列目标样式。

**原则**：先问题后方案；每条带可定位信息（章节名/首句/`data-id`）；样式变更与结构变更（删空段等）分开统计；`skipped` 须说明原因。

```markdown
## 变更摘要
> 将在 N 处统一正文字号并规范缩进，删除 M 个空段；K 块保持不动。

**发现的问题**：…

**变更表**：…
| 变更类型 | 处数 | 现状 → 改后 | 示例位置 |
|----------|------|-------------|----------|
| 字号统一 | 17 | 14pt/15pt → 12pt | 「第一条…」（data-id 409-474） |

```

### Step 5 — oplist_exec 落地写回

Step 3+4 已输出完整 oplist JSON 且 §paramString 自检清单全部通过后，经 session 一次性写回。**必须**调用 **`wps_toolcall_fmt`**（见 `references/tools/wps-toolcall-oplist.md` §3）。

```
1. wps_toolcall_fmt("open_typeset_session", '{"recog_result":{"formatList":...}}')
2. wps_toolcall_fmt("oplist_exec", '{"oplist":[...]}')
3. wps_toolcall_fmt("close_typeset_session", "{}")
```

- `oplist_exec` **非幂等**；失败**不重试**，向用户报告 `failed` 项
- 成功后将规划 JSON 的 `status` 更新为 `applied`，向用户说明排版已完成，引导在文档中查看
- 用户追问「具体改了什么」时，以 `changeSummary` 如实说明；系统未返回逐条执行日志时，请用户以当前文档为准核对


## 禁止事项

- 禁止 Step 3+4 多次 `wps_read` / 重复 `overview()` / 按块或按 class 分散取证
- 禁止 Step 3 与 Step 4 拆成两轮输出（须同轮给出 `oplist` + brief 摘要）
- 禁止未校验、未输出完整 oplist 即调用 `oplist_exec`
- 禁止跳过 `open_typeset_session` / `close_typeset_session`