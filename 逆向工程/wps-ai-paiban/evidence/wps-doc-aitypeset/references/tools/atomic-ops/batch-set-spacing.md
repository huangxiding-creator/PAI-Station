# batch_set_spacing

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

段距/行距。scope 必填；spacing 须用带单位字符串（见 [atomic-ops.md §单位约定](../atomic-ops.md)）。

## 两种模式

- **legacy（顶层 pPr + scope）**：对 scope 内全部段落统一写 spacing，走 KFormatMolding。
- **rules（推荐，按段微调）**：`format_rule.rules[]`，每条 rule 自带 `source` + `pPr.spacing`，定位走 ParaIdRegistry（与 `batch_set_paragraph_props` 同构）。刷完整类样式后单独调几段时用此模式，避免波及整类要素。`rules` 非空时忽略顶层 `pPr`。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.pPr.spacing` | legacy 必填 | 段前/段后/行距；须用带单位 string |
| `format_rule.rules[].source.tag` | rules 必填 | 语义 tag（formatList 中的要素） |
| `format_rule.rules[].source.data_ids` | rules 可选 | 省略=该 tag 全部段落；给定=仅这些 data-id |
| `format_rule.rules[].pPr.spacing` | rules 必填 | 该 rule 的行距设置 |
| `format_rule.apply_in_table` | 可选 | 默认 false |

| spacing 字段 | 说明 |
|--------------|------|
| `before` / `after` | 段前/段后间距，如 `"12pt"` |
| `line` | 行距；须 string 自描述，写法见下表 |

`spacing.line` 写法：

| 写法 | 含义 |
|------|------|
| `"1.5x"` | 倍率行距（推荐） |
| `"24pt"` | 固定行距 |
| `"24pt+"` | 最小行距 |

## 示例 JSON

### 全文统一行距

```json
{
  "scope": {},
  "action": {
    "type": "batch_set_spacing",
    "format_rule": {
      "pPr": {
        "spacing": { "line": "1.5x", "before": "0pt", "after": "0pt" }
      }
    }
  }
}
```

### 仅正文段落：段前段后 + 行距

```json
{
  "scope": { "start": { "type": "paragraph" }, "filter": { "type": "paragraph" } },
  "action": {
    "type": "batch_set_spacing",
    "format_rule": {
      "pPr": {
        "spacing": { "before": "6pt", "after": "6pt", "line": "1.5x" }
      }
    }
  }
}
```

### rules 模式：按 data_ids 单独调整指定段落的行距

```json
{
  "scope": {},
  "action": {
    "type": "batch_set_spacing",
    "format_rule": {
      "rules": [
        { "source": { "tag": "main_text", "data_ids": ["120-128"] }, "pPr": { "spacing": { "line": "1.35x" } } },
        { "source": { "tag": "main_text", "data_ids": ["340-355"] }, "pPr": { "spacing": { "line": "1.0x" } } }
      ]
    }
  }
}
```

> 多条 rule 可对同一 tag 的不同 data_ids 设置不同行距；仅列出的段落被改，其余 main_text 段落不受影响。

**注意**：本 op 写入 pPr.spacing 时，若 scope 为全文 {}， 且目标段落已通过 batch_apply_paragraph_style 挂接了含 ind/jc 的样式， pPr 的写入可能覆盖这些已挂接的段落属性。
**建议**：(1) 行距在 import_element_styles 样式定义中声明；(2) 如需单独调用，scope 应按 tag 限定。
