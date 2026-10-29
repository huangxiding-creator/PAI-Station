## 变更摘要

**状态**：`applied`　**模式**：strict　**规则来源**：preset:试卷标准卷 文科（A3）


**发现的问题（改前实测）**：
- 段落数(非空/空)：21/6
- 字号档位分布：{'12pt': 9, '15pt': 6, '14pt': 3, '13pt': 2, '22pt': 1}
- 段首空格缩进段数：6
- 中文字体分布：{'宋体': 14, '黑体': 4, '楷体': 2, '仿宋': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 4, 'main_text': 10, 'catalog_h2': 2, 'catalog_h3': 2, 'signature': 2}

**已执行的变更**：
- batch_set_paragraph_props: 直出 19 段
- setup_page_setup: 纸张/边距已写入全部节
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 1 张

**改后实测**：
- 段落数(非空/空)：23/6
- 字号档位分布：{'10.5pt': 14, '18pt': 5, '12pt': 2, '16pt': 1}
- 段首空格缩进段数：6
- 中文字体分布：{'宋体': 12, '黑体': 8, '楷体': 2, '(默认)': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 4, 'main_text': 10, 'catalog_h2': 2, 'catalog_h3': 2, 'signature': 2}