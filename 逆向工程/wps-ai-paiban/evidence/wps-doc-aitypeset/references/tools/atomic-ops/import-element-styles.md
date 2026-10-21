# import_element_styles

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

写要素样式到样式表。须在 `batch_apply_paragraph_style` 前；支持**构造格式**与**参考模板**；`style_name` 非空时仅按该名建样式。参考模板时 scope 必填。

## 参数字段

| `source` 枚举 | 模式名 | 做什么 |
|--------------|--------|--------|
| `"json"`（默认，可省略） | **构造格式** | 手写 `pPr`/`rPr` 创建样式 |
| `"extract"` | **参考模板** | 用 `scope` 定位段落，复制其格式为独立样式（只填 `style_name`） |

| 字段 | 必须 | 说明 |
|------|------|------|
| `element_style_rules` | 是 | 样式规则数组，每项见下 |
| scope | `source=extract` 时必 | 定位被复制格式段（取 scope 内首段）；`source=json` 时忽略 |

**`element_style_rules[]` 每项**：

| 字段 | 必须 | 说明 |
|------|------|------|
| `source` | 否，默认 `"json"` | 见上表；同一数组可混用 |
| `element` | `source=json` 时与 `style_name` 至少一个 | `Normal`、`title`、`heading 1`~`heading 9`、`header`、`footer` |
| `style_name` | `source=extract` 时必；`source=json` 时与 `element` 至少一个 | 非空时**仅**按此名查找/创建，不回退 `element`；须与 `batch_apply_paragraph_style` 的 `target.style_name` 一致 |
| `pPr` | 仅 `source=json` | 段落属性；单位见 [atomic-ops.md §单位约定](../atomic-ops.md) |
| `rPr` | 仅 `source=json` | 字符属性；`rPr.sz` 用 number（pt） |

**`pPr` 常用字段**：`jc`（`start`/`center`/`end`/`both`/`distribute`）、`outlineLvl`（1~9=大纲级别，10=正文，number 类型）、`keepNext`/`keepLines`（bool）、`spacing.{before,after,line}`（须带单位 string，如 `"12pt"`、`"1.5x"`）、`ind.{left,right,firstLine,hanging}`（须带单位 string）。

**`rPr` 常用字段**：`b`/`i`（bool）、`sz`（number，pt；**非 OOXML 半磅**，三号=16、小三=15、四号=14、小四=12、五号=10.5）、`color`（必须是具体 `#RRGGBB` 色值，不确定时用 `#000000`）、`rFonts.{ascii,eastAsia,hAnsi}`。

## 示例 JSON

以下为完整 oplist 单步条目（`{ scope, action }`）；写入 `oplist` 时直接使用。

### 构造格式（`source=json`，可省略 `source`）

```json
{
    "scope": {},
    "action": {
        "type": "import_element_styles",
        "element_style_rules": [
            {
                "element": "title",
                "pPr": {"jc":"center","outlineLvl":10,"keepNext":true,"spacing":{"line":"1.5x","before":"0pt","after":"6pt"},"ind":{"firstLine":"0pt"}},
                "rPr": {"sz":18,"b":true,"color":"#333333","rFonts":{"eastAsia":"黑体"}}
            },
            {
                "element": "heading 1",
                "pPr": {"jc":"start","outlineLvl":1,"keepNext":true,"spacing":{"line":"1.5x","before":"12pt","after":"6pt"},"ind":{"firstLine":"0pt"}},
                "rPr": {"sz":15,"b":true,"color":"#333333","rFonts":{"eastAsia":"黑体"}}
            },
            {
                "element": "Normal",
                "pPr": {"jc":"both","outlineLvl":10,"ind":{"firstLine":"2ch"},"spacing":{"line":"1.5x","before":"0pt","after":"0pt"}},
                "rPr": {"sz":12,"rFonts":{"eastAsia":"宋体"}}
            }
        ]
    }
}
```

### 参考模板（`source=extract`）

```json
{
  "scope": { "start": { "type": "heading1" } },
  "action": {
    "type": "import_element_styles",
    "element_style_rules": [
      { "source": "extract", "style_name": "论文一级标题" }
    ]
  }
}
```

### 混用两种模式（同一 `element_style_rules` 数组）

```json
{
  "scope": { "start": { "type": "heading1" } },
  "action": {
    "type": "import_element_styles",
    "element_style_rules": [
      { "source": "extract", "style_name": "论文一级标题" },
      {
        "element": "Normal",
        "style_name": "论文正文",
        "pPr": {
          "spacing": { "line": "1.5x", "before": "0pt", "after": "0pt" },
          "jc": "both",
          "ind": { "firstLine": "24pt" }
        },
        "rPr": { "sz": 16, "rFonts": { "eastAsia": "仿宋" } }
      }
    ]
  }
}
```
