# pPr 段落属性参考

OOXML `w:pPr`（Paragraph Properties）子元素，按标准顺序排列。

---

## 属性列表

| 属性名 | 类型 | XML 元素 | 说明 |
|--------|------|----------|------|
| `pStyle` | string | `w:pStyle` | 段落样式 ID |
| `keepNext` | boolean | `w:keepNext` | 与下段同页 |
| `keepLines` | boolean | `w:keepLines` | 段内不分页 |
| `pageBreakBefore` | boolean | `w:pageBreakBefore` | 段前分页 |
| `widowControl` | boolean | `w:widowControl` | 孤行控制 |
| `numPr` | object | `w:numPr` | 列表编号 `{ilvl, numId}` |
| `pBdr` | object | `w:pBdr` | 段落边框 `{top, left, bottom, right, between, bar}` |
| `shd` | object | `w:shd` | 段落底纹 `{val, color, fill}` |
| `tabs` | array | `w:tabs` | 制表位 `[{val, pos, leader}]` |
| `suppressAutoHyphens` | boolean | `w:suppressAutoHyphens` | 抑制自动断字 |
| `bidi` | boolean | `w:bidi` | 双向文本 |
| `adjustRightInd` | boolean | `w:adjustRightInd` | 调整右缩进 |
| `snapToGrid` | boolean | `w:snapToGrid` | 对齐网格 |
| `spacing` | object | `w:spacing` | 段落间距 `{before, after, line, lineRule, beforeLines, afterLines}` |
| `ind` | object | `w:ind` | 缩进 `{left, right, firstLine, firstLineChars, hanging, hangingChars, leftChars}` |
| `contextualSpacing` | boolean | `w:contextualSpacing` | 与相同样式段落合并间距 |
| `mirrorIndents` | boolean | `w:mirrorIndents` | 镜像缩进 |
| `jc` | string | `w:jc` | 水平对齐 |
| `textAlignment` | string | `w:textAlignment` | 垂直对齐 |
| `outlineLvl` | number | `w:outlineLvl` | 大纲级别 1~9（1 = 一级），10=正文 |
| `rPr` | object | `w:rPr` | 段落默认字符属性 |

---

## spacing 子属性

| 子属性 | 单位 | 说明 |
|--------|------|------|
| `before` | twips | 段前间距 |
| `after` | twips | 段后间距 |
| `line` | twips 或 240分之一 | 行距值 |
| `lineRule` | string | `"auto"` / `"exact"` / `"atLeast"` |
| `beforeLines` | 行×100 | 段前间距（行数） |
| `afterLines` | 行×100 | 段后间距（行数） |

### 常见行距值

| 行距 | lineRule | line |
|------|----------|------|
| 单倍 | auto | 240 |
| 1.5 倍 | auto | 360 |
| 2 倍 | auto | 480 |
| 固定 14pt | exact | 280 |
| 固定 20pt | exact | 400 |
| 最小 12pt | atLeast | 240 |

---

## ind 子属性

| 子属性 | 单位 | 说明 |
|--------|------|------|
| `left` | twips | 左缩进 |
| `right` | twips | 右缩进 |
| `firstLine` | twips | 首行缩进 |
| `firstLineChars` | 字符×100 | 首行缩进（字符） |
| `hanging` | twips | 悬挂缩进 |
| `hangingChars` | 字符×100 | 悬挂缩进（字符） |
| `leftChars` | 字符×100 | 左缩进（字符） |

---

## tabs 制表位

### pos（位置）

| 单位 | 说明 |
|------|------|
| twips | 制表位距页面左边缘的距离（1 twip = 1/20 pt） |

常用值转换示例：

| 位置 | pos 值 |
|------|--------|
| 2cm | 1134 |
| 5cm | 2835 |
| 10cm | 5670 |
| 15cm | 8505 |
| 2字符 | 2 x 10.5 x 20=240 （基于10.5pt字号） |

> 使用字符设置位置时，是基于段落使用的标题样式（pStyle引用的样式）中的字号转换而来的，计算公式为“字符数x字号（pt）x20”

### val（对齐方式）

| 值 | 说明 |
|----|------|
| `left` | 左对齐，文本从制表位向右展开（默认） |
| `center` | 居中对齐，文本以制表位为中心向两侧展开 |
| `right` | 右对齐，文本从制表位向左展开 |
| `decimal` | 小数点对齐，文本按小数点对齐到制表位 |
| `bar` | 竖线，在制表位处绘制一条竖线（不对齐文本） |
| `clear` | 清除该位置的制表位 |
| `num` | 编号对齐，用于列表编号后的对齐 |

### leader（前导字符）

| 值 | 说明 | 效果 |
|----|------|------|
| `none` | 无前导字符（默认） | |
| `dot` | 点线 | ....... |
| `hyphen` | 连字符 | ------ |
| `underscore` | 下划线 | ______ |
| `heavy` | 粗实线 | ━━━━━━ |
| `middleDot` | 居中点 | ······· |

---

## pBdr 边框子属性

每条边框（top/left/bottom/right/between/bar）支持：

| 属性 | 说明 |
|------|------|
| `val` | 边框样式：`"single"` `"double"` `"dashed"` `"dotted"` `"none"` 等 |
| `sz` | 宽度（1/8 pt） |
| `space` | 与文字距离（pt） |
| `color` | 颜色（6位十六进制 或 `"auto"`） |

---

## jc（水平对齐）

| 值 | 说明 |
|----|------|
| `left` | 左对齐 |
| `center` | 居中对齐 |
| `right` | 右对齐 |
| `both` | 两端对齐，末行左对齐 |
| `distribute` | 分散对齐，末行也均匀分布 |

## textAlignment（垂直对齐）

| 值 | 说明 |
|----|------|
| `top` | 顶端对齐 |
| `center` | 居中对齐 |
| `baseline` | 基线对齐 |
| `bottom` | 底端对齐 |
| `auto` | 自动（由应用程序决定） |

---

## 单位换算

| 换算 | 公式 | 示例 |
|------|------|------|
| pt → twips | × 20 | 12pt = 240 |
| cm → twips | × 567 | 1cm ≈ 567 |
| in → twips | × 1440 | 1in = 1440 |
| 字符 → xxxChars | × 100 | 2字符 = 200 |
| 行距倍数 → line(auto) | × 240 | 1.5倍 = 360 |
| 固定行距 → line(exact) | pt × 20 | 14pt = 280 |
