# batch_apply_paragraph_style

> 公共约定见 [atomic-ops.md](../atomic-ops.md)：§scope、§format_rule 子字段索引。

## 用途

按识别标签挂样式。须在 `import_element_styles` 后；scope 与 tag 范围取交集；`target.style_name` 非空时仅按该名挂接，须与 `import_element_styles` 一致。

按 `doc_element_recog` 的 **formatList 标签**（`source.tag`）批量挂接到样式表中的要素样式。scope 与每条 rule 的 tag 范围取交集；`scope: {}` 时生效范围等于 tag 范围（可按需收窄 scope）。**默认跳过表格内段落**（`apply_in_table=true` 时表格内段落也应用）。

## 参数字段

| 字段 | 必须 | 说明 |
|------|------|------|
| `format_rule.apply_in_table` | 否，默认 false | true 时表格内段落也应用样式 |
| `format_rule.rules` | 是 | 映射规则数组，至少一条 |
| `rules[].source.tag` | 是 | formatList 键（**非** scope `type`），如 `catalog_h1`、`main_text` |
| `rules[].target.element` | 与 `style_name` 至少一个 | 要素名；`style_name` 非空时可省略 |
| `rules[].target.style_name` | 与 `element` 至少一个 | 非空时**仅**按此名查样式，不回退 `element`；须与 `import_element_styles` 同条 `style_name` 一致 |
| `rules[].is_normal` | 否，默认 false | true 保留边框、分页符、列表缩进；挂 `Normal` 建议 true |
| `rules[].clear_span_props` | 否，默认 false | true 清除段落内 run 的直接字符格式，让样式 rPr 完全生效；标题类建议 true，正文类按需（保留有意义的局部加粗等用 false） |

**`source.tag` 常用键**（须为 formatList 中已有键；`MB_None` 映射的 tag 会被跳过）：

| source.tag | 含义 |
|------------|------|
| `doc_title` / `doc_title_en` / `general_doc_title` / `emphasized_title` | 文档/公文标题 |
| `catalog_h1`~`catalog_h9` | 一~九级标题 |
| `chapter_title` / `section_title` | 章标题 / 节标题 |
| `ack_title` / `ref_title` / `statement_title` | 致谢 / 参考文献 / 声明标题 |
| `table_title` / `image_title` | 表格标题 / 图片标题 |
| `main_text` / `addressees` / `addressee` | 正文 / 收文机关（复数/单数均可） |
| `signature` | 落款 / 署名 / 日期 |

## 示例 JSON

以下为完整 oplist 单步条目。须在同轮 `import_element_styles` **之后**执行。

### 按 `element` 挂接（常用）

```json
{
  "scope": {},
  "action": {
    "type": "batch_apply_paragraph_style",
    "format_rule": {
      "rules": [
        { "source": { "tag": "doc_title" },   "target": { "style_name": "美化文档标题" }, "is_normal": false, "clear_span_props": true },
        { "source": { "tag": "catalog_h1" }, "target": { "style_name": "美化标题 1" },    "is_normal": false, "clear_span_props": true },
        { "source": { "tag": "catalog_h2" }, "target": { "style_name": "美化标题 2" },    "is_normal": false, "clear_span_props": true },
        { "source": { "tag": "main_text" },  "target": { "style_name": "美化正文" },      "is_normal": true,  "clear_span_props": false },
        { "source": { "tag": "addressees" }, "target": { "style_name": "美化正文" },      "is_normal": true,  "clear_span_props": false }
      ]
    }
  }
}
```

### 按 `style_name` 挂接（与 import 自定义样式名一致）

```json
{
  "scope": {},
  "action": {
    "type": "batch_apply_paragraph_style",
    "format_rule": {
      "rules": [
        { "source": { "tag": "catalog_h1" }, "target": { "style_name": "论文一级标题" }, "is_normal": false, "clear_span_props": true },
        { "source": { "tag": "main_text" },  "target": { "style_name": "论文正文" },     "is_normal": true,  "clear_span_props": false }
      ]
    }
  }
}
```

### 收窄 scope（仅第 1 节内 tag 生效）

```json
{
  "scope": { "start": { "type": "section", "index": 1 }, "end": { "type": "section", "index": 1 } },
  "action": {
    "type": "batch_apply_paragraph_style",
    "format_rule": {
      "rules": [
        { "source": { "tag": "main_text" }, "target": { "element": "Normal" }, "is_normal": true, "clear_span_props": false }
      ]
    }
  }
}
```

## 常见误用

- ❌ `format_rule.pPr.pStyle` — **不支持**；按标签挂段落样式须用 `format_rule.rules[]`
- ❌ `clear_all_span_props` — 应为 `clear_span_props`
- ❌ 未先 `import_element_styles` 就挂接样式
- ❌ `source.tag` 填 scope `type`（如 `heading1`）— 应填 formatList 键（如 `catalog_h1`）
- ❌ `style_name` 非空却指望回退 `element` 查找
- ❌ `doc_title` 与 `catalog_h1` 挂到同一 `element` 且无独立 `style_name` — title 须居中且字号大于 h1
