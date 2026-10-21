# 页面设置（page）

`page` 控制纸张大小、页边距、分栏。不填则保留原文档的页面设置。

## 纸张大小

两种方式（互斥，同时存在时 `customSize` 优先）：

**预设纸张**：

```json
{ "page": { "size": "A3" } }
```

共 53 个预设，涵盖 ISO 216 A/B 系列、ISO 269 C 系列、JIS P 0138 B 系列、中国开本、美制。**B 系列因 ISO 和 JIS 存在同名不同尺寸的型号，必须带 `(ISO)` / `(JIS)` 后缀区分**；开本用 `开` 后缀（如 `16开`）；其他系列无歧义不需要后缀。

### A 系列（ISO 216）

最常用的办公纸。比例 √2:1，相邻号面积翻倍。A 系列在 ISO 和 JIS 下尺寸完全相同（无歧义，无需后缀）。

| 型号 | 尺寸 |
|------|------|
| A0 | 841×1189 mm |
| A1 | 594×841 mm |
| A2 | 420×594 mm |
| A3 | 297×420 mm |
| A4 | 210×297 mm |
| A5 | 148×210 mm |
| A6 | 105×148 mm |
| A7 | 74×105 mm |
| A8 | 52×74 mm |
| A9 | 37×52 mm |
| A10 | 26×37 mm |

### B 系列（ISO 216）

ISO 216（1975 制定）的 B 系列定义为 A 相邻号之间的几何平均 √(A_n·A_{n+1})。

| 型号 | 尺寸 |
|------|------|
| B0(ISO) | 1000×1414 mm |
| B1(ISO) | 707×1000 mm |
| B2(ISO) | 500×707 mm |
| B3(ISO) | 353×500 mm |
| B4(ISO) | 250×353 mm |
| B5(ISO) | 176×250 mm |
| B6(ISO) | 125×176 mm |
| B7(ISO) | 88×125 mm |
| B8(ISO) | 62×88 mm |
| B9(ISO) | 44×62 mm |
| B10(ISO) | 31×44 mm |

### B 系列（JIS P 0138）

JIS P 0138（1929 制定）早于 ISO 216 约 46 年，B 系列**独立定义**且尺寸略大于 ISO 同型号，是日本/台湾地区办公常用尺寸。

| 型号 | 尺寸 |
|------|------|
| B0(JIS) | 1030×1456 mm |
| B1(JIS) | 728×1030 mm |
| B2(JIS) | 515×728 mm |
| B3(JIS) | 364×515 mm |
| B4(JIS) | 257×364 mm |
| B5(JIS) | 182×257 mm |
| B6(JIS) | 128×182 mm |
| B7(JIS) | 91×128 mm |
| B8(JIS) | 64×91 mm |
| B9(JIS) | 45×64 mm |
| B10(JIS) | 32×45 mm |

> **同名 B 型号 ISO/JIS 尺寸差 6~42 mm**，例如 `B4(ISO)` 250×353 mm 与 `B4(JIS)` 257×364 mm 相差 7×11 mm（docx 实际宽高差几百 twips）。

### C 系列（ISO 269）

信封尺寸标准，与 A 系列配合设计（如 C4 信封装 A4 纸）。无 JIS 版。

| 型号 | 尺寸 |
|------|------|
| C0 | 917×1297 mm |
| C1 | 648×917 mm |
| C2 | 458×648 mm |
| C3 | 324×458 mm |
| C4 | 229×324 mm |
| C5 | 162×229 mm |
| C6 | 114×162 mm |
| C7 | 81×114 mm |
| C8 | 57×81 mm |
| C9 | 40×57 mm |
| C10 | 28×40 mm |

### 美制（ANSI/ASME Y14.1）

| 型号 | 尺寸 |
|------|------|
| letter | 8.5×11 in |
| legal | 8.5×14 in |

### 中国开本（正度 787×1092 mm 全开）

国内传统印刷/出版用纸规格。基于**正度 787×1092 mm 全开**连续对折得到，n 开 = 全开 ÷ n（对折 log₂n 次）。常见为 8/16/32 开。

| 型号 | 尺寸 | 常见用途 |
|------|------|----------|
| 1开  | 787×1092 mm | 整开纸（海报、招贴、试卷底纸） |
| 2开  | 545×787 mm | 对开（海报、试卷大题页） |
| 4开  | 393×545 mm | 4 开（试卷合订、画册、挂历） |
| 8开  | 272×393 mm | 8 开（小学教材、试卷、连环画） |
| 16开 | 196×272 mm | 16 开（图书、考试试卷、杂志） |
| 32开 | 136×196 mm | 32 开（口袋书、笔记本、词典） |
| 64开 | 98×136 mm | 64 开（小型工具书、便携手册） |

> **16开 (196×272 mm) 与 A4 (210×297 mm) 接近但不同**：A4 略宽 14 mm、高 25 mm。如需精确对应 A 系列，优先用 `A4` / `A3` 等。

**自定义尺寸**：

```json
{
  "page": {
    "customSize": {
      "width": { "value": 21, "unit": "cm" },
      "height": { "value": 29.7, "unit": "cm" }
    }
  }
}
```

| 属性 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `width` | lengthWithUnit | 是 | 页面宽度 |
| `height` | lengthWithUnit | 是 | 页面高度 |

## 页面方向

`orientation` 是 `page` 级别的独立属性，与 `size` 或 `customSize` 配合使用：

```json
{ "page": { "size": "A3", "orientation": "landscape" } }
```

| 值 | 说明 |
|------|------|
| `portrait` | 纵向（默认） |
| `landscape` | 横向 |

## 页边距

```json
{
  "page": {
    "margins": {
      "top": { "value": 2.54, "unit": "cm" },
      "bottom": { "value": 2.54, "unit": "cm" },
      "left": { "value": 3.17, "unit": "cm" },
      "right": { "value": 3.17, "unit": "cm" },
      "header": { "value": 1.5, "unit": "cm" },
      "footer": { "value": 1.75, "unit": "cm" },
      "gutter": { "value": 0, "unit": "cm" }
    }
  }
}
```

| 属性 | 说明 |
|------|------|
| `top` | 上边距 |
| `bottom` | 下边距 |
| `left` | 左边距 |
| `right` | 右边距 |
| `header` | 页眉距页面顶部边界 |
| `footer` | 页脚距页面底部边界 |
| `gutter` | 装订线宽度 |

> 所有边距均使用 `lengthWithUnit` 格式：`{ "value": <number>, "unit": "<pt|cm|mm|in>" }`

## 分栏

```json
{
  "page": {
    "columns": {
      "count": 2,
      "space": { "value": 1.27, "unit": "cm" },
      "equalWidth": true,
      "separator": false
    }
  }
}
```

| 属性 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `count` | integer | 是 | 栏数，1 = 不分栏（默认） |
| `space` | lengthWithUnit | 否 | 栏间距（等宽分栏时生效） |
| `equalWidth` | boolean | 否 | 是否等宽分栏，默认 `true` |
| `separator` | boolean | 否 | 是否显示分栏分隔线，默认 `false` |
| `columnDefs` | array | 否 | 不等宽分栏时各栏定义 |

不等宽分栏示例：

```json
{
  "page": {
    "columns": {
      "count": 2,
      "equalWidth": false,
      "columnDefs": [
        { "width": { "value": 12, "unit": "cm" }, "space": { "value": 1, "unit": "cm" } },
        { "width": { "value": 5, "unit": "cm" } }
      ]
    }
  }
}
```

简写形式（等宽分栏，默认栏间距）：

```json
{ "page": { "columns": 2 } }
```
