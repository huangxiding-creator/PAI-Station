# cleanup_empty_paragraphs / trim_paragraph_leading_chars

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§公共数据结构。

## 用途

| action.type | 用途 | scope |
|-------------|------|-------|
| `cleanup_empty_paragraphs` | 删全文空段 | 忽略 |
| `trim_paragraph_leading_chars` | 删段首空白 | 忽略 |

备注：`cleanup_empty_paragraphs` 含图片/嵌入对象/分页符/分节符/下划线的段保留；`trim_paragraph_leading_chars` 跳过居中/右对齐/有下划线。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `type` | 是 | op 名；仅此字段 |
| scope | 忽略 | 全文遍历 |

## 示例 JSON

### 清理 + 去段首空格（编排常见前置组合）

```json
{
  "oplist": [
    { "scope": {}, "action": { "type": "cleanup_empty_paragraphs" } },
    { "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } }
  ]
}
```

### 单步：删空段

```json
{ "scope": {}, "action": { "type": "cleanup_empty_paragraphs" } }
```

### 单步：删段首空白

```json
{ "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } }
```
