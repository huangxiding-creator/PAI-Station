## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：1919/2
- 字号档位分布：{'11pt': 1539, '12pt': 253, '14pt': 113, '16pt': 13, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 1919}
- 识别标签：{'doc_title': 1, 'catalog_h1': 13, 'catalog_h2': 113, 'main_text': 1538, 'catalog_h3': 253}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 71 张

**改后实测**：
- 段落数(非空/空)：1921/2
- 字号档位分布：{'11pt': 1540, '12pt': 253, '14pt': 113, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 1919, '黑体': 1, '宋体': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 13, 'catalog_h2': 113, 'main_text': 1538, 'catalog_h3': 253}