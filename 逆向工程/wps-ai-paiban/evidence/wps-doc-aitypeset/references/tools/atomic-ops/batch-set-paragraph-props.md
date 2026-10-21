# batch_set_paragraph_props

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§单位约定、§scope。  
> **适用范围**：仅 **strict**（`path-strict-rule.md` / SmartLayoutGen）直出 oplist；beauty / tradition **不得**使用本 op。

## 用途

按 `doc_element_recog` 的 **formatList 标签**（`source.tag`）批量写入段落属性（`pPr`）与字符属性（`rPr`）。只写 JSON 里出现的 `pPr`/`rPr` 字段；**不改 `pStyle`**；未写字段保留段落原值。

scope 与每条 rule 的 tag 范围取交集；`scope: {}` 时生效范围等于 tag 范围。默认跳过表格内段落（`apply_in_table=true` 时表格内段落也应用）。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.apply_in_table` | 否，默认 false | true 时表格内段落也应用 |
| `format_rule.rules` | 是 | 规则数组，至少一条 |
| `rules[].source.tag` | 是 | formatList 键（**非** scope `type`），如 `catalog_h1`、`ref_list` |
| `rules[].source.data_ids` | 否 | 可选；`"start-end"` 字符串数组，省略 = 该 tag 在 formatList 中的全部段落 |
| `rules[].pPr` | 与 `rPr` 至少一个 | 段落属性；字段语义同 `import_element_styles` 的 `pPr` |
| `rules[].rPr` | 与 `pPr` 至少一个 | 字符属性；整段 `applyCharProps` |

每条 rule 的 `pPr`/`rPr` **至少一个非空**。

### 合并与定位

| 规则 | 说明 |
|------|------|
| 定位 | `effective = resolveScope(scope) ∩ resolveTag(tag) [∩ data_ids]`；与 `batch_apply_paragraph_style` 同套交集语义 |
| 合并键 | **同 tag + 同 data_ids 集合**（顺序无关）→ 合并 `pPr`/`rPr`；同字段冲突后覆盖 |
| 省略 data_ids | 等价于该 tag 在 formatList 的全集 |
| 非法 data_ids | 忽略非法项 + warning；交集为空 → 该 rule skip |
| 无交集 | 单 rule 可 skip/warning；整 op `appliedCount==0` 失败（与 batch_apply 一致） |

### formatList tag 常用键

键须为当前文档 `formatList` 中已有键；以实际 `formatList` 为准，不得臆造「服务端不返回」的内部 tag（如 `abs_keywords_title`）。引擎键名权威来源：`KFormatTags`（`kformatdefs.h`）。下表为常用键速查。

| source.tag | 含义 |
|------------|------|
| `doc_title` / `doc_title_en` | 文档标题 |
| `abs_title` / `abs_content` / `abs_keywords` | 中文摘要标题 / 正文 / 关键词行 |
| `abs_title_en` / `abs_content_en` / `abs_keywords_en` | 英文摘要对应 |
| `catalog_title` | 目录标题（「目  录」行） |
| `catalog_h1`~`catalog_h9` | 正文一~九级标题 |
| `main_text` | 正文 |
| `ref_title` / `ref_list` | 参考文献标题 / 条目 |
| `ack_title` / `ack_content` | 致谢标题 / 正文 |
| `appendix_title` / `appendix_content` | 附录标题 / 正文 |
| `image_title` / `table_title` | 图题 / 表题 |
| `addressees` / `addressee` / `signature` | 主送机关 / 落款等 |

> `chapter_title` 在引擎内可能映射为 `chapter_section_title`（`getRealTag`）；绑 tag 以 formatList 实际键为准。

## 示例 JSON

### 典型 strict oplist 单步

```json
{
  "scope": {},
  "action": {
    "type": "batch_set_paragraph_props",
    "format_rule": {
      "apply_in_table": false,
      "rules": [
        {
          "source": { "tag": "doc_title" },
          "pPr": { "jc": "center", "spacing": { "before": "24pt", "after": "18pt", "line": "1x" } },
          "rPr": { "sz": 16, "b": true, "rFonts": { "eastAsia": "黑体" } }
        },
        {
          "source": { "tag": "catalog_h1" },
          "pPr": { "jc": "start", "spacing": { "before": "12pt", "after": "6pt", "line": "1.5x" }, "outlineLvl": 0, "keepNext": true },
          "rPr": { "sz": 15, "b": true, "rFonts": { "eastAsia": "黑体" } }
        },
        {
          "source": { "tag": "main_text" },
          "pPr": { "jc": "both", "spacing": { "before": "0pt", "after": "0pt", "line": "20pt" }, "ind": { "firstLine": "2ch" } },
          "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
        },
        {
          "source": { "tag": "ref_list" },
          "pPr": { "spacing": { "line": "20pt" } },
          "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
        }
      ]
    }
  }
}
```

### 可选 data_ids（通常省略）

```json
{
  "scope": {},
  "action": {
    "type": "batch_set_paragraph_props",
    "format_rule": {
      "rules": [
        {
          "source": { "tag": "catalog_h2", "data_ids": ["42-42", "58-58"] },
          "pPr": { "jc": "center" },
          "rPr": { "sz": 14, "rFonts": { "eastAsia": "黑体" } }
        }
      ]
    }
  }
}
```

## 常见误用

- ❌ strict 路径使用 `import_element_styles` + `batch_apply_paragraph_style` 代替本 op
- ❌ strict 路径使用 `batch_set_paragraph_indent` / `batch_set_spacing` / `batch_set_span_style` 拼段落格式
- ❌ `source.tag` 填 scope `type`（如 `heading1`）— 应填 formatList 键（如 `catalog_h1`）
- ❌ 在 `pPr`/`rPr` 中填写要求原文未写明的字段
- ❌ 指望本 op 修改 `pStyle` 或清除未声明的局部格式
