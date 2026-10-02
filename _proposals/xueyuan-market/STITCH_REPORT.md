# STITCH_REPORT — T-P0-17 前端×引擎缝合验收

> 2026-09-28。验收对象：C 线前端 `WeAppForge/projects/zongbao/`（mock 模式开发）× B 线引擎 `services/xueyuan-engine/`（已验收侧，pytest 56/56）。契约基线 `API_DESIGN.md`。
> 方法：①静态契约形状对拍（mock-fixtures.ts vs 引擎源码+测试断言，引擎为真源）→ ②活体缝合冒烟（8872 影子位真实 HTTP 全序列）→ ③活体页面走查（Page 桩+真实 HTTP 层）。

## 结论：**带条件 PASS**

缝合质量整体达标：形状对拍 10 处微差已全部对齐（19/19 前端出厂门零回归）；活体 29 步 HTTP 序列 + 27 断言页面走查，防泄漏判据、503 降级契约、支付全链（签名→幂等回调→解锁→全量正文）、收藏真源、搜索三态、鉴权负例全部实证通过。

**唯一缝合断链（条件项 A1）**：`POST /reports/{id}/chapters/{chapter_id}`（API_DESIGN **P0-6，防泄漏主闸+限流主落点**）引擎侧未实装，前端 reader.ts 已购付费章加载独走此端点 → 已购用户真实引擎上读不了付费章。需主会话裁决修法（见 §三）。

---

## 一、契约形状对拍（静态）

### 1.1 已改：mock-fixtures.ts 对齐引擎（10 项，均为形状微调不改语义）

| # | 端点 | 差异 | 改动 |
|---|---|---|---|
| 1 | 全部鉴权端点 | 401 code：mock `AUTH_REQUIRED` vs 引擎 `UNAUTHORIZED` | 改 `UNAUTHORIZED`（5 处），message 对齐「未登录或凭证过期」 |
| 2 | 404 | message：mock「研报不存在」vs 引擎「报告不存在或已下架」 | 对齐（4 处；message 仅展示，code 才是机器判据） |
| 3 | GET /chapters 试读章 | 引擎带 `pages`（=ceil(char_count/340)），mock 缺 | 补 `pages`（同口径 340 字/页估算） |
| 4 | GET /chapters 未购付费章 | 引擎元数据带 `html_len`+`pages`（html 仍缺席），mock 只有 4 基础字段 | 补 `html_len`+`pages`；**html 字段缺席判据原样保留** |
| 5 | GET /me entitlements | 引擎元素含 `order_id`（契约外向后兼容追加），mock 缺 | 补 `order_id`（回填 mock 订单号） |
| 6 | GET /reports/{id} | mock 多 `cover` 字段（引擎 report_detail 无；catalog 条目才有） | detail 响应剔除 cover |
| 7 | 同上 related[].why | mock「同省（江苏）」vs 引擎纯标签「同省」 | 对齐纯标签 |
| 8 | GET /catalog tab=praise | 引擎空 items+praise_visible:false，mock 走 hot 排序返回非空 | 补 praise 空态分支 |
| 9 | GET /search 空 q | 引擎 400 INVALID_PARAM，mock 200 空态 | 对齐 400（前端空态本就走榜单不进检索） |
| 10 | GET /search 命中 | 引擎响应有 `layer` 子字段（"title"/"chapter_title"，none→null），mock 缺 | 补 `layer` 子字段 |

改动后回归：`xy-frontend.test.mjs` 15/15 + `xy-pages-smoke.test.mjs` 4/4 全绿（.ts 改毕经 WeAppForge tsc 同 flags 重编 .js，编译零错误）。

### 1.2 留待主会话裁决（契约语义级，未改）

| # | 项 | 详情 |
|---|---|---|
| **A1** | **POST /reports/{id}/chapters/{cid} 引擎未实装** | API_DESIGN P0-6 定义（防泄漏主闸、限流主落点、响应 `{chapter_id,html,is_trial}`）；mock 已实现同构端点；前端 `pages/reader/reader.ts` L137 已购付费章加载**独走此端点**。引擎全路由 grep 无此 POST，活体实证 `404 {"detail":"Not Found"}`。**已购→读付费章链路在真实引擎上断**（前端 toast「章节加载失败」）。附带：限流主落点当前实际在 GET with_content=all（chapters.py L77），与 P0-6 落点描述错位。修法二选一：①B 线按 P0-6 补端点（Bearer+权益+429，mock 实装可参照）；②C 线 reader.ts 已购改走 GET /chapters?with_content=all（已购回全量 html）。建议①（保主闸单点语义）。 |
| A2 | /search layer_used 取值阶段差 | 引擎切片①恒 `like`（+layer 子层）；mock 用契约终态 L1/L2/L3。两者均在契约枚举 {L1,L2,L3,like,none} 内，前端 layerHintText 三态均有文案不炸——不构成缝合 bug。FTS5 切片②（T-P0-19）上线后引擎自然出现 L1-L3。mock 保留终态形状不改。 |

### 1.3 记录级（双方均在契约内 / mock 造数自由度，不改）

- mock /pay/status 查单即置 paid=模拟微信回调已达；引擎纯查单，paid 靠 /pay/callback。响应形状一致（4 字段同构）。
- mock 恒 pay_configured:true、/pay/sign 恒 200（模拟已开通）；真实现状 secret 未回填→503 降级（活体两轮分别实证，互为镜像）。
- rank_badge：引擎冷启动 null（无阅读数据）；前端 shapeDetail `|| ''` 已容。readers_also：引擎无共读数据 []；前端 `|| []` 已容。
- me.nickname：引擎默认 ''；mock「试读者」。decision_card 页数：mock 常数估算；引擎 char_count/340 真算——字段同构。
- 引擎未注册路由 404 体为 `{"detail":"Not Found"}`（Starlette 默认），不走统一 {code,message} 错误体——引擎侧小瑕疵，记录不修。
- **A 线数据态观察（报备非缝合项）**：包内 catalog.json 试点 `trialChapterCount=17`（19 章中 17 章试读、仅 2 章付费，剩余 1762 页几乎全免费）——引擎按数据正确裁剪，但与产品口径「试读 2 章/全文还有 17 章」反差大，商业闭环上试点近乎免费。属 A 线数据治理。

## 二、活体缝合冒烟（8872 真实 HTTP）

引擎：`XY_DEV_LOGIN=1 XY_FAKE_PAY=1` uvicorn 127.0.0.1:8872（8870 全程未碰）。脚本：`stitch_live_probe.mjs`（可复跑）。

### 第一轮：secret 未回填（真实现状）— 11/11 PASS

| 步 | 结果 | 关键证据 |
|---|---|---|
| 1 POST /auth/login | 200 | uid=u…、expires_in=2592000、**pay_configured=false（login 预判灰置信号正确）** |
| 2 GET /catalog?tab=hot | 200 | **total=38**（包内全量进库）、试点在列、条目 12 字段齐 |
| 3 GET /catalog?tab=praise | 200 | 空态+praise_visible=false |
| 4 GET /reports/{试点} 游客 | 200 | 20 必需字段零缺失、**cover 不在场（与 mock 对齐后一致）**、decision_card 五件齐、rank_badge="阅读榜 #1" |
| 5 GET /chapters?with_content=trial | 200 | 试读 17 章带 html+pages；**付费 2 章 html 缺席+html_len/pages 元数据在（防泄漏判据成立）** |
| 6 GET /chapters?with_content=all 未购 | 200 | **付费章仍裁剪（服务端权益判定，客户端不得自证）** |
| 7 POST /pay/sign | **503** | `{"code":"PAY_NOT_CONFIGURED","message":"虚拟支付尚未开通","degrade":"pay_gray"}` 精确降级体 |
| 12a /search?q=水网 | 200 | layer_used=like、layer="title"、hot_words=8、含 layer 子字段 |
| 12b /search 零命中 | 200 | layer_used=none、fallback_hint=true |
| 12c /search 空 q | **400** | INVALID_PARAM |
| 13 401 负例 | 401/401 | 伪 Bearer code=UNAUTHORIZED（与 mock 对齐后同码） |

### 第二轮：临时 dev secret（--with-secret，同引擎测试 pay_on fixture 假值，跑毕即删）— 17 PASS + 1 GAP

| 步 | 结果 | 关键证据 |
|---|---|---|
| 8a POST /pay/sign | 200 | sign_data 七件齐（offerId/productId/CNY/buyQuantity/goodsPrice/mode/outTradeNo）、pay_sig/signature 均 64hex、out_trade_no={reportId}_{ts} |
| 8b GET /pay/status | 200 | status=pending、entitlement_granted=false |
| 8c POST /pay/callback ×2 | 200/200 | 首回调 first=true、**重放 first=false（幂等不重发放）** |
| 8d GET /pay/status | 200 | status=paid、entitlement_granted=true |
| 8e GET /chapters?with_content=all 已购 | 200 | **付费 2 章全量 html 下发、html_len 残留=0** |
| 9 POST /chapters/{cid} | **404 GAP** | `{"detail":"Not Found"}`——P0-6 端点未实装（见裁决项 A1） |
| 10 GET /me | 200 | entitlements 含试点、source=purchase、**order_id 在场**、6 字段齐 |
| 11 favorite POST×2/DELETE | 200 | 重复幂等、/me 收藏即时出现（服务端真源） |

secret 清除后复核：`pay_configured` 即时回落 false（load_pay_config 每调用重读文件，NFR-10 顺带实证）。收尾：uvicorn 确杀，**netstat 8872 listeners=0**；8870 在役原样（PID 26676 未动）。

### 活体页面走查（xy-pages-smoke 活体变体）— 27/27 PASS

原 smoke 的 wx.request 桩为内联 throw（不支持外部注入），故做变体脚本 `stitch_live_pages.mjs`：wx.request 桩替换为真实 fetch→8872、`appConfig.mockApi=false`、断言按引擎真实数据适配（口径同源：渲染数据态而非 mock 精确值）。四页全过：

- 首页：包内 38 份秒开→引擎刷新、分转元 498、筛选聚合（新疆/江苏/河南/浙江/湖北）、搜索命中（LIKE title）、零命中降级+热词 8、省份筛选子集、详情导航。
- 详情：决策卡真实页数（「已读 182 页 / 全文还有 2 章 · 1762 页」）、锚价 1888、阅读榜徽章、付费章提示不触网、支付前披露弹层、未开通灰置文案（virtualPay=false，与真实现状同 503 态）、收藏真源。
- 阅读器：19 章、试读章 43 块渲染、付费章（idx17）锁定占位不拉正文、回试读章、决策卡就绪。
- 我的：非离线态、收藏即时出现（js-shuiwang-2026）、赠阅位 P1 隐藏。

## 三、PASS 条件清单

1. **【必须】裁决 A1**：P0-6 `POST /reports/{id}/chapters/{cid}` 二选一——引擎补端点（建议：保防泄漏主闸单点+限流落点归位）或前端已购改走 GET with_content=all。修毕重跑 `stitch_live_probe.mjs --with-secret` 步 9 转绿即闭条件。
2. 【建议】A2 记录在案：联调/真机期 /search 恒回 `like` 属切片①预期，勿误诊；FTS5 切片②后自然出现 L1-L3。
3. 【建议】A 线数据治理：试点 trialChapterCount=17 与「试读 2 章」产品口径对齐（现试点近乎全免费）。

## 附：工件与复跑

- 探针（可复跑，需引擎在 8872）：`E:\AI-Station\_proposals\xueyuan-market\stitch_live_probe.mjs`（`node stitch_live_probe.mjs [--with-secret]`）、`stitch_live_pages.mjs`（页面走查活体）。
- 前端改动：`WeAppForge/projects/zongbao/utils/mock-fixtures.ts`（10 项形状对齐）+ 重编 `mock-fixtures.js`；页面代码零改动；引擎源码零改动；未 commit。
- 临时 secret `data/secrets/virtual_pay_xueyuan.secret` 已删（写入仅存在于第二轮运行窗口内，值为 fixture 级假值）。
