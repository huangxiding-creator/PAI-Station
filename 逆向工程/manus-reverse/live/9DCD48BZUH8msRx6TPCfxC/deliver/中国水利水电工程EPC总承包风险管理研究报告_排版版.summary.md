## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：594/1
- 字号档位分布：{'10.5pt': 459, '16pt': 118, '24pt': 15, '14pt': 1, '11pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'宋体': 459, '黑体': 132, '(默认)': 3}
- 识别标签：{'doc_title': 1, 'catalog_h1': 130, 'main_text': 458}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- batch_page_break_before: 段前分页 130 处
- setup_table_style: 三线表 55 张

**改后实测**：
- 段落数(非空/空)：596/1
- 字号档位分布：{'10.5pt': 460, '16pt': 119, '24pt': 15, '14pt': 1, '11pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'宋体': 460, '黑体': 133, '(默认)': 3}
- 识别标签：{'doc_title': 1, 'catalog_h1': 130, 'main_text': 458}