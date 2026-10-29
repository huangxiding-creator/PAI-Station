# book118-reverse 授权与边界（接线战役）

日期: 2026-10-24 | 战役: book118（原创力文档 max.book118.com）检索面纯 HTTP 全链接线

## 授权依据

- 用户 1024 全渠道 API 化令（本战役任务书明引）。
- 既有战果复用：kb_factory harvest_engine T19/T23/T37 已收官预览链
  （openapi getPreview 免登录 + .shtm 内联 var base 配置挖掘），
  本战役只补「检索面 login_gated:empty → 纯 HTTP 题录」一役。

## 目标

检索→题录清单 纯 HTTP 化（零浏览器零CDP），复刻件 `replica/book118_api.py`；
配套免费预览文字提取腿（≥500 字/份，可提取口径）。验收 = 5 次独立会话
「国际工程 EPC」类查询拿到题录清单；若真端点级登录墙，产出 login_gated
根因报告（端点级实证）也算收官。

## 边界（红线）

1. **不破付费墙**：只取免登录免费层（预览页清单/免费预览页图/公开元数据）；
   收费文档（preview<actual）选品阶段即标注 perm=yellow 跳过下载；
   不做任何绕付费/绕VIP操作。
2. **只读**：全部 GET/查询类请求；不写不传不改站方数据；不删任何本地文件。
3. **节流**：检索腿间隔 ≥3s；资产腿间隔 ≥0.5s（对齐 harvest_engine 口径）。
4. **账号态/密钥零入仓**：本战役全免登录，不读任何 secret 文件；
   浏览器仅侦察（--start-minimized）用完即清。
5. **数字零造假**：贯通率/字数/请求账全实测落账，禁手填。
6. **无 push**：本地 commit 只加本目录 `逆向工程/book118-reverse/`。

## 素材资产（接线员不重逆）

| 资产 | 位置 | 复用什么 |
|---|---|---|
| T19 适配器 | kb_factory/harvest_engine/adapters/book118.py | .shtm var base 挖掘锚/ openapi 新方言参数/ jsonpReturn 批口径 |
| T37 验收件 | kb_factory/harvest_engine/e2e/book118_accept.py | shtm memo 332 份样本/ doclist 分类页口径 |
| shtm memo | kb_factory/harvest_engine/e2e/artifacts/book118/book118_shtm_memo.json | .shtm 真实页面结构（零网络离线分析） |
| wenku 战役 | 逆向工程/wenku-search-reverse/ | 结构纪律/ stdlib urllib 直连打法/ 信封判读 |
| chinca 战役 | 逆向工程/chinca-reverse/ | WAF 挑战 JS Node vm 原样执行法（SafeLine 若需） |
| 产线桥 | kb_factory/harvest_engine/production_bridge.py | 对接口：Book118Adapter.search 腿替换 |

## 已知墙（预期管理）

- **SafeLine(雷池) JS 挑战**：max.book118.com httpx 直打 468 挑战页（T19 实测）；
  Playwright 渲染 1-3s 自跳。→ 本战役先验挑战可否纯 HTTP 过（chinca 先例），
  或找免挑战面（static/openapi/m 子域）。
- **匿名搜索登录墙（表象）**：search.html?q= 渲染页 0 条 .shtm 结果 +
  login 弹窗（T19 实测 2026-10-22）→ 本战役任务书主假设：渲染面表象 ≠
  端点级墙，底层 tdsearch XHR/替代检索面（m 站/doclist/sitemap）待端点级实证。
- **NewView 指纹墙**：对 curl/httpx/Playwright 全 200+空 body → 遗产链不动。
- **预览层=图片**：openapi 页清单是 view-cache 图（gif/png），文字层走 OCR
  （harvest_engine T13/T33 管线在役）；≥500 字验收腿只对「有文字可提取」件计。
