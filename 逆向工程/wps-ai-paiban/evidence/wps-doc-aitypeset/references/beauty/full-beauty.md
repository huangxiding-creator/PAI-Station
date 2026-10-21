# 全量美化（full beauty）

使用内置的一些样式对全文的role进行美化。

**规则来源**：`beauty-default.yaml`（排版基线）+ `beauty-type-scales.yaml`（字号配套）+ `beauty-palettes.yaml`（配色，自动选主题）。

**核心策略**：按 role 写入样式表 → 全文挂接命名样式；**不**从文档 baseline 学样式。

---

## oplist 编排流程（产出单个 oplist 数组）

```
决策阶段（不产出 op）：
  1+2. themeAssessment + scaleAssessment → 主体风格（配色 + 字号，见 beauty-theme-select.md）
  3. h1AlignAssessment   → 全文 catalog_h1 是否统一居中（见 §一级标题对齐）
  4. 合并样式定义        → merge(default, typeScale, palette)

oplist 数组元素（§本路径可用 op，一次提交 oplist_exec）：
  5. 结构清理（按需）         → trim / cleanup
  6. import_element_styles   → 写入文档样式表
  7. batch_apply_paragraph_style → 按 role 全文挂接
  8. 段落格式（按需）         → 缩进 / 间距 / 其他句属性
```

oplist 条目形态 `{ scope, action }`；各 op 字段详见 `references/tools/atomic-ops/` 对应文件；单位见 `atomic-ops.md §单位约定`。

### 本路径可用 op

**禁止**使用此列表之外的 op。

核心 4 步（必选，固定顺序）：

```
trim_paragraph_leading_chars → cleanup_empty_paragraphs
→ import_element_styles
→ batch_apply_paragraph_style
```

可选步骤（按需追加，保持先后）：

```
→ batch_set_paragraph_indent → batch_set_span_style
→ batch_set_spacing
```

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

**常见误用**：

- ❌ 未先 `import_element_styles` 就挂接样式
- ❌ `source.tag` 填 scope `type`（如 `heading1`）— 应填 formatList 键（如 `catalog_h1`）
- ❌ 颜色值**必须**是`"color":"#RRGGBB"`这种RGB的颜色值，不确定的颜色值使用`"color":"#000000"`兜底

### 1+2. 主体风格（themeAssessment + scaleAssessment）

配色与字号配套细则见 [beauty-theme-select.md](beauty-theme-select.md)。**不 ask_user**。

写入规划 JSON 顶层 `themeAssessment` 与 `scaleAssessment`；`changeSummary` 须含配色气质标签（如「通用黑色」）及字号配套名称与正文/标题主字号（如「通用字号：正文宋体 12pt / 首页大标题宋体加粗 18pt」）。

### 3. 一级标题对齐（h1AlignAssessment）

对 formatList 中**每一条** `catalog_h1`，用 skeleton 引文（overview / formatList 定位）先做**单条**居中资格判定。**不 ask_user**。

**单条居中资格**（`centerEligible`）— 满足下列**任一**即为 true：

| 条件 | 判定 |
|------|------|
| 无编号 | 引文去首尾空白后，**不以**任何编号前缀开头（见下表「左对齐编号」） |
| 第 x 章 / 节 / 部分 | 引文匹配 `^第[一二三四五六七八九十百千零〇两\d]+(章|节|部分)`（后接可选空格/标点） |

**居中资格示例**：`第一章 绪论`、`第二节 方法`、`第三部分 结论`、`绪论`（无编号）

**单条不符合居中资格**（`centerEligible: false`）的常见前缀：

| 类型 | 示例 |
|------|------|
| 阿拉伯数字 | `1.`、`1、`、`1)`、`1.1` |
| 中文序号 | `一、`、`（一）`、`第二节`（**无**「第」前缀） |
| 其他「第 x …」 | `第一条`、`第1款`（**非**章/节/部分） |

**全文落地规则（关键）**：

| 条件 | 全部 catalog_h1 的对齐 |
|------|------------------------|
| **每一条** h1 的 `centerEligible` 均为 true | **全部居中** → `heading-1-center` / `美化标题 1（居中）` |
| **存在任一条** `centerEligible` 为 false | **全部左对齐** → `heading-1` / `美化标题 1` |

**禁止**仅对部分 h1 居中、对其余左对齐（混用两种 h1 样式）。

写入规划 JSON：

```json
{
  "h1AlignAssessment": {
    "allCenterEligible": false,
    "centerEligibleDataIds": ["120-128", "340-355"],
    "leftEligibleDataIds": ["500-512"],
    "reason": "存在条款式一级标题（1. 绪论），全文 h1 统一左对齐"
  }
}
```

`allCenterEligible: true` 时 `leftEligibleDataIds` 为空；为 false 时**全部** h1 走左对齐，即使部分标题本身符合居中资格。

**oplist 落地**：

- `allCenterEligible: true` → `import_element_styles` 仅写 `heading-1-center` 一条；`batch_apply` 对全部 `catalog_h1` 挂 `美化标题 1（居中）`
- `allCenterEligible: false` → 仅写 `heading-1`（左对齐）；`batch_apply` 对全部 `catalog_h1` 挂 `美化标题 1`

### 4. 样式表 — oplist 元素：import_element_styles

对每个需统一的 role，将 `merge(beauty-default, typeScale, palette)` 转为 `element_style_rules` 条目：

| 来源 | 字段 |
|------|------|
| `beauty-palettes.yaml` → `styleNames[role]` | `style_name` |
| 合并后的段/句属性 | `pPr` / `rPr`（单位见 atomic-ops.md） |
| doc_element_recog 要素名 | `element`（如 `heading 1`、`Normal`） |

样式名优先用 `beauty-palettes.yaml` → `styleNames`（如 `_Beauty_body`）。字段示例见下方 §完整 oplist 示例。

### 5. 全文挂接 — oplist 元素：batch_apply_paragraph_style

对 `structureProfile` 中 **confidence ≥ medium** 的块，按 formatList 标签批量挂接。

`doc_title` 与 `catalog_h1` 须使用不同 `style_name`（title 居中、字号大于 h1）；`target.style_name` 须与 `import_element_styles` 同条规则一致。字段示例见下方 §完整 oplist 示例。

对 `formatList` 中各 tag **批量挂接**。

**落款**（`formatList.signature` 非空时）：

1. `import_element_styles` 写入 `footer-like`（`美化尾注`）与 `footer-like-lead`（`美化尾注（首行）`，`pPr.spacing.before: 24pt`）
2. **分两条** `batch_apply_paragraph_style`，`source.tag` 均为 `signature`，用 `scope` 三段式 `start`/`end` + `index` 区分首段与其余段（**禁止**先全文挂接再覆盖）：

| 段落 | scope | `style_name` |
|------|-------|--------------|
| 落款首段 | `{ "start": { "type": "signature", "index": 1 }, "end": { "type": "signature", "index": 1 } }` | `美化尾注（首行）` |
| 落款第 2 段起（≥2 段时） | `{ "start": { "type": "signature", "index": 2 } }`（**省略** `end`） | `美化尾注` |

仅 1 条落款时只执行首段那条。

```json
{
  "scope": { "start": { "type": "signature", "index": 1 }, "end": { "type": "signature", "index": 1 } },
  "action": {
    "type": "batch_apply_paragraph_style",
    "format_rule": {
      "rules": [
        { "source": { "tag": "signature" }, "target": { "style_name": "美化尾注（首行）" }, "is_normal": false, "clear_span_props": true }
      ]
    }
  }
},
{
  "scope": { "start": { "type": "signature", "index": 2 } },
  "action": {
    "type": "batch_apply_paragraph_style",
    "format_rule": {
      "rules": [
        { "source": { "tag": "signature" }, "target": { "style_name": "美化尾注" }, "is_normal": false, "clear_span_props": true }
      ]
    }
  }
}
```

**禁止**对落款使用正文样式或首段段前距 <18pt。

### 6. 其他 op（按需）

结构清理在 import **之前**，段落格式在 apply **之后**（顺序见 §本路径可用 op）：

| 位置 | issue | op |
|------|-------|-----|
| import 之前 | 段首空格 | `trim_paragraph_leading_chars` |
| import 之前 | 连续空段 | `cleanup_empty_paragraphs` |
| apply 之后 | 缩进/行距 | `batch_set_paragraph_indent` / `batch_set_spacing` |
| apply 之后 | 句级加粗/字号 | `batch_set_span_style` |

### 完整 oplist 示例（一次提交 oplist_exec）

以下为 full 模式典型 oplist，步骤 4-6 的所有元素合并为同一数组、**一次**提交 `oplist_exec`：

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
            "element": "title", "style_name": "美化文档标题",
            "pPr": { "jc": "center", "outlineLvl": 10, "keepNext": true, "spacing": { "line": "1.35x", "before": "0pt", "after": "8pt" }, "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 18, "b": true, "color": "#000000", "rFonts": { "eastAsia": "宋体", "ascii": "Times New Roman" } }
          },
          {
            "element": "heading 1", "style_name": "美化标题 1（居中）",
            "pPr": { "jc": "center", "outlineLvl": 1, "keepNext": true, "spacing": { "line": "1.35x", "before": "6pt", "after": "3pt" }, "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 14, "b": false, "color": "#000000", "rFonts": { "eastAsia": "黑体", "ascii": "Times New Roman" } }
          },
          {
            "element": "heading 2", "style_name": "美化标题 2",
            "pPr": { "jc": "start", "outlineLvl": 2, "keepNext": true, "spacing": { "line": "1.35x", "before": "5pt", "after": "2pt" }, "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 13, "b": true, "color": "#000000", "rFonts": { "eastAsia": "宋体", "ascii": "Times New Roman" } }
          },
          {
            "element": "Normal", "style_name": "美化正文",
            "pPr": { "jc": "both", "outlineLvl": 10, "ind": { "firstLine": "2ch" }, "spacing": { "line": "1.35x", "before": "0pt", "after": "0pt" } },
            "rPr": { "sz": 12, "b": false, "color": "#000000", "rFonts": { "eastAsia": "宋体", "ascii": "Times New Roman" } }
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
            { "source": { "tag": "doc_title" },  "target": { "style_name": "美化文档标题" }, "is_normal": false, "clear_span_props": true },
            { "source": { "tag": "catalog_h1" }, "target": { "style_name": "美化标题 1（居中）" }, "is_normal": false, "clear_span_props": true },
            { "source": { "tag": "catalog_h2" }, "target": { "style_name": "美化标题 2" },    "is_normal": false, "clear_span_props": true },
            { "source": { "tag": "main_text" },  "target": { "style_name": "美化正文" },      "is_normal": true,  "clear_span_props": true }
          ]
        }
      }
    }
  ]
}
```

上例对应 `allCenterEligible: true`（全部 h1 均为无编号或「第 x 章/节/部分」）。若存在任一条款式 h1，则 `allCenterEligible: false`，改用 `美化标题 1`（`jc: start`）挂接**全部** catalog_h1。

---

## 作用范围

- **全文**：`formatList` 中已纳入的 data-id  
- **跳过**：未写入 formatList 的块、表格/图片/object 节点  

---

## 规划 JSON 要点

```json
{
  "mode": "full",
  "status": "planned",
  "themeAssessment": { "themeId": "official-black", "themeLabel": "通用黑色", "reason": "…" },
  "scaleAssessment": { "scaleId": "official-document", "scaleLabel": "通用字号", "reason": "…" },
  "h1AlignAssessment": { "allCenterEligible": true, "centerEligibleDataIds": ["120-128", "340-355"], "leftEligibleDataIds": [], "reason": "…" },
  "ruleSource": "beauty-default+type-scales",
  "oplist": []
}
```

顶层 `ruleSource` 为 `beauty-default+type-scales`（配色、字号分别来自 palette 与 type-scales）。

---

## 用户摘要模板

> 文档整体格式较分散（{n} 档字号混用）。将采用 **{themeLabel}** 配色 + **{scaleLabel}** 字号配套，对全文 {roleCount} 类段落统一排版；预计改动 {blockCount} 处。

---


## 应有的检查链
- 字号：doc_title > heading-1 > heading-2 > ... > body
- 标题：首行缩进 0 字符；正文首行缩进 2 字符
- 一级标题对齐：**全部** h1 均无编号或为「第 x 章/节/部分」→ 统一 `jc: center`；**否则**统一 `jc: start`


## 禁止

- ask_user 选主题（自动规则已覆盖；P0 口头偏好除外）
- `doc_title` 与 `catalog_h1` 共用 `style_name`
- 对 `1.`、`一、` 等条款式 catalog_h1 使用居中样式
- 仅对部分 catalog_h1 居中、对其余左对齐（混用两种 h1 样式）
