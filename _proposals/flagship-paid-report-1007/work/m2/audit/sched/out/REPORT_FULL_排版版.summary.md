## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：3462/2
- 字号档位分布：{'11pt': 2846, '12pt': 335, '10pt': 133, '14pt': 133, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 3280, '宋体': 182}
- 识别标签：{'doc_title': 1, 'catalog_h1': 26, 'catalog_h4': 358, 'catalog_h3': 365, 'main_text': 2549, 'catalog_h2': 162}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 83 张

**改后实测**：
- 段落数(非空/空)：3464/2
- 字号档位分布：{'11pt': 2847, '12pt': 335, '10pt': 133, '14pt': 133, '16pt': 15, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 3280, '宋体': 183, '黑体': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 26, 'catalog_h4': 358, 'catalog_h3': 365, 'main_text': 2549, 'catalog_h2': 162}