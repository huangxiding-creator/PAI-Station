# 微信支付小程序接入调研（channel: wechat_pay）

generated: 2026-09-27 | 27 docs | 调研机：Windows git-bash，官方中文站 webReader 直抓 + GitHub API 实测 stars

> 用户点名要查清「微信支付是怎么接入进来的」。结论先行：**小程序内卖数字内容（研报付费阅读）只有一条正道——虚拟支付通道；标准商户号 JSAPI 是给实物/服务的；云支付只是免签名的工程封装，不改变资质门槛。**

---

## 一、文档总表

### A. 标准接入（JSAPI v3）官方文档

| # | 标题 | URL | 要点 |
|---|------|-----|------|
| 1 | 小程序支付-产品介绍 | <https://pay.weixin.qq.com/docs/merchant/products/mini-program-payment/introduction.html> | 官方产品页；适用实物商品/服务，虚拟内容另有通道 |
| 2 | JSAPI 下单（v3） | <https://pay.weixin.qq.com/doc/v3/merchant/4012791856> | POST `/v3/pay/transactions/jsapi`：appid+mchid+out_trade_no+notify_url+amount(分)+payer.openid → `prepay_id`；RSA-SHA256 请求签名；2024 起平台证书→微信支付公钥（不过期） |
| 3 | wx.requestPayment | <https://developers.weixin.qq.com/miniprogram/dev/api/payment/wx.requestPayment.html> | 前端五参数：timeStamp / nonceStr / package=`prepay_id=***` / signType=`RSA` / paySign；paySign=商户私钥对 `appId\n timeStamp\n nonceStr\n package\n` 签名（后端算好下发） |
| 4 | v3 回调验签解密（通用规则） | <https://pay.weixin.qq.com/docs/merchant/development/interface-rules/paymentnotification.html> ⚠️章节路径待核实 | Wechatpay-Signature/Timestamp/Nonce/Serial 四头+原始 body，用**平台证书/微信支付公钥**（不是商户证书）验签 → APIv3 密钥 AES-256-GCM 解密 resource.ciphertext → 校金额 → 应答 200 `{code:SUCCESS}`，否则衰减重试 |
| 5 | 商户号申请材料 | <https://pay.weixin.qq.com/static/applyment_guide/applyment_detail_public.shtml> | 营业执照+对公账户/法人账户+法人身份证；**个人自然人不能申请**；小微商户只能渠道商拓展码进件（线下为主） |
| 6 | 进件主体类型（平台收付通） | <https://pay.weixin.qq.com/doc/v3/partner/4012086921> | 企业/个体工商户/小微三档；小微 0.38%-0.6% |
| 7 | APPID 绑定授权 | <https://pay.weixin.qq.com/static/product/6g4g4c.shtml> ⚠️页面 id 待核实 | 商户平台 产品中心→账号关联 签授权协议 → 小程序后台确认；一个 mchid 可绑多 appid；openid 必须是下单 appid 名下 |

### B. 虚拟支付（数字内容合规通道）官方文档

| # | 标题 | URL | 要点 |
|---|------|-----|------|
| 8 | 虚拟支付：个人（2026-09 新开放） | <https://developers.weixin.qq.com/miniprogram/dev/platform-capabilities/business-capabilities/virtual-payment/person.html> | 个人主体+身份证+**「工具」类目**+认证备案；**月支付限额 10 万元**；费率 **Android 1% / iOS 12%**；开通约 5 分钟审核+扫码签约；记 AppID/OfferId/AppKey 三件套（AppKey 只进服务端）；`wx.requestVirtualPayment` mode=`short_series_goods`；paySig=HMAC-SHA256(AppKey)、signature=HMAC-SHA256(sessionKey) 双签名；发货推送 `xpay_goods_deliver_notify`（重试 15 次）+query_order 兜底（5 分钟轮询）；退款 Android 商户主动/iOS 用户找 App Store，180 天内连手续费退；结算 **Android T+3 / iOS 45-60 天**；发票次月 5 号后；**不支持信息发布平台、信息搜索查询等电信业务资质类服务** |
| 9 | iOS 端虚拟支付接入指引 | <https://developers.weixin.qq.com/miniprogram/dev/platform-capabilities/business-capabilities/virtual-payment/ios.html> | iOS 走苹果 IAP；单独申请+签《iOS 端虚拟支付服务协议》+配小程序简称+开通苹果 IAP；微信客户端 8.0.68+；与 Android 共用同一 API/签名体系，通道费率结算不同 |
| 10 | 虚拟支付技术服务费说明 | <https://developers.weixin.qq.com/miniprogram/dev/platform-capabilities/business-capabilities/virtual-payment/devplan.html> | 费率总说明页；企业档/合作计划档具体数字**待核实**（三方报道合作计划 15%） |
| 11 | 虚拟支付回调处理 | <https://developers.weixin.qq.com/miniprogram/dev/framework/virtual-payment/callback.html> ⚠️路径待核实 | XML 推送；wx_order_id 幂等；漏单 query_order 查补 |

### C. 云支付 / 云托管

| # | 标题 | URL | 要点 |
|---|------|-----|------|
| 12 | CloudPay.unifiedOrder（wx-server-sdk） | <https://developers.weixin.qq.com/miniprogram/dev/wxcloud/reference-sdk-api/wx-server-sdk/CloudPay/CloudPay.unifiedOrder.html> | 云函数内 `cloud.cloudPay.unifiedOrder()` 免证书免签名；**回调直接推送指定云函数**（functionName 参数），不走向商户 notify_url；前提仍是先绑定商户号（控制台→设置→全局设置→微信支付→添加商户号，超管授权） |
| 13 | 云托管支付示例（uniPay） | <https://github.com/TCloudBase/wxcloudrun-pay-nodejs> | 服务商模式实质：商户号授权给小程序→得**子商户号**；要求已认证**非个人**小程序 |
| 14 | 云函数+云调用四步收款（腾讯云实践） | <https://cloud.tencent.com/developer/article/1790513> ⚠️文章 id 待核实 | 轻量团队无服务器方案；小微在线开通入口已调整/迁移云托管（**待核实**） |

### D. 主体与类目

| # | 标题 | URL | 要点 |
|---|------|-----|------|
| 15 | 小程序服务类目大表 | <https://developers.weixin.qq.com/miniprogram/product/material/> | **商业资讯-研报**：企业/个体+CPN 增值电信许可；**财经类专业评论**：有资质要求；**出版物（电子出版物等）**：网络出版服务许可+出版物经营许可；**数字内容基础服务/付费内容供应**：ICP 许可/备案；**个人主体仅约 4 类可选（旅游/工具/体育/教育服务）——无任何内容阅读类目** |

### E. SDK 生态（GitHub API 2026-09-27 实测）

| # | 仓库 | 语言 | Stars | 维护 | v3+回调验签 |
|---|------|------|------:|------|------|
| 16 | [wechatpay-apiv3/wechatpay-java](https://github.com/wechatpay-apiv3/wechatpay-java) | Java | 1546 | 官方，push 2025-04 | 支持（证书/公钥自动轮换） |
| 17 | [wechatpay-apiv3/wechatpay-go](https://github.com/wechatpay-apiv3/wechatpay-go) | Go | 1284 | 官方，push 2025-07 | 支持（downloader 自动轮换） |
| 18 | [klover2/wechatpay-node-v3-ts](https://github.com/klover2/wechatpay-node-v3-ts) | TS | 772 | 活跃 | 支持（npm wechatpay-node-v3；**官方无 Node SDK**） |
| 19 | [minibear2021/wechatpayv3](https://github.com/minibear2021/wechatpayv3) | Python | 1338 | 活跃（2026-09） | 支持（验签+解密+证书更新） |
| 20 | [wechatpy/wechatpy](https://github.com/wechatpy/wechatpy) | Python | 4307 | 活跃（2026-05） | 支付以 v2 为主，v3 需补（原 offu 组织已迁移） |
| 21 | [w7corp/easywechat](https://github.com/w7corp/easywechat) | PHP | 10366 | 活跃（2026-08） | 支持（原 w7-group 组织） |
| 22 | [yansongda/pay](https://github.com/yansongda/pay) | PHP | 5371 | 活跃（2026-09） | 支持；聚合微信+支付宝，多商户配置 |

### F. 政策与新闻

| # | 标题 | URL | 要点 |
|---|------|-----|------|
| 23 | 2018 公众号 iOS 虚拟支付限制公告（转载） | <https://maimai.cn/article/detail?fid=1331576093&efid=2VLwpOctdMS4ktMVa_WnpA> | iOS 虚拟支付七年封禁起点；官方原文在 mp.weixin.qq.com 难检索（**原文 URL 待核实**） |
| 24 | 苹果小程序合作伙伴计划/腾讯 15% 协议 | <https://i.ifeng.com/c/8sY3qQFj1vK> | 2025-11 达成协议，iOS 端开放虚拟支付；抽成 30%→15% |
| 25 | 个人开发者虚拟支付「先别喊零门槛」 | <https://segmentfault.com/a/1320000046840000> ⚠️原文 URL 待核实 | 虚拟支付≠免备案/类目/内容资质/算法备案；个人档实际门槛仍高 |

### G. 费率速查

| # | 标题 | URL | 数字 |
|---|------|-----|------|
| 26 | 优惠费率活动对照表 | <https://pay.weixin.qq.com/doc/v3/merchant/4012076387> | 标准费率 **0.6%**（多数行业）；优惠活动 **0.2%-0.6%**；跨境二级商户 0.4% |
| 27 | 小微商户介绍 | <https://pay.weixin.qq.com/core/affiliate/micro_intro> | 小微费率枚举 **0.38%-0.6%**；仅渠道商进件 |

---

## 二、微信支付接入路线图（三条路线对比）

| 维度 | 路线 A：标准商户号 JSAPI v3 | 路线 B：云开发 CloudPay / 云托管 uniPay | 路线 C：小程序虚拟支付 |
|------|------|------|------|
| **定位** | 实物商品/服务收款，能力最全 | A 的免运维封装（免签名免证书，回调进云函数） | 小程序内**数字内容唯一合规通道** |
| **主体门槛** | 企业/个体工商户（营业执照+对公账户）；个人不可 | 同 A（云托管 uniPay 明确要求已认证非个人小程序，服务商模式给子商户号） | **个人主体 2026-09 起可开**（身份证+「工具」类目+认证备案，月限 10 万）；企业/个体主体费率更优 |
| **核心链路** | 后端 `/v3/pay/transactions/jsapi` → prepay_id → wx.requestPayment(五参数) → notify 验签解密 → 发货 | 云函数 `cloud.cloudPay.unifiedOrder` → 回调直接进指定云函数 | 服务端双签名 → `wx.requestVirtualPayment`(short_series_goods) → `xpay_goods_deliver_notify` 发货推送 + query_order 兜底 |
| **密钥体系** | APIv3 密钥(32位,回调解密)+商户证书私钥(请求签名)+平台证书/微信支付公钥(回调查验签) | 平台托管，开发者不接触证书 | AppKey(服务端 HMAC)+sessionKey+OfferId |
| **费率** | 约 0.6%（优惠 0.2%-0.6%） | 同 A + 云资源费 | Android **1%**；iOS **12%**（个人档；合作计划 15% 档为企业） |
| **结算** | T+1 起结算（**待核实**具体行业档） | 同 A | Android T+3；iOS 45-60 天（苹果账期） |
| **卖研报（数字内容）合规性** | ❌ 违规：iOS 明令禁止，安卓要求虚拟支付类目；外链 H5 支付属规避行为会被处置 | ❌ 同 A（通道同源） | ✅ 正道（iOS 需单独申请开通+IAP） |
| **适配场景** | 电商/服务/打赏实物交付 | 无服务器轻量团队收实物款 | 内容付费/会员/道具/解锁——**试点场景唯一选择** |

## 三、试点研报付费阅读（前 20 页免费+付费解锁全文/下载）合规推荐路径

**判定：研报付费解锁=小程序内虚拟商品交付 → 必须走路线 C（虚拟支付）。** 用 JSAPI 商户号卖数字内容= iOS 端违规+安卓端类目违规；引导用户去外部 H5 页支付是微信明令打击的规避行为（下架支付能力乃至封禁小程序风险），2025-11 之后已无必要冒险。

**推荐分两步走：**

1. **MVP 验证期（最快上线，个人主体）**
   - 个人主体小程序 + 「工具」类目 + 完成认证(300元/年)与备案 → 开通虚拟支付（个人档，审核约 5 分钟，扫码签约）
   - 费率 Android 1% / iOS 12%；**月支付限额 10 万元**（验证期足够）；结算 Android T+3、iOS 45-60 天
   - 产品形态注意：个人档**不支持「信息发布平台、信息搜索查询」等电信业务资质类服务**——产品应定位为「付费解锁阅读/下载的文档工具」，研报以文件（PDF）交付，不做 UGC/站内检索平台，降低被认定为信息服务平台的风险
   - iOS 端需额外：配置小程序简称 + 开通苹果 IAP + 微信客户端 8.0.68+；用户退款走 App Store
2. **正式运营期（规模化，企业/个体工商户主体）**
   - 注册个体工商户/公司 → 小程序主体变更为企业 → 选「商业资讯-研报」类目（需 CPN 增值电信许可）或「财经类专业评论」（有资质要求）；若研报以连续出版物形态发行，需《网络出版服务许可》+《出版物经营许可》（一般单篇研究文档不构成出版物，按数字内容处理即可，**边界个案建议咨询**）
   - 开通虚拟支付企业档（费率优于个人档，数字以 devplan 页为准）；月营收超 10 万后个人档强制升级
   - 若同站需要卖实物周边/咨询服务，再叠加标准商户号 JSAPI（0.6%）双通道

**工程要点（对应安全清单）：**
- 服务端：AppKey/APIv3 密钥/商户私钥只进服务端环境变量；发货以官方推送为准并幂等（wx_order_id / out_tradeNo）；金额以服务端下单为准、回调后复核；query_order/查单接口定时兜底（建议 5 分钟）
- 前端：wx.requestPayment 的五参数全部后端生成下发；success 回调≠支付成功，UI 解锁必须等服务端确认
- 回调（若走路线 A）：验签用平台证书/微信支付公钥（不是商户证书），timestamp 防重放，金额校验后才发货，应答失败会重试需幂等

## 四、待核实清单（诚实标注）

1. 云开发控制台「小微商户在线开通」入口现状（历史存在，近年向云托管 uniPay 迁移）——需登录控制台实测
2. 虚拟支付企业档/合作计划档的官方费率具体数字（devplan 页未抓到全文；三方报道 15%）
3. 标准商户号结算周期（常见 T+1，行业/银行差异）官方口径页
4. 2018 公告与 segmentfault 分析文的原文精确 URL（结论已多源互证）
5. 回调通知官方章节、APPID 绑定帮助页的精确 doc id（机制流程已多源官方佐证）

## 五、最大的坑

**iOS/Android 双轨费率与账期差**：同一份研报，安卓用户付 100 元你拿 99（1% 技术服务费，T+3 结算），iOS 用户付 100 元你只拿 88（12% Apple 佣金，45-60 天才结算）——若不单独开通 iOS 虚拟支付，iOS 用户直接付不了款（占微信小程序用户约 1/4-1/3，**比例待核实**）；而用「iOS 隐藏入口/外链支付」规避是 2018 年以来微信明令打击的违规行为，代价是支付能力下架或封小程序。次坑：个人主体类目只给「工具」，内容类目个人根本选不了——这就是「零门槛」宣传的真实门槛。
