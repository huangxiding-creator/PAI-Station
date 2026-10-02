# 引擎惯例（engine_conventions）

> 浓缩自：AI_NATIVE_OPTIONS.md、FEASIBILITY_REPORT.md 1.1/第四节、PROPOSAL.md 十一/假设7-8
> 实读补充：WeAppForge/projects/zongbao/config/index.ts、utils/pay.ts、utils/store（四页脚手架在役代码）
> 用途：xueyuan-engine（新端口 8871）从 qianwen-engine 换装的全部惯例与差异点。所有断言可溯源。

## 1. 总纲：抄骨架不新起炉灶

- 选型：xueyuan-engine = **抄 qianwen-engine 骨架**，Bearer token/异步/幂等/pay_sign 双签名全在役，同构度>80%。（源：AI_NATIVE_OPTIONS #7）
- 在役证据：qianwen-engine（总包AI顾问）已在 ECS 47.120.43.20:8869 systemd active，pay_sign 公网 401@78ms；签名单测 5 向量 PASS。（源：FEASIBILITY 1.1，引 WFR #42/#45）
- xueyuan-engine 差异三件：换 appid/appsecret（总包学园 wxfdb55b184756e89e）+ 新端口 **8871** + 独立 secret 文件。（源：FEASIBILITY 1.1｜PROPOSAL 假设7）

## 2. 服务层技术栈与惯例（qianwen-engine 在役约定）

| 惯例 | 内容 | 在役证据 |
|---|---|---|
| 框架 | FastAPI（异步） | FEASIBILITY 1.1 表第一行「FastAPI/Bearer/异步」 |
| 认证 | **Bearer token**（静态 token 鉴权，客户端 header 携带） | 同上；公网探针 401@78ms（未带 token 被拒） |
| 异步 | 全链异步（async 端点，AI 生成不阻塞） | 同上 |
| 幂等 | 订单/支付回执幂等：同 outTradeNo 重复请求返回幂等 200；已解锁资源再购买返回 409 | harness D 场景实测（已解锁 409/幂等 200，WFR #41/#43） |
| pay_sign 双签名 | 服务端持有 appsecret 生成虚拟支付所需签名（paySig/signature），签名腿独立端点+单测 5 向量 | WFR #42/#45 |
| pay_log 对账 | 每笔支付落 pay_log 表逐单核对（biaoxun 同款已建成） | RISK R-12｜PROPOSAL 十一（对账表逐单核对） |
| 503 降级 | offerId/secret 缺失时支付腿 503：试读可用、支付灰置，不阻塞开发/提审 | harness D 场景已验证（WFR #43） |

## 3. 支付腿惯例（客户端封装实读，zongbao utils/pay.ts）

- 唯一合规通道：wx.requestVirtualPayment（虚拟支付），数字内容不走 JSAPI。（源：utils/pay.ts 文件头注释｜deep_pay Q1）
- **未开通优雅降级**：`features.virtualPay === false` 或 `wx.requestVirtualPayment` 不存在 → 返回 `{ok:false, message:'支付通道开通中，敬请期待。试读章节持续免费开放。'}`，**不抛错**。（源码实读）
- 请求体关键参数（组装后交服务端签名）：
  - `env: 0`（0=正式环境，1=沙箱）
  - `currencyType: 'CNY'`、`platform: 'android'`、`buyQuantity: 1`
  - `mode: 'short_series_goods'`（道具直购）
  - `orderId/outTradeNo`: `${reportId}_${Date.now()}`（**幂等键**；具体解锁哪份报告由 outTradeNo 绑定，一个通用道具够用——源：WIZARD 设计说明）
  - `goodsPrice`: 价格（分）
  - `paySig`/`signature`: 空串占位，**由服务端签名后下发**（协议要求；本地不持密钥）
- 成功回调：本地先解锁（unlockLocal）+云端订单幂等对账由服务端负责（发货兜底）；失败回调区分 cancel（「已取消支付」）与其他（「支付未完成，请稍后重试」）。（源码实读）

## 3b. 客户端 store 惯例（utils/store.ts 实读）

- **目录装载**：`loadCatalog()` 内存缓存 catalog.json，require 失败降级空目录并 console.error，不崩；`getReport(id)` 按短 ID 查找。
- **本地权益缓存**：`getEntitlements()/isUnlocked(reportId)/unlockLocal(reportId)`——wx storage 键 `zongbao_entitlements` 存 reportId 数组，Set 去重追加；**云端发货为准，本地缓存只是支付成功回调的先行动作**（文件头注释：「本地缓存；云开发开通后切云数据库」）。
- `trialChapterCount()` 从 appConfig 读试读章数（=2）——试读边界是配置不是硬编码。
- 启示给 xueyuan：entitlements 服务端表是判据真源（SCHEMAS §4），本地缓存只做离线体验；两者冲突时服务端赢。

## 3c. 四页脚手架改造映射（PROPOSAL 十一）

| zongbao 四页（tabBar） | xueyuan 改造为 |
|---|---|
| index | 商城首页（搜索/榜单/筛选/省份地图） |
| reader | 分章阅读器（md2blocks 渲染+试读/付费门） |
| ai | AI 伴读（P2；KB 直连链路换 appid） |
| me | 我的权益（ entitlements/书券/勋章/退款记录，P1） |

- 脚手架自带 store/pay/ai 三 utils 优雅降级惯例（FEASIBILITY 1.1 引 WFR #11）——三降级路径=配置开关+能力探测+兜底文案，新页面必须沿用同款降级写法。

## 4. featureFlags 三开关（配置中心惯例）

config/index.ts 实样——「后台能力开通一处翻转，代码零改动」：

| 开关 | 含义 | 默认 | 翻转时机 |
|---|---|---|---|
| `virtualPay` | 虚拟支付（wx.requestVirtualPayment） | false | offerId/secret 落位后置 true |
| `cloud` | 云开发（AI 对话/知识库/PDF 云存储） | false | 环境开通后置 true 并填 cloudEnvId |
| `voiceInput` | 同声传译插件（WechatSI） | false | 后台插件申请通过后置 true |

另有 `cloudEnvId: ''`（开通时填）与 `trialChapterCount: 2`（免费试读章节数）。（源：zongbao config/index.ts 实读；FEASIBILITY 1.1「三开关，开通即翻转零改码」）

## 5. 部署惯例（ECS 配方照抄）

- 同一 ECS 47.120.43.20，新端口 **8871**，双层墙配方照抄 8869 作业：ufw → 阿里云安全组（后者只能用户控制台开闸）。（源：PROPOSAL 假设7｜记忆 aliyun-ecs-deploy-runtime）
- 部署链：云助手分片（tar 分片+密钥+依赖）→ systemd（Restart=always 开机自启）→ 双层墙开闸 → 公网探针。从打包到公网 401@106ms 共约 12 分钟实测。（源：FEASIBILITY 1.1，WFR #32-34）
- ECS 单点兜底：本地实例暂留作回退；云助手 15 分钟内重部署；期间前端降级提示「服务维护」，试读缓存页可用。（源：R-07）
- secret 落位：`data/secrets/virtual_pay_xueyuan.secret`（offer_id/product_id/iOS 实际价三值）；填入→引擎重启即生效（插入点=WFR #45 同款）。（源：WIZARD 最后｜PROPOSAL 假设8）

## 6. xueyuan-engine 相对 qianwen-engine 的差异清单

| 维度 | qianwen-engine（8869，在役） | xueyuan-engine（8871，新建） |
|---|---|---|
| 小程序 | 总包AI顾问 biaoxun wx5cee1574ce45819b | 总包学园 wxfdb55b184756e89e |
| 业务 | AI 问答（KB 直连） | 研报商城（内容下发+权益+支付+归因+评分退款） |
| 道具 | 1 元解锁 | 49800 分「研报单篇解锁」通用道具 |
| secret | virtual_pay_biaoxun 口径 | data/secrets/virtual_pay_xueyuan.secret |
| 新增腿 | — | 内容按权益下发（entitlements 校验）、catalog/chapters 供给、poster 归因三表、criticisms 评分四层（P1）、refunds/vouchers（P1） |
| 保持不变 | Bearer/异步/幂等/pay_sign/pay_log/503 降级/健康探针 | 同左，全部照抄 |

（源：AI_NATIVE_OPTIONS #7｜FEASIBILITY 1.1/第四节｜PROPOSAL 十一）

## 6b. API 语义速查（幂等/冲突，harness D 场景实测口径）

| 场景 | 返回 | 语义 |
|---|---|---|
| 同 outTradeNo 首次支付成功 | 200 + 订单落库 | 正常路径 |
| 同 outTradeNo 重复回调/重放 | **200 幂等**（不重复发货） | 对账安全 |
| 已解锁报告再次发起支付 | **409 Conflict** | 冲突明确化，前端提示「已解锁」 |
| offerId/secret 缺失时调支付腿 | **503 降级**（试读可用/支付灰置） | 开通等待期形态 |
| 未带 Bearer token 探针 | **401**（毫秒级） | 活体判据 |

（源：FEASIBILITY 1.1 harness D 场景（已解锁 409/幂等 200）+探针惯例综合）

## 7. 回归与验收惯例

- harness 框架复用：26 断言含支付 D 场景（已解锁 409/幂等 200）——换断言集复用框架。（源：FEASIBILITY 1.1，WFR #41/#43）
- 上传链 forge.mjs 全链直接用零改造：L3 构建→L4 上传→L5 体验码；且首航目标 appid 就是总包学园 wxfdb55b184756e89e；企微推送体验码在役。（源：FEASIBILITY 1.1，WFR #9/#40/#44/#46）
- 公网判据：未带 token 探针=401（毫秒级）即为活体；401 慢/超时=故障。（源：FEASIBILITY 1.1 探针惯例）

## 8. P0 依赖图中的位置（调度惯例）

- 三线并行：A content_pipeline 批处理 ∥ B xueyuan-engine 换装+8871 部署 ∥ C 商城前端；F 支付腿等 offerId 与全部开发/提审重叠，503 降级保证不阻塞。（源：FEASIBILITY 第四节）
- 最长路径=前端→联调→提审→官方审核 1-7 天；我方开发+联调 2-3 个工作日（估算）。（源：FEASIBILITY 第四节）
- AI 伴读腿（P2）复用总包AI顾问的工程大脑 KB 直连链路——同 ECS 换 appid 配置。（源：PROPOSAL 4.5）

## 9. 代码纪律（项目全局）

- 静态 secret 一律 data/secrets/ 下落盘，代码/日志/仓库零硬编码（安全红线）。
- 引擎错误信息不泄漏内部细节；前端统一 PayResult `{ok, message}` 形态（utils/pay.ts 实样）。
- 幂等键=outTradeNo；一切支付侧写操作先查幂等再执行（409 vs 200 语义见第 2 节）。
- 命名沿用：报告=reportId、订单=outTradeNo、价格=分（priceFen/goodsPrice）。
