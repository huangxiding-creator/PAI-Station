# BUSINESS MODEL: 总包学园 · 研报商城

## Pricing model
- **Model**: one_time（单篇买断·虚拟支付道具直购）+ 书券内循环；远期叠加 subscription（年度会员，官方准入 DAU≥1万+上线90天后）
- **Recommended price**: **¥498**（用户钦定，与实锤竞品锚的取向说明见下）
- **Bands (from 1 competitors)**: p25/median/p75 全为 **1888**（唯一核实单篇深度研报价：发现报告研选 ¥1888/300页，cred 0.7；慧博计时制/镝数聚会员制/盐选订阅制不属单篇带，不混入）
- **Rationale**: pricing.py(premium, n=1) 表明专业带上限支撑力到 ¥1888；**¥498=锚价的 26%，是主动选择的渗透价**——垂直无竞品（定价权在我）+ 高毛利结构（内容成本已沉没）允许低锚入场抢心智；「同等深度 1/4 价格」是详情页核心话术。

## Tiers
| Tier | Price | Limits | Target |
|---|---|---|---|
| 试读 | ¥0 | 前20页在线阅读（≈20%行业舒适带） | 所有访客（免登录可读，扫码即读） |
| 单篇买断 | ¥498 | 全文在线阅读+双PDF下载+水印版转赠1次+AI伴读 | 投标商务/经营人员（核心persona） |
| 组队价 | ¥998/3人 | 全队各得一份阅读权 | 部门/项目组小团队 |
| 书券 | 非卖品 | 邀请/批评/iOS补偿获得，1书券=1元抵扣 | 内循环锁客（合规：非现金非分销） |
| （远期）年度会员 | 待定价 | 全库阅读 | 需官方准入门槛解除后 |

## Acquisition
- **Primary channel**: 情报卡海报裂变（scene 归因+邀请解锁+组队），CAC 目标 ≈¥5（估算，服务端边际成本）
- **Content/SEO lever**: 每份报告=一个长尾关键词落地页（「XX省水网商机研究」），持续自然流量
- **Distribution wedge**: 点赞必得赠报告（边际成本0）+ 20页免费试读 = 先给后取

## Compliance cost estimate
- 支付合规：虚拟支付独立商户号（Android 类目费率 1%~10% 以签约协议为准；iOS Apple 通道 12%）；退款 UI 入口+24h 投诉处理+支付前明示不可无理由退款 = 官方义务（deep_pay Q4）
- 促销合规：点赞必得=附条件赠送（无概率公示义务）；批评退款规则事前进协议（承诺即合同）；不碰砍价/返现/多级分销/强制分享
- GDPR/等保：不适用（无出境数据）；内容免责声明（行业研究非投资建议）
- Net: 合规成本≈一次性签约流程+条款文案，无持续硬成本

## Billing implementation
- Provider: **wx.requestVirtualPayment（mode=short_series_goods 道具直购）**——pay_sig/签名双腿服务端签名已建成（biaoxun pay_sign 端点换 appid 配置即用）
- 退款：Android = 虚拟支付 refund_order API（180天内退手续费；**部分退款参数级语义开通后实测，书券兜底**）；iOS = 苹果通道+等额书券补偿双轨
- Webhook/对账：pay_log 对账表（已在 biaoxun 建成同款）+ 退款率日报企微推送
- Tracking fields（埋点）: scene(r,i)/share_event/invite_relation 首触归因 + 漏斗（曝光→扫码10%→带新9%基线）+ 试读转化点

## Unit economics (best estimate)
- COGS per 单：≈¥0（报告成本已沉没于 EPC100 产线；交付=带宽+PDF存储，40份358MB≈忽略）
- 渠道费：Android 1%~10%（签约实证前按 5% 中位预估）；iOS 12%
- Gross margin：Android ≈88-95%，iOS ≈85%（双端同价我方吸收差价）
- 退款预留：按 Steam 基线上浮 15% 计提（熔断线 25%）
- Break-even：无新增固定成本（ECS 复用）→ **首单即回正**

## Open assumptions
- 主体=企业/个体户（个人主体不可行，批准门确认）
- 虚拟支付类目（教育/知识付费）核验通过 + offer_id/product_id 开通
- 道具直购「部分退款」语义须开通后实测（书券兜底方案已备）
- 需求量级为间接证据（垂直无竞品+价格带），首月真实转化率是 P0 验收判据
