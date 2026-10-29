## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：1914/2
- 字号档位分布：{'11pt': 1383, '12pt': 343, '10pt': 87, '14pt': 87, '16pt': 13, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 1914}
- 识别标签：{'doc_title': 1, 'catalog_h1': 24, 'main_text': 1285, 'catalog_h2': 155, 'catalog_h3': 447}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- batch_page_break_before: 段前分页 24 处
- setup_table_style: 三线表 97 张

**改后实测**：
- 段落数(非空/空)：1916/2
- 字号档位分布：{'11pt': 1384, '12pt': 343, '10pt': 87, '14pt': 87, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 1914, '黑体': 1, '宋体': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 24, 'main_text': 1285, 'catalog_h2': 155, 'catalog_h3': 447}