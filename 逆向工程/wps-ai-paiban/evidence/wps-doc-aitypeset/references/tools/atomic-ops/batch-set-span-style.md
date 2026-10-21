# batch_set_span_style

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

句/run 级格式。`batch_apply_paragraph_style` **之后**执行；用于整段或局部加粗、字号、颜色等。

两种定位方式：

| 方式 | 适用 | `format_rule` 形态 |
|------|------|-------------------|
| **scope 驱动** | 某类段落全文 run 统一格式 | 顶层 `rPr` + 三段式 `scope` |
| **rules 逐段** | 段内局部 run（如**段首提纲**） | `rules[]`，每条 `source.data_id` + `offset` + `rPr` |

## 参数字段

### scope 驱动（整段/范围内 run）

| 字段 | 必须 | 说明 |
|------|------|------|
| `scope` | 是 | 三段式，见 atomic-ops.md §scope |
| `format_rule.rPr` | 是 | 至少含 `b`/`i`/`sz` 之一（硬约束 #3）；禁仅 `rFonts` |

### rules 逐段（段内 offset）

| 字段 | 必须 | 说明 |
|------|------|------|
| `scope` | 否 | 通常 `{}`；定位由每条 rule 的 `source` 承担 |
| `format_rule.rules[]` | 是 | 每条含 `source` + `rPr` |
| `rules[].source.data_id` | 是 | 目标段落 data-id（如 `"63-159"`） |
| `rules[].source.offset.start` / `end` | 是 | 段内字符偏移；`end` 覆盖提纲实际范围（如至全角冒号 `：`），**禁止**全篇写死同一长度 |
| `rules[].rPr` | 是 | 至少含 `b`/`i`/`sz` 之一 |

| rPr 字段 | 类型 | 说明 |
|----------|------|------|
| `b` / `i` | bool | 加粗 / 斜体 |
| `sz` | number | 字号（**pt，非 OOXML 半磅**）；三号=16、小三=15、四号=14、小四=12、五号=10.5 |
| `color` | string | `#RRGGBB`（6 位十六进制） |
| `rFonts.ascii` / `eastAsia` / `hAnsi` | string | 西文 / 东亚 / 扩展西文字体名 |

## 示例 JSON

### 一级标题加粗（scope 驱动）

```json
{
  "scope": { "start": { "type": "heading1" }, "filter": { "type": "heading1" } },
  "action": {
    "type": "batch_set_span_style",
    "format_rule": { "rPr": { "b": true } }
  }
}
```

### 正文字号 + 字体 + 颜色（scope 驱动）

```json
{
  "scope": { "start": { "type": "paragraph" }, "filter": { "type": "paragraph" } },
  "action": {
    "type": "batch_set_span_style",
    "format_rule": {
      "rPr": {
        "sz": 16,
        "color": "#000000",
        "rFonts": { "eastAsia": "仿宋", "ascii": "Times New Roman" }
      }
    }
  }
}
```
