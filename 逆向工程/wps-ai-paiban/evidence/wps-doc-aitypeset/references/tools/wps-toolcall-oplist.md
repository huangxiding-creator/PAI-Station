# 工具：wps_toolcall_fmt — oplist 流程专用 op

> **本文档定位**：美化流程中 `wps_toolcall_fmt`工具的使用说明

## 1、本文件涵盖的 opString

| opString | 功能 | paramString |
|----------|------|-------------|
| `doc_element_recog` | 获得文档大纲结构（A 源） | `"{}"` |
| `open_typeset_session` | 打开排版会话（oplist 写回前） | JSON，见 §3 |
| `oplist_exec` | 执行 oplist（批量写回） | JSON，见 §3 |
| `close_typeset_session` | 关闭排版会话（写回后） | `"{}"` |

## 2、doc_element_recog

- **业务用途**：获得文档大纲结构，作为结构识别 **A 源**输入。
- **paramString**：无参，传 `"{}"`
- **返回值**：

| 字段 | 必须 | 类型 | 说明 |
|------|------|------|------|
| `code` | 是 | number | `0` 成功；非 0 失败 |
| `formatList` | 否 | object\<string, string[]\> | 段落标签 → data-id[] |
| `splitHints` | 否 | object\<string, string\> | data-id → 段内语义标签 |
| `areaFormatList` | 否 | object\<string, string[][]\> | 区域标签 → `[[startDataId, endDataId]]` |
| `numFormatList` | 否 | object\<string, object[]\> | 编号列表 |
| `outlineFormatList` | 否 | object\<string, object[]\> | 大纲层级（若有） |
| `entityList` | 否 | object\<string, object[]\> | 实体（若有） |

**formatList 键表、A 源处理与 data-id 对齐**见 `references/doc_structure/doc-element-recog.md`。

## 3、session 与 oplist_exec

典型写回顺序（beauty / strict）：

```
open_typeset_session → oplist_exec → close_typeset_session
```
### open_typeset_session

- **paramString**：`{"recog_result":{...}}`（必填；`formatList`, 若存在则填：`splitHints`）

```json
{
  "formatList": {
    "doc_title": ["33-55"],
    "catalog_h1": ["56-63"],
    "main_text": ["63-159", "189-338"]
  },
  "splitHints": { "63-120": "摘要" }
}
```

```
wps_toolcall_fmt("open_typeset_session", '{"recog_result":{"formatList":{"catalog_h1":["56-63"],"main_text":["63-159"]},"splitHints":{"63-120":"摘要"}}}')
```

### oplist_exec

- **业务用途**：执行规划阶段产出的 **oplist**，批量写回当前文档。接口**非幂等**；失败**禁止**自动重试。
- **paramString**：`{"oplist":[...]}`（`oplist` 必填）
- **op 闭合骨架**：每条 op = `{"scope":{...},"action":{...}}`。写完 action 内容后**先闭合内部子结构，再追加 `}}` 闭合 action 和 op**。

### close_typeset_session

- **paramString**：`"{}"`
- **业务用途**：关闭 session；`oplist_exec` 成功后**必须**调用。

