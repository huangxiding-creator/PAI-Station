## 变更摘要

**状态**：`applied`　**模式**：full　**规则来源**：beauty-default+type-scales

**主体风格**：通用黑色（official-black）+ 通用字号（official-document）

**一级标题对齐**：检测到条款式标题「一、准入预审机制」→ 全文 h1 统一左对齐


**发现的问题（改前实测）**：
- 段落数(非空/空)：4152/2
- 字号档位分布：{'11pt': 3728, '12pt': 226, '10pt': 92, '14pt': 92, '16pt': 13, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 3954, '宋体': 198}
- 识别标签：{'doc_title': 1, 'main_text': 3212, 'catalog_h5': 314, 'catalog_h2': 115, 'catalog_h3': 263, 'catalog_h1': 27, 'catalog_h4': 219}

**已执行的变更**：
- trim_paragraph_leading_chars: 清段首空白 0 处
- cleanup_empty_paragraphs: 删除空段 0 处
- import_element_styles: 写入样式 6 条
- batch_apply_paragraph_style: 挂接 3837 段 {'main_text': 3212, 'doc_title': 1, 'catalog_h1': 27, 'catalog_h2': 115, 'catalog_h3': 263, 'catalog_h4': 219}
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- batch_page_break_before: 段前分页 27 处
- setup_table_style: 三线表 24 张

**改后实测**：
- 段落数(非空/空)：4154/2
- 字号档位分布：{'12pt': 3694, '11pt': 316, '13pt': 115, '14pt': 27, '18pt': 1, '16pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'宋体': 3811, '微软雅黑': 315, '黑体': 28}
- 识别标签：{'doc_title': 1, 'main_text': 3284, 'catalog_h5': 314, 'catalog_h2': 51, 'catalog_h3': 341, 'catalog_h1': 25, 'catalog_h4': 135}