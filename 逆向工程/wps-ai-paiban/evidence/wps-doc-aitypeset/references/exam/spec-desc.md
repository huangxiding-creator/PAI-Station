# 格式规范结构说明

## 一、spec 顶层结构

一份完整的 spec 文件包含以下顶层字段：

```json
{
  "schemaVersion": "1.0",
  "name": "your-spec-name",
  "description": "规范描述",
  "page": { ... },
  "styles": { ... },
  "elements": { ... },
  "phases": { ... }
}
```

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `schemaVersion` | string | 是 | 固定为 `"1.0"` |
| `name` | string | 是 | 规范名称，如 `"standard-science"` |
| `description` | string | 否 | 规范的文字描述 |
| `page` | object | 否 | 页面设置，不填则保留原文档设置 |
| `styles` | object | 是 | 命名样式库，必须包含 `base` |
| `elements` | object | 是 | 各内容要素的格式定义 |
| `phases` | object | 否 | 阶段开关，默认全部为 `true` |

## 二、样式库（styles）

`styles` 是一个键值对对象，每个 key 是样式名，value 是样式定义。其中 **`base` 是必填的，并且要设置`wordStyleName`以创建样式**，它是所有元素的基础样式，也是正文默认使用的样式。

### 3.1 样式继承模型

引擎使用三层继承确定每个元素的最终格式：

```
styles.base（全局默认）
  -> elements.<元素>.baseStyle（引用的命名样式）
    -> elements.<元素> 自有的 rPr/pPr（inline 覆盖）
```

元素只需声明与 baseStyle **不同**的部分。

### 3.2 样式定义（styleDef）

每个样式可包含以下属性：

```json
{
  "styles": {
    "base": {
      "wordStyleName": "试卷正文",
      "rPr": {
        "rFonts": { "eastAsia": "宋体", "ascii": "Times New Roman", "hAnsi": "Times New Roman" },
        "sz": 21,
        "color": "000000"
      },
      "pPr": {
        "spacing": { "lineRule": "auto", "line": 360 },
        "jc": "left"
      }
    }
  }
}
```

| 属性 | 类型 | 说明 |
|------|------|------|
| `baseStyle` | string | 引用的基础样式名（样式间继承） |
| `rPr` | object | 字符属性，详见[第四章](#四字符属性rpr) |
| `pPr` | object | 段落属性，详见[第五章](#五段落属性ppr) |
| `wordStyleName` | string | 关联 Word 命名样式。声明后引擎会创建对应的 Word 样式，元素引用时自动以 `pStyle` 方式应用 |
| `resetFormat` | string/object | 格式清理策略，引用此样式的元素会自动继承。详见[第七章](#七格式重置resetformat) |

### 3.3 样式继承示例

样式之间可以通过 `baseStyle` 形成继承链：

```json
{
  "styles": {
    "base": {
      "rPr": { "rFonts": { "eastAsia": "宋体", "ascii": "Times New Roman" }, "sz": 21 },
      "pPr": { "spacing": { "lineRule": "auto", "line": 360 }, "jc": "left" }
    },
    "titleLarge": {
      "baseStyle": "base",
      "rPr": { "rFonts": { "eastAsia": "黑体" }, "sz": 36, "b": true },
      "pPr": { "jc": "center" },
      "wordStyleName": "试卷标题 1"
    }
  }
}
```

`titleLarge` 继承（或者说是合并） `base` 的样式定义，并覆盖差异部分（黑体、小二号(36)、加粗、居中）。

### 3.4 wordStyleName 的作用

当样式声明了 `wordStyleName`，引擎会在 Word 文档中创建对应的命名样式。元素通过 `baseStyle` 引用该样式时，自动以 `pStyle`（段落样式引用）方式应用，而非 inline 属性。

这意味着：

- Word 样式中定义的属性会通过样式优先级生效，inline属性优先级高于样式引用中的同类属性
- 如果段落原有 inline 属性与 Word 样式冲突，你期望以样式中的属性为准，需要 `resetFormat` 清除 inline 属性（详见[第七章](#七格式重置resetformat)）

**典型用法**：`base` 和标题类样式（`titleLarge`、`titleMedium`、`titleSmall`）声明 `wordStyleName`，方便统一修改样式属性，其他辅助样式不需要，它们更多是行内应用。

### 3.5 常用样式模板

以下是理科/文科试卷中常见的样式集合，可直接复用或在此基础上修改：

| 样式名 | 用途 | 典型 rPr | 典型 pPr |
|--------|------|----------|----------|
| `base` | 全局正文基础 | 宋体/TNR 10.5pt | 1.5倍行距，左对齐 |
| `titleLarge` | 试卷主标题 | 黑体 18pt 加粗 | 居中 |
| `titleMedium` | 卷标题 | 黑体 18pt | 居中 |
| `titleSmall` | 大题标题 | 黑体 10.5pt | 左对齐 |
| `subTitle` | 副标题/科目 | 黑体 15pt | 居中 |
| `infoText` | 卷头信息（左对齐） | 宋体/TNR 12pt | 左对齐 |
| `infoCenter` | 卷头信息（居中） | 宋体/TNR 12pt | 居中 |
| `studentInfo` | 考生信息区 | 12pt | 居中 |
| `sealLineStyle` | 密封线 | 黑体 10.5pt 加粗 | 居中 |
| `boldSmall` | 注意事项标题等 | 黑体 10.5pt 加粗 | 继承 base |
| `materialFont` | 材料正文 | 楷体/TNR 10.5pt | 继承 base |

## 四、字符属性（rPr）

`rPr`（Run Properties）控制文字的视觉呈现。出现在 `styles` 的样式定义和 `elements` 的元素定义中。可以设置的属性见[rPr 字符属性参考](./rPr-properties.md)

### 注意事项

- spec 中字号统一使用半磅值，不要使用"三号""五号"等中文名称。
- 用户提出使用x磅字号时，如无特殊说明，指的是实际字号的磅值而非数据记录中的半磅值，需要转换后使用

## 五、段落属性（pPr）

`pPr`（Paragraph Properties）控制段落的排版行为。出现在 `styles` 的样式定义和 `elements` 的元素定义中。可以设置的属性见[pPr 段落属性参考](./pPr-properties.md)

### 单位约定

spec 中的属性值尽量使用 OOXML 原生单位，以减少引擎转换逻辑。各属性的单位如下：

| 属性 | 单位 | 说明 |
|------|------|------|
| `sz` | 半磅值 | 五号=21, 小四=24, 小三=30 |
| `ind.firstLineChars` / `hangingChars` / `leftChars` | 字符×100 | 2字符=200, 1.5字符=150 |
| `spacing.line` | OOXML 原生 | auto: 240分之一（1.5倍=360）；exact/atLeast: twips（14pt=280） |
| `spacing.before` / `after` | twips | 12pt=240, 6pt=120 |
| `cellPadding.*` | twips | 5pt=100 |
| `tabs` | **字符** | **唯一例外**：引擎根据元素字号自动转换为 twips，公式 = 字符数 × 字号(pt) × 20 |

> **为什么 tabs 使用字符单位？** tabs 的 twips 位置取决于元素字号，不同字号的 1.5 字符对应不同的 twips 值。使用字符单位让 spec 编写者无需关心字号对应的具体 twips 值。

## 六、元素定义（elements）

`elements` 定义试卷中各内容要素的格式。每个元素通过 `baseStyle` 引用 `styles` 中的命名样式，再用自身的 `rPr`/`pPr` 覆盖差异部分。支持的要素见前文提到的`contentElements.md`。

### 6.1 元素通用结构

大多数元素遵循相同的结构（`elementDef`）：

```json
{
  "elements": {
    "examTitle": {
      "baseStyle": "titleLarge",
      "rPr": { "sz": 36 },
      "pPr": { "jc": "center" },
      "resetFormat": "all",
      "firstParagraph": { "pPr": { "jc": "center" } },
      "lastParagraph": { "pPr": { "jc": "left" } }
    }
  }
}
```

| 属性 | 类型 | 说明 |
|------|------|------|
| `baseStyle` | string | 引用的基础样式名。若该样式有 `wordStyleName` 则自动使用 Word 样式引用 |
| `rPr` | object | 字符属性覆盖，详见[第四章](#四字符属性rpr) |
| `pPr` | object | 段落属性覆盖，详见[第五章](#五段落属性ppr) |
| `resetFormat` | string/object | 格式重置规则，详见[第七章](#七格式重置resetformat) |
| `firstParagraph` | object | 首段格式覆盖，详见[第八章](#八首段尾段变体) |
| `lastParagraph` | object | 尾段格式覆盖，详见[第八章](#八首段尾段变体) |

### 6.2 选择题选项（option）

`option` 是特殊元素，不使用常规的 `rPr`/`pPr` 结构，而是用专属字段控制选项排列。

```json
{
  "option": {
    "baseStyle": "base",
    "tabs": [1.5, 11, 20, 29]
  }
}
```

| 属性 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `baseStyle` | string | 否 | 引用的基础样式名 |
| `rPr` | object | 否 | 字符属性覆盖 |
| `pPr` | object | 否 | 段落属性覆盖 |
| `tabs` | number[] | 是 | 制表位位置数组，单位：字符 |
| `resetFormat` | string/object | 否 | 格式重置规则 |

**tabs 与选项排列的关系**：

- `tabs` 数组的长度决定每行最多容纳的选项数
- 例如 `[1.5, 11, 20, 29]` 提供 4 个制表位，意味着一行最多 4 个选项
- 如果选项超过 4 个，多余的选项自动换行
- 不提供或只提供 1 个，则一行最多 1 个选项（竖排）

```
tabs: [1.5, 11, 20, 29]  ->  四列横排：
A. xxx    B. xxx    C. xxx    D. xxx

tabs: [1.5]              ->  竖排：
A. xxx
B. xxx
C. xxx
D. xxx
```

### 6.3 配图（image）

`image` 是特殊元素，没有 `baseStyle`/`rPr`/`pPr`，只有专属字段：

```json
{
  "image": {
    "standaloneAlign": "center",
    "calculationAlign": "right",
    "gapFromText": 6
  }
}
```

| 属性 | 类型 | 说明 |
|------|------|------|
| `standaloneAlign` | string | 独立配图段落的对齐方式：`center` / `left` / `right` |
| `calculationAlign` | string | 计算/解答题配图的对齐方式（不填则跟随 `standaloneAlign`） |
| `gapFromText` | number | 配图与周围文字的间距，单位 pt |

### 6.4 表格（table）

```json
{
  "table": {
    "alignment": "center",
    "width": "auto",
    "cellPadding": { "top": 0, "bottom": 0, "left": 100, "right": 100 },
    "clearCellMargins": true
  }
}
```

| 属性 | 类型 | 说明 |
|------|------|------|
| `alignment` | string | 表格在页面中的水平对齐：`center` / `left` / `right` |
| `width` | string | `"auto"` = 内容自适应（清除固定宽度），`"100%"` = 填满页面宽度，`"keep"` = 保留原文档宽度 |
| `cellPadding` | object | 单元格内边距（twips，1pt=20twips）：`{ top, bottom, left, right }` |
| `clearCellMargins` | boolean | 是否清除行级和单元格级的边距覆盖，默认 `true` |

## 七、格式重置（resetFormat）

`resetFormat` 控制元素在应用格式前是否清除原有格式。引擎的处理顺序为：**先沿样式链收集所有需要清除的属性 → 全部清除 → 再写入新的样式属性**。

这对于通过 `wordStyleName` 引用的 Word 命名样式尤为重要——Word 中 `pStyle` 引用的样式优先级低于段落内联属性，如果不清除冲突的内联属性，样式定义就无法生效。

### 7.1 链式查找与自动推断（默认行为）

当元素未声明 `resetFormat` 时，引擎沿 `baseStyle` 链**逐级向上查找**，直到找到以下任一条件：

1. 某个样式显式声明了 `resetFormat`（如 `"auto"`、`"all"`）→ 使用该值
2. 某个样式声明了 `wordStyleName` → 隐式按 `"auto"` 模式处理

**示例 1**：直接引用带 `wordStyleName` 的样式

```json
"examTitle": {
  "baseStyle": "titleLarge"
}
```

`titleLarge` 有 `wordStyleName: "试卷标题 1"`，引擎自动按 `"auto"` 模式清除。

**示例 2**：通过中间样式间接引用

```json
"styles": {
  "base": { "wordStyleName": "试卷正文", "pPr": { "spacing": { ... } } },
  "boldSmall": { "baseStyle": "base", "resetFormat": "auto", "rPr": { ... } }
},
"elements": {
  "metadata": {
    "securityLevel": { "baseStyle": "boldSmall" }
  }
}
```

`securityLevel` 未声明 `resetFormat`，引擎沿链查找：`boldSmall` 上有 `resetFormat: "auto"` → 使用 auto 模式。auto 会解析完整的样式继承链（`base` + `boldSmall`），收集链上所有声明的 `pPr`/`rPr` 属性（包括 `base` 的 `spacing`），全部清除后再写入新格式。

> **为什么需要链式收集？** auto 模式通过 `resolveStyle` 解析完整继承链，获取所有祖先样式声明的属性。这些属性会通过 Word 样式或 inline 方式生效，如果段落原有 inline 属性与之冲突，必须先清除才能让新格式正确生效。

### 7.2 在样式上声明 resetFormat

`resetFormat` 不仅可以在元素上声明，也可以在**样式定义**中声明。这样所有引用该样式的元素都会自动继承清理策略，无需逐个声明：

```json
"styles": {
  "boldSmall": {
    "baseStyle": "base",
    "resetFormat": "auto",
    "rPr": { "rFonts": { "eastAsia": "黑体" }, "sz": 21, "b": true }
  }
}
```

引用 `boldSmall` 的元素默认继承 `resetFormat: "auto"`，除非元素自身显式覆盖。

### 7.3 字符串模式

| 值 | 含义 |
|------|------|
| `"auto"` | 沿样式继承链收集所有声明的属性，全部清除对应的段落内联格式 |
| `"all"` | 全部清除，等价于 `{ pPr: "all", rPr: "all" }` |
| `"none"` | 不清除任何属性（即使样式链上有 `wordStyleName`） |

```json
"volume": {
  "title": {
    "baseStyle": "titleMedium",
    "resetFormat": "all"
  }
}
```

### 7.4 对象模式（精确控制）

```json
"question": {
  "title": {
    "baseStyle": "base",
    "resetFormat": { "pPr": ["jc"], "rPr": ["sz", "szCs"] }
  }
}
```

| 属性 | 取值 | 说明 |
|------|------|------|
| `pPr` | `"all"` | 清空整个段落属性（自动保留自动编号 `numPr`） |
| `pPr` | `string[]` | 只清除指定段落属性，可选值详见[第五章](#五段落属性ppr) |
| `rPr` | `"all"` | 清空所有 Run 的字符格式 |
| `rPr` | `string[]` | 只清除指定字符属性，可选值详见[第四章](#四字符属性rpr) |
| `exclude` | object | 从合并后的清除范围中排除指定属性（不执行清除） |

**与继承的 resetFormat 合并**：对象模式不是独立生效，而是会沿 `baseStyle` 链计算继承的 resetFormat，然后将两者合并（取并集）。例如 `question.title` 的 `baseStyle` 是 `base`，`base` 有 `wordStyleName`，隐式按 `"auto"` 推断出清除 `rFonts`、`sz`、`color` 等属性，与元素自身的 `{ "rPr": ["sz", "szCs"] }` 合并后，最终清除 `rFonts`、`sz`、`szCs`、`color`。

### 7.5 exclude（排除）

当继承合并后的清除范围包含不需要的属性时，可用 `exclude` 排除：

```json
"question": {
  "title": {
    "baseStyle": "base",
    "resetFormat": {
      "pPr": ["jc"],
      "rPr": ["sz", "szCs"],
      "exclude": { "rPr": ["rFonts", "color"] }
    }
  }
}
```

此时合并后的清除范围中会移除 `rFonts` 和 `color`，保留原文档中这两个属性的设置。

`exclude` 仅支持数组形式（不支持 `"all"`），且只对非 `"all"` 的清除范围生效。

### 7.6 查找优先级

| 优先级 | 来源 | 说明 |
|--------|------|------|
| 1 | 元素自身的 `resetFormat` | 字符串模式直接使用；对象模式与继承合并 |
| 2 | 样式链上的 `resetFormat` | 沿 `baseStyle` 逐级向上查找第一个声明 |
| 3 | 样式链上的 `wordStyleName` | 未找到显式声明时，遇到 `wordStyleName` 隐式按 `"auto"` |
| — | 均未找到 | 不执行格式清理 |

> **注意**：当元素自身声明了对象模式的 `resetFormat` 时，仍会沿 `baseStyle` 链计算继承的 resetFormat 并合并（取并集），然后通过 `exclude` 排除不需要的属性。

### 7.7 何时需要 resetFormat

| 场景 | 建议 |
|------|------|
| 元素引用带 `wordStyleName` 的样式（直接或间接） | 不需要声明，自动推断即可 |
| 中间样式需要统一格式清理策略 | 在样式上声明 `resetFormat`，所有引用者自动继承 |
| 元素需要彻底清除原有格式再应用新格式 | 使用 `"all"` |
| 只需清除部分属性（如对齐方式） | 使用对象模式精确指定 |
| 样式链上无 `wordStyleName` 也无 `resetFormat` | 不需要声明，默认不清除 |
| 注意事项标题/列表项 | 通常使用 `"all"` 清除原有格式 |

## 八、首段/尾段变体

当一个元素包含多个段落时（如题干跨多段），如有需要可为**首段**和**尾段**分别指定不同的格式。

### 快速参考

```json
{
  "question": {
    "title": {
      "baseStyle": "base",
      "pPr": {
        "tabs": [1.5],
        "ind": { "hangingChars": 150 }
      },
      "firstParagraph": {
        "pPr": { "tabs": [1.5], "ind": { "hangingChars": 150 } }
      },
      "lastParagraph": {
        "pPr": { "ind": { "leftChars": 150 } }
      }
    }
  }
}
```

**应用规则**：

| 段落数 | 第 1 段 | 中间段 | 最后一段 |
|--------|---------|--------|----------|
| 1 段 | firstParagraph | — | — |
| 2 段 | firstParagraph | — | lastParagraph |
| 3+ 段 | firstParagraph | 默认 pPr | lastParagraph |

**关键规则**：

- `firstParagraph.pPr`/`rPr` **完全替换**元素默认的 `pPr`/`rPr`（不合并），但 `baseStyle` 始终生效
- 单段落时只视为首段，尾段规则不生效
- 未声明时所有段落使用元素默认格式（向后兼容）
- 适用于所有多段落元素：`question.title`、`subQuestion.title`、`material.*` 等
