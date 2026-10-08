# agent5

# 历史提案已定决策与未竟事项侦察报告

## 0. 命名与 appid 地图（先读，防止张冠李戴——不可重开的既定事实）

| 产品 | appid | 前端目录 | 引擎/端口 | 证据 |
|---|---|---|---|---|
| 总包学园（研报商城） | wxfdb55b184756e89e | `WeAppForge/projects/zongbao`（原位改造，A8 决策：zongbao 自始就是学园脚手架代号） | xueyuan-engine :8871 | `_proposals/xueyuan-market/ARCHITECTURE.md` A8 |
| 总包AI顾问（原「总包千问」提案、原标讯演示号） | wx5cee1574ce45819b（0929 用户令迁移，接管原 biaoxun 标讯号） | `WeAppForge/projects/zongbao-ai`（0929 由 biaoxun 改名，封死"目录名骗人"事故） | qianwen-engine :8869（本地影子 8870） | `_proposals/weapp-forge/RUN_LEDGER.md` #11/#25 |
| 总包千问注册号 | wxd096fc6994ef6f48（曾抄错一位致"账号消失"误诊，G12 翻案） | —（提案期注册号；据全局记忆后转役"总包说"展示号，此条无 _proposals 文件证据，仅记忆） | — | `_proposals/qianwen-gc/GAP_REPORT.md` G12 |

---

## 1. 学园商城提案（`_proposals/xueyuan-market/`）

### 1.1 五引擎（情报裂变 2.0，`VIRAL_100X.md` §三，用户已选「全量采纳」RUN_LEDGER #37）
核心洞察：付费章本身（商机项目清单明细）就是裂变物——分享"书里正好对他有用的一页"。
1. **引擎1（主引擎）商机卡**：一条商机一张卡，A 线 build 时从商机清单章抽结构化条目，38 份回填；卡面=省徽章+项目名+投资额大字+业主+阶段+码；卡片详情页免登录+H5 长尾页；公众号宣传文=10 卡 H5 合集。
2. **引擎2 报告即媒介**：下载 PDF 加购者个人专属码尾页（pdftail.py，PIL 画 CJK 尾页→pypdf 追加），每次流转=带归因投放，"盗版即分销"；一级归因、书券奖励、非现金=非分销合规。
3. **引擎3 榜单**：周榜（rank_week ISO 周快照冻结）、省级热度榜、最大单、新入榜业主——新闻感数据卡周更。
4. **引擎4 一周商机故事**：每周 1 条最戏剧性商机三段式小故事，免费模型判断层选条。
5. **引擎5 情报官体系**（替代裸"邀2人"）：有效带新=读完≥1章试读或停留≥3分钟（挤干归因水分）；L1 观察员(1)/L2 分析师(5)/L3 情报官(20)；权益全虚拟（L2=200券+首读权、L3=1000券+周榜署名+闭门会远期）。
K 模型从 0.1-0.2 抬到 0.4-0.8（60 天观察窗诚实估算）；验收判据七条在 VIRAL_100X §七。全部已落地（RUN_LEDGER #44-48：3104 卡、卡短码、榜单/K看板、PDF尾页在役）。

### 1.2 256 张 trial 码池机制（RUN_LEDGER #49，2026-09-29）
- 生成：32 报告 × 8 用户 = **256 张体验版码**（env_version=trial），`qr_pool --all-users --live` 在 ECS 原位灌；首次跑废 256 调（qrs/ 目录不存在）→ qr_pool 写前 mkdir 自愈重灌。
- 配套根治引擎级 bug：`poster._alloc_short_code` 无 (report,inviter) 复用查 → 码池永不命中+poster_code 无界膨胀；修为复用查先行+跨渠道复用（短码=归因键，一人一报告一枚）。
- 清账：480→256 行与 256 文件 1:1。
- 运营节律（已定不可重开）：新测试者进来=重跑码池灌命令（幂等，只为新 uid 补码）；**Day-0 正式发布后须 --env-version release 全量重灌（在册未做）**。

### 1.3 生产 8871「四部署」
1. **部署① P0 生产上云**（#30/#35，0928）：数据相位（core 594 片 49 分钟）+引擎相位（两断两修：云助手 Timeout 非 TimeoutSeconds、b64 二次追加污染→rm 幂等头）；公网 health=200，catalog=32（38−6 下架）。
2. **部署② P1 引擎上生产**（#41，0928）：ecs_deploy 幂等重跑；坑=`systemctl enable --now` 对已 active 服务不重启→跑旧代码公网 404，手动 restart 后 P1 八域 401 正闸；deploy 脚本焊死 enable+显式 restart。
3. **部署③ w3 全量合流+热修**（#48，0928「继续继续，全部完成」）：四波 agent 验收后引擎合流部署；含故事段 stage 占位 '-' 热修重部署+DELETE rank_week 重算。
4. **部署④ deploy #4**（#49，0929）：tools/ 焊进部署包+零交叉审计白名单同步，与短码复用修复同批。

### 1.4 等用户的两个事项现状（截至本侦察实测）
- **虚拟支付 offer_id：仍未开通**。本地 `E:/AI-Station/data/secrets/` 实查**无 `virtual_pay_xueyuan.secret`**（只有 qianwen 的 `virtual_pay.secret`），即凭证从未回填；引擎侧占位 secret=503 降级在役（DEPLOY_PREP §2.1）。开通 6 步向导=`WIZARD_VIRTUAL_PAY.md`（一个通用道具「研报单篇解锁」xy_report_unlock/49800 分，回传 offer_id+product_id+iOS 实际价）。
- **类目：未设置**。REVIEW_PACK §三必办清单 #1：用户 MP 后台设「教育/知识付费」（备选「工具」），「商业资讯」不在 KB 开放清单证据中（待核）。
- 附带：手机体验版开「开发调试」半步（#49：用户已选体验版=控制台步①完成）；生产域名定稿+HTTPS（PROD_BASE 仍 TBD 占位，nginx 模板 __XUEYUAN_DOMAIN__）。

### 1.5 2MB 主包墙与分包工单 D-1（RUN_LEDGER #39）
- 事故链：首轮 4194KB>2MB 被拒（errcode 80051）→ 剥 @vant 1183K+mp-html 48K（全库零引用死重）+content/cards 1254K（P1 已关）+全部 .ts 289K → 2683KB 仍超 → chapters.json 实测已是紧凑 JSON（pretty-print 仅省 0.07%）→ **偏差 D-1=快照内 3 份巨型研报不捆正文走服务端**（js-shuiwang 638K/gs-shuili 585K/zj-shuili 516K）→ 最终 v0.3.0 编译包 810KB 上传 PASS（余 1.2MB）。
- **D-1 工单（正式版/P1 上线前硬前置，未做）**：微信铁律=章节所在分包必须含 reader 页→单内容分包 ≤2MB 装 2596K 不下，cards 1254K 回归后更炸；候选方案=**大小报告贪心双分包 或 渐进缓存 USER_DATA_PATH**；快照态影响面=3 份报告离线首开降级「章节加载失败」（在线 87ms 无感）；vant/mp-html 死重清除待回 live 树（npm 构建链一并清）。

---

## 2. 旗舰付费研报提案（`_proposals/flagship-paid-report-1007/`，含 GOAL_LEDGER.md + bluebook/CHARTER.md）

### 2.1 F5a 系列收官状态（GOAL_LEDGER「状态」表，全部有凭证）
| 腿 | 态 | 要点 |
|---|---|---|
| F5a H5 发布站 | ✅ 1007 | http://47.120.43.20:8885/ 公网全链 200；systemd；双层墙已开 |
| F5a-2 支付全自动+反馈取证+比例退款 | ✅ 1007 | pay.py stub 就绪凭证即插；grade_feedback 四档（严重100%/局部40%/轻微20%/建议0%）；取证协议 L1-L3；公网复验收官 |
| F5a-3 存量批量上架 | ✅ 1007 | **65 在售+1 预售**（企业全景¥698×28+省份¥598×16+专题¥498-598×17+独家¥698×2） |
| F5a-4 收款码 | ✅ 1007 | 全站真码在役；支付宝位按令撤净（全站 0 处）；商户五件套到位后切 wxpay 全自动 |
| F5a-5 域名解析腿 | ✅ 调查收官 | epcschool.top/gcbrain.top 被 Beaver 全端口 403；买家路径=IP:8885（后被 F5a-6/8 取代） |
| F5a-6 备案域名 | ✅ 1007 | **yrecepc.cn 直用**（阿里云接入已备案）；DNS 写入 16 轮 UI 全败后走同源 API 直调契约 |
| F5a-7 og 分享卡 | ✅ 1007 | 全站 133 页头注入；deploy_ecs.py --site-only 暂存-验证-原子换入 |
| F5a-8 迁二级域名 | ✅ 1007 | **正式对外 URL=http://report.yrecepc.cn/**（后 F5d 升 https） |
| F5b 宣传飞轮 | 🔶 自发布已实证 | 总包之声两篇上线；视频腿 v5=We-AIPO emitter 法全移植，r50_snei_v1_am 首片真发布成功（1008 09:31）；r7/r12 判定键翻案（列表只渲染 desc 不渲染标题）；dup 定点清除（真宿主=.opr-item） |
| F5c 交易闭环 | 🔶 变现腿在役 | **G5 未达成（等首单）**；订单看门狗 RP_OrderWatch 每6min+漏斗计量去伪+视频日更双槽（09:37/14:37） |
| F5d 在线支付 | 🔶 代码全就绪·等商户五件套 | **https://report.yrecepc.cn/**（LE 证书至 2027-01-06）；pay.py 微信v3 37/37 tests（Native+JSAPI 三段流）；v2 视觉改版两轮审计 9 修；lite 部署经济学（1.0MB/435s）；平台运行手册=`report_platform/GOAL_LEDGER.md` |

### 2.2 蓝皮书五卷 charter（`bluebook/CHARTER.md`，1007 F1 点火）
《中国工程总承包（EPC）蓝皮书 2026-2029》：¥10,000/套（单卷 ¥2,800 可拆售引流）；50 万字=存量 1034.8 万字（67 目录/成色 A46·B19·C1·D1）的 5% 萃取：
- 卷一《市场全景卷》10万字（17省 258.9万字跨库融合重写）
- 卷二《标杆企业卷》12万字（28家旗舰，每家 4000-5000 字+横向对标四维矩阵）
- 卷三《区域机会卷》12万字（17省，每省 6500-7500 字五章制）
- 卷四《专题实战卷》10万字（八大高翻车域专题，每专题 1.2 万字）
- 卷五《独家判断卷》6万字（原创判断层，ACH 对抗自证+证据强度三档）
S0 门=数字零造假/判断分级/可回溯/无剧透转化面；已知缺口四项（水利投标 D 级、企业卷 6 家回捞、卷五原创融合、2026 时效增补节）；里程碑 M1 framework 五卷章纲=**目标 1008（今天）**，M2 卷三=1012，M6 首单=1107 前。

### 2.3 当前收入目标与硬指标（GOAL_LEDGER 头部，1007 用户第三波令）
- **硬指标：未来一个月（截止 2026-11-07）平台订单库真实入账累计 ≥ ¥100,000**；不等用户提示，全部生产/宣传/变现自主推进。
- 路径拆解：扩 SKU（存量成稿上架+单章¥199 拆分）× 流量（总包之声引流）× 高客单（蓝皮书 ¥10,000 在编）。
- 库存盘点：真成稿仅 2 家（R50-SNEI 已上架 ✅、CNNC-EPC 核电 15.6 万字上架中）；EPC1-50 其余为过程资产非成稿。
- 成功判据（七连令⑥）：用户看到宣传后**真正扫码下单**，看了不买=没成功。
- 百倍升级=九飞轮矩阵（PROPOSAL §9.2，①宣传⑤校准⑨数据资产等）+反馈五层防线（§十 L1 交易锚定✅/L2 阅读锚定/L3 内容锚定/L4 行为画像/L5 存证透明）+反馈激励设计（采纳返券、退款与激励互斥）。

---

## 3. weapp-forge 提案（`_proposals/weapp-forge/`）：工厂的边界与设计决策

### 3.1 定位与十倍门
「小程序锻造厂」：一句话→4 小时后出现在我的小程序后台可扫码调试（onboarding_time 72h→4h=17.99×）；Scorecard 0.849 PROCEED。格局判断=**零件红海成熟、编排层蓝海真空（我们缝）**——840 条实测证据（GH 328 repo+npm 351 包）。

### 3.2 七腿流水线（每腿=世界最好零件 × 显式交接契约）
L1 规格化（类目/合规规则注入）→ L2 生成（原生 TS+api-typings+vant-weapp）→ L3 构建（miniprogram-ci+weapp-tailwindcss）→ L4 上传（ci upload，密钥外置 R7 红线）→ L5 调试（ci preview+automator）→ L6 测试（simulate 单测+automator E2E+**官方四指标≥60 出厂门**）→ L7 发布/运营（提审材料+类目检查+虚拟支付+msgSecCheck）。
双保险位（设计决策）：automator 官方 28 月未更新→@weapp-vite/miniprogram-automator 兜底+ci preview 人工道；官方 DevTools Skill 公测漂移→CLI+MCP 双接口。

### 3.3 边界（v1 明确排除，不可重开）
跨端框架（uni-app/taro——单端原生最稳）、多租户 SaaS、iOS 虚拟支付（12% 抽成与账期，P4 决策）、多语言。P0-P4 阶段：P0 地基（HelloWorld 全链计时 27.3s 实测）→P1 试点（研报小程序全功能）→P2 出厂门→P3 复利（第 N+1 个小程序 ≤1 人日）→P4 商业化（SaaS go/no-go，premium ¥22,700/年锚 5,400）。

### 3.4 运行期沉淀的关键设计决策（RUN_LEDGER，多为事故根因级、不可重开）
- **robot 1..30 轮转**（robot_cursor.txt+robot_registry.jsonl）：同一机器人再上传会顶掉自己被钉的体验版记录→钉位悬空→「页面不存在」（#23 根因）。
- **出码纪律=码内显式 page+check_path=false**：无 path 打开按线上版 1.0.7 老页面表解析（桌面协议链全回落老标讯，四连判实锤）；唯一好路=显式 page 新解析（#24）。
- **探针语义**：check_path=true 是「通道体检」非健康探针（真页回图=通道活；ask 41030=预期常数）——#28 教训级自纠错。
- **BOOT-SIM 门**（67→71 项断言）+ Node25 ci 上传坑（corecompiler 子进程炸→exit 0 假成功→localstorage-shim.cjs 父子同注）。
- **目录改名 biaoxun→zongbao-ai**：封死「目录名骗人」事故（#25）。
- Node spawn 须 windowsHide、wb.upload 先 mkdir、远端脚本绝对路径 PYTHONPATH、SimHei 无 •/｜ 字形（#21 坑）。

---

## 4. qianwen-gc 提案（总包AI顾问）：虚拟支付与类目盯哨现状

### 4.1 提案层（`_proposals/qianwen-gc/`，停在 09-28 批准门状态——文档已滞后于实际交付）
- 架构分水岭（不可重开的实证结论）：秘塔 search-api 无法定向工程大脑知识库（计费标签无专题/知识库项）→ 双引擎=自建工程 RAG（主引擎，13 本书+We-AIPO/EPC100 语料+免费模型）+ 秘塔外援腿（带公网出处）。主引擎后走 KB 直连网页积分池（免费 100 点/天，14s 带书页引用）。
- 定价：1 元/次解锁（行业空白卡位；Android 毛利 97.9%/iOS 86.9%）；退款三档（<40 全退/40-75 退半/>75 不退）+六层防薅+影子模式。
- GAP_REPORT 三大翻案（诊断结论不可重开）：G1「积分=0 被 5000 拦」=TLS 指纹 WAF（curl_cffi impersonate='chrome' 即通）；G2 key 归属不影响主引擎；G12「appid 查无」=appid 抄错一位（f→b）。

### 4.2 虚拟支付现状（WeAppForge/RUN_LEDGER.md #199，1007 23:2x 收官；用户令「虚拟支付已经开通」）
服务端五步全收官：①offer_id=1450664233；②道具 unlock_once「咨询解锁-单次」1 元（wujie 微前端 raw CDP 注入配方：Runtime.evaluate 递归 iframe 找 file input→DOM.requestNode→setFileInputFiles）；③AppKeys 沙箱+现网入 secret；④pay_sign 官方新规格（paySig=HMAC(appKey,uri&body)/signature=HMAC(session_key,body)，无 VirtualPayment& 前缀，官方向量锚定 6 测全绿）；⑤生产上线 4 次部署，**env=1 沙箱旗标字节级实证**+健康 6/6+配置零漂移。通道突破：tcb run service:config 3.8.5 结构性死路（勿再试）→ 正解=@cloudbase/manager-node 5.9.0 直调，配方=TCB_DEPLOY.md §8a。
**待办（用户裁决后）**：客户端 0.8.0 解锁 UI 接 requestVirtualPayment（沙箱联调验 signData 线格式）→ 道具发布 → env=1 切 0 现网。本地 `data/secrets/virtual_pay.secret` 实查在位（7 键含 offer_id/product_id/env/sandbox_appkey/prod_appkey/export_product_id，1008 17:07 更新=工作在推进）。

### 4.3 类目盯哨 QianwenCatWatch 现状（本侦察实测）
- 根治史：1002 拒审根因=类目「深度合成-AI问答」审核中跑在免费加急前面（AI 标识已洗清）→ **硬门=类目已通过才许重提审**（下次走常规审核，加急包用完）；1008 OS 级根治：会话级 cron 随会话死过一次（盯哨静默失守一整天）→ schtasks QianwenCatWatch 每 3h 硬腿 `WeAppForge/work/mp_cancel_logout/watch_category_task.py`（判据 GREEN/PENDING/ERROR；静默纪律=绿灯/异常且仅状态翻转那一次才企微；GREEN 立旗 data/state/mp_category_green.flag，重提审留给会话腿做 BOOT-SIM+submit_audit）。
- **实测：schtasks QianwenCatWatch State=Ready，LastRun 2026/10/8 16:41，NextRun 19:41；状态文件 last_verdict=GREEN（2026-10-08T13:41）；日志显示 10:41 仍 PENDING→13:41 翻 GREEN（类目=工具/信息查询,深度合成/AI问答,资讯/信息资讯），已发企微「小程序类目绿灯」；绿旗文件 13:41 落盘。即：类目已于今天（10-08）生效，0.7.7 重提审硬门已解锁。**
- 关联既定事实：1004 注销事件已收官（用户令「取消」，11:49 JS el.click() 真成功，三重终审证据）；一次性备件包 `WeAppForge/filing/category_dossier/` 三场景开箱即用。

---

## 5. 用户已拍板决策清单（不可重开）

### 学园商城（xueyuan-market）
1. **批准门 0928**：企业主体（用户答复）；其余 7 项按提案默认全批（「其它按照你建议」C8 全自主）：¥498 统一定价/前 20 页试读/线性退款映射（50→50%…100→100%，月≤2次，每报告1次）/站内点赞必得（每日1份，附条件赠送）/40 docx 直接上架/ECS 8871/虚拟支付硬前置。
2. **常驻令**：新报告双通道分发（公众号宣传+小程序直接上架在线售卖）——上架是产线常驻出货通道（变更#1）。
3. **决策单①-⑤全按默认**（变更#2）：5 WARN 越带全接受/js-shuiwang 决策卡明示/下架最薄 6 份（38→32）/ownerType 提审后补/AI tab 隐藏。
4. **情报裂变 2.0 全量采纳**（变更#4，VIRAL_100X 五引擎）。
5. **AGREEMENT_COPY v1.2**（变更#5）：情报官 L1/L2/L3 体系+有效带新判据+转赠规则（每报告终身1次/与退款互斥/源限 purchase）。
6. 用户令二连：安全组 8871 自行放行；P1、P2 全开发完。
7. 「请发布为体验版」→v0.3.0；0929 用户已选体验版。
8. 设计级既定（AI_NATIVE_OPTIONS 八抉择+ARCHITECTURE A1-A8）：批评评分=代码闸+免费模型+熔断（自动退仅≤50%档）；海报=服务端 PIL+码池；检索=FTS5+jieba 三层降级；支付=道具直购+503 降级；内容交付=服务端按权益下发+空壳章；阅读器=md2blocks；引擎=抄 qianwen-engine；退款=自动+熔断+人工复核位；前端=zongbao 原位改造。

### 旗舰付费研报（flagship-paid-report-1007）
1. **1007 七连令**：¥10,000 报告/50 万字级/详细简介+目录转化面/全链条（生产→排版→宣传→总包之声→扫码下单）自主负责/宣传增长飞轮/成功判据=真实扫码下单/自主决策直到实现为止。
2. **自建平台令**：阿里云自建 H5 发布平台（网站，**不走小程序**——审核备案拖周期）；手机可看；收款二维码；允许试读；付费数据自主掌控；付费数据不断增长成飞轮。
3. **经营系统定位令（三连）**：用户只给方向+现有资源，其余全部工作全自动；成为稳定、持续、不断进化的现金流；持续赚钱、赚越来越多的钱。
4. **硬指标令**：一个月 ¥100,000（截止 2026-11-07）。
5. **百倍升级令**（初步想法为底座）→九飞轮矩阵；**反馈真实可信令**→五层防线；反馈激励（返券/互斥）。
6. **F5d 令**：「在线支付/免凭证/支付后即读即下载」+「世界顶级审美」；UI 微信独占（支付宝休眠位保留）；无合规绕行商户注册，个人码监听器=账号风险红线不做。
7. **域名两连令**：「阿里云已备案域名查清直接用上」（yrecepc.cn）+「用二级域名/顶级域能不用尽量不用」（report.yrecepc.cn）。
8. 视频系列令：「视频也是自己发布」「测试最新研报宣传视频发视频号」「借鉴 We-AIPO 方法」「下载开源项目做宣传视频」（huashu-art-motion）。

### weapp-forge
1. 用户五条补充指令全部钉死：全网最顶级/顶级缝合怪绝不造轮子/推送到我的小程序后台+可调试验证测试/微信支付接入调研清楚/试点=研报付费阅读+语音+AI对话+微信AI 能力。
2. **企业主体**（视频号企业认证，2026-09-27 确认）→虚拟支付企业档。
3. 0929「发布到 wx5cee1574ce45819b 并设为体验版」（appid 迁移接管标讯号）；「自行调试优化，真正能使用才交给我」；「提升页面设计，顶级 UI 水平」（蓝图设计系统）；五连令（三问题库/导出/标语×2/咨询化+语音）；「彻底排查，不要再发生」（三道永久防线）；四连令（自测台优化/新入口解析/老项目全删/彻底修复高质量交付→老项目清零+目录改名）；三连令（语音交互重做→v0.4.3）。
4. （后续 qianwen 项目线）「请接1元解锁虚拟支付」；1007「虚拟支付已经开通」；1004「取消」（注销事件）。

### qianwen-gc
1. 用户四件原始需求（多模态咨询/每日3次+1元漏斗/质量对赌/海报裂变）=开发基线。
2. 三大翻案结论（TLS WAF/key 归属/appid 抄错）不可重开。
3. 提案 D1-D5 决策项中：D3 主体=企业（走通）；D1 秘塔充值=自愿不阻塞（主引擎 KB 直连已实证）；D5 语料默认先上本地已有。

---

## 6. 未竟事项清单（谁在等什么）

### 等用户（硬阻塞）
| # | 事项 | 项目 | 证据 |
|---|---|---|---|
| 1 | **微信支付商户五件套**（mchid/appid/api_v3_key/serial_no/private_key_pem）+公众号 AppSecret+平台证书公钥 → secret.ini [wxpay] 即插即热 | 旗舰 F5d | GOAL_LEDGER F5d 行 + report_platform/GOAL_LEDGER.md「待用户」 |
| 2 | **虚拟支付 offer_id 三值回传**（6 步签约+建道具） | 学园 | WIZARD_VIRTUAL_PAY.md；本地无 virtual_pay_xueyuan.secret 实证 |
| 3 | **类目设置**（教育/知识付费方向） | 学园 | REVIEW_PACK §三 #1 |
| 4 | 手机体验版开「开发调试」（半步）+生产域名定稿+HTTPS+提审 | 学园 | RUN_LEDGER #49；ARCHITECTURE §七 TBD |
| 5 | （可选）支付宝资质；（可选）OSS 开通解除 UserDisable | 旗舰/学园 | report_platform GOAL_LEDGER；DEPLOY_PREP §1.5 |
| 6 | 0.7.7 重提审后的发布节奏（正式版 cure=一切入口按我方页面表解析）；对己推草稿改/更用法涉 0822 红线的裁决 | 总包AI顾问/旗舰 F5b | weapp-forge RUN_LEDGER #23/#27；flagship GOAL_LEDGER F5b 悬决 |

### 等我方（既定待办，勿重开已关闭问题）
| # | 事项 | 项目 |
|---|---|---|
| 1 | **D-1 分包重构**（正式版/P1 上线前硬前置；贪心双分包或 USER_DATA_PATH 渐进缓存；vant/mp-html 死重回 live 树） | 学园 |
| 2 | Day-0 发布后 QR 池 --env-version release 全量重灌 | 学园 |
| 3 | PDF 夜航四晚批（pdfs 相位 6,309 片，ledger 未记完成） | 学园 |
| 4 | F1 framework 五卷章纲（M1 目标=1008 今天）→M2 卷三 1012→M6 首单 1107 前 | 旗舰 |
| 5 | G5 首单（≥1 真实 ¥10,000 订单）与 ¥100k 月收入（2026-11-07） | 旗舰 |
| 6 | 0.8.0 客户端解锁 UI（沙箱联调）→道具发布→env 切 0 | 总包AI顾问 |
| 7 | **0.7.7 重提审（硬门已于今日 13:41 解锁，绿灯+旗已立；走常规审核）** | 总包AI顾问 |
| 8 | 视频日更队列续渲染新卡（cnnec/fengcheng 两片渲染件在库，r49+ 续队） | 旗舰 F5c |
| 9 | epcschool.top 净路两选一（阿里云接入备案 或 gcblog.net 中继）=停为待决项（已被 yrecepc.cn 路线绕开，低优） | 旗舰 F5a-5 |
| 10 | 蓝皮书四缺口定向（水利投标 D 级/企业卷 6 家回捞/卷五原创/2026 时效增补） | 旗舰 F1 |

### 运行态在役（不是待办，是背景）
RP_OrderWatch 每6min；RP_VideoDaily_1/2 双槽 09:37/14:37；QianwenCatWatch 每3h（Ready，19:41 下轮）；WeChatBriefDaily 22:00 等——按免打扰纪律不手动触发。

## Key Facts
- 学园五引擎=商机卡主引擎/报告即媒介PDF个人码/周榜/一周商机故事/情报官质量门体系；用户选「全量采纳」；K 模型 0.1-0.2→0.4-0.8 (E:/AI-Station/_proposals/xueyuan-market/VIRAL_100X.md §三 引擎1-5；§四 K 表)
- 256 张 trial 码=32 报告×8 用户，env_version=trial，qr_pool --all-users --live ECS 原位灌；短码复用 bug 根治；Day-0 发布后须 --env-version release 全量重灌在册 (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md #49（2026-09-29 体验版启用日）)
- 2MB 主包墙：首轮 4194KB errcode 80051 被拒，剥死重后 2683KB 仍超，偏差 D-1=3 份巨型研报（js-shuiwang 638K/gs-shuili 585K/zj-shuili 516K）不捆正文走服务端，终包 810KB PASS (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md #39)
- D-1 分包工单：正式版/P1 上线前须分包重构；微信铁律=章节所在分包必须含 reader 页；方案=大小报告贪心双分包或渐进缓存 USER_DATA_PATH (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md #39 「D-1 偏差+根治工单」)
- 学园生产 8871 四部署：①P0 上云(#35) ②P1 引擎(#41) ③w3合流+热修(#48) ④deploy #4=tools/进包+短码修复(#49 显式编号) (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md #35/#41/#48/#49)
- 学园批准门 8 项全批+企业主体（2026-09-28 用户答复「总包学园小程序主体是企业」）；「其它按照你建议」C8 全自主 (E:/AI-Station/_proposals/xueyuan-market/REQUIREMENTS.md §六 批准门状态)
- 学园等用户：虚拟支付 6 步开通+回传 offer_id/product_id/iOS 实际价（本地 data/secrets 实查无 virtual_pay_xueyuan.secret=凭证未回填）；类目=教育/知识付费主报+工具备选（「商业资讯」待核） (E:/AI-Station/_proposals/xueyuan-market/REVIEW_PACK.md §一-1.2 类目建议；§三 必办清单 #1/#7)
- 一个通用道具设计：productId=xy_report_unlock 49800 分，解锁哪份报告由 outTradeNo 绑定，不需 40 个道具；503 降级（缺凭证可试读收藏、支付灰置）已验证不阻塞开发提审 (E:/AI-Station/_proposals/xueyuan-market/KNOWLEDGE_BASE/virtual_pay.md §3/§10)
- 旗舰硬指标：未来一个月实现 ¥100,000 收入，平台订单库真实入账累计 ≥¥100,000（截止 2026-11-07）；路径=扩SKU×流量×高客单；真成稿仅 2 家（R50-SNEI 已上架/CNNC-EPC 上架中） (E:/AI-Station/_proposals/flagship-paid-report-1007/GOAL_LEDGER.md 文件头部硬指标令+库存盘点)
- 旗舰 1007 七连令+经营系统三连令+自建平台令（不走小程序，阿里云 H5，试读+收款码+付费数据自主） (E:/AI-Station/_proposals/flagship-paid-report-1007/GOAL_LEDGER.md 用户令 2026-10-07 引用块)
- F5a 系列收官：F5a/F5a-2/3/4/5/6/7/8 全 ✅（65+1 SKU 在售、yrecepc.cn、report.yrecepc.cn、og 卡、收款码全站）；F5b 🔶 自发布实证（r50 首片视频 1008 09:31 真发布）；F5c 🔶 等首单；F5d 🔶 代码全就绪等商户五件套 (E:/AI-Station/_proposals/flagship-paid-report-1007/GOAL_LEDGER.md 状态表 F5a-F5d 行)
- 蓝皮书五卷 charter：¥10,000/套，五卷=市场全景10万+标杆企业12万+区域机会12万+专题实战10万+独家判断6万=50万字；存量 1034.8 万字 5% 萃取；M1 framework 目标 1008；S0 门=数字零造假/判断分级/可回溯/无剧透 (E:/AI-Station/_proposals/flagship-paid-report-1007/bluebook/CHARTER.md 产品定义+五卷结构表+里程碑)
- 平台运行手册=report_platform/GOAL_LEDGER.md：F5d 收官态、lite 部署经济学、tar 双剥坑、v2 视觉审计闭环、待用户=商户五件套+AppSecret（支付宝可选） (E:/AI-Station/report_platform/GOAL_LEDGER.md 「待用户 (硬阻塞变现)」节)
- weapp-forge 边界：v1 排除跨端框架/多租户SaaS/iOS虚拟支付(P4决策)/多语言；七腿流水线+官方四指标≥60出厂门；格局=零件红海成熟、编排层蓝海真空 (E:/AI-Station/_proposals/weapp-forge/PROPOSAL.md §六 MVP 范围 v1 不做；§五 七腿)
- 总包AI顾问 appid 迁移既定：wx5cee1574ce45819b（0929 用户令「发布到 wx5cee1574ce45819b 并设为体验版」接管原标讯号）；目录 biaoxun→zongbao-ai 改名封死目录名骗人事故 (E:/AI-Station/_proposals/weapp-forge/RUN_LEDGER.md #11/#25)
- 页面不存在根因链（不可重开）：robot 顶掉被钉记录→钉位悬空；无 path 打开按线上版 1.0.7 老页面表解析；防线=robot 1..30 轮转+码内显式 page+check_path=false+BOOT-SIM (E:/AI-Station/_proposals/weapp-forge/RUN_LEDGER.md #23/#24/#26)
- 总包AI顾问虚拟支付 1007 收官：offer_id=1450664233、道具 unlock_once 1元、pay_sign 官方新规格 6 测全绿、生产 env=1 沙箱旗标字节级实证+健康6/6；改密钥唯一活口=@cloudbase/manager-node 直调（TCB_DEPLOY.md §8a）；待办=0.8.0 客户端 UI+道具发布+env 切 0 (E:/AI-Station/WeAppForge/RUN_LEDGER.md 199（2026-10-07 23:2x 虚拟支付开通落地·服务端五步全收官）)
- 类目盯哨现状（实测）：schtasks QianwenCatWatch State=Ready，LastRun 2026/10/8 16:41，NextRun 19:41；state last_verdict=GREEN（2026-10-08T13:41，类目含 深度合成/AI问答）；绿旗 mp_category_green.flag 13:41 落盘——0.7.7 重提审硬门已解锁 (E:/AI-Station/data/state/qianwen_cat_watch_state.json 辅证：qianwen_cat_watch.log 尾部 3 行 + mp_category_green.flag + powershell Get-ScheduledTask)
- QianwenCatWatch 根治史：1008 会话级 cron 随会话死过一次（盯哨静默失守一整天）→ OS 层 schtasks 每3h；静默纪律=绿灯/异常且仅翻转那一次才企微；GREEN 只立旗，重提审留给会话腿（BOOT-SIM+submit_audit） (E:/AI-Station/WeAppForge/work/mp_cancel_logout/watch_category_task.py 1-19 模块 docstring)
- 0.7.7 二连拒根因既定：类目「深度合成-AI问答」提审时仍审核中，免费加急(2h)跑在类目审批(1-7工作日)前；AI 标识已洗清（OCR+像素探针实证）；硬门=类目已通过才许重提审；加急包用完下次走常规审核 (E:/AI-Station/WeAppForge/RUN_LEDGER.md 194/196/197)
- qianwen-gc 三大翻案（不可重开）：5000 错误=TLS 指纹 WAF（curl_cffi impersonate='chrome' 即通）；key 归属不影响主引擎（KB 直连网页积分池）；appid 抄错一位（f→b）致「账号消失」误诊 (E:/AI-Station/_proposals/qianwen-gc/GAP_REPORT.md G1/G2/G12)
- qianwen-gc 架构分水岭：秘塔 search-api 无法定向工程大脑（计费标签无专题/知识库项）→双引擎=自建工程 RAG 主引擎+秘塔外援腿；1元/次空白卡位（Android 毛利 97.9%） (E:/AI-Station/_proposals/qianwen-gc/PROPOSAL.md §1 架构分水岭；§0 一句话说清)
- 学园 zongbao 目录=总包学园本体（appid wxfdb55b184756e89e，projectname=zongbao-xueyuan）——原位改造不新开项目（A8）；zongbao/biaoxun(→zongbao-ai)/qianwen 三 appid 注册表无冲突 (E:/AI-Station/_proposals/xueyuan-market/ARCHITECTURE.md A8 决策（§三）)
- 学园既定设计八抉择：批评评分=代码闸+免费模型+熔断（自动退仅≤50%档）；海报=服务端PIL；检索=FTS5+jieba；支付=道具直购+503；内容=服务端下发+空壳章；阅读器=md2blocks；引擎=抄 qianwen-engine；退款=自动+熔断+人工位 (E:/AI-Station/_proposals/xueyuan-market/AI_NATIVE_OPTIONS.md 全表 #1-#8)
- AGREEMENT_COPY 已升 v1.2（用户拍板变更#5+#4 落法）：情报官 L1/L2/L3 有效带新判据（读完≥1章或停留≥3分钟）+转赠规则§四（每报告终身1次/与退款互斥/源限 purchase）；前端镜像 76 条正文行双向 diff 100% 验证 (E:/AI-Station/_proposals/xueyuan-market/AGREEMENT_COPY.md 头部数字对齐声明+§2.4；RUN_LEDGER #43/#45)

## Risks
- 提案目录滞后于实际交付：_proposals/qianwen-gc 与 _proposals/weapp-forge 均停在 09-28/09-29 批准门形态，总包AI顾问真实进展（0.7.7 提审、虚拟支付五步收官、类目绿灯）只在 WeAppForge/RUN_LEDGER.md 与 data/state/ 运行态文件——只读提案目录会得出过时结论
- 类目绿灯是今日（10-08 13:41）新鲜翻转：0.7.7 重提审动作可能正被其他会话执行中，任何重提审/发布相关动作前须先核 WeAppForge/RUN_LEDGER 尾部与 filing/ 目录，避免与在跑会话撞车
- wxd096fc6994ef6f48（提案期总包千问号）转役总包说系全局记忆结论，未在四个提案目录中找到文件证据——引用时须标注记忆来源
- 学园 6 份下架名单（38→32）与 13 份薄商品名单是既定默认决策（变更#2），若按 40 份口径谈论上架数量会与生产 catalog total=32 冲突
- 学园「生产 8871 四部署」中 #48 自述「生产三连部署」，ledger 显式编号的 deploy #4 在 #49——四次为合理重构口径，但严格计数以 ledger 原文为准
- 旗舰收入目标 ¥100,000（2026-11-07 截止）与 G5 首单（≥1 真实 ¥10,000 订单）是两个不同判据，勿混用；当前两者均未达成（订单库 paid=3 真单系 F5a-3 时代旧数）
- 多个等用户事项（商户五件套/offer_id/类目）为硬阻塞，若新工作假设其已到位会造成返工；本地 data/secrets/virtual_pay.secret 属于总包AI顾问（非学园），两套凭证不可互串

## Open Questions
- 总包AI顾问 0.7.7 重提审是否已在类目绿灯（10-08 13:41）后由某会话执行？watch_category_task.py 设计为「重提审留给会话腿」，需查最新 WeAppForge/RUN_LEDGER 或提审回执确认
- 0.8.0 客户端解锁 UI 的沙箱联调（requestVirtualPayment signData 线格式实证）当前进度如何——git status 显示 services/qianwen-engine 多文件+virtual_pay.secret 今日 17:07 在改，疑似正在进行
- 学园 PDF 夜航四晚批（pdfs 相位 6,309 片）在 ledger #35 之后无完成记录，ECS 侧 /opt/xueyuan/data/xueyuan/pdfs 实际是否灌满未验证
- 学园生产域名（PROD_BASE TBD）最终是否会复用 yrecepc.cn 已备案资产（如 xueyuan.yrecepc.cn）——旗舰侧 Beaver 墙经验（子域过墙=www/report 双 200 实证）可复用，但未见拍板记录
- 旗舰 F5b 悬决项「对己推草稿的改/更用法涉 0822 红线」仍标待用户裁决，未见后续翻案记录
- 学园类目最终选了什么：盯哨日志中总包AI顾问类目=「工具/信息查询,深度合成/AI问答,资讯/信息资讯」，学园自己的类目设置（教育/知识付费）无任何后台实证——REVIEW_PACK 口径仍是待办
