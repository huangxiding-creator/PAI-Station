# agent0

# F5a 报告售卖站全面盘点（只读侦察 · 全部有文件证据）

站点名「总包智库 · 研究报告发布平台」。纯 stdlib 零依赖 Python 实现，静态站 `site/` + 单文件后端 `server.py` + 支付模块 `pay.py` + 站点生成器 `build_site.py`。

---

## 1. 商品模型：66 个 SKU（65 在售 + 1 预售）

数据单一事实源 = `E:/AI-Station/report_platform/content/report.json`（顶层键 `site_name` + `reports`，共 66 条）。每条含 sku/title/subtitle/price/price_label/words_wan/badges/chapters/cat/cat_name/sample_file/intro/audience 等字段。

| 分类 | 数量 | 单价 | 明细 |
|---|---|---|---|
| flagship 旗舰深度 | 2 | ¥1,999 | CNNC-EPC（15.6万字14章）、R50-SNEI（10万字15章） |
| ent 企业拆解 | 28 | ¥698 | ENT-01~28 |
| prov 省份市场 | 16 | ¥598 | PROV-01~16 |
| topic 专题实战 | 17 | TOPIC-01~11 ¥598；TOPIC-12~17 ¥498 | |
| excl 独家 | 2 | ¥698 | EXCL-01/02 |
| 预售（coming_soon=true, report.json:7193） | 1 | ¥10,000 | BLUEBOOK-2027 蓝皮书（50万字五卷本，仅意向登记，不入构建） |

- **在售价格区间 ¥498–¥1,999**；含预售则为 ¥498–¥10,000。
- **内容形式 = 双载体**：`content/full/` 下每 SKU 两件（`{sku}.html` 全文网页 + `{sku}.pdf`），130 个文件 = 65 SKU × 2，实付后网页在线阅读 + PDF 下载双解锁。
- **免费试读**：`content/sample/` 65 个 md → 生成 `sample_{sku}.html` 试读页（目录全览+第1章片段，`build_site.py:297-316`）。
- 站点页面：index + 65 详情页 + 65 试读页 + reader + admin（`build()` 清场逻辑在 `build_site.py:491-500`）。

## 2. 买家全流程（页面 → API 链路）

**浏览**：`/`（index.html 目录页：刊头统计/旗舰墨面/分组卡墙/购买须知）→ `/{sku}.html` 详情页（徽章条/目录大纲/免费试读卡/购买区 buy-box/吸底购买栏）→ `sample_{sku}.html` 试读 → 回详情 `#buy`。

**支付主路（微信内，全自动）**——`template.py:413-489 PAY_JS` + `server.py`：
1. 点 `payWxBtn`（data-ev=click_buy）→ 前端先 `GET /api/pay/ready` 探测能力；
2. 微信内且 jsapi 就绪 → 跳 `GET /api/pay/wxlogin?sku=` → 服务端 302 到微信 OAuth（snsapi_base 静默授权，`pay.py:181-189`）；
3. 微信回跳 `GET /api/pay/wxback?sku&code` → `code2openid`（`pay.py:191-205`）→ 生成一次性 pt 令牌（内存存储 10min TTL，`server.py:34-35,278-281`）→ 302 回 `/{sku}.html?pt=…`；
4. 页面 JS 检到 pt → `POST /api/pay/jsapi`（pop pt 校验 sku 匹配+未过期）→ JSAPI 下单得 prepay_id → 返回 RSA 签名 payParams → 前端 `WeixinJSBridge.invoke('getBrandWCPayRequest',…)` 拉起收银台；
5. 支付成功 → 微信回调 `POST /api/pay/notify/wx`（平台证书验签+防重放 5min 窗口+AES-256-GCM 解密 resource，`pay.py:236-256`）→ `mark_paid` 幂等核销（签发 access_token，`pay.py:332-346`）；
6. 前端每 2.5s 轮询 `GET /api/pay/status?order_no&ck`（ck=客户端回查密钥 sha256 门禁）→ state=paid → 返回 `reader_url=/reader.html?o=…&s=签名` + `pdf_url=/api/full.pdf` → 1s 后自动跳阅读页。

**微信外（浏览器）**：`POST /api/pay/create {sku,channel:'wxpay'}` → Native 下单得 code_url → `GET /api/pay/qr?text=weixin://…` 服务端 qrcode 库自绘 PNG → 展示二维码长按/扫码 → 同样轮询 status。

**备用通道（alt-pay 折叠条，当前实际在用的路）**：微信收款码图（`content/qr_wechat.png` 企业微信收款码，`build_site.py:68-74` 码缺席显占位）→ 买家扫码转账备注订单号 → 填表 `POST /api/order {sku,contact,note,order_no}` 落库 state=pending → 人工核对到账（admin 台）→ 解锁。

**收货（阅读页 reader.html，`build_site.py:344-416 READER_JS`）**：凭 `订单号+支付尾号后4位` `GET /api/order/query` 换签名链接；或直接开支付返回的专属链接。`GET /api/reader/content?o&s`（HMAC-SHA256(key=access_token,msg=order_no) 前32位签名门禁，`server.py:56-59,91-101`）载入全文 HTML；`GET /api/full.pdf` 下载 PDF。**售后**：页内星级+章节定位反馈 `POST /api/feedback` → 规则分档（严重 100%/局部 40%/轻微 20%/建议 0%，`pay.py:367-386`）→ 章节必须命中真章节表（L3 内容锚定）且退款需该章节真实阅读埋点（L2 阅读锚定防套利）→ 命中即 `auto_refund` 原路比例退款（护栏：累计封顶实付+最多 3 轮）。全程埋点 `POST /api/track`（visit/scroll_xx/read_sample/click_buy/show_qr/order_created/read_chapter 等 9+ 事件）。

## 3. 支付轨道现状

**设计 = 企业直连全自动**：微信支付 v3（Native+JSAPI，RSA-SHA256 签名串/AES-GCM 解密/主动查单兜底）+ 支付宝手机网站支付 RSA2（全在 `pay.py`，回调验签/幂等核销/比例退款 37 tests 绿，GOAL_LEDGER.md 记载）。**明确不做个人码监听器**（账号风险红线，GOAL_LEDGER.md:22「个人码监听器 = 账号风险红线, 不做」）。

**现状 = 半自动 stub 态**：`secret.ini`（被 .gitignore 排除）四节键名如下（值打码）：
- `[legacy]`：`admin_token`
- `[pay]`：`notify_base`（=https://report.yrecepc.cn，见 `work/_set_notify_base.py:13`）
- `[wxpay]`：`mchid`、`appid` —— **仅 2/5 件**（缺 `api_v3_key`、`serial_no`、`private_key_pem`，另 JSAPI 还需 `oauth_secret`；五件套齐才 `_ok=True`，`pay.py:62-66,176-178`）→ `pay_ready()=False` → 前端 `fallback()` 自动展开转账登记备用通道
- `[wxapp_wxfdb]`：`appid`、`appsecret`、`upload_key` —— **总包学园小程序(wxfdb)的凭证已躺在平台 secret.ini 里**
- 无 `[alipay]` 节 → 支付宝休眠（UI 微信独占，1007 用户令）

GOAL_LEDGER.md「待用户」第 1 条 = 微信支付商户号五件套 + 公众号 AppSecret（**硬阻塞变现**）。certs/wx_platform_pub.pem 平台证书也等商户资质后才就位。

## 4. 部署形态

- **ECS** 47.120.43.20（阿里云 cn-heyuan，实例 i-f8za6qhv365cwhti5y35，`deploy/deploy_ecs.py:30-32`）。服务 systemd `report-platform` 常驻 **:8885**，WorkingDirectory=/www/report_platform，db=/www/report_platform/data/report_platform.db（`deploy/report-platform.service` 与 `deploy_ecs.py:149-169`）。
- **域名关系**：`report.yrecepc.cn`（LE 证书 2027-01-06 到期）挂在 ECS 上 dify 容器 nginx（conf `/root/dify/docker/nginx/conf.d/yrecepc.conf`）：80→301→443，`proxy_pass http://172.18.0.1:8885`（`work/_https_phasec.py:24-61` 实证）→ **IP:8885 就是源站直连口（双层墙 ufw+安全组都开 8885），域名是 HTTPS 正式买家口**（微信支付回调 notify_base 强制 https）。SITE_BASE=`https://report.yrecepc.cn`（`template.py:493`，canonical/og 唯一属主）。
- **deploy/ 两个文件**：`deploy_ecs.py`（打包 tar.gz→base64 按 12KB 分片→阿里云 CLI RunCommand 通道（tools/ecs_qw.py 免 SSH）→远端拼装解压→systemd 常驻→ufw+安全组开闸；含 `--site-only` 原子换站变体：site_new 验证过才 mv 换入）+ `report-platform.service`（unit 样板）。日常增量走 `work/_deploy_lite.py` lite 包 ≈1.0MB/115 片/435s（GOAL_LEDGER.md「部署经济学」）。

## 5. 服务端 API 面清单（server.py 全路由）

**GET（9 条 + 静态）**：
| 路由 | 用途 | 位置 |
|---|---|---|
| `/api/stats?token=` | admin 数据台：漏斗计数+最近500订单+质量脉搏（RP_ADMIN_TOKEN 门禁） | server.py:171 |
| `/api/order/query?order_no&tail` | 读者门：订单号+尾号→签名阅读/PDF 链接 | :189 |
| `/api/reader/content?o&s` | 全文 HTML（签名门禁） | :207 |
| `/api/full.pdf?o&s` | 完整 PDF 下载（签名门禁） | :217 |
| `/api/pay/qr?text=` | code_url→PNG 二维码（qrcode 库） | :235 |
| `/api/pay/ready` | 能力探测布尔（wxpay/jsapi） | :250 |
| `/api/pay/wxlogin?sku=` | 微信内 OAuth 302 | :255 |
| `/api/pay/wxback?sku&code` | OAuth 回跳→pt 令牌→302 回详情页 | :268 |
| `/api/pay/status?order_no&ck` | 支付轮询（ck_hash 门禁） | :288 |
| `/` `/sample` `/reader` `/admin` `/assets/*` `/{sku}.html` 根层通配 | 静态页（resolve+startswith 防穿越） | :312-325 |

**POST（8 条）**：`/api/track`（埋点）、`/api/order`（个人码半自动登记→pending）、`/api/pay/create`（企业下单 wx Native/ali WAP）、`/api/pay/jsapi`（微信内一键支付）、`/api/pay/notify/wx`（微信回调验签核销）、`/api/pay/notify/ali`（支付宝回调验签）、`/api/feedback`（反馈→分档→比例退款，L2/L3 双锚定）、`/api/refund`（主动退款）。白名单外一律 404（server.py:330-334）。

## 6. 与「小程序化」的距离（借鉴 总包AI顾问 `E:/AI-Station/WeAppForge/projects/zongbao-ai/`）

**可直接复用（后端零改动或近零）**：
- **pay.py 整个支付引擎**——JSAPI 本就是小程序支付同族原语：`wx_jsapi_order`/`wx_jsapi_params`（RSA paySign）直接对接小程序 `wx.requestOrderPayment`；退款/对账/幂等核销/比例退款全套白拿；
- **订单状态机与安全设计**（access_token+HMAC 签名链接+ck 门禁、refund 护栏、orders/feedback/pay_amounts 表结构）；
- **商品数据模型** `content/report.json`（66 SKU 完整元数据）+ **内容资产** `content/full/` 130 件（HTML+PDF）+ 试读 md 65 件；
- **部署底座**：ECS+systemd+HTTPS 域名 report.yrecepc.cn（小程序 request 合法域名硬要求 https，已满足）；
- **凭证衔接**：secret.ini 已有 `[wxapp_wxfdb]`（学园小程序 appid/appsecret/upload_key）——小程序侧身份/上传凭证已预置在同一文件；
- zongbao-ai 的工程骨架可借：`utils/api.js`（401 自动重登重试/统一错误文案/token 缓存）、custom-tab-bar、theme.json darkmode、app.json 页面组织。

**必须重做**：
- **前端全套**：template.py 的 CSS/PAY_JS/READER_JS 是 H5 专属 → 需 WXML/WXSS 重写目录/详情/试读/阅读四类页面（最快捷径：reader 用 web-view 嵌现有 `reader.html?o&s` 签名链接，签名机制原样可用）；
- **支付触发层**：`WeixinJSBridge` → `wx.requestOrderPayment`；`/api/pay/wxlogin` OAuth 302 三段流在小程序内不需要（`wx.login`→`jscode2session` 原生拿 openid，`pay.py:191` 的 code2openid 是同族调用可改参复用）；pt 令牌交接机制整段可省；
- **Native 二维码路径**（`/api/pay/qr`）小程序内无意义（那是外置浏览器场景）；
- **PDF 交付**：小程序内需 `wx.downloadFile`+`wx.openFile`（合法域名配置），或保留 H5 链接跳出；
- **埋点上报**：fetch→wx.request 封装（借 api.js 模式）；
- **合规层**：小程序内卖研究报告需过类目/资质（虚拟支付 vs 微信支付商户号两条路——学园已跑通过虚拟支付 offer_id 那套，见记忆 xueyuan-market-proposal，可作第二轨道参考）。

**一句话结论**：后端（支付引擎/订单机/内容库/数据模型/HTTPS 域名）≈100% 可复用，小程序化≈纯前端工程 + openid 获取方式适配 + 类目合规；真正硬阻塞仍是商户资质（五件套缺 3 件），与 H5/M 小程序形态无关。

## Key Facts
- 商品 66 SKU：flagship 2(¥1999)+ent 28(¥698)+prov 16(¥598)+topic 17(¥598/¥498)+excl 2(¥698)+预售 BLUEBOOK-2027 ¥10000(coming_soon=true)，在售 65 份 (E:/AI-Station/report_platform/content/report.json reports[] 全表；BLUEBOOK-2027 coming_soon 在 7193 行)
- 内容双载体：content/full/ 130 文件 = 65 SKU × {sku}.html + {sku}.pdf；试读 content/sample/ 65 个 md (E:/AI-Station/report_platform/content/full/ 目录清点 130 项)
- 支付=企业直连设计：微信支付 v3 Native+JSAPI、支付宝 WAP RSA2；个人码监听器被明令不做（账号风险红线） (E:/AI-Station/report_platform/pay.py 1-16 模块 docstring；GOAL_LEDGER.md:22)
- secret.ini 键名（值打码）：[legacy]admin_token；[pay]notify_base；[wxpay]mchid,appid（5件套仅2件，缺api_v3_key/serial_no/private_key_pem+oauth_secret→stub态）；[wxapp_wxfdb]appid,appsecret,upload_key；无[alipay] (E:/AI-Station/report_platform/secret.ini 1-14（grep 键名扫描）)
- 买家主路：payWxBtn→/api/pay/ready→微信内 wxlogin→OAuth→wxback→pt令牌(10min)→/api/pay/jsapi→WeixinJSBridge→回调 /api/pay/notify/wx 验签解密→mark_paid→轮询 /api/pay/status(ck门禁)→reader_url+pdf_url (E:/AI-Station/report_platform/template.py PAY_JS 413-489；server.py 250-311/433-449)
- 备用通道=个人收款码+转账登记：POST /api/order {sku,contact,note,order_no}→state=pending 人工核对；qr_wechat.png 缺席显占位 (E:/AI-Station/report_platform/server.py 346-360；build_site.py:68-74)
- 阅读门禁=HMAC 签名链接：sig=HMAC-SHA256(key=access_token,msg=order_no)[:32]；/api/reader/content 与 /api/full.pdf 双腿同门禁；partial_refunded 保留阅读权 (E:/AI-Station/report_platform/server.py 56-62, 91-101, 207-233)
- 售后=反馈分档比例退款：严重100%/局部40%/轻微20%/建议0%；质量类反馈章节必须命中全文真章节表且需真实阅读埋点；退款护栏=累计封顶+≤3轮 (E:/AI-Station/report_platform/pay.py 362-386(grade_feedback), 389(MAX_REFUND_ROUNDS), 458-494(auto_refund)；server.py:463-506)
- 部署：ECS 47.120.43.20 实例 i-f8za6qhv365cwhti5y35 (cn-heyuan)，systemd report-platform :8885，db=/www/report_platform/data/report_platform.db；通道=阿里云CLI RunCommand 免SSH，tar.gz→base64 12KB分片 (E:/AI-Station/report_platform/deploy/deploy_ecs.py 30-33, 104-169)
- 域名与IP关系：report.yrecepc.cn LE证书(2027-01-06到期)挂 dify nginx 容器，80→301→443→proxy_pass http://172.18.0.1:8885；IP:8885=源站直连口(双层墙 ufw+安全组)；SITE_BASE=https://report.yrecepc.cn (E:/AI-Station/report_platform/work/_https_phasec.py 24-61；template.py:493)
- API 面：GET 9条(stats/order/query/reader/content/full.pdf/pay/qr/pay/ready/pay/wxlogin/pay/wxback/pay/status)+静态路由；POST 8条(track/order/pay/create/pay/jsapi/pay/notify/wx/pay/notify/ali/feedback/refund)，白名单外404 (E:/AI-Station/report_platform/server.py 168-334)
- 小程序化参照系：总包AI顾问 appid=wx5cee1574ce45819b，BASE_URL=https://ai.epcschool.top，7页面+custom-tab-bar，api.js 带401自动重登；report_platform/secret.ini 已预置学园号 [wxapp_wxfdb] 三键 (E:/AI-Station/WeAppForge/projects/zongbao-ai/project.config.json 2；utils/config.js BASE_URL；report_platform/secret.ini 11-14)
- 测试面：tests/ 四文件 test_build_site.py(317行)/test_pay_refund.py(191)/test_promo_guard.py(135)/test_server.py(63)；GOAL_LEDGER 记 pay.py 37/37 绿 (E:/AI-Station/report_platform/tests/ wc -l 清点)
- 硬阻塞=微信支付商户资质五件套+公众号AppSecret 等用户（GOAL_LEDGER 待用户第1条）；当前线上实际收款路=个人码转账+人工核对 (E:/AI-Station/report_platform/GOAL_LEDGER.md 58-62「待用户 (硬阻塞变现)」)

## Risks
- 微信支付商户资质五件套缺 3 件（api_v3_key/serial_no/private_key_pem + oauth_secret），全自动支付轨道处于 stub 态——线上当前实际收款只能走个人码转账+人工核对（半自动），这是变现硬阻塞，与小程序化与否无关
- 小程序内卖付费研究报告有类目/资质合规门槛（微信对「虚拟商品」有虚拟支付专属通道限制），需确认走虚拟支付（学园已验证的 offer_id 路线）还是商户号 wxpay 直连，两者资质要求不同
- 前端 PAY_JS/READER_JS 全部基于 H5 API（fetch/WeixinJSBridge/URLSearchParams/IntersectionObserver），小程序需整体重写，不能直接搬运；reader 走 web-view 嵌签名链接是捷径但受小程序 web-view 业务域名配置约束
- PDF 交付在小程序内需 wx.downloadFile 合法域名配置 + 业务域名报备，PDF 文件名当前固定为 EPC-report.pdf（server.py:230）对多 SKU 有误导性
- server 为单进程 sqlite + 全局锁（_LOCK 串行化所有 DB 访问），小程序流量叠加后可能成瓶颈；pt 令牌存进程内存（_PT_STORE），重启即失效
- secret.ini 同时承载 H5 平台与小程序(wxfdb)凭证，凭证隔离与轮换策略需注意；该文件已正确 gitignore
- BLUEBOOK-2027 预售的意向登记链接跳到首个 SKU 页面锚点（build_site.py:140 用 reps[0]），依赖 report.json 排序稳定性

## Open Questions
- 小程序宿主用哪个 appid：复用总包AI顾问 wx5cee1574ce45819b、学园 wxfdb，还是新注册？（secret.ini 已有 [wxapp_wxfdb] 三键，暗示学园号可能是宿主）
- report.yrecepc.cn 是否会加入小程序 request/web-view 合法域名（需 mp 后台配置，代码侧无证据）
- 支付合规路线二选一：商户号 wxpay 直连（复用 pay.py JSAPI 全套）vs 小程序虚拟支付（学园 256 trial 码池已验证的路线）——取决于类目审批结果与用户商户资质进度
- 阅读器走原生重写还是 web-view 嵌 reader.html（工作量差一个量级，体验与审核风险各异）——需产品决策
- ECS 上 dify nginx 容器同时服务多个业务（8881/8882/8871/8885/8889），小程序流量增长后是否需要拆分或加缓存层
