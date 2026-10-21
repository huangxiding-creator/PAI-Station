# doc_element_recog 结构识别的返回值及处理说明

调用：

```
wps_toolcall_fmt("doc_element_recog", "{}")
```

## 返回 JSON 字段

| 字段 | 说明 |
|------|------|
| `code` | `0` 成功；非 0 视为识别失败，不得单独作为结构依据 |
| `formatList` | 段落级语义标签 → data-id 列表（**主依据**） |
| `areaFormatList` | 区域级标签 → data-id 范围 `[start, end]` |
| `splitHints`    | 无需理解其意义，如存在此字段需要透传给工具`wps_toolcall_fmt(open_typeset_session)`
| `numFormatList` | 仅 list↔heading 争议时查成员关系，**禁止**全量解析 |
| `outlineFormatList` | 忽略 |
| `entityList` | 忽略 |


`formatList` 的键为段落级语义标签，值为 data-id 数组。编排时 `source.tag` 须为当前文档 `formatList` 中**已有键**

## areaFormatList

| 键 | 含义 | 用途 |
|----|------|------|
| `appendix` | 附录区域 | 附录内标题/正文规则可不同于主文 |
| `parallel_sub_doc` | 并列子文档区域 | 多文合一；区域内独立分类 |
| 其他 | — | 作为 **范围约束**，不覆盖 formatList 段落标签 |

范围格式：`[["17-164", "189-338"]]` 表示 `[startDataId, endDataId]`（含端点）。

## 失败与降级

| 情况 | 处理 |
|------|------|
| `code !== 0` 或调用失败 | 不得仅依赖本源；降级为 overview + 启发式 |
| `formatList` 为空 | 同左 |
