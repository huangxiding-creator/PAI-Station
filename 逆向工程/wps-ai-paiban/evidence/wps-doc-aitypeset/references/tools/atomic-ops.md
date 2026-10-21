# 原子排版能力

> **本文档定位**：介绍各个原子排版能力接口，编排 `oplist` 的可拆解排版能力，编排结果提供给 `oplist_exec` 接口统一执行。

**op**：一栏表 `action.type` 列的 op 名称。

**oplist**：`[{ "scope": {}, "action": { "type": "<op名>", ... } }, ...]`，按各路径 rule 文件规定的编排顺序排列后提交 `oplist_exec`。

## 原子能力一栏表

| 分类 | action.type | 用途 | 适用问题 | scope | 详情文件 |
| ---- | ----------- | --- | ------- | ----- | ------ |
| 结构清理 | `cleanup_empty_paragraphs` | 删全文空段 | 连续空段 | 忽略 | [cleanup-trim.md](atomic-ops/cleanup-trim.md) |
| 结构清理 | `trim_paragraph_leading_chars` | 删段首空白 | 段首多余空格 | 忽略 | [cleanup-trim.md](atomic-ops/cleanup-trim.md) |
| 样式管理 | `import_element_styles` | 写要素样式到样式表 | 需建样式库 | 参考模板时要 | [import-element-styles.md](atomic-ops/import-element-styles.md) |
| 样式管理 | `batch_apply_paragraph_style` | 按识别标签挂样式 | 样式不统一 | 要 | [batch-apply-paragraph-style.md](atomic-ops/batch-apply-paragraph-style.md) |
| 段落格式 | `batch_set_paragraph_props` | 按 tag 写段落/字符属性 | strict 规范直出 | 要 | [batch-set-paragraph-props.md](atomic-ops/batch-set-paragraph-props.md) |
| 样式管理 | `setup_toc_styles` | 配目录样式 | 目录格式 | 忽略 | [setup-toc-styles.md](atomic-ops/setup-toc-styles.md) |
| 段落格式 | `batch_set_paragraph_indent` | 段落缩进 | 缩进混乱 | 要 | [batch-set-paragraph-indent.md](atomic-ops/batch-set-paragraph-indent.md) |
| 段落格式 | `batch_set_span_style` | 句/run 格式 | 字体/加粗不一 | 要 | [batch-set-span-style.md](atomic-ops/batch-set-span-style.md) |
| 段落格式 | `batch_set_spacing` | 段距/行距 | 间距不一 | 要 | [batch-set-spacing.md](atomic-ops/batch-set-spacing.md) |
| 分页 | `batch_page_break_before` | 按 tag 插分页 | 章节分页 | 忽略 | [batch-page-break-before.md](atomic-ops/batch-page-break-before.md) |
| 页面设置 | `setup_page_setup` | 纸张/边距/方向 | 页面设置不对 | 要 | [setup-page-setup.md](atomic-ops/setup-page-setup.md) |
| 页面设置 | `setup_header_footer` | 页眉/页脚/页码 | 页眉页脚配置 | 忽略 | [setup-header-footer.md](atomic-ops/setup-header-footer.md) |
| 表格 | `setup_table_style` | 配表格样式 | 表格格式 | 要 | [setup-table-style.md](atomic-ops/setup-table-style.md) |
| 目录 | `insert_table_of_contents` | 插入目录 | 缺目录 | 忽略 | [table-of-contents.md](atomic-ops/table-of-contents.md) |
| 目录 | `update_table_of_contents` | 更新目录 | 目录过时 | 忽略 | [table-of-contents.md](atomic-ops/table-of-contents.md) |
| 目录 | `delete_table_of_contents` | 删除目录 | 需重建目录 | 忽略 | [table-of-contents.md](atomic-ops/table-of-contents.md) |

> **scope 列取值**：`忽略`→`scope` 写 `{}`；`要`→三段式（§scope）；`参考模板时要`→`import_element_styles` extract 模式必填 scope。



## 如何编排 oplist

1. **选 op**：按 issueList 对照 §原子能力一栏表「适用问题」，只选需要的 op（可多步）。
2. **填条目**：每条 `{ scope, action }`；请求结构见 §公共数据结构。
3. **定 scope**：见一栏表「scope」列及表下说明；三段式语法见 §scope。
4. **组织 action 参数**：对照一栏表确定 `action.type` 后，加载「详情文件」列对应文件填写字段；单位见 §单位约定。
5. **排序**：见所在路径 rule 文件的编排顺序段落。
6. **写回**：`oplist` 放入 `oplist_exec`。

---

## 公共数据结构

### oplist 条目骨架

每条 oplist 条目 = `{ scope, action }`。`oplist_exec` 按数组顺序逐步执行，单步 failed/skipped 不阻断后续。

```json
{
  "scope": {},
  "action": {
    "type": "<op名>",
    "format_rule": { "pPr": {}, "rPr": {}, "sectPr": {}, "rules": [], "tocStyle": {}, "tblPr": {}, "defaults": {} },
    "format": { "tocPr": {} },
    "element_style_rules": []
  }
}
```

> 骨架列出 `action` 下**可能出现的全部键**；编排时**仅保留当前 op 所需字段**，其余省略。各键适用哪些 op 见 §action 可选字段 及 §format_rule 子字段索引。

### 条目顶层字段


| 字段            | 必填   | 含义             | 怎么填                     |
| ------------- | ---- | -------------- | ----------------------- |
| `scope`       | 视 op | 本步作用的文档 GCP 范围 | 见 §scope；取值见一栏表「scope」列 |
| `action`      | 是    | 本步要执行的 op 及其参数 | 对象，至少含 `type`           |
| `action.type` | 是    | op 名称          | 见一栏表 `action.type` 列    |


### action 可选字段

各键含义：

| 字段 | 含义 |
| --- | --- |
| `action.format_rule` | 格式规则容器；子结构因 op 而异，见 §format_rule 子字段索引 |
| `action.format` | 目录参数包装层；仅目录 op 使用；oplist 内须嵌套为 `action.action.format.tocPr` |
| `action.element_style_rules` | 样式导入规则数组；仅 `import_element_styles` 使用；字段详述见详情文件 |


### format_rule 子字段索引

`action.format_rule` 的子字段因 op 而异，对照下表确定：


| 子字段                    | 适用 op                                                                         | 含义                                    |
| ---------------------- | ----------------------------------------------------------------------------- | ------------------------------------- |
| `format_rule.pPr`      | `batch_set_paragraph_indent`（`pPr.ind`）、`batch_set_spacing`（`pPr.spacing`）    | 段落属性                                  |
| `format_rule.rPr`      | `batch_set_span_style`                                                        | 字符属性                             |
| `format_rule.sectPr`   | `setup_page_setup`                                                            | 节属性（纸张 `pgSz`、边距 `pgMar`）             |
| `format_rule.rules[]`  | `batch_apply_paragraph_style`、`batch_set_paragraph_props`、`batch_page_break_before`、`setup_header_footer` | 规则数组；各 op 结构不同，详见一栏表「详情文件」列对应文件 |
| `format_rule.tocStyle` | `setup_toc_styles`                                                            | 目录标题行 + TOC1~9 样式                     |
| `format_rule.tblPr`    | `setup_table_style`                                                           | 表格属性（边框/底纹/字号/对齐/行高列宽）                  |
| `format_rule.defaults` | `setup_header_footer`                                                         | 与 `rules[]` 深度合并的默认规则                 |


### formatList（编排前提）

当前排版会话已注册的 **tag → 段落 ID[]** 映射。`batch_apply_paragraph_style`、`batch_set_paragraph_props`、`batch_page_break_before` 等按 tag 定位的 op，`source.tag` / `target.tag` 须为其中**已有键**；键不存在则该 rule 跳过。`batch_set_paragraph_props` 常用键见 `atomic-ops/batch-set-paragraph-props.md`。

### scope 与 formatList tag 的区别


| 用途                                           | 用 scope `type`             | 用 formatList `tag`           |
| -------------------------------------------- | -------------------------- | ---------------------------- |
| 定位「第几个一级标题」「全文正文段」                           | ✓ 如 `heading1`、`paragraph` | ✗                            |
| `batch_apply_paragraph_style` 的 `source.tag` | ✗ 勿填 `heading1`            | ✓ 如 `catalog_h1`、`main_text` |
| `batch_set_paragraph_props` 的 `source.tag` | ✗ 勿填 `heading1`            | ✓ 如 `catalog_h1`、`ref_list` |
| `batch_page_break_before` 的 `target.tag`     | ✗                          | ✓                            |
| `import_element_styles` extract 模式定位参考段      | ✓                          | ✗                            |


## scope（三段式）

结构：`{ start, end, filter }`，子对象 `{ type, index?, extra?, pattern? }`。


| 字段       | 说明                                                                           |
| -------- | ---------------------------------------------------------------------------- |
| `start`  | 范围起点；缺省/`{}` → 文档起始                                                          |
| `end`    | 范围终点；**键缺失**时复制 start（有 index 则同实例，无 index 则取该类型末个）；`**{}` 或双缺** → subdoc 末尾 |
| `filter` | 对 start..end 再过滤；缺省 → 直接用 start..end；支持 `pattern`（Word 通配符）                  |
| `type`   | 块类型（见下表）；定位时必填                                                               |
| `index`  | 1-based 实例序号；`section`/`page`/`signature` 等；缺省 start=1，end=末个 |
| `extra`  | 仅 `header`/`footer` 的 filter 有效：`default`（默认）、`first`（首页）、`even`（偶数页）        |


**常用 scope 写法**：


| 意图       | scope                                                                                        |
| -------- | -------------------------------------------------------------------------------------------- |
| 全文       | `{}`                                                                                         |
| 某类要素全部实例 | `{ "start": { "type": "heading1" }, "filter": { "type": "heading1" } }`                      |
| 第 N 个实例  | `{ "start": { "type": "heading1", "index": 2 }, "end": { "type": "heading1", "index": 2 } }` |
| 落款首段（第 1 个 signature） | `{ "start": { "type": "signature", "index": 1 }, "end": { "type": "signature", "index": 1 } }` |
| 落款第 2 段起 | `{ "start": { "type": "signature", "index": 2 } }`（**不写** `end`） |
| 第 N 节    | `{ "start": { "type": "section", "index": 2 }, "end": { "type": "section", "index": 2 } }`   |
| 第 1~3 页  | `{ "start": { "type": "page", "index": 1 }, "end": { "type": "page", "index": 3 } }`         |
| 范围内所有表格  | `{ "filter": { "type": "table" } }`                                                          |
| 首页页眉     | `{ "start": { "type": "header" }, "filter": { "type": "header", "extra": "first" } }`        |


**`scope.type` 枚举**：


| type                                               | 含义        | formatList 键对照                         | 需要 index       |
| -------------------------------------------------- | --------- | -------------------------------------- | -------------- |
| `doc_title` / `doc_title_en` / `general_doc_title` | 文档主标题   | `doc_title` 等                          | 否              |
| `emphasized_title`                                 | 强调标题     | `emphasized_title`                     | 否              |
| `heading1`~`heading9`                              | 一~九级标题  | `catalog_h1`~`catalog_h9`              | 否              |
| `paragraph`                                        | 正文段落     | `main_text`                            | 否              |
| `subtitle`                                         | 副标题       | —                                      | 否              |
| `signature`                                        | 签名/落款    | —                                      | 否              |
| `chapterTitle`                                     | 章标题       | `chapter_title`                        | 否              |
| `sectionTitle`                                     | 节标题       | `section_title`                        | 否              |
| `abstract` / `abstract_title` / `abstract_content` | 摘要区/标题/内容 | `abs` / `abs_title` / `abs_content`   | 否              |
| `abstractKeywords`                                 | 摘要关键词     | —                                      | 否              |
| `abstractLabel`                                    | 摘要标签      | —                                      | 否              |
| `cover` / `statement`                              | 封面/声明     | `cover` / `statement`                  | 否              |
| `statementTitle` / `statementContent`              | 声明标题/内容   | `statement_title` /                   | 否              |
| `catalogTitle` / `catalogContent`                  | 目录标题/内容   | —                                     | 否              |
| `referenceTitle` / `referenceList`                 | 参考文献标题/列表 | `ref_title` /                      | 否              |
| `appendixTitle` / `appendixContent`                | 附录标题/内容   | `catalog_title`                      | 否              |
| `acknowledgmentTitle` / `acknowledgmentContent`    | 致谢标题/内容   | `ack_title` /                        | 否              |
| `introductionTitle`                                | 引言标题      | —                                      | 否              |
| `conclusionTitle`                                  | 结论标题      | —                                      | 否              |
| `annotationTitle`                                  | 注释标题      | —                                      | 否              |
| `tableTitle`                                       | 表格标题      | `table_title`                          | 否              |
| `imageTitle`                                       | 图片标题      | `image_title`                          | 否              |
| `formula`                                          | 公式        | —                                      | 否              |
| `footnoteText`                                     | 脚注文本      | —                                      | 否              |
| `emphasizedCharacter`                              | 着重号字符     | —                                      | 否              |
| `section` / `page`                                 | 节/页       | —                                      | **是**（1-based） |
| `table` / `selection`                              | 表格/当前选区   | —                                      | 否              |
| `header` / `footer`                                | 页眉/页脚     | filter.extra: `default`/`first`/`even` | 否              |


## 单位约定

**一条规则**：`rPr.sz` 用 **JSON number（磅）**；`spacing` / `ind` / `sectPr` 用 **带单位字符串**。所有 op 共用同一套格式。

| 字段 | 写法 | 示例 | 禁止 |
|------|------|------|------|
| `rPr.sz` | number，磅 | `12` `16` `10.5` | `"12"` `"24pt"` 半磅 |
| `spacing.before`/`after` | `"Npt"` 等 | `"12pt"` `"0.5cm"` | 裸数字 `12` |
| `spacing.line` | 自描述 string | `"1.5x"` `"24pt"` `"24pt+"` | `1.5` + `lineRule` |
| `ind.*` | `"Npt"` 或 `"Nch"` | `"24pt"` `"2ch"` | 裸数字 |
| `sectPr.pgSz`/`pgMar.*` | `"Npt"` 等 | `"595.3pt"` `"21cm"` | 裸数字（会静默忽略） |
| `tblPr.font.*_size` / `row_height.*.value` / `col_widths[]` | number，磅 | `10.5` `25` | `"10.5"` 字符串 |
| `tblPr.three_line_widths.*` / `borders.*.line_width` | 带单位字符串 | `"1.5pt"` `"0.75pt"` | 裸数字 |

**`spacing.line` 写法**（string 自描述，勿配 `lineRule`）：

| 写法 | 含义 |
|------|------|
| `"1.5x"` | 1.5 倍行距 |
| `"24pt"` | 固定行距 24 磅 |
| `"24pt+"` | 最小行距 24 磅（内容多时可更高） |

**长度单位**（用于 `spacing` / `ind` / `sectPr`；`N` = 数值）：

| 写法 | 含义 | 示例 |
|------|------|------|
| `"Npt"` | N 磅 | `"12pt"` 段前距 12 磅 |
| `"Ncm"` | N 厘米 | `"21cm"` A4 纸宽 |
| `"Nmm"` | N 毫米 | `"25.4mm"` |
| `"Nin"` | N 英寸 | `"8.5in"` |
| `"Nch"` | N 个汉字宽（**仅 `ind.*`**） | `"2ch"` 首行缩进 2 字 |

**常用值**：小四=12、四号=14、三号=16；首行缩进 2 字=`"2ch"` 或 `"24pt"`；正文行距=`"1.5x"`。中文字号名 → pt 查 `strict_rules/spec-unit-conversion.md`。

**禁止**（高频错）：

- `rPr.sz` 写 string（`"36"` 是遗留半磅，skill 层禁用）
- `spacing.line` 写 `1.5` + `lineRule:"multiple"` → 应写 `"1.5x"`
- `sectPr` 写纯数字 `595.3` → 应写 `"595.3pt"`
- 自行换算 twip/半磅

---

**排版变更摘要见** `references/beauty/op-list-summary.md`

**写回约束**：

1. 业务 op 只能写入 `oplist` 经 `oplist_exec` 执行，**必须**一次性发送完整 `oplist`，**禁止**拆分多次发送，**禁止**单独调用 op。
2. `oplist` 传入 `wps_toolcall_fmt` 的 `paramString` 时会把 JSON 转为字符串，须对特殊字符**转义**；调用前**必须**完成 §paramString 自检清单，全部通过才可写回。

### paramString 自检清单

**先输出、再压缩（禁止重写）**：

1. **Step 3+4**：输出完整 `{"oplist":[...]}`（形态见 §编排示例）。
2. **Step 5**：`paramString` **须与 Step 3+4 那份 JSON 内容完全一致**，仅去掉换行与空格压成一行；**禁止**跳过 Step 3+4、**禁止**重写或改写字段/op 条数。

```
Step 3+4 输出：
{
  "oplist": [
    { "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } },
    { "scope": {}, "action": { "type": "cleanup_empty_paragraphs" } }
  ]
}

Step 5 paramString（同一内容，仅去换行空格）：
{"oplist":[{"scope":{},"action":{"type":"trim_paragraph_leading_chars"}},{"scope":{},"action":{"type":"cleanup_empty_paragraphs"}}]}
```

| 组 | 检查项 |
| --- | --- |
| 结构 | op 条数与摘要一致；顺序符合所在路径规定的编排顺序；每条为 `{"scope":{...},"action":{...}}`；`import_element_styles` 在 `batch_apply_paragraph_style` 之前 |
| 括号 | `{`/`}`、`[`/`]` 数量分别相等；action 内容写完后用 `}}` 闭合 action 与 op |
| 转义 | 中文直接写 `"黑体"`，**禁止** `\uXXXX`；值内 `"` 写 `\"`；**最后一项后面不要逗号**（如 `[{...},{...}]` 正确，`[{...},{...},]` 错误） |
| 形态 | 以 `{"oplist":[` 开头、以 `]}` 结尾；仅为 JSON 字符串，不含 ``` 围栏 |

末条 `batch_apply_paragraph_style` 典型闭合：`...false}]}}}]}`（`]` rules → `}` format_rule → `}` action → `}` op → `]` oplist → `}` 根）。

```
BAD：..."clear_span_props":false}]}}]}     ← 少 }，解析失败
GOOD：..."clear_span_props":false}]}}}]}   ← 补 op 对象的 }
```

---

## 编排示例

### 示例 1：段首空格 + 一级标题加粗

```json
{
  "oplist": [
    { "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } },
    {
      "scope": { "start": { "type": "heading1" }, "filter": { "type": "heading1" } },
      "action": { "type": "batch_set_span_style", "format_rule": { "rPr": { "b": true } } }
    }
  ]
}
```

### 示例 2：样式导入 + 按识别标签挂接

先 `import_element_styles` 写入样式表，再 `batch_apply_paragraph_style` 按 formatList 标签映射挂接。`batch_apply_paragraph_style` 的 scope 常用 `{}`（全文∩tag），引擎将 scope 与 rules 内 tag 范围取交集。

```json
{
  "oplist": [
    { "scope": {}, "action": { "type": "cleanup_empty_paragraphs" } },
    { "scope": {}, "action": { "type": "trim_paragraph_leading_chars" } },
    {
      "scope": {},
      "action": {
        "type": "import_element_styles",
        "element_style_rules": [
          {
            "element": "title",
            "style_name": "美化文档标题",
            "pPr": { "spacing": { "line": "1.5x", "before": "0pt", "after": "12pt" }, "outlineLvl": 10, "keepNext": true, "jc": "center", "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 18, "b": true, "color": "#1F4E79", "rFonts": { "eastAsia": "黑体" } }
          },
          {
            "element": "heading 1",
            "style_name": "美化标题 1",
            "pPr": { "spacing": { "line": "1.5x", "before": "12pt", "after": "6pt" }, "outlineLvl": 1, "keepNext": true, "jc": "start", "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 15, "b": true, "color": "#1F4E79", "rFonts": { "eastAsia": "黑体" } }
          },
          {
            "element": "heading 2",
            "style_name": "美化标题 2",
            "pPr": { "spacing": { "line": "1.5x", "before": "10pt", "after": "4pt" }, "outlineLvl": 2, "keepNext": true, "ind": { "firstLine": "0pt" } },
            "rPr": { "sz": 14, "b": true, "rFonts": { "eastAsia": "黑体" } }
          },
          {
            "element": "Normal",
            "style_name": "美化正文",
            "pPr": { "spacing": { "line": "1.5x", "before": "0pt", "after": "0pt" }, "outlineLvl": 10, "jc": "both", "ind": { "firstLine": "2ch" } },
            "rPr": { "sz": 12, "rFonts": { "eastAsia": "宋体" } }
          }
        ]
      }
    },
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
    },
    {
      "scope": { "start": { "type": "heading1" }, "filter": { "type": "heading1" } },
      "action": { "type": "batch_set_span_style", "format_rule": { "rPr": { "b": true } } }
    },
    {
      "scope": {},
      "action": {
        "type": "batch_set_spacing",
        "format_rule": { "pPr": { "spacing": { "line": "1.5x", "before": "0pt", "after": "0pt" } } }
      }
    }
  ]
}
```

