# Phase 6 · WBS（Tracer-Beat 垂直切片）

## EPIC → Story → Task

### E1 协议核心（纯函数，TDD 金本位）
- S1.1 weread_sign.py：calc_hash / bkdr_hash / build_app_id / sign
  - T1.1.1 单测向量对拍（构造已知输入输出；TS 版逻辑人工对拍 ≥3 组）
- S1.2 deobfuscate 解混淆：chk 剥离 → 尾部交换表 → 倒序成对交换 → b64 解码
  - T1.2.1 roundtrip 单测（构造混淆样本）
- S1.3 HTML→MD 转换器 weread_html.py
  - T1.3.1 金标准样本单测（标题/段落/加粗/图片/脚注/未识别降级）

### E2 客户端与导出（src 层）
- S2.1 WeReadClient：auth 载入/校验/续期 + search/book_info/chapter_infos（FakeOpener 单测）
- S2.2 chapter_html：签名组装 + 请求 + 解混淆 + e_0/e_1/e_3 拼接 + txt 分支（Fake 单测）
- S2.3 extract_book：章节树遍历 + 权限预检（maxFreeChapter 截断标记 partial）+ 图片收集
- S2.4 to_markdown：YAML 头 + 目录 + 章节渲染
- S2.5 to_docx：封面/目录/Heading 层级/中文字体/图片/页码

### E3 脚本管线（scripts 层）
- S3.1 weread_login.py：扫码引导 + cookie 提取 + auth.json 写入
- S3.2 weread_search.py：关键词→书单（写 _recon）
- S3.3 weread_batch.py：--keyword/--limit/--book-id 断点续采 + 冷却 + 日限额 + 熔断
- S3.4 weread_to_docx.py：对未转换的 book.json 补生成 DOCX（幂等）

### E4 真机验证（Phase 11）
- S4.1 用户扫码 → auth.json
- S4.2 真实搜索 + 提取一本完整书 → 三产物验收（A1-A4）
- S4.3 勘误表回写 KNOWLEDGE_BASE.md

## 依赖边（关键路径）

S1.1+S1.2 → S2.2 → S2.3 → S2.4/S2.5 → S3.3 → E4
S1.3 → S2.4；S2.1 → S3.1/S3.2；S1.x 可并行开发

## 风险缓冲

- 签名对拍失败（TS 移植 bug）→ 预留 0.5 天调试；必要时用浏览器页面实测请求样本反推校验
- 正文响应结构与知识库不符 → 勘误表流程，脚本 dump 原始样本到 _recon 再分析
