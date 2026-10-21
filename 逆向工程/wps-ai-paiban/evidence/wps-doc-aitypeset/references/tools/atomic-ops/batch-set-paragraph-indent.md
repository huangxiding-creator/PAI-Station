# batch_set_paragraph_indent

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。

## 用途

段落缩进（直接格式）。scope 必填；`format_rule.pPr.ind` 至少一项。

## 两种模式

- **legacy（顶层 pPr + scope）**：对 scope 内全部段落统一写 ind，走 KFormatMolding。
- **rules（推荐，按段微调）**：`format_rule.rules[]`，每条 rule 自带 `source` + `pPr.ind`，定位走 ParaIdRegistry（与 `batch_set_paragraph_props` 同构）。刷完整类样式后单独调几段时用此模式，避免波及整类要素。`rules` 非空时忽略顶层 `pPr`。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.pPr.ind` | legacy 必填 | 至少含 `left`/`right`/`firstLine`/`hanging` 之一；须用带单位 string（见 [atomic-ops.md §单位约定](../atomic-ops.md)） |
| `format_rule.rules[].source.tag` | rules 必填 | 语义 tag（formatList 中的要素） |
| `format_rule.rules[].source.data_ids` | rules 可选 | 省略=该 tag 全部段落；给定=仅这些 data-id |
| `format_rule.rules[].pPr.ind` | rules 必填 | 该 rule 的缩进设置 |
| `format_rule.apply_in_table` | 可选 | 默认 false |

| ind 字段 | 说明 |
|----------|------|
| `left` / `right` | 左/右缩进 |
| `firstLine` | 首行缩进（正值） |
| `hanging` | 悬挂缩进（正值，内部自动取负传给引擎） |

## 示例 JSON

### 首行缩进 2 字符

```json
{
  "scope": { "start": { "type": "paragraph" }, "filter": { "type": "paragraph" } },
  "action": {
    "type": "batch_set_paragraph_indent",
    "format_rule": { "pPr": { "ind": { "firstLine": "2ch" } } }
  }
}
```

### 悬挂缩进（参考文献等）

```json
{
  "scope": { "start": { "type": "paragraph" }, "filter": { "type": "paragraph" } },
  "action": {
    "type": "batch_set_paragraph_indent",
    "format_rule": { "pPr": { "ind": { "left": "24pt", "hanging": "24pt" } } }
  }
}
```

### rules 模式：仅取消指定段落的首行缩进

```json
{
  "scope": {},
  "action": {
    "type": "batch_set_paragraph_indent",
    "format_rule": {
      "apply_in_table": false,
      "rules": [
        { "source": { "tag": "main_text", "data_ids": ["120-128", "340-355"] }, "pPr": { "ind": { "firstLine": "0pt" } } }
      ]
    }
  }
}
```

> 仅列出的 data-id 段落被改；省略 `data_ids` 则作用于该 tag 全部段落。多条 rule 可对不同 data_ids 设置不同缩进。
