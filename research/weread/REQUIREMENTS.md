# Phase 4 · 需求规格说明书（用户已批准关键决策）

> 批准记录 2026-09-10：主路线=**API 签名直调**；节奏=**标准**（章节间隔 1.5~3.5s 随机、单书冷却 ≥2min、日限额默认 3 本）。

## 功能需求

### F1 扫码登录引导（scripts/weread_login.py）
- DrissionPage 可见窗口打开 https://weread.qq.com/，等待用户微信扫码
- 轮询 `/web/user` 直到返回登录态（超时默认 300s）
- 成功后提取 cookie（wr_skey/wr_vid/wr_rt 等）→ `data/weread/_auth/weread_auth.json`（含获取时间戳）
- 登录态同时持久化于 `data/browser_profile/`（复用现有 profile，端口 9333）

### F2 登录态校验与自动续期
- 任何脚本启动时先校验 auth.json：无效/缺失 → 明确提示运行 weread_login.py
- 续期：GET 首页收 `Set-Cookie` 更新 wr_skey（对齐 zhaohongxuan 方案）
- `-2012` 统一识别为登录失效，熔断并提示重登

### F3 关键词搜索（forge/weread.py: search）
- `GET /web/book/search` 分页（maxIdx 游标）
- 返回：bookId/标题/作者/简介/封面/是否可读，写 `data/weread/_recon/search_<kw>.json`

### F4 书籍详情与章节目录
- `GET /web/book/info` → 元数据 + `format`/`maxFreeChapter`/`paid`（权限预检）
- `POST /web/book/chapterInfos` → 章节树（chapterUid/标题/层级）

### F5 整书正文提取（签名直调）
- 签名模块（forge/weread_sign.py）：calcHash/sign/BKDR/appId 移植，与 touchFish TS 同输入同输出
- 解混淆（forge/weread.py）：chk 剥离 → 交换表还原 → base64 解码 → HTML
- epub/pdf：e_0+e_1+e_3 拼 HTML；txt：t_0+t_1
- 结构化 Book 对象：{元数据, 章节树, 每章 HTML/纯文本/图片}

### F6 Markdown 导出（专业排版）
- YAML 头（书名/作者/封面/bookId/提取时间/来源）
- 目录（锚点链接）+ 章节层级标题
- HTML→MD 专用转换器：标题/段落/加粗斜体/图片（下载本地化 `images/`）/脚注/引用/表格降级保真
- 产物：`data/weread/{书名}/{书名}.md`

### F7 Word 导出（专业排版，超越 hundun_to_docx 三级映射）
- 封面页（书名/作者/元数据）→ 目录页 → 正文
- 章标题 Heading 1、节 Heading 2/3；正文中文（宋体正文/雅黑标题）字号规范
- 图片嵌入、引用块样式、页码页脚
- 产物：`data/weread/{书名}/{书名}.docx`

### F8 批量断点续采（scripts/weread_batch.py）
- `--keyword "X" [--limit N] [--book-id ...]`：搜索→按序提取整书
- 幂等：`book.json` 已存在且完整即跳过；单书失败记录 `_recon/failed.json` 不挡批
- 产物双格式 + book.json 原料（对齐 hundun 约定 + 提案 19.11 原料湖 schema）

### F9 账号安全护栏（熔断器，最高优先级）
- 章节请求间隔 1.5~3.5s 均匀随机；单书完成后冷却 ≥120s
- 日限额默认 3 本（`config/weread.secret.ini` 可配 `[safety] daily_book_limit`）
- 熔断条件：连续 3 次请求异常 / 出现验证码页面特征 / 未知 errCode → 立即终止并写 `_recon/circuit_break.json`
- 永不调用：`/web/book/read`（写操作）与安卓 chapterdownload

### F10 官方 Skill API 元数据层（P2 可选，本次不实现）
- 预留接口注释；正文永远走 web API

## 非功能需求

| # | 需求 |
|---|------|
| N1 | 零新增 pip 依赖（stdlib + DrissionPage + python-docx） |
| N2 | 核心模块单测覆盖 ≥80%：签名/解混淆/HTML→MD/MD→DOCX（金标准向量对拍） |
| N3 | ruff line-length=100 通过；中文 docstring；模块首行注明安全红线 |
| N4 | 内容只写 `data/weread/`；凭据只在 secret.ini 与 auth.json（gitignored） |
| N5 | 原子写（tmp+os.replace）；单书失败不挡批 |
| N6 | 直连不走系统代理（对齐 hundun/metaso 铁律） |

## 验收标准（金标准，C12）

| # | 标准 |
|---|------|
| A1 | 真机扫码登录一次成功，auth.json 生成，二次运行免扫码 |
| A2 | 搜索关键词返回书单 JSON（真实数据） |
| A3 | 完整提取一本可读全书：MD+DOCX+book.json，章节数与官方目录一致 |
| A4 | DOCX 在 Word 打开：封面/目录/标题层级/中文字体/图片正常 |
| A5 | 签名单测：与 touchFish TS 版同输入同输出（向量对拍 ≥3 组） |
| A6 | 解混淆单测：构造样本→还原原文 roundtrip |
| A7 | 断点续采：中断重跑正确跳过已完成书 |
| A8 | 熔断：模拟连续异常→停止+记录 |
