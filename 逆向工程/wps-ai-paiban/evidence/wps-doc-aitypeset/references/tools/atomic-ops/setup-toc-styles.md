# setup_toc_styles

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定。

## 用途

配目录样式。scope 忽略；须在 `insert_table_of_contents` / `update_table_of_contents` 前。

写入目录标题样式（「目录标题」）及 TOC 1~9 条目样式。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.tocStyle` | 是 | 至少含 `title` 或 `levels[]` 之一 |
| `tocStyle.title` | 否 | `{ pPr, rPr }`，对应「目录标题」样式 |
| `tocStyle.levels[]` | 否 | 每项 `{ level: 1~9, pPr, rPr }` |

`pPr`/`rPr` 同 [import-element-styles.md](import-element-styles.md)；单位见 [atomic-ops.md §单位约定](../atomic-ops.md)。

## 示例 JSON

须在 `insert_table_of_contents` / `update_table_of_contents` **之前**执行。

```json
{
  "scope": {},
  "action": {
    "type": "setup_toc_styles",
    "format_rule": {
      "tocStyle": {
        "title": {
          "pPr": { "jc": "center", "spacing": { "before": "12pt", "after": "12pt" } },
          "rPr": { "sz": 16, "b": true, "rFonts": { "eastAsia": "黑体" } }
        },
        "levels": [
          {
            "level": 1,
            "pPr": { "ind": { "firstLine": "0pt" }, "spacing": { "after": "3pt" } },
            "rPr": { "sz": 12, "b": true, "rFonts": { "eastAsia": "宋体" } }
          },
          {
            "level": 2,
            "pPr": { "ind": { "firstLine": "2ch" }, "spacing": { "after": "3pt" } },
            "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
          },
          {
            "level": 3,
            "pPr": { "ind": { "firstLine": "4ch" } },
            "rPr": { "sz": 12 }
          }
        ]
      }
    }
  }
}
```
