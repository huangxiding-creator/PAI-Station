# 自然语言 → oplist 参数换算表（spec-unit-conversion）

将自然语言样式描述转为 oplist JSON 参数（`pPr`/`rPr`，及 `setup_page_setup` / `setup_header_footer` / `setup_toc_styles` 的 `format_rule` 字段）。

**单位格式**：`rPr.sz` 用 number（磅）；`spacing`/`ind`/`sectPr` 用带单位字符串（如 `"12pt"`、`"1.5x"`、`"2ch"`）。

可换算属性白名单：中文字体、西文字体、字号、加粗、首行缩进、对齐方式、行距、段前间距、段后间距。

**规范未写的字段不得出现在产出参数 JSON 中**（`pPr`/`rPr`/`sectPr`/页眉脚参数等同理）。
---

## 歧义消解

### 范围取值

规范给出数值范围时，**取最小值**：

| 规范表述 | 取值 |
|---------|------|
| 段前间距 30～36 磅 | `"before": "30pt"` |
| 行距 20-24 磅 | `"line": "20pt"` |

### 离散选项

多个可选值（「或」「/」连接）时，**取第一个**：

| 规范表述 | 取值 |
|---------|------|
| 五号或小五号 | 五号 → `sz: 10.5` |

### 数值单位智能识别

原文仅给数字、未写单位时，按上下文推断：

| 属性 | 规则 | 示例 |
|------|------|------|
| 字号 | 标准字号名或带「磅/pt」 | 12 磅 → `sz: 12` |
| 行距 | 数值 ≤3 → 倍数；>3 → 固定磅 | 1.5 → `"1.5x"`；20 → `"20pt"` |
| 段前/段后 | 数值 ≤3 → 行；>3 → 磅 | 0.5 行 → 按行距换算 `"Npt"`；12 磅 → `"12pt"` |
| 缩进 | 数值 ≤5 → 字符；>5 → 磅 | 2 → `"2ch"`；24 → `"24pt"` |

### 字号别名

**规范直出时仍优先输出数字 pt**。

规范写「3 号」「小三号」等非标准两字表述时，先规范化为标准字号名再查表（如 3 号→三号，小三号→小三）。

---

## 字号（rPr.sz）

单位 **pt**（磅），直接对应文档显示字号。

| 规范表述 | rPr.sz |
|---------|--------|
| 初号 | 42 |
| 小初 | 36 |
| 一号 | 26 |
| 小一 | 24 |
| 二号 | 22 |
| 小二 | 18 |
| 三号 | 16 |
| 小三 | 15 |
| 四号 | 14 |
| 小四 | 12 |
| 五号 | 10.5 |
| 小五 | 9 |
| 六号 | 7.5 |
| 七号 | 5.5 |
| 八号 | 5 |
| Npt / N磅（字号上下文） | N |

---

## 字体（rPr.rFonts）

| 规范表述 | rFonts 字段 | 值 |
|---------|-----------|---|
| 宋体 | eastAsia | `宋体` |
| 黑体 | eastAsia | `黑体` |
| 楷体 / 楷体_GB2312 | eastAsia | `楷体` |
| 仿宋 / 仿宋_GB2312 / 仿宋GB2312 | eastAsia | `仿宋` |
| Times New Roman | ascii, hAnsi | `Times New Roman` |
| Calibri | ascii, hAnsi | `Calibri` |
| 英文用XXX | ascii, hAnsi | 对应英文字体名 |

中文字体写入 `rFonts.eastAsia`；西文字体写入 `rFonts.ascii` + `rFonts.hAnsi`。规范同时写中英文字体时两者都填。

---

## 对齐（pPr.jc）

| 规范表述 | pPr.jc |
|---------|--------|
| 居中 / 居中编排 | `center` |
| 两端对齐 | `both` |
| 左对齐 / 顶左 / 顶格 | `start` |
| 右对齐 | `end` |
| 分散对齐 | `distribute` |

「顶格」「左顶格」「顶头」「齐头」→ `ind.firstLine: "0pt"`（与 `jc: start` 独立；规范只写顶格时不自动填 `jc`）。

---

## 缩进（pPr.ind）

须用带单位字符串：`"24pt"` / `"2ch"` / `"3cm"` 等。

| 规范表述 | pPr.ind 字段 | 值 |
|---------|-------------|---|
| 首行缩进2字符 / 2个汉字符 / 左空2字 / 段落首行左缩进2个汉字符 | firstLine | `"2ch"` 或 `"24pt"` |
| 首行缩进N字符 | firstLine | `"Nch"` 或 `"N×12pt"`（按小四基准，如 `"24pt"`） |
| 顶左 / 顶格 / 无缩进 / 左顶格 / 顶头 / 齐头 | firstLine | `"0pt"` |
| 悬挂缩进N字符 | firstLine | `"-Nch"`（**禁止**输出 `hanging` 字段名；负值 firstLine 表达） |
| 悬挂缩进N磅 | firstLine | `"-Npt"` |

**禁止**在 pPr/rPr 中输出「左缩进」「右缩进」作为独立语义；仅当原文明确左右缩进且能映射为 `ind.left`/`ind.right` 时才填 OOXML 字段。

**目录 1/2/3** 缩进见 §目录样式。

---

## 行距（pPr.spacing.line）

须用自描述 string，**禁止** `line` + `lineRule` 组合。

| 规范表述 | spacing.line |
|---------|-------------|
| 单倍行距 | `"1x"` |
| 1.5倍行距 | `"1.5x"` |
| 2倍行距 | `"2x"` |
| N倍行距 / N倍 / 1.25倍 | `"Nx"`（如 `"1.25x"`） |
| 固定值N磅 / 行距N磅 / 行间距N磅 | `"Npt"`（如 `"20pt"`） |
| 最小值N磅 | `"Npt+"`（如 `"15pt+"`） |

---

## 段间距（pPr.spacing.before / after）

须用带单位字符串。

| 规范表述 | 字段 | 值 |
|---------|------|---|
| 段前N磅 | spacing.before | `"Npt"`（如 `"12pt"`） |
| 段后N磅 | spacing.after | `"Npt"` |
| 段前段后0 / 段间距为0 | spacing.before + after | `"0pt"` |
| 段前N行 / 段后N行 | spacing.before / after | 换算为 `"Npt"`（见「数值单位智能识别」） |

段前/段后示例：`12磅` → `"12pt"`；`0.5行` → 按行距换算为 `"Npt"`。

---

## 加粗 / 斜体（rPr）

| 规范表述 | rPr 字段 | 值 |
|---------|---------|---|
| 加粗 | b | `true` |
| 黑体（整段，字体本身加粗语义） | rFonts.eastAsia=`黑体`，不额外设 b | — |
| 黑体加粗 | rFonts.eastAsia=`黑体` + b=`true` | — |
| 斜体 | i | `true` |

---

## 颜色（rPr.color）

| 规范表述 | rPr.color |
|---------|----------|
| 黑色 / 默认 | 不填（不出现该字段） |
| 红色 | `#FF0000` |
| 蓝色 | `#0000FF` |
| 具体 RGB 描述 | `#RRGGBB` |

---

## 大纲级别（pPr.outlineLvl）

取值 1~10（number 类型）。

| element | outlineLvl | 说明 |
|---------|-----------|------|
| `title` | `10` | 文档标题，同正文 |
| `heading 1` | `1` | 一级标题 |
| `heading 2` | `2` | 二级标题 |
| `heading N` | `N` | 依次类推 |
| `Normal` | `10` | 正文 |

标题样式必须设置对应 `outlineLvl` 和 `keepNext: true`。

---

## 页面边距（setup_page_setup）

映射至 `format_rule.sectPr.pgMar`（及可选 `pgSz`）。

| 规范表述 | sectPr.pgMar 字段 | 值 |
|---------|------------------|---|
| 上边距 N cm / 上页边距 N 厘米 | top | `"<N*28.35>pt"` 或 `"<N>cm"` |
| 下边距 / 左 / 右 | bottom / left / right | 同上，字符串带单位 |
| 上下左右均为 N cm | top/bottom/left/right | 各 `"<N>cm"` |
| mm | 任意边 | 除以 10 转 cm 再写带单位字符串 |
| 装订线 | gutter | 可写 `"<N>cm"`；规范仅写装订线、未写叠加到左右边距时**忽略** |

纸张尺寸示例：A4 纵向 → `pgSz: { "w": "595.3pt", "h": "841.9pt", "orient": "portrait" }`。

---

## 页眉 / 页脚 / 页码（setup_header_footer）

映射至 `setup_header_footer` 的 `format_rule` 字段。

| 规范表述 | 映射 |
|---------|------|
| 页脚只要页码 / 页脚居中页码 | `footers.default.pageNumber: { show: true, align: "center" }` |
| 页眉/页脚不要页码 | `pageNumber: { show: false }` 或 `mode: "clear"` |
| 罗马数字页码 / 大写罗马 | `pageNumber.format: "romanUpper"` |
| 小写罗马 | `pageNumber.format: "romanLower"` |
| 阿拉伯数字页码 | `pageNumber.format: "arabic"` |
| 从正文开始使用阿拉伯数字 | `target: { tag: "main_text" }` + `pageNumber: { format: "arabic", restart: true, start: 1 }` |
| 摘要/前言用罗马数字，正文用阿拉伯 | 分两条 `rules[]`：前言节用 `target.tag`（如 `"abs_title"`）+ `romanUpper`；正文 `target: { tag: "main_text" }` + `arabic`+`restart` |
| 首页不同 / 奇偶页不同 | `sectionFlags: { differentFirstPage: true }` 或 `{ oddAndEvenPages: true }`；对应 variant 用 `first`/`even` |
| 页眉文字 / 页脚文字 | `headers.default.text` / `footers.default.text` + 可选 `pPr`/`rPr` |
| 正文开始设页眉 / 正文起添加页眉 | `target: { tag: "main_text" }` + `headers.default.mode: "set"` |

**节定位**：优先用 `target.tag`（如 `"main_text"`、`"catalog_h1"`）定位——引擎自动将 tag 段落范围与节求交，无需知道具体节号。仅当 formatList 无合适 tag 时，才回退到 `sectionFrom/sectionTo`（须查 `structureProfile` 确认节号）。**禁止**不分析就写 `sectionFrom: 1`。

**硬约束**：同一 variant 下页眉与页脚不可同时 `pageNumber.show=true`（规范写「页脚页码」时只写 `footers`）。

无法映射到 `target.tag` 或 `sectionFrom/sectionTo` 的复杂分节页码方案 → `changeSummary.manualIssues`。

---

## 目录样式（setup_toc_styles）

`tocStyle.levels[]` 中 `level: 1/2/3` 的 `pPr`/`rPr`；`level` 由 `spec-tag-binding.md` §层级映射 确定。

| 规范表述 | 字段 |
|---------|------|
| 目录项缩进 N 字符 | 对应 `level` 的 `pPr.ind.firstLine` |
| 目录项字体/字号/行距等 | 对应 `level` 的 `pPr`/`rPr`（查上文段落换算表） |

---

## 完整换算示例

规范原文：`黑体三号加粗居中，单倍行距，段前24磅，段后18磅`

```json
{
  "pPr": {
    "jc": "center",
    "spacing": { "before": "24pt", "after": "18pt", "line": "1x" },
    "keepNext": true
  },
  "rPr": {
    "sz": 16,
    "b": true,
    "rFonts": { "eastAsia": "黑体" }
  }
}
```

规范原文：`宋体小四号字，行距20磅，段前段后0磅，首行缩进2个汉字符`

```json
{
  "pPr": {
    "jc": "both",
    "spacing": { "before": "0pt", "after": "0pt", "line": "20pt" },
    "ind": { "firstLine": "2ch" }
  },
  "rPr": {
    "sz": 12,
    "rFonts": { "eastAsia": "宋体" }
  }
}
```

注意：上例中 `jc: "both"` 仅在规范原文写明「两端对齐」时才填入。如果规范未写对齐方式则不填。
