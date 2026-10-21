# batch_page_break_before

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§format_rule 子字段索引。

## 用途

按 tag 插分页/分节。scope 忽略；按 tag+kind 定位；非 scope 驱动。

按 **formatList tag** 定位插入点，不使用 scope。`format_rule.rules[]` 结构与 `batch_apply_paragraph_style` 不同。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.rules` | 是 | 规则数组，至少一条 |
| `rules[].target.tag` | 是 | formatList 键，同 `batch_apply_paragraph_style` 的 `source.tag` |
| `rules[].target.kind` | 否，默认 `element` | `element`=单段要素；`area`=多段区域（如封面） |
| `rules[].break` | 否，默认 `page` | `page`/`section`/`sectionContinuous`/`sectionEvenPage`/`sectionOddPage`/`column` |
| `rules[].collapse` | 否 | `element` 默认 `start`（段前）；`area` 默认 `end`（区域后） |
| `rules[].indices` | 否 | 1-based 实例序号列表；省略则对所有实例生效 |

## 示例 JSON

### 一级标题前分页 + 封面区域后分页

```json
{
  "scope": {},
  "action": {
    "type": "batch_page_break_before",
    "format_rule": {
      "rules": [
        { "target": { "tag": "catalog_h1", "kind": "element" }, "break": "page" },
        { "target": { "tag": "cover", "kind": "area" }, "break": "page", "collapse": "end" }
      ]
    }
  }
}
```

### 仅第 1 个「摘要」要素前分节 + 奇数页

```json
{
  "scope": {},
  "action": {
    "type": "batch_page_break_before",
    "format_rule": {
      "rules": [
        {
          "target": { "tag": "abs", "kind": "element" },
          "break": "sectionOddPage",
          "collapse": "start",
          "indices": [1]
        }
      ]
    }
  }
}
```
