## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：4499/31
- 字号档位分布：{'11pt': 4182, '12pt': 160, '10pt': 71, '14pt': 71, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 4128, '宋体': 371}
- 识别标签：{'doc_title': 1, 'main_text': 3374, 'catalog_h1': 28, 'catalog_h3': 204, 'catalog_h4': 800, 'appendix_title': 14, 'catalog_h2': 78}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 29 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 35 张

**改后实测**：
- 段落数(非空/空)：4501/2
- 字号档位分布：{'11pt': 4183, '12pt': 160, '10pt': 71, '14pt': 71, '16pt': 15, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 4128, '宋体': 372, '黑体': 1}
- 识别标签：{'doc_title': 1, 'main_text': 3375, 'catalog_h1': 28, 'catalog_h3': 204, 'catalog_h4': 800, 'appendix_title': 14, 'catalog_h2': 78}