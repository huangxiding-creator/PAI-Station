# agent6

# 总包学园（wxfdb55b184756e89e）小程序代码现状盘点

**项目根**：`E:/AI-Station/WeAppForge/projects/zongbao/`（project.config.json 确认 appid=wxfdb55b184756e89e，projectname=zongbao-xueyuan）。**发布快照**：`E:/AI-Station/WeAppForge/work/zongbao_trial/`（体验版实际形态）。**配套引擎**：`E:/AI-Station/services/xueyuan-engine/`（部署 ECS 47.120.43.20:8871，见 `E:/AI-Station/WeAppForge/work/ecs_deploy_xueyuan.py` 第 6/37 行）。

---

## 1. 页面地图（app.json 注册 9 页 + tabBar 2 页）

| 页面 | 职责（一句话） | 证据 |
|---|---|---|
| pages/index/index（书架，tabBar） | 商城首页：300ms 防抖搜索 / 阅读榜·今日上新双 tab / 省份·业主类型·行业三筛选 chips / 报告卡列表，包内 catalog 秒开+接口增量刷新双源，下拉刷新+上拉分页 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/index/index.ts` 首行注释+onLoad |
| pages/reader/reader | 分章阅读器：章节侧栏、试读章渲染、付费章锁定占位/按权益在线拉取、试读末章决策卡、scene 容错解析（r=短ID&i=邀请人）、≥30 秒停留静默上报、AI 伴读「问一问」半屏面板 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/reader/reader.ts` 首行注释+onLoad/reportDwell |
| pages/me/me（我的，tabBar） | 已购/收藏/赠品三 tab + 书券卡（攒 498 券兑 1 份）+ 情报官卡（L1/L2/L3 带新梯队）+ 退款记录 + 已购检索/订阅/周榜/协议四入口；服务端态为真源、离线走本地镜像兜底 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/me/me.ts` 首行注释 |
| pages/detail/detail | 研报详情页：元数据+预览三件套+决策卡+价格锚、发票信息收集（本地备注级）、披露三件、收藏/解锁、P1 三入口（点赞赠阅/3 人组队 ¥998/批评评分退款）+P2 转赠 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/detail/detail.ts` 首行注释 |
| pages/agreement/agreement | 用户协议与规则页：八节全文（真源 utils/agreement.ts）+ 支付前披露三要点卡 + anchor 锚点滚动（pay/like/transfer/team/voucher/invite） | `E:/AI-Station/WeAppForge/projects/zongbao/pages/agreement/agreement.ts` |
| pages/cards/detail | 商机情报卡落地页（情报裂变 2.0）：card_id 直达或扫码 scene→cardResolve→详情，loading/ready/invalid 三态，卡→报告 CTA，可分享 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/cards/detail.ts` |
| pages/search/owned | P2 已购库章级检索：关键词→(report/chapter/snippet) 列表，游标分页（next_cursor 空串止），结果点按跳 reader 对应章 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/search/owned.ts` |
| pages/subscribe/index | P2 订阅位：31 省固定常量+catalog 聚合主题两组标签多选，POST 全量保存/DELETE 单项；引擎未配置（501）→整页隐藏不报错 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/subscribe/index.ts` |
| pages/rank/rank | 3c 商机周榜（公开内容页）：一周商机故事+省级热度/最大单/新入榜业主三榜，行点击穿卡详情/报告详情，分享=周榜本身 | `E:/AI-Station/WeAppForge/projects/zongbao/pages/rank/rank.ts` |
| pages/ai/ai（休眠） | 云开发 extend.AI（deepseek）流式对话助手——**未注册进 app.json pages 且 packOptions.ignore 排除出包**，cloud=false 时纯降级文案 | `E:/AI-Station/WeAppForge/projects/zongbao/app.json` packOptions.ignore + `pages/ai/ai.ts` |

detail 页为守住单文件 ≤400 行预算，把 P1/P2 处理器拆成 `pages/detail/p1-handlers.ts`（218 行，点赞/组队/批评 19 个 handler）与 `pages/detail/p2-handlers.ts`（65 行，转赠）经对象展开并入 Page 配置。

## 2. 后端接线

- **主仓形态（projects/zongbao）**：`config/index.ts` 中 `apiEnv:'dev'`、`mockApi:true` → 全部请求走本地 mock 夹具（utils/mock-fixtures*.ts，与真实请求同签名）；DEV_BASE=`http://127.0.0.1:8872/api/v1`（B 线影子位）；PROD_BASE 为占位 `https://api.zongbao-xueyuan.tbd/api/v1`，注释明确「prod=备案域名 nginx 反代 8871（域名 TBD 用户定）」。
- **发布形态（work/zongbao_trial）**：`work/zongbao_trial/config/index.js` 四翻焊死——`apiEnv:'prod'`、`mockApi:false`、PROD_BASE=`http://47.120.43.20:8871/api/v1`（ECS 裸 IP 直连 8871，HTTP 非 HTTPS）、`p1:false`。
- **请求封装**（`E:/AI-Station/WeAppForge/projects/zongbao/utils/api.ts`）：wx.request 统一封装，Bearer token（storage key `zongbao_token`），401 静默重登重试一次，503 PAY_NOT_CONFIGURED→支付灰置事件，网络失败→「服务维护中，试读内容仍可离线阅读」降级，超时 10s，`__XY_BASE__` 可注入测试。
- **API 清单（前端实际调用，30 个）**：`POST /auth/login`；`GET /catalog`；`GET /search`；`GET /reports/{id}`；`GET /reports/{id}/chapters?with_content=trial|all`；`POST /reports/{id}/chapters/{cid}`；`POST|DELETE /reports/{id}/favorite`；`POST /pay/sign`；`GET /pay/status`；`GET /me`；P1：`POST /reports/{id}/like`、`POST /reports/{id}/criticize`、`GET /criticisms/{id}`、`POST /refund/apply`、`GET /invite/relations`、`POST /invite/dwell`、`POST /team`、`POST /team/{id}/join`、`GET /me/vouchers`、`POST /vouchers/redeem`；卡三契约：`GET /cards/{card_id}`、`GET /cards/resolve`、`GET /cards/by-report/{rid}`；P2：`POST /reports/{id}/chat`、`GET /search/owned`、`POST /reports/{id}/transfer`、`GET|POST|DELETE /subscriptions`；`GET /rankings`。
- **引擎侧多出的端点（前端不调）**：`/invite/scan`、`/reports/{rid}/download`、`/pay/callback`、`/refund/callback`、poster 两个、`/admin/resync`、`/rankings/export`、`/k/dashboard`、`/health`（`E:/AI-Station/services/xueyuan-engine/xueyuan_engine/` 各模块 @router 装饰器）。
- **内容旁挂**：`content/off.json` 运营下架位（6 份在列→在架 32 份，与体验版 desc「32份在售」吻合），引擎 sync 幂等对齐，改后 `systemctl restart xueyuan-engine` 生效。

## 3. 购买流程现状

- **定价**：单篇研报 ¥498（49800 分），iOS/安卓同价（`utils/agreement.ts` PAY_PRICE_LINE 逐字）。
- **支付链已完整编码但当前关死**：detail/reader 的 onUnlock → 支付前披露半屏弹层（templates/pay-sheet.wxml，2.2 三条逐字）→ onPayAgree → `utils/pay.ts unlockReport()`：`features.virtualPay`（repo 与 trial **均为 false**）+ `wx.requestVirtualPayment` 存在性双闸 → 未开即返回降级文案「支付通道开通中，敬请期待。试读章节持续免费开放。」
- **开通后流程**：`POST /pay/sign` → `wx.requestVirtualPayment({mode, signData, paySig, signature})`（sign_data/pay_sig/signature 三值服务端供给、逐字节透传不重序列化）→ 成功先 `unlockLocal()` 本地解锁（体验先行）→ 1s 间隔轮询 `GET /pay/status`（限 5 次）以云端 `entitlement_granted` 为准。
- **三层灰置矩阵**：本地开关 virtualPay / 服务端 503 PAY_NOT_CONFIGURED / login 回包 `pay_configured:false` ——任一触发支付入口灰置，试读/收藏/搜索不受影响。
- **无真实微信支付**：全项目 grep 无 `wx.requestPayment`，虚拟支付是唯一支付通道（「数字内容唯一合规通道」注释）。ALREADY_ENTITLED→「已解锁该研报」。
- **trial码（256 张码池）**：是引擎侧产物（部署脚本打包 `tools/(qr_pool 码池)` 上 ECS）；小程序侧消费形态=扫码 scene——reader `parseScene` 解析 `r=报告短ID&i=邀请人短ID`（utils/format.ts:219），cards 页 `cardResolve` 解析卡码；**App 内没有兑换码输入框**。权益来源五类：purchase/gift（点赞获赠）/voucher（书券 49800 分兑）/team/invite。
- **订阅**：非付费订阅，是「省份/主题」报告更新订阅（P2），引擎 configured 探测通过才露出入口。
- **发票**：P0 仅本地收集抬头/税号（storage key `zongbao_invoice`），真实开票流留待后续。

## 4. 阅读器能力

- **非 webview、非 rich-text，自研三段管线**：章节 HTML（mammoth 产物，包内 chapters.json 或按权益在线拉取）→ `utils/render.ts htmlToMd()`（h1-h6/p/table/ul/ol 正则转 Markdown，表格转 Markdown 表）→ `utils/md2blocks.js`（零依赖 Markdown→结构化块 `{t:'h1'|'h2'|'h3'|'p'|'quote'|'code'|'ul'|'ol'|'table'|'hr', inl:[{k:'t'|'b'|'i'|'c'|'l'}]}`）→ reader.wxml `wx:for` 逐块渲染+WXSS 精细排版（表格/代码块横向 scroll-view，文本 user-select）。render.ts 注释明确「不再裸露 HTML 标签也不引入 rich-text 黑盒」。
- **渲染件血统**：`utils/md2blocks.js` 头注「总包AI顾问 v0.2.4」、`utils/render.ts` 注释「排版革命（总包AI顾问 v0.2.6）」——**渲染管线本就是从总包AI顾问继承的**。
- **分页模型**：章为最小单元（侧栏目录 📖/🔒 标记、上一章/下一章按钮），整章一次滚动渲染，章内无自研分页；付费章锁定占位（🔒+章题+解锁 CTA）不解锁不拉正文。
- **叠加能力**：试读末章决策卡（免费试读 N 字/付费剩余/模糊标题预告）；P1 末章轻入口；P2「问一问」AI 伴读（引擎检索式，引用胶囊点击跳章，会话内不持久化）；v1.2 停留 ≥30 秒 onUnload/onHide 静默上报 `/invite/dwell`。

## 5. 商品模型

- **主营**：省级水利工程商机研报 38 份（catalog.json：江苏水网/浙江/甘肃/西藏…「总包创研院出品」），单篇 ¥498，每份带 trialChapterCount 试读章（如江苏 17/19 章、浙江 11/21 章）；off.json 下架 6 份→在架 32。
- **营销面**：商机情报卡 38 张（content/cards/*.json，情报裂变 2.0 落地页，卡详情公开免登录可读→导流报告详情）+ 商机周榜（一周故事+三榜，公开内容页可分享）。
- **玩法经济**：书券（1 券=1 元，攒 498 兑任一份，账本逐笔可查）、点赞日赠阅、3 人组队 ¥998、批评评分退款（≥50 分按分退，月限 2 次）、转赠（仅本人购买源可转）。
- **AI**：在役的是引擎检索式伴读（P2 chat，provider 由引擎答 local/openai_compat）；云开发 extend.AI 页（pages/ai）休眠未上包。

## 6. 主包体积风险

- **app.json 无 subPackages 字段**——9 页全部主包，零分包（分包工单 D-1 未做，与记忆「2MB主包墙=分包工单D-1」一致）。
- **全量主仓有效包体 ≈3.91MB**：content 3.62MB（reports 章节正文 2.45MB + cards 1.22MB + catalog 24KB）+ 代码约 298KB（按 project.config.json packOptions 排除 node_modules/.ts/tsconfig/package.json、app.json 排除 pages/ai 实测）。
- **体验版为何能上**：发布快照 `work/zongbao_trial` 内容裁到 725KB（35 个报告目录，仅 xz-shuili-2026 保留 219KB 全文，其余 ~30KB 壳），且 `work/upload_xueyuan_trial.mjs` 上传时再忽略 `content/cards/**`、`miniprogram_npm/@vant/**`、`miniprogram_npm/mp-html/**`、`*.ts` → 有效包体仅 **0.82MB**。
- **零 npm 依赖在役**：miniprogram_npm 为空目录；@vant/weapp 与 mp-html 装在 node_modules 但全库零引用（脚手架遗留，上传注释自认「主包 2MB 限瘦身」）；所有页面 usingComponents 均为空。
- **风险结论**：只要想把 38 份全文内容随包发出，就必须做分包（或继续走「包内壳+引擎在线拉正文」的瘦身形态）。

## 7. TypeScript 使用情况

- **真源是 .ts，.js 是编译产物随仓提交**：app.ts + 16 个页面/处理器 .ts + 13 个 utils .ts；tsconfig.json strict、ES2020、CommonJS、**原地 emit（outDir:"./"）**；types 引 miniprogram-api-typings。project.config.json packOptions 以 `.ts` 后缀排除出包，开发者工具跑的是 .js。
- **同步状态实测良好**：全部 .js 时间戳（1790609874，9-28 批量编译）晚于所有对应 .ts 最后修改——无 stale 编译产物（符合「杜绝跑旧代码铁律」）。
- 唯一例外：`utils/md2blocks.js` 为纯 JS+配套 `md2blocks.d.ts` 声明（零依赖件刻意不加编译环节）。

## 附：与总包AI顾问的既有继承点（对「借鉴总包AI顾问」工作流的直接输入）

1. **md2blocks/render 排版管线**——已继承（v0.2.4/v0.2.6 血统，注释留名）。
2. **api.ts 401 静默重登重试**——注释「qianwen 惯例」。
3. **`__XY_BASE__` 测试注入**——注释「biaoxun __QW_BASE__ 同款惯例」。
4. **发布门禁 harness**——`work/harness_xueyuan.cjs` 头注「惯例沿 work/harness.cjs」（总包AI顾问同款静态 QA 断言集）。
5. **miniprogram-ci 上传**——`work/upload_xueyuan_trial.mjs`（privateKey 直注+preview 二维码，Node 25 localStorage 兼容补丁）。
6. 待借鉴空白：总包AI顾问已有的虚拟支付服务端五步（offer/pay_sign 官方 AppKey 新规格，见记忆 qianwen-gc-proposal）在学园侧仍是 virtualPay=false 关死状态，等待类目+offer_id。

## Key Facts
- appid=wxfdb55b184756e89e，projectname=zongbao-xueyuan；packOptions 排除 node_modules/tsconfig.json/.ts/package.json (E:/AI-Station/WeAppForge/projects/zongbao/project.config.json 4,7-13)
- app.json 注册 9 页（index/reader/me/detail/agreement/cards-detail/search-owned/subscribe/rank），tabBar 仅书架+我的，无 subPackages 字段；pages/ai 被 packOptions.ignore 排除出包 (E:/AI-Station/WeAppForge/projects/zongbao/app.json 2-12,34-41)
- 主仓 config：apiEnv='dev'，mockApi=true，virtualPay=false，cloud=false，voiceInput=false，p1=true；DEV_BASE=http://127.0.0.1:8872/api/v1，PROD_BASE=https://api.zongbao-xueyuan.tbd/api/v1 占位（注释：prod=备案域名 nginx 反代 8871） (E:/AI-Station/WeAppForge/projects/zongbao/config/index.ts 23-25,42-53)
- 发布快照四翻焊死：apiEnv='prod'，mockApi=false，PROD_BASE='http://47.120.43.20:8871/api/v1'（ECS 裸 IP），p1:false，virtualPay 仍 false (E:/AI-Station/WeAppForge/work/zongbao_trial/config/index.js 7,26-34)
- 支付链：unlockReport() 双闸（features.virtualPay + wx.requestVirtualPayment 存在）→未开即降级文案；开通后 /pay/sign → wx.requestVirtualPayment 三值逐字节透传 → unlockLocal → 轮询 /pay/status（1s×5）云端发货为准；全项目无 wx.requestPayment (E:/AI-Station/WeAppForge/projects/zongbao/utils/pay.ts 44-79)
- API 封装共 30 个端点（auth/catalog/search/report/chapters/favorite/pay-sign/pay-status/me + P1 十个 + 卡三契约 + P2 五个 + rankings）；Bearer 注入/401 静默重登重试一次/503 PAY_NOT_CONFIGURED 灰置/网络失败服务维护降级 (E:/AI-Station/WeAppForge/projects/zongbao/utils/api.ts 116-137,207-386,440-637)
- 阅读器渲染管线：章节 HTML → htmlToMd → md2blocks 结构化块 → reader.wxml wx:for 渲染；注释「不再裸露 HTML 标签也不引入 rich-text 黑盒」；md2blocks.js 头注「总包AI顾问 v0.2.4」、render.ts 注释「排版革命（总包AI顾问 v0.2.6）」 (E:/AI-Station/WeAppForge/projects/zongbao/utils/render.ts 1-4,59-103)
- reader：scene 容错解析 r=报告短ID&i=邀请人短ID；试读末章决策卡；付费章锁定占位不解锁不拉正文；P2 问一问伴读引用胶囊跳章；≥30 秒停留 onUnload/onHide 静默上报 /invite/dwell (E:/AI-Station/WeAppForge/projects/zongbao/pages/reader/reader.ts 64-96,163-205,312-366)
- 商品=38 份省级水利商机研报单篇 ¥498（49800 分），trialChapterCount 逐份标注（江苏 17/19、浙江 11/21）；off.json 下架 6 份=在架 32 份 (E:/AI-Station/WeAppForge/projects/zongbao/content/catalog.json 3-20（价格 49800）)
- 全量有效包体实测 3.91MB（content 3.62MB：reports 2.45MB+cards 1.22MB；代码 298KB）；体验版快照内容裁到 725KB+上传忽略 cards/vant/mp-html/.ts → 有效 0.82MB；miniprogram_npm 空目录，@vant/mp-html 零引用 (E:/AI-Station/WeAppForge/work/upload_xueyuan_trial.mjs 17-27（ignores 列表）)
- TypeScript 真源在用：tsconfig strict/ES2020/CommonJS/outDir './' 原地 emit；实测所有 .js 编译时间戳晚于对应 .ts 最后修改（无 stale）；utils/md2blocks.js 为纯 JS+md2blocks.d.ts (E:/AI-Station/WeAppForge/projects/zongbao/tsconfig.json 1-18)
- 引擎部署：ECS /opt/xueyuan 端口 8871（8870=qianwen 在役勿占），打包含 tools/qr_pool 码池，secrets=xueyuan_mp.secret/xueyuan_engine_hmac.key/virtual_pay_xueyuan.secret；引擎路由与前端 api.ts 一一对应另多 callback/admin/poster 端点 (E:/AI-Station/WeAppForge/work/ecs_deploy_xueyuan.py 5-7,36-38,104-110)
- 发布门禁：harness_xueyuan.cjs 静态 QA 断言集（惯例沿 work/harness.cjs 即总包AI顾问同款），对象=构建产物包目录，断言来自 REQUIREMENTS.md P0 上线门 10 条硬判据 (E:/AI-Station/WeAppForge/work/harness_xueyuan.cjs 1-9)
- pages/ai 为云开发 extend.AI（deepseek 流式）助手页但休眠：未注册进 app.json pages 且被 packOptions.ignore 排除；cloud=false 返回 null 降级 (E:/AI-Station/WeAppForge/projects/zongbao/pages/ai/ai.ts 9-24)

## Risks
- 无 subPackages：38 份全文随包发出必超 2MB 主包墙（全量实测 3.91MB）；体验版靠裁内容（725KB）+上传忽略（cards/npm）压到 0.82MB——正式全量上线前分包工单 D-1 必须做，或永久走「包内壳+引擎在线拉正文」形态
- 体验版 PROD_BASE 是 http://47.120.43.20:8871/api/v1（HTTP+裸 IP）——仅适用于体验版「不校验合法域名」；正式提审必须换 HTTPS+备案域名并加入 request 合法域名（主仓 PROD_BASE 仍是 api.zongbao-xueyuan.tbd 占位符，域名用户未定）
- virtualPay=false 双闸关死：支付闭环代码完备但端到端不可用，开通依赖后台虚拟支付 offer_id+类目通过（记忆：等用户=虚拟支付 offer_id+类目）；当前用户无法真实付费，权益只能靠试读/赠阅链路
- 主仓 mockApi=true：P1/P2 全量功能（卡/榜/订阅/已购检索/转赠/伴读）只在 mock 或联调形态验证过，体验版快照 p1=false 把这些页面整个从 app.json 摘除——真实引擎上的 P1/P2 端到端路径未随体验版曝光
- off.json 在仓里是引擎侧镜像（真源在 ECS，改后须 systemctl restart xueyuan-engine）：两端不同步时在架集合会漂移
- node_modules 装 @vant/weapp+mp-html 但零引用且 miniprogram_npm 为空——若有人误跑「构建 npm」或取消上传 ignores，包体会被无谓撑大

## Open Questions
- 正式提审生产域名定稿（api.zongbao-xueyuan.tbd 占位等待用户定夺，须 HTTPS+备案）——config/index.ts 第 24 行注释明确 TBD
- 微信当前单包上限口径：团队 D-1 工单按 2MB 主包墙立项，体验版按 0.82MB 工程化规避；若平台已放宽单包 4MB，38 份全文或可直接随主包，分包方案需重新评估（需以开发者工具实测上传结果为准）
- reader scene 的 r= 报告短ID 与 256 张 trial 码池短码的映射关系在引擎 tools/qr_pool 侧，前端不感知——短码复用坑记忆称已根治，具体映射规则需查引擎侧确认（本任务只盘点小程序侧）
- pages/ai 云开发 AI 页的启用时间表（cloudEnvId 空、cloud=false），以及是否会被 P2 引擎伴读（/chat）方案取代
