# 增量美化（incremental beauty）

**规则来源**：文档 **baseline**（同级段落样式众数）；样本不足时回退 [full-beauty.md](full-beauty.md)。

**核心策略**：样式表 + 挂名 —— 从 baseline 写入样式表，仅对 fixList 挂接同级样式名；**不**全文套 beauty-default。

---

## 工作流概览

**前置**：`formatList` 与 `overview`（style index + detail HTML）已就绪；模式已判定为 **incremental**。

```
Phase A  baseline + fixList
Phase B  oplist 编排
+ brief 变更摘要（同轮一次输出）
```

**同轮硬约束**：Phase A 与 Phase B、brief **一次输出**；禁止先输出 fixList、下一轮再编 oplist；禁止重复 baseline / anomaly / 美观差距计算。

---

## Phase A：baseline 与 fixList

依次完成：

1. 定 scope  
2. 提取 baseline（样式名 + 属性众数）  
3. anomaly 检测（§Anomaly）→ fixList  
4. 美观差距检测（§美观差距）→ **追加** fixList  

`fixList` 为空 → **结束流程**，不写回。

---

## Scope（修复范围）

优先级：

1. **用户 explicit scope** — 章节标题、条号、data-id 范围；只在此范围内做 anomaly  
2. **无指定** — 全文可评估块中的 fixList  
3. **exclusion zone**（始终 skip）— 表格、图片、文本框、**封面**（`coverZone`）、未入 formatList 的块  

定位用户章节：匹配 `catalog_h1` / skeleton 标题文本 → 取该标题至下一同级标题之间的 data-id 范围。

---

## Baseline（文档自身基准）

从 **scope 内、已写入 formatList 的块** 提取。

**优先**用 overview 的 **style index + detail HTML** 估算 `baselineStyleName` / `baselineProps`。**仅** index 不足时允许 **1 次**批量补读（§批量补读）。

```
1. 取 scope 内同 role 块（body / heading-1 / title / …）；每 role 至多抽 2 个代表 data-id
2. 优先从 style index / detail HTML 读 pStyle/class、fontSize、textAlign、textIndent、lineHeight、bold
3. 不足时 **1 次** wps_read 批量补读（§批量补读），禁止逐块、逐 class 多次调用
4. 样式名众数 → baselineStyleName[role]
5. 属性众数 → baselineProps[role]（转为 import_element_styles 的 pPr/rPr）
6. 同 role 样本 <3 → **改判 full**（见 [full-beauty.md](full-beauty.md)），**禁止**加载 `beauty-default.yaml` 代替 baseline
7. **跨 role 可区分性检查**：`heading-*` 与 `body` 不可区分 → 改判 full
8. **baseline 合理性检查**：`doc_title` / 各级标题 的 `baselineStyleName` 不应与 `body` 相同；相同 → 该 role 全部块进 fixList（`doc_title` 须重建为标题样式）
9. **层次平衡检查**：若标题与正文字号级差过大 → 为 title/heading-* 生成 `hierarchy_gap_excessive` fixList（见下）
```

### 批量补读（Phase A 至多 1 次 `wps_read`）

从 `formatList` 为每个存在的 tag **各取 1～2 个** data-id；将 style index 中出现的 top class 一并传入。**一次**调用返回 blocks + css 规则：

```js
(wps) => {
  const { doc, css } = wps
  const ids = ["56-63", "120-128", "409-474"]
  const blocks = ids.map(id => {
    const el = doc.querySelector('[data-id="' + id + '"]')
    return el ? el.outerHTML : ''
  })
  const classes = ['.normal', '.r2', '.r3', '.r5', '.r6', '.r7']
  const rules = {}
  classes.forEach(c => { rules[c] = css(c) })
  return JSON.stringify({ blocks, rules })
}
```

- `ids` 按实际文档替换；**禁止**为每个 id 或每个 class 单独再调 `wps_read`  
- 补读结果**不得**作为独立结构来源参与 reconcile（仅用于 baseline / 规整度深判）

```json
{
  "baselineStyleName": {
    "body": "正文",
    "heading-1": "Heading 1"
  },
  "baselineProps": {
    "body": { "fontSize": "12pt", "textIndent": "2em", "textAlign": "justify", "lineHeight": 1.35 },
    "heading-1": { "fontSize": "15pt", "bold": true, "textAlign": "left" }
  },
  "sampleCounts": { "body": 42, "heading-1": 6 }
}
```

**优先级**：`baselineStyleName` + `baselineProps`（来自 index / 补读）> 不修改；**禁止**用 `beauty-default.yaml` 填充 baseline

---

## Anomaly（异常检测）

### 块级 outlier

只对 **偏离同 role baseline** 的块进入 fixList。skeleton 对比 formatList，未列入但样式明显偏离 body 的块一并纳入（`unlisted_style_outlier`）。

| 异常 | 条件 |
|------|------|
| `styleName_outlier` | 段落样式名 ≠ 同 role 的 `baselineStyleName` |
| `fontSize_outlier` | 与同 role baseline 差 ≥1.5pt |
| `indent_outlier` | 段首全角空格但 baseline 用 textIndent；或 textIndent 不一致 |
| `align_outlier` | 正文 center 但 baseline 为 justify/left；落款（`signature`）非右对齐 |
| `spacing_before_outlier` | 落款**首段**段前距 **<18pt**（目标 **24pt**，与正文拉开） |
| `heading_level_jump` | h2 字号 ≥ h1，或 h3 ≥ h2（含 **h3 与 h2 同字号**） |
| `empty_stack` | scope 内连续空段 >2 且无相邻标题 |
| `list_as_heading` | numFormatList 成员却被 reconcile 为 heading-* |
| `run_color_mixed` | 同一自然段内出现多个正文色，且不是链接、批注、修订或用户明确要求保留的强调色 |
| `bracket_heading_indented` | 以 `（一）`、`（1）`、`(1)` 等括号编号开头的标题/条目使用了正文首行缩进 |
| `unlisted_style_outlier` | 未入 formatList，样式偏离 body baseline |

### 层次过激（`hierarchy_gap_excessive`）

当 `hierarchyBalanceOk === false` 时，**该 role 下所有 heading 块**（即使与同 role baseline 一致）进入 fixList：

| 字段 | 说明 |
|------|------|
| `issue` | `hierarchy_gap_excessive` |
| `current` | 该块当前字号（与同 role baseline 相同） |
| `targetProps` | **inline** 字号/加粗：优先按文档 h1→h2 梯度推算；畸态规整时可参考 h1=14pt、h2=13pt、h3=12pt bold（**禁止**打开 `beauty-default.yaml` 查表） |
| `targetStyleName` | 保留 `baselineStyleName[role]`；无命名样式时新建 `_DocBeauty_hN` |


Phase B 编排：`import_element_styles` 写入调整后的 heading 规则（保留 `baselineStyleName` + inline `targetProps`），再对 fixList 挂接。

---

## 美观差距（追加 fixList）

文档**内部一致**（同 role 无 outlier），但 baseline **观感不佳**时，§Anomaly 得不到条目。对 `baselineProps` 检查；不达标则该 role 在 scope 内**全部块**追加进 fixList。

---

## fixList → oplist：标题样式统一（易漏，必查）

incremental 编排时 agent **常只写 `main_text`**，遗漏 fixList 中的标题项。凡 fixList 含任一标题 role，**必须**同步写入标题的 `import_element_styles` + `batch_apply_paragraph_style`，**禁止** oplist 仅有正文挂接。

### role → formatList tag

| fixList `role` | `batch_apply` 的 `source.tag` | `import_element_styles` 的 `element` |
|----------------|------------------------------|--------------------------------------|
| `doc_title` | `doc_title` | `title` |
| `heading-1` | `catalog_h1` | `heading 1` |
| `heading-2` | `catalog_h2` | `heading 2` |
| `heading-3` | `catalog_h3` | `heading 3` |
| `heading-4` | `catalog_h4` | `heading 4` |
| `heading-5` | `catalog_h5` | `heading 5` |

### 编制算法（Phase B 输出 oplist 前逐步执行）

```
1. 从 fixList 收集 headingRoles = 所有 role ∈ {doc_title, heading-1 … heading-5}
2. 若 headingRoles 为空 → 仅需正文/落款等非标题 rules；跳过下述标题步骤
3. 若 headingRoles 非空：
   a. 对 headingRoles 中每个 role，按上表得到 tag + element
   b. import_element_styles.element_style_rules[] 须含该 role 的样式定义
      - 一般条目：baselineStyleName[role] + baselineProps[role]（pPr/rPr）
      - hierarchy_gap_excessive / beauty_gap_*：同上 style_name，rPr/pPr 用 fixList 的 targetProps 覆盖
   c. batch_apply_paragraph_style.format_rule.rules[] 须含每条 tag 一条 rule：
      { "source": { "tag": "<上表 tag>" },
        "target": { "element": "<上表 element>", "style_name": "<baselineStyleName[role]>" },
        "is_normal": false, "clear_span_props": true }
   d. doc_title 与 catalog_h1 禁止共用 style_name（硬约束 #6）
4. 标题 fix 与正文 fix 写在**同一条** batch_apply 的 rules[] 中，一次提交
```

### 典型遗漏与纠正

| ❌ 遗漏 | ✅ 纠正 |
|--------|--------|
| fixList 有 `heading-1` 异常，oplist 只 `batch_apply` 了 `main_text` | 补 `catalog_h1` 的 import + batch_apply rule |
| 只写了 `import_element_styles` 的 Heading 1，未写 `batch_apply` 的 `catalog_h1` | import 与 batch_apply **成对**出现 |
| `hierarchy_gap_excessive` 涉及 h1、h2，只处理了 h1 | fixList 中**每个**标题 role 各一条 import + batch_apply |
| `styleName_outlier` 的标题块进了 fixList，但未按 tag 挂接 | 按 **tag** 合并挂接（非逐 data-id 裸写 inline） |

fixList **仅含正文**异常时，可不写标题 rules；**任一**标题 role 在 fixList 中 → 上表涉及的全部 tag **必须**出现在 oplist 中。

```json
{
  "fixList": [
    {
      "dataId": "409-474",
      "role": "body",
      "issue": "fontSize_outlier",
      "current": { "styleName": "—", "fontSize": "15pt" },
      "targetStyleName": "正文"
    },
    {
      "dataId": "120-128",
      "role": "heading-1",
      "issue": "hierarchy_gap_excessive",
      "current": { "styleName": "Heading 1", "fontSize": "26pt" },
      "targetStyleName": "Heading 1",
      "targetProps": { "fontSize": "14pt", "bold": true }
    }
  ],
  "untouchedCount": 98
}
```

---

## Phase B：oplist 编排（产出单个 oplist 数组）

> **禁止**拆分为多次 `oplist_exec` 调用。以下 1～4 是 **oplist 数组内元素的排列顺序**，最终合并为一个 `{"oplist":[...]}` 一次提交。

```
oplist 数组元素（§本路径可用 op，一次提交 oplist_exec）：
  1. 结构清理（按需）               → trim / cleanup
  2. import_element_styles         → baselineProps 写入样式表（每 role 至多一条规则）
  3. batch_apply_paragraph_style   → 仅 fixList 对应 scope 挂接 targetStyleName
  4. 段落格式（按需）               → 缩进 / 间距 / 其他句属性
```

### 本路径可用 op

按需选取，**禁止**使用此列表之外的 op。

```
trim_paragraph_leading_chars → cleanup_empty_paragraphs
→ import_element_styles
→ batch_apply_paragraph_style
→ batch_set_paragraph_indent → batch_set_span_style
→ batch_set_spacing
```

各 op 字段详见 `references/tools/atomic-ops/` 对应文件；单位见 `atomic-ops.md §单位约定`。

### 编排硬约束

违反任一条将失败或误改全文。写回前自检：全部 `target.element` 或 `target.style_name` 已在 `import_element_styles` 定义；全部 `source.tag` 在 `formatList` 中；每条 action 已对照对应 `atomic-ops/<op>.md`。

| # | 约束 | 说明 |
|---|------|------|
| 1 | **样式库路径** | `import_element_styles` 在前；`element_style_rules` 覆盖本 oplist 全部 `batch_apply_paragraph_style` 的 `target.element` 或 `target.style_name`（`main_text` 挂 `Normal` 时 `import_element_styles` **须含 `element: "Normal"`**） |
| 2 | **batch_apply 形态** | `scope: {}`；`format_rule.rules[]`（禁 `pPr.pStyle`、`scope.heading`）；每条含 `source.tag`（formatList 键）、`target.element`（OOXML 名如 `Normal`/`heading 1`）、`is_normal`、`clear_span_props` |
| 3 | **段落级 vs run 级** | 字体/段距/缩进 → import + batch_apply；局部加粗等 → `batch_set_span_style`（`rPr` 须含 `b`/`i`/`sz` 之一，禁仅 `rFonts`） |
| 4 | **scope 引擎格式** | 按块类型收窄用三段式 scope（见 `atomic-ops.md` §scope）；**禁止** `{ "heading": "..." }` |
| 5 | **单位** | 见 `atomic-ops.md` §单位约定 |
| 6 | **doc_title ≠ catalog_h1** | `doc_title` 与 `catalog_h1` **禁止**共用 `target.style_name`；title 须独立样式，居中且字号大于 h1 |
| 7 | **pPr 写入的副作用** | `batch_set_spacing` 虽然只声明 `spacing`，但 `pPr` 写入时可能**重置**同层的 `ind`、`jc` 等已挂接属性；解决：(a) spacing 仅在 `import_element_styles` 的样式定义中声明；(b) 必须独立调用时 scope 限定到具体 tag |
| 8 | **单次提交** | 全部 op 合入一个 `oplist` 数组，**一次** `oplist_exec` 提交；**禁止**拆分为多次调用 |
| 9 | **标题成对挂接** | fixList 含任一标题 role → `import_element_styles` 与 `batch_apply` **均须**覆盖对应 `catalog_h*` / `doc_title`（见 §fixList → oplist：标题样式统一）；**禁止**仅有 `main_text` rule |

**常见误用**：

- ❌ 未先 `import_element_styles` 就挂接样式
- ❌ fixList 有标题异常，oplist 只写了 `main_text` 的 `batch_apply`（须补 `catalog_h*` / `doc_title`）
- ❌ 写了标题的 `import_element_styles` 却漏写同 tag 的 `batch_apply` rule
- ❌ `source.tag` 填 scope `type`（如 `heading1`）— 应填 formatList 键（如 `catalog_h1`）
- ❌ 颜色值**必须**是`"color":"#RRGGBB"`这种RGB的颜色值，不确定的颜色值使用`"color":"#000000"`兜底

### oplist 元素：import_element_styles

优先使用 `baselineStyleName[role]` 作为 `style_name`；文档无可用名时新建（如 `_DocBeauty_body`）。

fixList 涉及的 role **必须**在样式表中有对应条目。**fixList 含标题 role 时**，须为每个涉及的 `catalog_h*` / `doc_title` 写入对应 `element_style_rules` 条目（见 §fixList → oplist：标题样式统一）。

### oplist 元素：batch_apply_paragraph_style

按 fixList **按 role 合并**后挂接：正文用 `main_text` / `signature` 等 tag；**标题须按 §fixList → oplist：标题样式统一** 为 fixList 涉及的每个 `catalog_h*` / `doc_title` 各写一条 rule，**禁止**仅有正文 rule。

遇到 `run_color_mixed` 或需要统一段内颜色的 fix，`clear_span_props` 必须为 `true`，必要时再用 `batch_set_span_style` 补回句级加粗等属性。

带括号编号开头的标题/条目若进入 `bracket_heading_indented`，不要改正文整体缩进；只对这些 data-id 追加 `batch_set_paragraph_indent`，写入 `format_rule.pPr.ind.firstLine: "0pt"`。

禁止对 fixList **逐段裸写** inline 属性（须挂样式名）。

### 完整 oplist 示例（一次提交 oplist_exec）

以下为 incremental 模式典型 oplist：fixList 同时含正文与一级标题异常，**标题与正文 rules 须同批出现**。

```json
{
  "oplist": [
    { "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } },
    { "scope": {}, "action": { "type": "cleanup_empty_paragraphs" } },
    {
      "scope": {},
      "action": {
        "type": "import_element_styles",
        "element_style_rules": [
          {
            "element": "Normal", "style_name": "正文",
            "pPr": { "jc": "both", "outlineLvl": 10, "ind": { "firstLine": "2ch" }, "spacing": { "line": "1.35x", "before": "0pt", "after": "0pt" } },
            "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
          },
          {
            "element": "heading 1", "style_name": "Heading 1",
            "pPr": { "jc": "start", "outlineLvl": 1, "keepNext": true, "ind": { "firstLine": "0pt" }, "spacing": { "line": "1.35x", "before": "6pt", "after": "3pt" } },
            "rPr": { "sz": 14, "b": true, "rFonts": { "eastAsia": "黑体" } }
          }
        ]
      }
    },
    {
      "scope": {},
      "action": {
        "type": "batch_apply_paragraph_style",
        "format_rule": {
          "rules": [
            { "source": { "tag": "main_text" },  "target": { "element": "Normal", "style_name": "正文" },      "is_normal": true,  "clear_span_props": true },
            { "source": { "tag": "catalog_h1" }, "target": { "element": "heading 1", "style_name": "Heading 1" }, "is_normal": false, "clear_span_props": true }
          ]
        }
      }
    }
  ]
}
```

---

## 规划 JSON 要点

```json
{
  "mode": "incremental",
  "status": "planned",
  "ruleSource": "document-baseline",
  "fixList": [],
  "untouchedCount": 98,
  "oplist": []
}
```

`ruleSource` 为 `document-baseline`；baseline 样本不足回退 beauty-default 时可为 `beauty-default`。

---

## 用户摘要模板

> 文档整体已较规整（正文 {dominant}% 为 {size}）。已从 baseline 提取 {m} 种样式；发现 {n} 处异常，**仅修改这 {n} 处**，其余 {untouched} 段保持不变。

畸态规整时补充：

> 各级标题与正文字号级差偏大（如一级标题 {h1}pt / 正文 {body}pt），将按适中梯度微调标题字号，正文与其余段落不变。

---

## 应有的检查链

写回前**逐项勾选**（标题项为 incremental 最易遗漏）：

- **标题样式（fixList 含标题 role 时必查）**
  - [ ] `import_element_styles` 已为 fixList 涉及的每个 `catalog_h*` / `doc_title` 写入样式定义
  - [ ] `batch_apply_paragraph_style.rules[]` 含与上表对应的每条 `source.tag`（非仅 `main_text`）
  - [ ] `target.style_name` 与 import 同条规则一致；`doc_title` ≠ `catalog_h1` 的 style_name
  - [ ] `hierarchy_gap_excessive` 时，fixList 中每个标题 role 均有 import + batch_apply 成对条目
- 字号/行距：围绕正文小四 12pt 建立层级；标题过大时优先收敛到 title 18pt、heading-1 14pt、heading-2 13pt、heading-3/4 12pt 加粗；12pt 正文建议行距 1.35 倍
- 标题/段距：首行缩进0字符；正文首行缩进2字符；括号编号开头的标题/条目首行缩进必须为0；标题段前段后随小四正文收紧

## 禁止

- 读取 §禁止加载清单 中的 full 专用 yaml/md（含「加载 beauty 默认基线 / 字号配套 / 配色主题」类动作）
- Phase A 内 **多次** `wps_read` / `css()` / 逐块 `querySelector`（全程 ≤1 次批量补读，见 §批量补读）
- index 已足够 baseline 时仍「批量读取关键块 HTML」
- 对 fixList 外块「顺便统一」
- fixList 有样本充足 baseline 仍全文套 beauty-default
- 样式表未定义就对 fixList 挂名
- 读取 [full-beauty.md](full-beauty.md) 的全文统一逻辑
- 套用 `user-spec` 或 strict 规范
- `doc_title` 与 `catalog_h1` 共用 `style_name`
- 带括号编号标题/条目沿用正文首行缩进
- fixList 含标题 role 但 oplist **仅** `batch_apply` 了 `main_text`（须补全对应 `catalog_h*` / `doc_title` rules）
- 仅为标题写了 `import_element_styles` 却未写同 tag 的 `batch_apply` rule（须成对）
- 拆分 oplist 为多次 `oplist_exec` 调用（正确做法：全部 op 合入一个数组一次提交）
