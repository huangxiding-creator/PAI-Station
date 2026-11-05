## 变更摘要

**状态**：`applied`　**模式**：incremental　**规则来源**：document-baseline

**发现的问题**：文档整体规整


**发现的问题（改前实测）**：
- 段落数(非空/空)：3662/2
- 字号档位分布：{'11pt': 3201, '12pt': 229, '10pt': 109, '14pt': 109, '16pt': 13, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 3464, '宋体': 198}
- 识别标签：{'doc_title': 1, 'catalog_h1': 27, 'catalog_h4': 472, 'main_text': 2782, 'catalog_h2': 132, 'catalog_h3': 247}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 39 张

**改后实测**：
- 段落数(非空/空)：3664/2
- 字号档位分布：{'11pt': 3202, '12pt': 229, '10pt': 109, '14pt': 109, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 3464, '宋体': 199, '黑体': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 27, 'catalog_h4': 472, 'main_text': 2782, 'catalog_h2': 132, 'catalog_h3': 247}