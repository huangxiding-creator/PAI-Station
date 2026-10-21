# setup_table_style

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

对 scope 内表格统一设置样式（边框、底纹、字号、对齐、行高列宽）。scope 必填；推荐 `{ "filter": { "type": "table" } }` 选中全文表格，或用 start/end 收窄范围。**表头 = 第 1 行**。

支持预设样式 `three_line`（三线表）/ `full_border`（全边框）/ `no_border`（无边框），可与 `borders` 等自定义字段叠加覆盖。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.tblPr` | 是 | 表格属性对象，至少含一项子字段 |

### tblPr 子字段

均可选，按需组合：

| 字段 | 类型 | 说明 |
|------|------|------|
| `style` | string | 预设：`three_line` / `full_border` / `no_border` |
| `three_line_widths` | object | 仅 `style=three_line` 时生效；缺省 top=`"1.5pt"` / middle=`"0.75pt"` / bottom=`"1.5pt"` |
| `borders` | object | 自定义边框，可叠加在预设之上 |
| `shading` | object | 底纹/背景色 |
| `font` | object | 表内字号（区分表头/表体） |
| `text_align` | object | 水平对齐（区分表头/表体） |
| `cell_align` | string 或 object | 垂直对齐；字符串=全表统一，对象=区分表头/表体 |
| `row_height` | object | 行高；扁平=全表统一，含 `header`/`body`=区分表头/表体 |
| `col_widths` | number[] | 各列宽度（磅），按列顺序；超出实际列数忽略 |

### three_line_widths

均为带单位字符串：

| 字段 | 默认 | 说明 |
|------|------|------|
| `top` | `"1.5pt"` | 表格顶部线宽 |
| `middle` | `"0.75pt"` | 表头底部分隔线宽 |
| `bottom` | `"1.5pt"` | 表格底部线宽 |

### borders

| 字段 | 说明 |
|------|------|
| `top` / `bottom` / `left` / `right` | 外边框 |
| `inside_h` / `inside_v` | 内部水平/垂直边框 |

每个方向为独立对象：

| 字段 | 说明 |
|------|------|
| `line_style` | `single` / `double` / `none` |
| `line_width` | 带单位字符串，如 `"0.5pt"` / `"1.5pt"` |
| `color` | 6 位十六进制色值，如 `"000000"` |

### shading

| 字段 | 说明 |
|------|------|
| `header_color` | 表头行背景色（6 位十六进制） |
| `even_row_color` | 偶数数据行（第 2, 4, 6…行）背景色 |
| `odd_row_color` | 奇数数据行（第 3, 5, 7…行）背景色 |
| `color` | 统一背景色（优先级低于上述三项） |

### font

| 字段 | 说明 |
|------|------|
| `header_size` | 表头字号（磅），如 `10.5` |
| `body_size` | 表体字号（磅），如 `10.5` |

### text_align（水平）

| 字段 | 说明 |
|------|------|
| `header` | 表头：`left` / `center` / `right` / `justify` |
| `body` | 表体 |
| `all` | 全表统一（设后 header/body 均采用此值） |

### cell_align（垂直）

统一写法：`"center"`；区分写法：`{ "header": "center", "body": "top" }`

| 值 | 说明 |
|----|------|
| `top` | 顶端对齐 |
| `center` | 居中对齐 |
| `bottom` | 底端对齐 |

### row_height

统一写法：`{ "value": 25, "rule": "at_least" }`

区分写法：`{ "header": { "value": 30, "rule": "at_least" }, "body": { "value": 25, "rule": "at_least" } }`

| 字段 | 说明 |
|------|------|
| `value` | 行高值（磅） |
| `rule` | `at_least`（最小值）/ `exactly`（固定值）/ `auto`（自动） |

返值：`tables_processed`、可选 `warnings[]`。

## 示例 JSON

### 三线表（全文表格）

```json
{
  "scope": { "filter": { "type": "table" } },
  "action": {
    "type": "setup_table_style",
    "format_rule": {
      "tblPr": {
        "style": "three_line",
        "three_line_widths": { "top": "1.5pt", "middle": "0.75pt", "bottom": "1.5pt" },
        "shading": { "header_color": "D9E2F3" },
        "font": { "header_size": 10.5, "body_size": 10.5 },
        "text_align": { "header": "center", "body": "center" },
        "cell_align": { "header": "center", "body": "center" },
        "row_height": {
          "header": { "value": 30, "rule": "at_least" },
          "body": { "value": 25, "rule": "at_least" }
        }
      }
    }
  }
}
```

### 全边框 + 列宽

```json
{
  "scope": { "filter": { "type": "table" } },
  "action": {
    "type": "setup_table_style",
    "format_rule": {
      "tblPr": {
        "style": "full_border",
        "font": { "header_size": 12, "body_size": 12 },
        "col_widths": [80, 120, 200]
      }
    }
  }
}
```
