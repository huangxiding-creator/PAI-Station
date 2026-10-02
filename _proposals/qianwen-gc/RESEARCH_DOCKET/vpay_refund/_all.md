# vpay_refund 调研卷宗：微信小程序虚拟支付——合规与退款能力（总包千问·1元解锁单条回复）

- 检索日期：2026-09-28 ｜ 条目：18（官方文档13 / 论坛3 / 新闻2）｜ 机器可读版：`_all.json`
- 方法：官方文档逐页 curl 抓取原文（developers.weixin.qq.com / pay.weixin.qq.com / wxcloudservice），新闻与论坛交叉检索佐证。**无捏造**：所有数字均出自下列来源原文；答不出的标 UNKNOWN。

---

## 六问必答（结论先行）

### Q1 虚拟支付 1 元档位：short_series_goods 等模式的具体参数、最小金额限制

**模式枚举**（`wx.requestVirtualPayment` 客户端 API，基础库 2.19.2+，底层为腾讯米大师计费）：
- `short_series_goods` = **道具直购**（1元解锁单条回复的对应模式）
- `short_series_coin` = 代币充值
- 另有会员订阅体系（安卓/鸿蒙 vips、iOS vip，自动续费制，与按次解锁无关）

**signData 必填参数**（道具直购）：
| 参数 | 说明 |
|---|---|
| offerId | 虚拟支付商户号（MP后台-虚拟支付-基本配置） |
| mode | 固定 `short_series_goods`（**个人主体文档明确：个人只做道具直购，不引入代币**） |
| productId | 道具ID（MP后台道具管理创建并发布） |
| goodsPrice | 道具单价，**单位分**，须与后台道具价格一致（不一致报 -15013） |
| buyQuantity | 购买数量 |
| currencyType | 固定 CNY |
| outTradeNo | 业务单号，8-32字符，唯一，不能下划线开头 |
| attach | 透传数据（发货推送原样回传） |
| env | 0 现网 / 1 沙箱 |
| paySig / signature | 支付签名（AppKey HMAC-SHA256）/ 用户态签名（sessionKey HMAC-SHA256） |
| activitySellingPrice | 可选优惠价（分），须与 goodsPrice 同传，传后即实际下单价——可做"批评补偿券"低价下单 |

**最小金额限制**：
- **道具定价**：`start_upload_goods` 仅要求 `price` 单位分且 **>0**——Android 端无最低档位，1 分也可定价（官方文档）。
- **iOS 端（Apple 支付）**：官方明确"**最低支付金额为 1 元**"，且需 iOS 15+、微信 8.0.68+、中国大陆 App Store 账户。
- 结论：**1 元（100分）档位在两端均合法且正好踩在 iOS 下限上**。第三方（迅课等）流传"最低1元、低于1元按1元收"的说法仅针对代币/充值场景，道具直购以官方">0分"为准。

### Q2 退款 API 是否存在（产品核心机制"批评按比例退款"的合规性关键）

**存在，且支持部分退款（Android 端）**：
- **API：`/xpay/refund_order`（接口英文名 refund_order，"启动订单退款任务"）**，仅服务器端调用，POST `https://api.weixin.qq.com/xpay/refund_order?access_token=&pay_sig=`。iOS 端 Apple 支付订单**不可用**（见 Q4）。
- **条件**：支付时间 **365 天内**可退；**180 天内退款平台退还手续费，超 180 天不退手续费**；异步任务——启动后须轮询 `query_order` 至"退款完成"。
- **部分退款**：请求体 `refund_fee` 需 **(0, left_fee]**，单位**分**；`left_fee` = 该单剩余可退金额（`query_order` 实时返回）。→ **1元订单可按任意比例退（如批评扣分退 30 分/50 分）**。多方实证：掘金第三方工具截图"输入退款金额（≤剩余可退金额）+选退款原因+退款来源"即完成退款。
- **必填枚举**：`refund_reason`：0暂无描述/1产品问题/2售后问题/**3意愿问题-用户主动退款**/4价格问题/5其他；`req_from`：1人工客服退款/2用户自己发起/3其它。"批评退款"可映射 1（产品问题）或 3（用户主动）。
- **关键错误码**：268490005 已被 cancel_currency_pay 退过不可再退；268490013 **核销状态订单禁退**；268490014 退款进行中可同参数重试；268490015 **频率限制**（批量退款须节流）；268490016 left_fee 与实际不符。
- **退款完成推送**：`xpay_refund_notify`（含 RefundFee/RetCode/WxRefundId）。
- **代币退款**：`/xpay/cancel_currency_pay`（currency_pay 逆操作，退代币回余额，非现金）。
- **MP后台人工退款**：【虚拟支付→交易订单】可直接退款（个人主体文档明示）。
- **投诉联动退款**：`/xpay/get_complaint_list` 等 7 个投诉接口 + `xpay_complaint_notify` 推送；第三方工具实测"收投诉自动退款并自动完结投诉单"。

**iOS 端致命限制与合规替代方案**：
- 官方原文："**Apple 支付不支持开发者主动向用户发起退款**"。用户只能在 App Store 申请，Apple 连续发起 **3 次退款问询、开发者须 3 秒内应答**（result_code 0=建议退款/1=拒绝 + evidence 必填），最终由 Apple 裁决；官方建议**对 iOS 订单隐藏退款按钮**，改为文案引导用户去 App Store。
- → "批评按比例退款"机制设计：**Android/鸿蒙/Windows 用 refund_order 按比例真金退（合法合规，官方接口）；iOS 用合规替代**：①补偿次数（补发"解锁券"道具，免费）②阶梯补偿（多次批评累积兑换会员/批量解锁）③全额退款引导（用户 App Store 申请，开发者退款问询应答 0 放行）。**跨端体验不一致是平台规则决定的硬约束，须在产品层明示**。

### Q3 主体档位：个人 vs 企业区别；2026-09 个人主体新政策

| 维度 | 个人主体（2026-09 新开放） | 企业/事业单位/个体工商户 |
|---|---|---|
| 资质 | 居民身份证，无需营业执照 | 营业执照 + 提现账户 + 支付管理员 |
| 类目 | 服务类目须含**「工具」** | 覆盖运营指南 7 形态（文娱/教育/社交/工具等，微短剧单独费率档） |
| 审核 | 一般 **5 分钟内**，扫码签约 | 1-7 个工作日 + 账户验证 + 扫码签约 |
| **限额** | **全终端月支付限额 10 万元** | 无月限文档约束 |
| 费率(Android) | **1%**（腾讯技术服务费） | 工具/社交/深度合成/文娱非微短剧：标准 10%，**当前生效 1%**；微短剧非视频号挂载 5% |
| 费率(iOS) | **12%**（Apple 佣金） | 同左：标准 17%（含12% Apple佣金），**当前生效 12%**（全部为 Apple 佣金，腾讯不另收） |
| 模式 | 只做道具直购（mode 固定 short_series_goods） | 道具/代币/订阅均可 |
| 排除项 | 不支持需电信业务资质的服务（电子邮件、语音信箱、储存转发、**信息发布平台、信息搜索查询**等） | 按类目资质要求 |

- 2026-09 政策细节（官方 person.html + 多方报道交叉证实）：个人主体虚拟支付 2026 年 9 月正式落地；官方甚至提供了 Agent 自动接入三方式（云开发/提示词/SKILL，skillhub.cn 的 `miniprogram-virtualpay-person`）。
- 结算与发票（两端一致）：Android **T+3**（资金冻结 3 日后分账）；iOS **45-60 天**；腾讯技术服务费发票次月 5 号后申请。
- ⚠️ 注意"1%"是**当前生效费率**（标准费率 10% 的优惠期），产品财务模型须按费率可能回升 10% 做压力测试；`query_order` 返回 `platform_fee_fen` 可逐单核对实际扣费。

### Q4 iOS 虚拟支付现状

- **已可用**（2025-11-13 苹果腾讯协议破冰，Bloomberg/新浪/凤凰/IT之家多方证实；2025-11-14 微信官方公告 iOS 支持虚拟支付）。
- 抽成：协议公布期口径 Apple 15%（"小程序合作伙伴计划"，常规30%降至15%）；**2026 年当前官方技术服务费文档口径：当前生效 12%，全部为 Apple 佣金**（标准费率 17% 含 12% Apple 佣金）——以官方文档 12% 为准。
- 回款周期：Apple 自然月结束后 **45-60 天**结算给腾讯，腾讯收到后划转开发者虚拟支付账户，到账可提现。
- 条件：iOS 15+、微信 8.0.68+、大陆 App Store 账户、最低支付 1 元、小程序须配置**小程序简称**（Apple display name）并开通 IAP；**Apple 支付无沙箱环境仅现网**。
- 退款：开发者不可主动退（详见 Q2）；iOS 退款问询 3 次×3 秒机制，超时应答=放弃话语权。

### Q5 微信支付商户号标准退款 API（普通商户）能否用于虚拟支付订单退款

**不能（官方未文档化支持；判定不可用）**。
- 标准退款 API `POST /v3/refund/domestic/refunds`（普通商户，365 天内、全部/部分退款、一单最多 50 次部分退款、150QPS）适用于普通商户直连下单的 JSAPI/小程序支付等订单。有个有趣细节：**订单退款金额 ≤1 元且为部分退款时，退款原因不在消息中展示**。
- 虚拟支付开通的是"**一个新的微信支付商户号**"（二级商户号），订单走**米大师/xpay 体系**：服务端签名是 `access_token + pay_sig`（HMAC-SHA256 AppKey），而非普通商户 API 证书/微信支付公钥体系；发货、查单、退款、提现全部走 `/xpay/*` 接口族或 MP 后台。
- 官方虚拟支付文档中，现金单退款唯一文档化路径 = `/xpay/refund_order`（+MP后台交易订单退款）；**没有任何官方文档说明 v3 退款 API 可退 xpay 订单**。云开发官方指南亦将"虚拟支付退款"（xpay 回调云函数 + refund_order）与"微信支付退款工作流"（v3 模板）列为两条独立通道。
- 结论：虚拟支付订单退款**必须走 /xpay/refund_order**；标准商户号退款 API 只管你自己普通商户号下的普通支付订单。

### Q6 风控红线（会被封/被处置的行为）

官方运营指南 + 文档错误码 + 社区实操交叉：
1. **外链规避（最高红线）**：原文"购买和支付均需接入小程序虚拟支付；**不得引导至 app、公众号、h5、个人号、网站完成支付**"。H5 收款、客服引导外部支付、公众号扫码付都是封禁级违规。
2. **应接未接**：7 类典型虚拟形态（含形态七"AI 生成/效率工具"——**总包千问属此形态，须全终端接入虚拟支付**）若不接入，平台**直接关闭安卓及非 iOS 端普通微信支付能力**。
3. **混合交易不拆分**：虚拟+实物混合订单（如 AI 服务赠实物）被认定虚拟支付，须拆两笔交易。
4. **类目不符**：个人主体做"信息发布平台/信息搜索查询"等需电信资质的服务=超范围。
5. **处罚链实证**：客户端错误码 -4 风控拦截、-15017 商家涉嫌违规收款功能被限制、-15019 商户受限、-15021 小程序被限频交易；微信支付风控推送 `xpay_wxpay_callback_notify`（due_diligence 尽职调查/punishment 管控流水）；社区实证投诉处理不及时会被"**调整结算周期、关闭自动提现**"，申诉约一周；`/xpay/query_punishment_reasons` 可查被管控原因与解脱路径。
6. **道具合规**：道具/代币名称须符合法律法规（敏感内容 268490007 禁止）；价格展示与实付不一致（goodsPrice 校验失败）易引发投诉。
7. **推送响应**：回调响应格式错误会重试 15 次；iOS 退款问询 3 秒超时 3 次即失去话语权。
8. **豁免区**：合法资质的线上问诊、持照律师法律咨询不属虚拟支付管控（不属于本产品场景）。

---

## 文档清单（18条）

### 官方文档（credibility 0.9）
1. **虚拟支付：企业、个体户（主文档）** — developers.weixin.qq.com/miniprogram/dev/platform-capabilities/business-capabilities/virtual-payment.html
   开通条件/二级商户号/T+3与iOS 45-60天结算/180天手续费规则/全量服务器API表/7类消息推送/iOS退款问询机制/签名算法。
2. **虚拟支付：个人** — .../virtual-payment/person.html
   个人主体三接入方式/月限10万/工具类目/Android 1%+iOS 12%/审核5分钟/mode固定short_series_goods/退款结算对照表/Agent检查清单。
3. **启动订单退款任务 refund_order** — .../server/API/VirtualPayment/api_refund_order.html
   365天窗口/180天手续费/refund_fee∈(0,left_fee]部分退款/全部请求返回参数/6个退款专属错误码/异步任务语义。
4. **代币支付退款 cancel_currency_pay** — .../api_cancel_currency_pay.html
   currency_pay逆操作/退代币非现金/双签名/amount参数。
5. **查询创建的订单 query_order** — .../api_query_order.html
   left_fee剩余可退/退款状态枚举5/7/8/order_type含普通退款与苹果iOS退款/platform_fee_fen逐单技术服务费。
6. **wx.requestVirtualPayment 客户端API** — .../api/payment/wx.requestVirtualPayment.html
   mode枚举/signData全参数/activitySellingPrice优惠价/21个错误码含风控拦截。
7. **批量上传道具 start_upload_goods** — .../api_start_upload_goods.html
   price单位分>0（Android无最低档）/道具id与名称长度/发布延迟同步。
8. **技术服务费（费率总表）** — .../virtual-payment/devplan.html
   工具/社交/深度合成/文娱非微短剧：Android标准10%当前1%、订阅首笔1%第二笔起10%；iOS标准17%（含12% Apple）当前12%；微短剧Android 5%（非视频号挂载）。
9. **虚拟支付业务运营指南** — developers.weixin.qq.com/community/minihome/doc/00002cf077cd4810fee42f4b865c01
   不得引导外部支付红线/7典型形态（形态七含AI生成工具）/管控关闭普通支付/混合拆分/问诊与法律咨询豁免。
10. **微信支付v3申请退款（普通商户）** — pay.weixin.qq.com/doc/v3/merchant/4013071036
   /v3/refund/domestic/refunds/365天/50次部分退款/150QPS/≤1元部分退款不展示原因；适用普通商户直连订单。
11. **使用AI工具快速接入小程序虚拟支付（云开发官方）** — .../wxcloud/guide/wechatpay/ai-virtualpayl-person
   全链路闭环/7类回调清单/沙箱PAYMENT_ILLEGAL_IN_SANDBOX坑/退款结算费率汇总/iOS隐藏退款按钮官方建议。
12. **工作流实现微信支付退款场景（云开发）** — .../wechatpay/refund.html
   标准微信支付退款工作流模板；与xpay虚拟支付退款为两条独立通道的对照证据。
13. **小程序虚拟支付回调处理（云开发）** — .../wechatpay/virtual-payment-callback.html
   iOS退款问询3次×3秒/超时回"不确定"交Apple/退款问询专属字段/云函数switch分发范式。

### 论坛（credibility 0.6）
14. **掘金：虚拟支付自动处理投诉与自动退款（悟空码字，2026-07-18）** — juejin.cn/post/7663374871138058276
   第三方工具实测：投诉单退款界面可见订单金额/实付/剩余可退，输入退款金额即退；投诉超时处罚=调整结算周期/关闭自动提现。
15. **微信开放社区：refund_order 报错提问** — developers.weixin.qq.com/community/develop/doc/000000caa5c5f059c2c4678a166400
   left_fee=300已确认仍报错的实操坑；排障须以query_order实时值为准。
16. **uni-app uni.requestVirtualPayment** — uniapp.dcloud.net.cn/api/plugins/virtualPayment.html
   第三方跨端封装对照：米大师体系/短剧类目历史起源/mode枚举一致。

### 新闻（credibility 0.6）
17. **Bloomberg: Apple, Tencent Agree to 15% Cut（2025-11-13）** — bloomberg.com/news/articles/2025-11-13/apple-and-tencent-agree-to-15-fee-on-wechat-mini-game-purchases
   苹果腾讯15%协议破冰；2026官方文档当前口径12%全为Apple佣金（口径演变须双记）。
18. **火炬树/知乎/掘金个人开放报道群（2026-09）** — torchtree.com 等
   个人主体虚拟支付2026-09落地多方独立佐证，与官方person.html完全一致。

---

## 对「总包千问」的直接产品结论

1. **1元解锁单条回复**：道具直购（short_series_goods）+ goodsPrice=100分，两端合法，iOS 正好压线最低1元；建议道具命名"单次解锁券"，支持 buyQuantity 批量购。
2. **批评按比例退款**：Android 全端可自动化——收 xpay 回调 → 判定批评成立 → query_order 查 left_fee → refund_order 按比例退（refund_reason=1产品问题，req_from=3其它）→ 收 xpay_refund_notify 回收权益。**iOS 不可主动退款**，须做补偿次数/阶梯补偿/引导 App Store 三选一的替代路径，并在产品内明示双端差异。退款有频率限制（268490015），批量退款需队列节流。
3. **主体选择**：若用户为个人主体：工具类目+月限10万（1元/单≈月3万单上限，够试点）；企业主体无月限且类目更宽。当前 Android 1% 费率是优惠期（标准10%），iOS 12% 且回款 45-60 天——现金流模型按此压测。
4. **绝对不做**：H5/公众号/个人号/外部站点收款引导（封禁级）；价格展示与实付不一致；投诉单置之不理（结算周期/自动提现会被处罚）。
