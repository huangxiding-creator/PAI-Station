## 变更摘要

**状态**：`applied`　**模式**：strict　**规则来源**：preset:公文（WPS 内部模板真身 · GB/T 9704-2012）


**发现的问题（改前实测）**：
- 段落数(非空/空)：1607/2
- 字号档位分布：{'11pt': 1147, '12pt': 259, '10pt': 93, '14pt': 93, '16pt': 14, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'微软雅黑': 1607}
- 识别标签：{'doc_title': 1, 'catalog_h1': 21, 'catalog_h3': 260, 'catalog_h2': 117, 'main_text': 1207}

**已执行的变更**：
- batch_set_paragraph_props: 直出 1606 段
- setup_page_setup: 纸张/边距已写入全部节
- setup_header_footer: 页脚页码已设置
- insert_table_of_contents: 已插入 TOC 域（3 级）
- setup_table_style: 三线表 51 张

**改后实测**：
- 段落数(非空/空)：1609/2
- 字号档位分布：{'16pt': 1606, '11pt': 2, '22pt': 1}
- 段首空格缩进段数：0
- 中文字体分布：{'仿宋_GB2312': 1467, '楷体_GB2312': 117, '黑体': 22, '方正小标宋简体': 1, '微软雅黑': 1}
- 识别标签：{'doc_title': 1, 'catalog_h1': 21, 'catalog_h3': 260, 'catalog_h2': 117, 'main_text': 1207}