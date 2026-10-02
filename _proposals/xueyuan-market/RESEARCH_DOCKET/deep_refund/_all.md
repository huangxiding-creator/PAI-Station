# 深研：按反馈质量退款 + 点赞随机赠报告（deep_refund）

调研日期：2026-09-28｜调研员：机制调研员（refund/gift专项）
机制描述：用户提交对研报的批评 → AI评"真诚度/真实度"0-100% → 按分退50%~100%；辅助机制"点赞随机赠报告"。
信源分级：政府官网/官方文档 > 学术研究(摘要页) > 主流媒体 > 行业分析。高风险域名零访问。标注 degraded 的为不可达但多源印证的条目。

---

## 问题1：先例——数字内容无条件退款/满意再付的滥用率 + 退款政策作为信任营销

### 1.1 海外数字内容退款基线（滥用率数据）

- **Steam 官方退款政策**（2015-06起）：14天内且游戏时长<2小时可退款，"no questions asked"（无理由）；官方明确"退款系统不得被滥用为免费玩游戏，Valve保留对滥用者停止提供退款的权利"。
  - URL: https://store.steampowered.com/steam_refunds/ ｜可信度 0.85（官方页本机 fetch 被网络策略拦截，**degraded**；政策内容经 GameDeveloper、Steam社区FAQ多源印证）
  - 反滥用设计要点：**条件门槛（时长<2h）+ 滥用者剥夺权**，而非取消全员退款。
- **Steam 退款率实证基线**（GameDiscoverCo 行业通讯, 2025-02-04）：由 Early Access 转 1.0 的游戏中位退款率 **10.4%**、平均 **11.4%**——即"标准宽松退款政策下，正常退款率约在个位数到11%区间"。
  - URL: https://newsletter.gamediscover.co/p/steam-refunds-how-many-should-you ｜可信度 0.75（行业通讯，基于 Steam 公开数据估算）
- **极端滥用个案**：独立开发者披露约 55,000 名玩家（约占买家 21%）通关后退款其短篇游戏，呼吁修改2小时政策。
  - URL: https://www.tweaktown.com/news/105091/ （GamesRadar/TweakTown 报道链）｜可信度 0.65（单一开发者自述，媒体转述）
  - 启示：**短内容/一次性消费完的数字商品最易被"用完即退"**——研报正是这种形态，风险高于游戏均值。
- **Epic Games Store**：14天+2小时自服务退款，政策与 Steam 同构，多年未收紧。
  - URL: https://www.epicgames.com/site/en-US/help （官方帮助页入口）｜可信度 0.75（degraded：政策细节经 Steam 社区对比帖与媒体报道印证）
- **Amazon Kindle（KDP）电子书**：美国 7 天、其他国家 14 天可退，**读完可退**；作者群体长期抗议 "read and return" 滥用，提议按已读比例（如>20%）限制退款。
  - URL: https://www.mobiread.com/forums/showthread.php?t=35083 （作者抗议讨论）；https://kdp.amazon.com ｜可信度 0.6（社区+作者侧信源，政策本身多源确认）

### 1.2 国内知识付费先例（最直接的参照物）

- **知乎 Live「7天无理由退款」**（2017-04-24 公告）：购买后及 Live 结束后 7 天内，**收听语音未超过 15 条**可无理由退款——国内首个"知识退款"，且是**条件式部分使用权退款**（听完≈不可退），与本项目"按反馈质量部分退款"同属"有门槛的信任退款"。
  - URL: https://www.yicai.com/news/5274231.html （第一财经）｜可信度 0.8
  - URL: https://www.zhihu.com/question/58992550 （知乎问题页，含官方规则问答）｜可信度 0.6
- **行业反面**：多数内容付费平台以"虚拟服务/虚拟商品"名义**不支持退款**，新华网 2018 年批评"一锤子买卖"。
  - URL: https://www.xinhuanet.com/ （《一经报名不予退款 内容付费一锤子买卖何时休》2018-05-09）｜可信度 0.8
- **部分退款先例结论**：法定与平台层面均无"按质量分档部分退款"的既定制度；最接近的先例是知乎Live式"按消费深度设退款门槛"（二元）与 Steam 的"条件门槛+滥用黑名单"。**按AI评分0-100%映射50-100%退款比例属机制创新，无现成判例约束，但也不撞任何已知监管红线（属商家自主承诺范畴，见问题2/3）。**

### 1.3 满意再付 / PWYW（pay-what-you-want）证据

- **Panera Cares 捐赠定价实验**：2010年起多家"随心付"餐厅，2019-02 最后一家（波士顿）关闭；核心死因是"不付钱的人占比过高"，关闭前已被迫限"折价餐每人每周一份"（= **频次上限是PWYW存活的必要闸门**）。
  - URL: https://www.businessinsider.com/panera-cares-closing-boston-2019-2 ｜可信度 0.8（主流媒体）
- **PWYW 学术文献**：
  - Kim, Nattero & Spann (2008)《Pay-What-You-Want – A New Participative Pricing Mechanism》——奠基论文（引用700+），证明PWYW在特定条件下可持续盈利（餐厅实证：人均出价高于固定价的80%量级）。
    - URL: https://link.springer.com/article/10.1007/s11747-007-0043-5 ｜可信度 0.9（学术）
  - Güzel (2025) PWYW 系统文献综述（European Research on Management and Business Economics，被引18+）：PWYW 在数字商品/博物馆场景可持续，物理服务规模化最脆弱。
    - URL: https://www.sciencedirect.com/science/article/pii/S2444845425000111 （期刊页）｜可信度 0.85
- **Humble Bundle（PWYW 数字内容成功先例）**：2010年成立，PWYW 卖游戏/电子书/软件，累计为慈善筹款超 1.95 亿美元；2014 年电子书 bundle 单年超 400 万美元。证明**数字内容+PWYW+分档底价可以规模化成立**。
  - URL: https://www.humblebundle.com/about ｜可信度 0.7（官方口径）

### 1.4 退款政策=信任营销的转化证据

- **Janakiraman et al. (2016)**《The Effect of Return Policy Leniency on Consumer Purchase and Return Decisions: A Meta-analytic Review》（Journal of Retailing，被引507+）：**21篇研究meta分析——宽松退款带来的购买增量大于退货增量，净效应为正**。
  - URL: https://www.sciencedirect.com/science/article/abs/pii/S0022435915000822 ｜可信度 0.9
- **Oghazi et al. (2018)**（被引352+）：感知退款政策宽松度→购买意愿，**由消费者信任完全中介**——即"退款承诺是信任广告"的理论根据。
  - URL: https://research.hanken.fi/zh/publications/online-purchase-return-policy-leniency-and-purchase-decision （Hanken研究库）｜可信度 0.85
- **Rao et al. (2018)** 信号理论：宽松退货窗口=质量信号，降低感知风险。
  - URL: https://www.sciencedirect.com/science/article/abs/pii/S0022435917301226 ｜可信度 0.8
- 行业统计（次级聚合，可信度0.5-0.6）：92%消费者在退货体验好后愿意复购（Invesp）；84%下单前会查看退款政策。

**问题1结论**：机制有实证支撑。退款率基线约5-11%（Steam类），短内容/研报类偏高（个案可达20%+）；宽松退款净效应为正的前提是**有门槛、有频次上限、有滥用黑名单**。Panera教训：无频次上限的"满意再付"必被击穿。

---

## 问题2：法规——数字内容冷静期适用与豁免；"部分退款"有无先例

### 2.1 数字内容不适用七日无理由退货（法定豁免链）

- **《消费者权益保护法》第25条**（2014修正）：网购七日无理由退货的四类例外——消费者定作、鲜活易腐、**在线下载或者消费者拆封的音像制品/计算机软件等数字化商品**、报纸期刊。
  - URL: http://www.npc.gov.cn （中国人大网法库）｜可信度 0.95（法条原文，多源一致；具体页面未直达，以 gov.cn 转载互证）
- **《网络购买商品七日无理由退货暂行办法》**（工商总局令第90号，2017-03-15施行；2020-10-23市场监管总局令第31号修订）第七条列明同样四类不适用；同时规定：经营者根据商品性质设置其他不退货商品，**须消费者购买时确认**，且**不得擅自扩大**范围，须显著标注。
  - URL: https://scjgj.beijing.gov.cn （北京市监局转载全文）｜可信度 0.9（政府官网全文）
- **《消费者权益保护法实施条例》**（国务院令第778号，2024-07-01施行）**第19条**：经营者通过网络等方式销售商品的应遵守消保法25条，**不得擅自扩大不适用无理由退货的商品范围**。
  - URL: https://xinwen.bjd.com.cn （北京日报刊发全文）｜可信度 0.9；官方入口 www.gov.cn（国务院令778号公报）0.95

**判定**：付费研报（在线文档/已下载虚拟商品）**法定上不适用七日无理由退货**——即"按反馈质量退款"完全是**商家自主承诺（额外优于法定）**，不是法定义务；监管态度是"不禁止你更宽松，但禁止你擅自更严"。这给了机制充分的法律自由度，但也意味着**承诺一旦公开即具合同拘束力**（见2.2）。

### 2.2 商家自主"不满意退款"承诺的法律效力（对"部分退款"的约束）

- 商业广告/页面中具体确定的承诺（"不满意退款"）可构成**要约**，消费者下单即成立合同，商家必须兑现（民法典要约规则+消保法）。
  - URL: http://kpzg.people.com.cn （人民网科普中国：线下无理由退货属经营者自愿承诺，承诺即合同义务）｜可信度 0.8
- 不兑现的后果：民事违约；若承诺时即无意履行→**虚假广告**，广告法第55条可处广告费3-5倍罚款；构成欺诈可"退一赔三"。
  - URL: http://www.gzns.gov.cn （南沙区政府普法）+ 案例报道 ｜可信度 0.7
- **部分退款平台先例**：无"按AI评分分档退款"的法规或平台判例；最接近的是知乎Live"收听≤15条可全退"的消费深度门槛（见1.2）与教育/游戏行业的协商式部分退费。**结论：合法可做，但规则必须事前公示且严格按公示执行**——评分标准、退款比例映射、时限、频次上限须写进用户协议并在支付页可见，否则"退款承诺"本身变成虚假宣传风险源。

---

## 问题3：微信生态——虚拟商品退款展示要求；"不满意退款"承诺的审核/运营限制

- **微信小程序平台运营规范**（官方原文 developers.weixin.qq.com；第三方全文转载）：
  - URL: https://developers.weixin.qq.com/miniprogram/product/ （官方文档入口）｜可信度 0.85；全文镜像 https://www.cnblogs.com/AtlasLapetos/p/18730051 ｜可信度 0.6（**degraded**：官方页与镜像页本机 fetch 均被网络策略拦截，条款经搜索摘要与多方转载印证）
  - 相关条款方向：小程序不得含诱导分享/诱导关注（见问题5）；虚拟商品类目与资质要求；抽奖类活动须真实、可公示。
- **虚拟支付与退款流程（官方）**：小程序虚拟支付需**企业主体**+签《虚拟支付服务协议》（后台"支付与交易→虚拟支付"开通，需营业执照/对公账户）；退款须走商户平台/接口规范操作，不得私下处理。官方《商品接口使用场景指引》含"退款规则及流程"专章。
  - URL: https://developers.weixin.qq.com/miniprogram/dev/framework/ministore/minishopguidance.html （微信开放社区·商品接口指引）｜可信度 0.85
- **iOS 端历史与现状**：iOS 小程序虚拟商品支付长期受限；2025-11-14 苹果"小程序合作伙伴计划"后 iOS 虚拟支付开放但对虚拟商品抽 15% 佣金。
  - URL: https://www.apple.com/ （计划公告）+ 行业报道 ｜可信度 0.7（**degraded**：官方细则页未直达）
  - 影响：退款机制的利润测算须按 iOS 15% 佣金后基数算。
- **商家自主承诺"不满意退款"在微信侧的限制**：平台规范**无条款禁止商家提供优于法定的退款承诺**；约束来自三点——(1)承诺须真实兑现（虚假宣传由市场监管追责，微信审核也会拒"无法兑现的服务承诺"类描述）；(2)虚拟支付订单的退款须走官方通道（原路退回）；(3)小程序类目若涉"内容资讯/教育信息"需对应资质。**微信支付侧无"部分退款"技术障碍**（商户端支持按金额部分退款），有据可查。
  - URL: https://pay.weixin.qq.com （微信支付商户文档·退款API支持部分退款金额）｜可信度 0.8（**degraded**：未逐字核对接口文档页，API能力为业界通行且多方印证）

---

## 问题4：AI评分退款的滥用风控——防模板化批评薅羊毛

### 4.1 学术基础：假评论/垃圾评论检测（特征工程直接可抄）

- **Ott et al. (2011) Deceptive Spam Corpus**：假评论检测基准数据集；此后 LSTM 方法达 94.56% 准确率（Mohawesh et al. 2023 综述内引）。
  - URL: https://www.sciencedirect.com/science/article/pii/S1319157823001982 ｜可信度 0.85
- **Mukherjee et al.（Yelp spam，被引244+）**：仅用词面 n-gram 特征即达 89.6%；行为特征（评论者历史、频次）叠加更优。
  - URL: https://www2.cs.uh.edu/~arjun/tr/UIC-CS-TR-yelp-spam.pdf ｜可信度 0.8
- **语义特征 > n-gram**：语义特征+行为特征组合优于纯词面特征（Identification of Fake Reviews Using Semantic and Behavioral Features）。
  - URL: https://www.researchgate.net/publication/325993727 ｜可信度 0.7
- **LLM-as-judge 可行性与偏差**：Zheng et al. (NeurIPS 2023, 被引13000+)：GPT-4级评审与人类一致性>80%（接近人-人一致性），但存在**位置偏差、冗长偏差（verbosity bias）、自我偏好**三大已知偏差。
  - URL: https://arxiv.org/abs/2306.05685 ｜可信度 0.95
- **Survey**：Gu et al. (2024) A Survey on LLM-as-a-Judge。
  - URL: https://arxiv.org/abs/2411.15594 ｜可信度 0.9

### 4.2 反薅羊毛闸门设计（综合先例给出的落地清单）

1. **内容相关性闸（防模板化复制）**：AI评分必须校验批评文本与该报告内容的**语义锚定**——是否引用了具体章节/数据点/论点（embedding 相似度+实体抽取命中报告正文）。模板化文本（"内容空洞、不值这个价"类通用话术）与任何报告都可复用 → 语义锚定分=0 → 不给退。依据：语义特征优于n-gram（4.1）。
2. **新颖度闸（防模板库/批量生成）**：与历史批评库、公开评论库做 n-gram/语义查重；同一账号或跨账号相似度过高→人工复审。依据：Mukherjee n-gram 89.6% 基线。
3. **冗长偏差校正**：LLM judge 对长文本打分偏高（Zheng et al.），须**设字数上限（如300字）+ 质量密度评分**，防"灌水凑长"骗高分。
4. **频次与账户闸（防批量账号）**：单账号每月退款上限（如1次）、账号历史退款率>某阈值（如30%）降为人工审核；设备指纹+支付主体去重。依据：Panera"折价餐每人每周一份"先例、Steam滥用者剥夺退款权先例。
5. **消费深度闸（知乎Live先例移植）**：未读报告（无阅读行为数据）者不可发起评分退款——批评的前提是使用过。
6. **黑名单+申诉双通道**：滥用者剥夺AI退款权转人工（Steam先例）；被误判者可申诉，防AI偏差误伤（4.1三大偏差）。
7. **财务熔断**：单报告退款率>25%或全站周退款额>营收15%时自动熔断复核（对应Steam基线11%、个案21%的经验上限）。

---

## 问题5：赠送合规——点赞送报告 / 随机抽赠 / 有奖销售限额 / 微信诱导分享边界

### 5.1 附条件赠送（点赞→必赠，非随机）

- 《规范促销行为暂行规定》（市场监管总局令第32号，2020-12-01施行）**第11条**：有奖销售=以销售商品或获取竞争优势为目的向消费者提供奖金/物品/其他利益，**分抽奖式与附赠式**。**点赞即赠（确定给付、无概率）属附赠式促销或附条件赠送，不构成抽奖**，无概率公示义务，无金额上限（抽奖式才有限额）。
  - URL: https://www.moj.gov.cn （司法部刊载全文，第17/18条同页）｜可信度 0.95；维基文库全文 https://zh.wikisource.org/wiki/规范促销行为暂行规定 ｜可信度 0.8
- 合规要点：赠品须真实给付（虚假承诺=虚假宣传）；"点赞"若是**站内行为（小程序内点赞）**则连诱导分享都不触发（见5.3）。

### 5.2 若做成"随机抽赠"→抽奖式有奖销售

- **《反不正当竞争法》第10条**：抽奖式有奖销售**最高奖金额不得超过5万元**；且须**事前明确公示奖品数量、中奖概率、兑奖条件**，活动开始后不得变更公示信息（有利于消费者除外）。
  - URL: https://www.samr.gov.cn （市场监管总局法库/反法现行文本）｜可信度 0.9（条文内容经人民网案例、司法部规定多源印证；具体条文页未直达，**degraded**）
- **《规范促销行为暂行规定》第17条**：抽奖式最高奖≤5万（多个最高奖中奖者任一超5万即违法；以使用权、服务等形式折算市价超5万亦违法）；**第18条**：非现金奖品按同期市场同类商品价格计。
  - URL: https://www.moj.gov.cn ｜可信度 0.95
- **执法案例**：广州番禺区市监局查处商家"有奖销售前未明确公布、随意变更中奖概率"（2023年度消费维权典型案例）；福建某楼盘"来访抽奖百达翡丽"因最高奖超5万被认定不正当有奖销售。
  - URL: http://gd.people.com.cn/n2/2024/0313/c123932-40188241.html （人民网广东）｜可信度 0.8
- **判定**：研报单价通常远低于5万，"随机抽赠研报"的奖值合规无忧；**真正的义务是中奖概率事前公示且不可暗中操纵**。"点赞随机赠报告"=抽奖式 → 必须在活动页公示：奖品（哪份报告）、数量、中奖概率、兑奖条件。

### 5.3 微信"诱导分享"红线边界

- **《微信外部链接内容管理规范》第2.1.2条**：通过**利益诱惑诱导用户分享/传播外链**属违规——含红包、**虚拟奖品**等诱导分享，或邀请好友解锁/助力等传播。2026-02 微信据此限制"元宝红包"链接；2019-05 曾专项治理"利诱分享朋友圈打卡"。
  - URL: https://weixin.qq.com/cgi-bin/antispam-statement （微信官方外链规范，及微信安全中心公告）｜可信度 0.85；案例报道 https://finance.sina.cn （新浪财经：微信回应限制元宝红包，引2.1.2条原文）｜可信度 0.8
- **边界判定**：
  - **违规形态**：分享到朋友圈/群→获得报告（利益与分享行为挂钩，"分享得报告"话术）。
  - **安全形态A（站内点赞）**：在小程序/站内对报告点赞→参与抽赠，全程不发生分享动作→不触发外链规范。
  - **安全形态B（自愿分享）**：用户自发分享（无利益对价），或在分享后**所有人无论是否分享都能参与**（利益与分享解耦）→常规运营。
  - 红线的法律判据是**利益-分享因果链**：给付是否以"完成分享"为前提。设计上把获赠条件绑定在"点赞（站内行为）"而非"分享"，即稳在界内。

### 5.4 赠送与退款叠加的诚实性

- "抽赠公示概率+赠品真实给付+不与分享挂钩"三者齐备即合规；若宣传"100%必中"而实际不符→虚假宣传（市场监管总局2026-09盲盒典型案例同逻辑处罚）。
  - URL: https://www.samr.gov.cn （盲盒典型案例通报）｜可信度 0.7（**degraded**：案例通报页未直达，经人民网/地方市监局转载印证）

---

## 总判定

1. **能不能做**：能。退款承诺是商家自主优于法定的承诺（数字内容本就豁免七日无理由），法律不禁止；实证上宽松退款净效应为正（Janakiraman meta），知乎Live已开国内先例，微信侧无禁止性条款且部分退款有官方支付通道。赠送侧：站内点赞+必赠最稳；随机抽赠须公示概率（≤5万限额对研报天然满足）；绝不做"分享才送"。
2. **最大滥用风险**：批量账号+模板化/LLM生成批评文本薅高分退款（研报是"一次性读完"形态，Steam个案显示此类内容退款率可冲到20%+；Panera死于无频次上限）。
3. **上线前必加三道闸**：(a) 语义锚定+查重+字数上限的AI评分防模板闸；(b) 账号级频次/退款率上限+滥用者转人工的黑名单闸（Steam先例）；(c) 全站退款率熔断（>25%单报告/15%周营收自动停）+ 事前公示的评分规则与申诉通道（承诺即合同，公示即枷锁，也是护身符）。

## 证据清单（含可信度汇总）

| # | URL | 可信度 | 用途 |
|---|-----|--------|------|
| 1 | https://store.steampowered.com/steam_refunds/ | 0.85 (degraded-fetch) | Q1 Steam官方政策 |
| 2 | https://newsletter.gamediscover.co/p/steam-refunds-how-many-should-you | 0.75 | Q1 退款率基线10.4%/11.4% |
| 3 | https://www.tweaktown.com/news/105091/ | 0.65 | Q1 21%买家退款滥用个案 |
| 4 | https://www.epicgames.com/site/en-US/help | 0.75 (degraded) | Q1 Epic政策 |
| 5 | https://www.mobiread.com/forums/showthread.php?t=35083 | 0.6 | Q1 Kindle读完即退抗议 |
| 6 | https://www.yicai.com/news/5274231.html | 0.8 | Q1/Q2 知乎Live条件退款先例 |
| 7 | https://www.zhihu.com/question/58992550 | 0.6 | Q1 知乎Live规则细节 |
| 8 | https://www.xinhuanet.com/ | 0.8 | Q1 行业不退款反面 |
| 9 | https://www.businessinsider.com/panera-cares-closing-boston-2019-2 | 0.8 | Q1 Panera关闭 |
| 10 | https://link.springer.com/article/10.1007/s11747-007-0043-5 | 0.9 | Q1 PWYW奠基论文 |
| 11 | https://www.sciencedirect.com/science/article/pii/S2444845425000111 | 0.85 | Q1 PWYW系统综述 |
| 12 | https://www.humblebundle.com/about | 0.7 | Q1 PWYW数字内容成功 |
| 13 | https://www.sciencedirect.com/science/article/abs/pii/S0022435915000822 | 0.9 | Q1 退款宽松度meta分析 |
| 14 | https://research.hanken.fi/zh/publications/online-purchase-return-policy-leniency-and-purchase-decision | 0.85 | Q1 信任中介 |
| 15 | https://www.sciencedirect.com/science/article/abs/pii/S0022435917301226 | 0.8 | Q1 信号理论 |
| 16 | http://www.npc.gov.cn | 0.95 | Q2 消保法25条 |
| 17 | https://scjgj.beijing.gov.cn | 0.9 | Q2 暂行办法全文 |
| 18 | https://xinwen.bjd.com.cn | 0.9 | Q2 实施条例19条全文 |
| 19 | http://kpzg.people.com.cn | 0.8 | Q2 自主承诺=合同义务 |
| 20 | http://www.gzns.gov.cn | 0.7 | Q2 虚假广告处罚 |
| 21 | https://developers.weixin.qq.com/miniprogram/product/ | 0.85 (degraded-fetch) | Q3 运营规范 |
| 22 | https://developers.weixin.qq.com/miniprogram/dev/framework/ministore/minishopguidance.html | 0.85 | Q3 虚拟支付退款规则 |
| 23 | https://pay.weixin.qq.com | 0.8 (degraded) | Q3 部分退款API |
| 24 | https://www.apple.com/ | 0.7 (degraded) | Q3 iOS 15%佣金 |
| 25 | https://www.sciencedirect.com/science/article/pii/S1319157823001982 | 0.85 | Q4 假评论检测综述 |
| 26 | https://www2.cs.uh.edu/~arjun/tr/UIC-CS-TR-yelp-spam.pdf | 0.8 | Q4 n-gram 89.6% |
| 27 | https://www.researchgate.net/publication/325993727 | 0.7 | Q4 语义+行为特征 |
| 28 | https://arxiv.org/abs/2306.05685 | 0.95 | Q4 LLM-judge一致性+偏差 |
| 29 | https://arxiv.org/abs/2411.15594 | 0.9 | Q4 LLM-judge综述 |
| 30 | https://www.moj.gov.cn | 0.95 | Q5 规范促销行为暂行规定全文 |
| 31 | https://zh.wikisource.org/wiki/规范促销行为暂行规定 | 0.8 | Q5 全文镜像 |
| 32 | https://www.samr.gov.cn | 0.9 (degraded-页) | Q5 反法第10条 |
| 33 | http://gd.people.com.cn/n2/2024/0313/c123932-40188241.html | 0.8 | Q5 未公示概率查处案例 |
| 34 | https://finance.sina.cn | 0.8 | Q5 微信2.1.2条+元宝案例 |
| 35 | https://weixin.qq.com/cgi-bin/antispam-statement | 0.85 | Q5 外链规范官方 |
