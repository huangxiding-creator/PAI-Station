# 段落位置变体（firstParagraph / lastParagraph）

当一个元素包含多个段落时（如题干跨多段），可为**首段**和**尾段**分别指定不同的格式，其余段落使用元素默认格式。

## 适用场景

理科试卷题干通常需要悬挂缩进 + 制表位实现题号悬挂，但这只适用于首段。续段应使用普通左缩进，不再需要制表位：

```
首段：  1.	已知函数 f(x) = ...    ← 制表位 + 悬挂缩进
续段：  其中 a > 0，b < 0。       ← 左缩进，无制表位
```

## Schema 定义

在任何支持多段落的元素上，添加 `firstParagraph` 和/或 `lastParagraph` 属性：

```json
{
  "question": {
    "title": {
      "baseStyle": "base",
      "resetFormat": { "pPr": ["jc"], "rPr": ["sz", "szCs"] },
      "pPr": {
        "ind": { "left": 1.5 }
      },
      "firstParagraph": {
        "pPr": { "tabs": [1.5], "ind": { "hanging": 1.5 } }
      }
    }
  }
}
```

### 属性说明

| 属性 | 类型 | 说明 |
|------|------|------|
| `firstParagraph` | object | 首段的格式覆盖（可选） |
| `firstParagraph.pPr` | pPrDef | 首段的段落属性，**完全替换**元素默认的 pPr |
| `firstParagraph.rPr` | rPrDef | 首段的字符属性，**完全替换**元素默认的 rPr |
| `lastParagraph` | object | 尾段的格式覆盖（可选） |
| `lastParagraph.pPr` | pPrDef | 尾段的段落属性，**完全替换**元素默认的 pPr |
| `lastParagraph.rPr` | rPrDef | 尾段的字符属性，**完全替换**元素默认的 rPr |

## 应用规则

对于每个节点（question / subQuestion 等）的段落数组：

| 段落数 | 第 1 段 | 中间段 | 最后一段 |
|--------|---------|--------|----------|
| 1 段 | firstParagraph | — | — |
| 2 段 | firstParagraph | — | lastParagraph |
| 3+ 段 | firstParagraph | 默认 pPr | lastParagraph |

**关键规则**：

- `firstParagraph.pPr` **完全替换**元素默认的 `pPr`（不合并），但 `baseStyle` 始终生效
- `lastParagraph.pPr` 同理
- 未声明 `firstParagraph` 时，首段使用元素默认格式
- 未声明 `lastParagraph` 时，尾段使用元素默认格式
- 两者都未声明时，所有段落行为与不使用此特性时完全一致（向后兼容）
- 单段落时只视为首段，尾段规则不生效

## 格式解析流程

```
baseStyle.pPr（来自 styles 定义）
  + firstParagraph.pPr（完全替换元素默认 pPr，作为 inline 覆盖）
  = 首段最终格式

baseStyle.pPr
  + 元素默认 pPr
  = 中间段落最终格式

baseStyle.pPr
  + lastParagraph.pPr（完全替换元素默认 pPr，作为 inline 覆盖）
  = 尾段最终格式
```

## 适用范围

此特性是**通用能力**，适用于所有多段落元素：

| 元素 | 段落分组依据 |
|------|------------|
| `question.title` | 每个 question 节点的 title 数组 |
| `subQuestion.title` | 每个 subQuestion 节点的 title 数组 |
| `material.*` | 每个 material 实例的对应子元素数组 |
| 卷头元素 | 每个段落独立成组（通常只有 1 段） |

## 更多示例

### 仅定义首段

如果只需要首段特殊，尾段和中间段使用相同默认格式：

```json
{
  "question": {
    "title": {
      "baseStyle": "base",
      "pPr": {
        "ind": { "firstLine": 2 }
      },
      "firstParagraph": {
        "pPr": { "tabs": [1.5], "ind": { "hanging": 1.5 } }
      }
    }
  }
}
```

### 同时覆盖字符属性

首段需要不同字号或字体时，可在 `firstParagraph.rPr` 中声明：

```json
{
  "section": {
    "title": {
      "baseStyle": "titleSmall",
      "rPr": { "sz": 10.5 },
      "firstParagraph": {
        "rPr": { "sz": 12, "b": true }
      }
    }
  }
}
```
