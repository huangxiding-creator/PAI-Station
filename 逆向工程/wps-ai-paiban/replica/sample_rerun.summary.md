## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：23/0
- 字号档位分布：{'12pt': 14, '14pt': 4, '13pt': 2, '18pt': 1, '16pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'宋体': 17, '黑体': 5, '(默认)': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 4, 'main_text': 10, 'catalog_h2': 2, 'catalog_h3': 2, 'signature': 2}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 1 张

**改后实测**：
- 段落数(非空/空)：25/0
- 字号档位分布：{'12pt': 14, '14pt': 4, '16pt': 2, '13pt': 2, '18pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'宋体': 17, '黑体': 6, '(默认)': 2}
- 识别标签：{'doc_title': 1, 'catalog_h1': 4, 'main_text': 10, 'catalog_h2': 2, 'catalog_h3': 2, 'signature': 2}