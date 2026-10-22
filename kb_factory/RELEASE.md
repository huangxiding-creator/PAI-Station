# KB-FACTORY 上线包与移交文档（W10 · 2026-10-22）

产线四件：编目引擎（`kb_factory/catalog_engine`）→ 渠道元数据（`channel_adapters`）→
履约（`fulfillment`）→ 交付转换（`convert`）+ 小程序售卖面（`微信小程序/zongbao-ai`）。
全链贯通证据：`kb_factory/e2e/E2E_REPORT.md`（16/16 断言绿，真网络真灌）。

## 1. 小程序侧

### 回归锚清单（每轮发布前必跑）
```
cd 微信小程序/zongbao-ai
py -3 tools/verify_kbfactory.py     # 43 项自检（ALL PASS 才走上传）
```
- 页序锚：`pages/kbfactory/kbfactory` 挂尾部，原 10 页顺序一根不动
  （ask/pot/zhiku/research/report/answer/my/legal/invoice/home）。
- 敏感词：页面四件 + 订单海报模块 + zhiku 新增块，零 渠道名/技术词
  （词表 `ima/wenku/文库/飞书/feishu/api`，只许扩不许收窄）。
- 支付接线：iOS 无付费入口（js 守卫+wxml 门控）· 邮箱校验 · 订单 payload 四键+摘要五键 ·
  海报导出/降级链 · 合规三句与履约中状态页。
- 冒烟（node 在位时自动并入）：支付成功/取消/409 三分支 + 本地订单箱排队。

### 用户人工步（不可机检，按序执行）
1. 微信开发者工具打开 `微信小程序/zongbao-ai/`，确认编译零错、真机预览正常。
2. 上传体验版 → 提交审核（类目：工具/信息查询；页面路径 `pages/kbfactory/kbfactory`，
   入口在智库页知识库工厂卡块）。审核文案不得出现渠道名/技术词（AI 表述禁令照旧）。
3. iOS 包确认无任何付费入口（虚拟支付 Android-only 铁律）。

## 2. 服务端五端点契约（小程序 ↔ 引擎；从 utils/api.js · pay.js · kbfactory_pay.js 汇总）

签名链语义（五端点同构）：服务端按蓝图摘要复算金额并出双签名 → 小程序
`wx.requestVirtualPayment` 原样透传（`sign_data` 为签名字符串，逐字节绑定，不重序列化）→
成功后回调服务端查单核验（微信侧订单+金额核验，幂等）→ 引擎侧闸门放行。
错误语义：`409`=服务端判定已付（补标记收口，不二次拉起支付）；`503`=支付未开通（统一降级
文案）；`401`=登录态过期（api 层静默重登重试一次）。

| # | 端点 | 入参 | 出参 | 备注 |
|---|---|---|---|---|
| 1 | `POST /api/kb/blueprint_sign` | `{need_text, blueprint:{domain,files,gb,total,version_sha}}` | 签名四件套 `{mode, sign_data, pay_sig, signature, out_trade_no}` | 单据类型 `blueprint_export`，¥0.1/张 |
| 2 | `POST /api/kb/blueprint_paid` | `{out_trade_no}` | 核验回执（幂等；409=已解锁） | 支付成功后查单核验+标记 |
| 3 | `POST /api/kb/order_sign` | 四键 `{need_text, blueprint:{…同上}, email, version}` | 签名四件套（动态金额） | 单据类型 `kb_order`；**金额=服务端按蓝图摘要+version 复算，勿信客户端** |
| 4 | `POST /api/kb/order_paid` | `{out_trade_no}` | 核验回执（幂等；409=已受理） | 同 2 语义 |
| 5 | `POST /api/kb/order` | 同 3 四键（支付成功后收尾腿） | 受理回执 `{accepted}`；失败时小程序落本地订单箱 `queued_local` | 服务端落订单 JSON 进 fulfillment `inbox/`：`blueprint_ref/email/version_selection` |

版本枚举（payload `version` 稳定值 → fulfillment 词法）：`original`（原包）· `md`（轻便
阅读版=markdown）· `import`（随身导入包=import_pack/ima_pack）；组合以 `+` 连接
（如 `md+import`），原包恒随单。定价参数（引擎 A 档）：base 29 + gb×2；md 版 ×1.5；
导入包 +¥19。

### 部署建议
- 载体：腾讯云 CloudBase——与总包AI顾问后端同环境。容器部署手册在役：
  `services/qianwen-engine/TCB_DEPLOY.md`（云托管+CloudBase MySQL；五端点并入该服务，
  新增 `/api/kb/*` 路由 + 订单表写 inbox 目录）。
- **W11 已落地（1022）**：五端点+履约桥已并入引擎并部署 ai.epcschool.top（订单状态机
  pending→paid→accepted→pulled；`accepted`=`confirmed` 受理态，回执键 `{accepted:true}`）。
  本地履约云拉：`py -3 -m kb_factory.fulfillment --cloud-pull --base DIR`（凭据 env
  `KB_ENGINE_URL`/`KB_BRIDGE_KEY` 或 `data/secrets/kb_bridge.key`；`--watch` + env
  `KB_CLOUD_POLL=1` 时每 300s 自动并入）。新表 `kb_orders`/`kb_blueprint_unlocks` 两处
  同步（store.py `_SCHEMA` + scripts/mysql_schema.sql）。
- 一键部署链：站在役 `deploy_refresh.cmd`（TCB 密钥已存 secret，未入仓；重部署不需扫码）。
- 履约体（`kb_factory.fulfillment --watch`）建议同容器常驻或独立小机；`inbox/outbox/ledger`
  目录挂持久卷。

## 3. 运维三件

### 3.1 fulfillment 常驻
```
py -3 -m kb_factory.fulfillment --watch --base <产线目录>        # 默认 60s 轮询，Ctrl-C 停
py -3 -m kb_factory.fulfillment --watch --interval 30 --base DIR # 自定义轮询
```
SLA：目标 30 分钟 / 承诺 2 小时（ledger 留痕 `within_target`）。Windows 常驻：计划任务或
`NSSM` 装服务；进程只移动文件绝不删除（failed 订单+原因 sidecar 在 `failed/`）。

### 3.2 日预算与频控参数表
| 参数 | 默认 | 生产建议 | 说明 |
|---|---|---|---|
| `KB_WENKU_MIN_INTERVAL` | 3s | **6s** | M1 实测 3s 连发触发文库速度软拒（v2 教训） |
| `KB_WENKU_DAILY_LIMIT` | 500/日 | 500/日 | 硬熔断 |
| ima 适配器内置 | 3s/200日 | 不动 | 登录态失效自动 OFF |
| `KB_WENKU_FETCH` + wenku secret | 未设=OFF | 待用户放行令 | 黄源双闸（env+secret 缺一不放行） |
| `KB_LOCAL_CORPUS` | `09 发布`+mosaico 知识件 | 按机回填 | 本地绿源根（`os.pathsep` 多目录） |
| `KB_SMTP_SECRET` | `07 任务/.../_credentials/smtp.secret.ini` | 待回填 | 缺配→企微降级人工发，不崩 |
| `KB_WECOM_NOTIFY` | 1 | 1（生产） | 0=冒烟/CI 静默 |
| 安全门 | — | 每次发版前 | `py -3 -m kb_factory.security_gate --check` |

### 3.3 常见故障处置
- **文库限流/空返**：`audit.jsonl` 看 `error`/空页；间隔调 6s、组间冷却 30s、连续空返熔断
  （run_seeds v2 配方）；履约不依赖网络，元数据步可复用已入档蓝图（E2E 同款降级）。
- **SMTP 缺配/发信失败**：包留 outbox，企微通知人工发（`wecom_fallback`/
  `smtp_error_fallback`，ledger `missing` 有原因）；回填 secret 后重发即可。
- **订单邮箱无效**：订单进 `failed/` 带 `.reason.txt`（只移动不删除），人工联系买家改单。
- **大包 >50MB**：只发网盘占位说明，企微人工转存百度网盘回填链接（待回填机制，§4）。
- **引擎蓝图缺失**：订单 fail 带原因；重跑 `run_seeds.py` 或 E2E 降级路径的 seeds 缓存。

## 4. 待用户供给项汇总（缺一项对应腿保持诚实降级，不阻塞其余链路）
1. **SMTP 发件凭据**：`smtp.secret.ini` 回填（host/port/user/password）→ `email` 直投。
2. **网盘回填**：>50MB 大包的百度网盘转存+链接回填机制（v1 人工，确认是否自动化）。
3. **ima 复活**：扫码恢复登录态（`KB_IMA_FETCH=1` 重启用）；按令不硬闯。
4. **wenku 黄源放行令**：`KB_WENKU_FETCH=1` + wenku secret 在位才启用（默认 OFF）。
5. **kb_goods 道具发布**：虚拟支付后台建/发布 kb_goods（¥1 短剧商品）后，在
   `data/secrets/virtual_pay.secret` 增行 `kb_product_id=kb_goods` 并重走部署链——
   未配置期间 `/api/kb/order_sign` 恒 503 诚实降级（蓝图导出腿复用已现网 export_once，
   不受影响）。小程序提审（§1）照常可走。
