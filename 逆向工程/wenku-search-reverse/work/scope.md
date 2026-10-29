# wenku-search-reverse 授权与边界（接线战役）

日期: 2026-10-24 | 战役: 百度文库搜索选品面纯 HTTP 全链接线

## 授权依据

- 用户 1024 全渠道 API 化令（本战役任务书明引）。
- 用户 1022 追加令「所有文档下载全部逆向破解复刻」+ KB-HARVEST 43/43 收官战果。
- 既有账号态面合法使用（`07 任务/自动建库Agent/_credentials/wenku.secret.ini` 存在，
  但本战役全部腿实证免登录可用 → 不动凭据文件，积分成本=0）。

## 目标

检索→选品→全文下载全链纯 HTTP 化（零浏览器零CDP），复刻件 `replica/wenku_full_api.py`。
验收 = 5 次独立会话「国际工程 EPC」类查询各拿到 ≥3 份真全文（md/txt，有正文非元数据）。

## 边界（红线）

1. **不破付费墙**：只取免登录免费层（ndview 初始 readerInfo 的 htmlUrls/rtcsRangeInfo
   预签直链 + 免费配额内页）；VIP 文档（sellType 命中）选品阶段即标注跳过下载；
   `ndocview/readerinfo` ACS 补页腿（越过 showPage 免费游标）只做无签探针定性，
   不做绕签——Acs-Token 生成属 wenku 前端 paris_2030（伤心文库 Electron 客户端也只是
   借页面自身函数，算法在 CDN bundle 内），完整破译另立战役。
2. **只读**：全部 GET/POST 查询类请求；不写不传不改站方数据；不删任何本地文件。
3. **节流**：检索腿间隔 ≥3s；资产腿间隔 ≥0.5s（对齐 harvest_engine WENKU_ASSET_MIN_INTERVAL）。
4. **账号态/密钥零入仓**：本战役全免登录，不读任何 secret 文件。
5. **数字零造假**：贯通率/字数/页数/请求账全实测落账，禁手填。
6. **无 push**：本地 commit 只加本目录 `逆向工程/wenku-search-reverse/`。

## 素材资产（接线员不重逆）

| 资产 | 位置 | 复用什么 |
|---|---|---|
| 12 端点档 | E:/AI-Station/kb_rev/api_notes.md | EP01-12 环境/鉴权判读 |
| 检索钥匙孔 | E:/AI-Station/kb_rev/web_search_capture/{capture.md,search_api.py} | syncmrecall sceneID=PCSearch 免登录配方（1021 实证） |
| 三下载器破译 | E:/AI-Station/逆向工程/文库下载器/extract/bingdian_v2/ | ACS=paris_2030 判读 + 原件 BOS 直链 |
| 收割引擎 | E:/AI-Station/kb_factory/harvest_engine/adapters/wenku.py | ndview 侧门/pageData/三型判定/type3 三腿/type1 getbdjson 桶式/wkretype |
| 签名器 | E:/AI-Station/kb_factory/harvest_engine/signer/page_signer.py | ndocview/readerinfo URL 模板（Acs-Token 头规约） |
| 信封判定 | E:/AI-Station/kb_factory/harvest_engine/envelope.py | tri_cap 陷阱/ code:0 陷阱判据 |
| 生产桥 | E:/AI-Station/kb_factory/harvest_engine/production_bridge.py | 线索行口径（本战役补真全文腿） |
| T38 实弹账 | E:/AI-Station/kb_factory/harvest_engine/e2e/artifacts/wenku_accept_ledger.jsonl | 1023 全链 200 实证基线 |

## 已知墙（预期管理）

- **view 页 403 指纹墙**（httpx/CDP 都撞）→ ndview 侧门绕（实证 200）。
- **BFE 反自动打分**：CDP 浏览器 403+验证码，裸 urllib+桌面 UA 放行（1021 实证）→ 全链用 stdlib urllib。
- **ACS 补页墙**：匿名越 showPage 补页需 Acs-Token（paris_2030，web 前端函数）→ 本战役
  不破，如实留墙；免费覆盖足额（showPage≥page）的选品策略绕开该墙。
- **type2 图片文档**：纯图片页无文字层 → md/txt 验收口径下如实跳过（OCR 归 harvest_engine T31 管线）。
