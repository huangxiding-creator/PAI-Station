# 工具：wps_toolcall_fmt — strict 规范文档专用 op

> **本文档定位**：仅 **strict（路径 F）** 处理用户上传的规范/范文附件时使用。函数签名见 `references/tools/wps-toolcall-fmt.md` §1。
> **本文档定位**：strict流程中 `wps_toolcall_fmt`工具的使用说明

## 1、本文件涵盖的 opString

| opString | 功能 | paramString |
|----------|------|-------------|
| `classify_desc_document` | 判定规范文档为范文或格式规范 | JSON，见 §2 |
| `preprocess_export_content` | 导出规范文档 FormatContent txt | JSON，见 §3 |

## 2、classify_desc_document

- **业务用途**：判定规范文档（doc/docx/wps/wpt/dot/dotx）是**范文**还是**格式规范**。接口**幂等只读**，失败可重试一次。

| 字段 | 必须 | 类型 | 说明 |
|------|------|------|------|
| `spec_file_path` | 是 | string | 规范文档本地绝对路径，仅支持 doc/docx/wps/wpt/dot/dotx |

| 返回字段 | 类型 | 说明 |
|----------|------|------|
| `code` | number | `0` 成功 |
| `msg` | string | 成功为 `"success"` |
| `doc_type` | string | `model_essay`（范文）或 `format_spec`（格式规范）；失败为 `""` |

```
wps_toolcall_fmt("classify_desc_document", '{"spec_file_path":"C:/Users/test/spec.docx"}')
```

## 3、preprocess_export_content

- **业务用途**：将规范文档内容导出为 FormatContent txt，供 `references/strict_rules/spec-ingest.md` 使用。接口**幂等**，失败可重试一次。

| 字段 | 必须 | 类型 | 说明 |
|------|------|------|------|
| `spec_file_path` | 是 | string | 规范文档本地绝对路径，仅支持 doc/docx/wps/wpt/dot/dotx |

| 返回字段 | 类型 | 说明 |
|----------|------|------|
| `code` | number | `0` 成功 |
| `msg` | string | 成功为 `"success"` |
| `output_path` | string | 导出的 txt 绝对路径；失败为 `""` |

```
wps_toolcall_fmt("preprocess_export_content", '{"spec_file_path":"C:/Users/test/spec.docx"}')
```
