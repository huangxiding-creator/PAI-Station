# ARCHITECTURE — 总包学园·研报商城（Phase 5 架构设计）

> 生成：2026-09-28，Super-Skill Phase 5。上游冻结基线：REQUIREMENTS.md（28 FR+14 NFR）/ SCHEMAS.md（13 表 DDL）/ CONTEXT.md（41 条统一语言，术语强制）/ AI_NATIVE_OPTIONS.md（8 抉择）/ GITHUB_DISCOVERY_REPORT.md / FEASIBILITY_REPORT.md §四。
> 生产实核：services/qianwen-engine/qianwen_engine/{app.py,store.py,wechat.py,config.py}、WeAppForge/projects/zongbao/{config/index.ts,utils/pay.ts,app.json,project.config.json}、WeAppForge/work/ecs_deploy{,_v025}.py、WeAppForge/data/secrets/weappforge*.json。
> 纪律：本文件只写设计不写代码；接口契约详见同目录 API_DESIGN.md；表结构以 SCHEMAS.md 为基，本文只做继承细化与增补（增表/增列不改语义）。

---

## 一、系统总图

```
                       ┌─────────────────────── 微信开放平台 ───────────────────────┐
                       │ code2session │ 虚拟支付(签名/服务端回调/refund_order)        │
                       │ getUnlimitedQRCode(码池预生成, P1)  订阅消息(P2)            │
                       └───────▲──────────────▲────────────────────▲───────────────┘
                               │ HTTPS       │ 服务端推送(回调)     │ 出码
                               │             │                     │
┌────────────────────────┐     │             │   ┌─────────────────┴─────────────────┐
│ 小程序「总包学园」       │     │             │   │  xueyuan-engine (FastAPI)         │
│ WeAppForge/projects/   │     │             │   │  ECS 47.120.43.20 : 8871          │
│ zongbao（原位改造）     │     │             │   │  systemd: xueyuan-engine.service  │
│  index  商城首页        │─────┼─────────────┼──►│  ┌───────────────────────────┐    │
│  reader 分章阅读器      │  Bearer+JSON     │   │  │ app.py 路由装配+限流+异常   │    │
│  ai     AI伴读(P2)      │  (试读免登录)     │   │  ├─ catalog/fts 检索降级     │    ├──► 企微推送
│  me     我的权益        │◄────┼─────────────┼───│  ├─ chapters 权益裁剪下发    │    │   (上新/退款日报/
│ featureFlags 三开关：   │     │             │   │  ├─ virtual_pay 签名/回调    │    │    熔断告警)
│  virtualPay/cloud/     │     │             │   │  ├─ download 双PDF水印流式   │    │
│  voiceInput            │     │             │   │  ├─ poster/criticize/refund │    │
└────────────────────────┘     │             │   │  │   /voucher/team (P1)      │    │
        ▲                      │             │   │  └───────────────────────────┘    │
        │ 扫码(scene r=短ID&i=短ID)          │   │        │              │            │
   情报卡海报(1080×1440, P1)◄────────────────┼───┼────────┼──────────────┘            │
                                              │   │        ▼              ▼
                                              │   │  ┌───────────┐  ┌──────────────┐
                                              │   │  │ SQLite    │  │ 内容静态区     │
                                              │   │  │ 13表+增补  │  │ data/xueyuan/ │
                                              │   │  │ FTS5虚表   │  │ pdfs/ posters/│
                                              │   │  └───────────┘  └──────────────┘
                                              │   └───────────────────────────────────┘
                                              │                ▲
┌────────────────────────────────┐            │                │ 上传(tar 分片→云助手)
│ EPC100 内容产线（本地）          │────────────┴────────────────┘
│ 40 docx(358MB)+持续补货          │
│ content_pipeline 批处理:         │   docx→mammoth HTML→h1切章→噪声过滤→试读/空壳拆分
│ →chapters.json+catalog.json     │   →双PDF(Edge headless+压缩)→进库(reports/chapters/FTS)
│ →情报卡素材(最狠1数据+1结论)      │   版权审计(重绘/删除/获授权)阻塞提审
└────────────────────────────────┘
```

一句话：**单引擎（xueyuan-engine:8871）+单库（SQLite 含 FTS5）+小程序原位改造（zongbao 四页）+微信官方 API 外联**，内容由 EPC100 产线批处理进库，钱货两清全走虚拟支付道具直购。

## 二、服务边界

**1. 单体引擎，不拆微服务。** 全部业务域（检索/权益/支付/下载/海报/批评评分/退款/书券/组队）收敛为一个 FastAPI 进程、一个 SQLite 库。理由：
- 规模判据：40-200 份报告、月千级访客（FEASIBILITY 2.2 保守-乐观档），读写 QPS 个位数；SQLite 单写锁（qianwen-engine store.py 在役惯例：`threading.Lock`+每操作短连接）绰绰有余。
- 域间耦合天然紧密：支付回调→权益→按权益下发→下载水印，跨服务拆分=自造分布式事务。
- 运维成本：单 systemd 单 venv 单部署链（12 分钟上云实测）；拆微服务在单人运营（FEASIBILITY 3.1）下是纯负资产。
- 内部以**模块边界**代偿服务边界：app.py 仅装配路由，业务域各自成包文件（见 §六目录规划），P1 各域（poster/criticize/refund/voucher）新增不改 P0 文件——「逻辑微服务、物理单体」。

**2. 前端三开关，翻转为零改码。** featureFlags（virtualPay/cloud/voiceInput，zongbao config/index.ts 在役实样）+`trialChapterCount:2`。后台能力到位→改配置发版即翻转；服务端另有 503 降级与之双层叠加（任一层触发支付灰置，NFR-10）。

**3. 边界外的四类依赖全部官方化**：微信 API（code2session/虚拟支付/refund_order/getUnlimitedQRCode/订阅消息）、企微推送（日报/告警/上新）、EPC100 产线（本地批处理后上传，不占引擎算力）、ECS 既有多服务（8864/8869/8881/8882 与 8871 平行共存，见 §七）。

## 三、ADR 决策记录（C5 格式：背景/选项/决定/后果）

### A1 单体引擎 vs 微服务
- **背景**：商城+支付+评分退款+裂变归因多业务域；FEASIBILITY §四要求 A/B/C 三线并行、2-3 工作日联调上线。
- **选项**：A 单体 FastAPI（模块化包）；B 按域拆微服务（支付/内容/评分各自容器）；C 云函数承载签名与生成。
- **决定**：**A**（AI_NATIVE_OPTIONS #7 抄 qianwen-engine 骨架，同构度>80% 实核成立）。
- **后果**：正——部署/对账/排障单点收敛，R-07 单点故障有 systemd+云助手 12 分钟重部署兜底；负——进程内互拖（评分线程异常理论上可拖慢支付腿）→以后台线程+超时隔离（qianwen `_run_answer` 同款），域间只经 SQLite 解耦。

### A2 检索=SQLite FTS5+jieba 预分词（含 R-10 三层降级）
- **背景**：三层搜索（标题/摘要→章节标题→商机关键词）+热词联想，NFR-01 P95<500ms；默认 tokenizer 不适配 CJK（R-10）。
- **选项**：A FTS5+入库前 jieba 切词存空格连接列；B 微信云开发搜索；C Elasticsearch。
- **决定**：**A**（AI_NATIVE_OPTIONS #3：零新依赖零成本，40-200 份规模绰绰有余）。
- **后果**：正——同栈同库同机，无外部服务；负——分词质量依赖 jieba 词库、整句成串不命中风险→三层降级逐层放宽+LIKE 全扫兜底（该规模全扫 P95 可达标），检索非唯一发现路径（榜单/筛选/省份地图补位）。检索只做关键词不做向量（REQUIREMENTS 4.2：上向量=蹭）。

### A3 内容交付=服务端按权益下发+空壳章防泄漏
- **背景**：付费正文若进小程序包，反编译即泄漏（R-06）；免登录试读要求 0.5 分钟直读。
- **选项**：A 包内嵌全文（客户端加密）；B 包内只放试读章正文+空壳章，付费正文服务端按 entitlements 判据下发。
- **决定**：**B**（AI_NATIVE_OPTIONS #5；content_pipeline 已实测付费章 html="" 空壳）。
- **后果**：正——解包审计判据可验（FR-P0-07「grep 付费章关键词零命中」）；试读章带正文进包保离线秒开（NFR-02/NFR-11 试读缓存页）。负——付费章阅读依赖在线→引擎侧单账号限流（60 次/分配置项）+企微告警（NFR-05）；本地权益缓存（zongbao store 惯例）只做先行动作，冲突服务端赢。

### A4 海报=服务端 PIL+小程序码预生成池（P1）
- **背景**：情报卡=社交货币（1080×1440）；getUnlimited 5000 次/分限频、scene ≤32 可见字符（R-11）。
- **选项**：A 服务端 PIL 模板；B 端侧 wxml-to-canvas；C 云函数绘图。
- **决定**：**A**，码从预生成池取（批量生成期实时调用量=0）；端侧仅留「实时昵称头像」补充位（AI_NATIVE_OPTIONS #2）。
- **后果**：正——千机一面、模板改不发版、字体渲染可控；负——引擎承担图片合成 CPU 与静态文件存储（data/xueyuan/posters/），海报 URL 直出无 CDN（规模不需要，P2 再评估）。scene 直拼 `r=短ID&i=短ID`（≈18 字符），溢出走短码映射（poster_code 表），解析失败归因降级不阻塞免费阅读。

### A5 支付=道具直购+pay_sign 双签名+offerId 缺 503 降级
- **背景**：数字内容虚拟支付强制（2026-04-01 全终端）；offer_id/product_id 须用户后台开通后回传（外部等待不可控）。
- **选项**：A 等开通后再开发支付；B JSAPI；C 道具直购 short_series_goods+服务端双签名+凭证缺 503 灰置。
- **决定**：**C**（AI_NATIVE_OPTIONS #4+#7；WFR #43/#45 实证 503 不阻塞、回填重启即恢复）。
- **后果**：正——开发/提审与开通完全并行（调度图 F）；一个通用道具（product_id=xy_report_unlock，49800 分）解全部报告，绑定关系在 outTradeNo。负——pay_sign 依赖 session_key（过期 401→前端静默重登重试，qianwen 在役惯例）；回调确切字段与部分退款参数级语义 **TBD（开通后实测，见 API_DESIGN §四）**。

### A6 批评评分=代码闸+免费模型判断层+熔断
- **背景**：按分退款（50→50%…100→100%）是真金白银裁量；LLM-as-judge 三偏差（位置/冗长/自我偏好，Zheng 2023）。
- **选项**：A 纯规则打分；B 纯 LLM 裁量；C 代码闸（资格/字数/查重/锚定分）→免费模型判断层（三维分+依据）→确定性映射→熔断硬门。
- **决定**：**C**（AI_NATIVE_OPTIONS #1+#8；免费模型优先铁律——全流程付费模型 API 调用数=0）。
- **后果**：正——AI 只有建议权无放款独裁量（自动退仅 ≤50% 档，100% 档命中黑名单特征转人工）；证据先行（锚定分=0 直接不给退）压制模板化薅退。负——判断层异步（提交秒回、评分结果轮询）；熔断停新发发起不中断已公示义务（承诺即合同）。

### A7 部署=云助手分片+systemd+双层墙（照抄 8869 作业）
- **背景**：ECS 47.120.43.20 已在付（零新增固定成本）；SSH 22 不对公网，通道=云助手 RunCommand。
- **选项**：A 新购服务器/容器平台；B 同 ECS 新端口 8871，tar→base64 分片→云助手→systemd→探针，ufw+安全组双层墙。
- **决定**：**B**（WFR #32-34 从打包到公网探针 12 分钟实测；NFR-14 从零重部署 ≤30 分钟）。
- **后果**：正——与 8869（qianwen-engine）/8864（laya-server）平行共存互不干扰（独立 venv/独立 DB/独立 unit）；负——单机单点（R-07）→systemd Restart=always+本地 8870 影子实例+前端「服务维护」降级兜底；安全组层只能用户控制台开闸（开闸请示一次到位）。

### A8（增补）前端=原位改造 projects/zongbao，不新开 projects/xueyuan
- **背景**：zongbao 四页脚手架适配度 80%（GITHUB_DISCOVERY §二），需判定改造还是新开目录。
- **选项**：A 新开 projects/xueyuan 从 zongbao 复制；B 原位改造 projects/zongbao。
- **决定**：**B 原位改造**。实核证据（2026-09-28）：①`projects/zongbao/project.config.json` 的 appid=**wxfdb55b184756e89e**（总包学园本体），projectname=`zongbao-xueyuan`，app.json 导航标题已是「总包学园」——zongbao 自始就是总包学园的脚手架代号而非另一小程序；②forge 注册表 `data/secrets/weappforge.zongbao.json` 已绑定该 appid↔`projects/zongbao`（与 biaoxun wx5cee1574ce45819b、qianwen wxd096fc6994ef6f48 三足鼎立，**无占用冲突**）；③`content_pipeline.py` L21 `PROJECT = ROOT/"projects"/"zongbao"`，试点内容已落位。
- **后果**：正——上传密钥/注册表/管线默认值零改动，`node pipeline/forge.mjs`（secrets 指到 weappforge.zongbao.json）即用；负——目录名与产品名不一致属历史代号（工程内以注册键为准），文档统一按「zongbao 目录=总包学园前端」表述。

## 四、数据流（四条关键链路）

**链路① 扫码→试读（免登录 0.5 分钟，FR-P0-04/FR-P1-07）**
1. 用户长按情报卡→识别小程序码，scene=`r=报告短ID&i=邀请人短ID`（≤32 字符）随 query 进入 reader 页；
2. 前端 `decodeURIComponent(options.scene)` 解析出报告短 ID（解析失败→归因降级：默认报告+邀请人置空，不报错）；
3. （P1）`POST /invite/scan` 落 scan_visit；已登录新用户落 invite_relation（首触归因：UNIQUE(invitee_uid,report_id) 先到先记）；
4. `GET /reports/{id}` 取详情+决策卡数据；`GET /reports/{id}/chapters` 取目录——试读章（is_trial=1）正文随包内文件秒开，服务端为对账真源；
5. 读至试读末章→决策卡（已读 X 页/还有 Y 章 Z 页/N 条核心结论模糊预览+目录树）→未购拉付费章→4xx 且无正文字段。

**链路② 发起支付→签名→回调→解锁→下载（FR-P0-06/07/08）**
1. 前端 wx.login→`POST /auth/login`{code}→code2session→服务端存 session_key（绝不下发）+签发 Bearer token；
2. 详情页点「解锁全文」→`POST /pay/sign`{report_id}；
3. 引擎四步闸：权益查重（已解锁→**409**）→订单 upsert（outTradeNo=`{reportId}_{ts}` 幂等键，pending）→offerId/product_id 缺→**503 降级**（前端灰置）→wechat.virtual_pay_sign 双签名（appsecret+session_key）；
4. 前端 wx.requestVirtualPayment 原样透传 sign_data+pay_sig+signature 拉起支付；成功回调先本地解锁缓存（体验先行）；
5. 微信服务端→`POST /pay/callback`（幂等）：核对 outTradeNo→orders.status=paid+wx_order_sn+raw_notify 落原文→**首次**发放 entitlements(source=purchase)；重复回调恒 200 同果，不重复加权益；
6. 前端轮询 `GET /pay/status` 确认发货（回调未达→引擎查单腿核对，接口名 TBD）；
7. 已购列表即时出现（`GET /me`）→`GET /reports/{id}/download?type=read|print`：流式下发预压缩双 PDF+按购者昵称+订单尾号合成水印（TTFB<2s，NFR-03/06）。

**链路③ 点赞→赠报告（附条件赠送，FR-P1-01）**
1. 站内点赞（与分享动作完全解耦——任何分享/转发不触发得赠）→`POST /reports/{id}/like`（Bearer）；
2. 引擎资格闸：当日已赠（gift_grants UNIQUE(user_id,grant_date)）→429「明日再来」；
3. 从该用户**未购清单**随机指定一份赠品报告（随机性仅在指定哪份，必得非抽奖，无概率公示义务）；
4. gift_grants 落库+entitlements(source=gift)→立即可全文阅读；
5. 赠品池规则页常驻公示（「必得·附条件赠送」表述）。

**链路④ 批评提交→评分→退款双轨（四层闸，FR-P1-02~06）**
1. 已购者在报告页发起批评→`POST /reports/{id}/criticize`{content}；
2. 层①资格闸（引擎侧）：真实阅读行为（read_log 判据）/每报告每用户 1 次（criticisms UNIQUE）/当月退款 ≤2 次；
3. 层②代码预筛（同步返回 pre_gate 结果）：字数 50-300→n-gram+语义查重（超阈值转人工队列）→锚定分（引用具体章节/数据点；模板化话术=0 直接不给退）；
4. 层②判断层（异步，免费模型）：真诚度/真实度/建设性各 0-100+评分依据（批评哪句↔报告哪节）；
5. 层③映射：final_score≥50 线性按分退；<50 不退+感谢券（vouchers source=criticism_thanks）；
6. 双轨执行：**Android**→refund_order 自动原路退（自动退仅 ≤50% 档；更高档/黑名单特征→manual_review）；**iOS**→开发者不可主动退→等额书券补偿（vouchers source=ios_refund）+引导苹果通道（双轨公示）；
7. 层④硬门熔断：单报告退款率>25% 或全站周退款额>营收 15%→自动停「新发起」（423）+企微当日告警；已公示退款义务继续履行；
8. 退款结果回调→`POST /refund/callback`（幂等）→refunds.status 推进；得分 ≥50 批评自动进 EPC100 改进队列（层④回流）→v2 版本致谢署名+月度真诚批评家榜单。

## 五、安全设计

**1. 密钥外置（NFR-04）**——`data/secrets/` 三文件，代码/日志/仓库零硬编码（`git grep` 判据）：

| 文件 | 内容 | 消费方 |
|---|---|---|
| `xueyuan_mp.secret` | `appsecret=`（总包学园 wxfdb55b184756e89e） | code2session/pay_sign |
| `virtual_pay_xueyuan.secret` | `offer_id=`/`product_id=`/`env=`（0 正式 1 沙箱）三行 key=value | virtual_pay（缺→503 降级） |
| `xueyuan_engine_hmac.key` | 引擎 HMAC 密钥（首启自动生成，qianwen 同款） | Bearer token 签发/校验 |

**2. 付费正文永不下发未授权（NFR-05/FR-P0-07）**：包内空壳章+库内付费正文只存服务端+响应裁剪三重防线；未购 token 请求付费章→4xx 且**响应体不含正文字段**（不是空串而是字段缺席）；单账号付费章拉取超阈值（默认 60 次/分，配置项）→429+企微告警。

**3. 水印溯源（NFR-06）**：每份下载 PDF 水纹=购者昵称+订单尾号，与 pay_log（orders 表承载）比对可定位订单；P2 前转赠额度锁定为 0；泄漏源经水印指纹定位后走微信官方侵权投诉通道。

**4. 防刷：资格闸全部在引擎侧，前端闸仅为 UX**——支付权益查重（409）、点赞日限（429）、批评四层闸、熔断（423）、限流（429）皆服务端判定；openid 永不进 scene/日志（短 ID 化+attach=sha256(openid)[:16] 脱敏关联，qianwen 在役实样）；session_key 仅服务端留存绝不下发。

**5. 认证**：Bearer token=HMAC-SHA256 载荷签名（{openid,exp}，30 天有效，qianwen wechat.py 同款）；过期 401→前端静默重登换发重试一次；微信回调腿不走 Bearer（签名校验方式 TBD 开通后实测）。

**6. 错误信息不泄漏内部细节**：对外错误体统一 {code,message}（机器码+人类可读中文）；堆栈只进引擎日志。

## 六、目录规划（Phase 7 直接用）

**引擎**（新建 `E:\AI-Station\services\xueyuan-engine\`，包名 xueyuan_engine，单文件 ≤400 行红线）：

```
services/xueyuan-engine/
├─ requirements.txt            # fastapi uvicorn[standard] curl_cffi（抄 qianwen）+ jieba Pillow pypdf（新增三件）
├─ xueyuan_engine/
│  ├─ __init__.py
│  ├─ config.py                # 路径/常量/阈值（限流 60/min、试读占比 15-25%、熔断 25%/15% 全为配置项）
│  ├─ app.py                   # FastAPI 装配+路由注册+{code,message} 异常处理器+限流中间件；无业务逻辑
│  ├─ wechat.py                # code2session/HMAC token/virtual_pay_sign 双签名——逐行照抄 qianwen（在役）
│  ├─ store.py                 # SQLite DDL（SCHEMAS 13 表+§下增补）+单写锁+每操作短连接（抄 qianwen store 惯例）
│  ├─ catalog.py               # /catalog /reports/{id}：榜单/筛选/决策卡数据/预览三件套（三维关联推荐=结构化匹配不用 AI）
│  ├─ fts.py                   # FTS5 虚表+jieba 预分词+三层降级+LIKE 兜底（A2）
│  ├─ chapters.py              # 按权益裁剪下发/空壳章/阅读行为落 read_log
│  ├─ virtual_pay.py           # /pay/sign /pay/callback /pay/status+orders 状态机+pay_log 对账
│  ├─ download.py              # 双 PDF 流式下发+水印合成（昵称+订单尾号）
│  ├─ poster.py                # [P1] 情报卡 PIL 生成+码池+归因三表写入
│  ├─ criticize.py             # [P1] 四层闸+免费模型判断层（异步线程）
│  ├─ refund.py                # [P1] 退款双轨+refund_order+熔断+日报数据
│  ├─ voucher.py               # [P1] 书券账本（发放/核销/余额）
│  ├─ team.py                  # [P1] 组队（3 人 ¥998 满员发放）
│  └─ notify.py                # 企微推送（上新/退款日报/告警）
└─ tests/                      # test_pay_sign 5 向量迁移+FTS 降级+幂等/409/503 契约单测（XY_DEV_LOGIN=1 双闸惯例）
```

**数据与静态区**：`data/xueyuan/`（db.sqlite、pdfs/、posters/）；`data/secrets/` 三件（§五-1）。

**SCHEMAS.md 之外的增补表**（Phase 5 增补，不改既有语义，继承「外键跨表用短 ID」纪律）：

| 增补表 | 期 | 字段要点 | 动机 |
|---|---|---|---|
| favorites | P0 | user_id,report_id,created_at, UNIQUE(user_id,report_id) | FR-P0-09 收藏以服务端状态为真源 |
| read_log | P1 | user_id,report_id,chapter_id,ts | 层①资格闸「真实阅读行为」判据 |
| teams / team_members | P1 | teams(id,report_id,leader_uid,status) / team_members(team_id,uid,out_trade_no,joined_at) | FR-P1-10 组队订单 99800 分 |

**前端**：原位改造 `WeAppForge/projects/zongbao/`（判定=A8，四页映射照 engine_conventions §3c：index→商城首页、reader→分章阅读器、ai→AI 伴读 P2、me→我的权益）；md2blocks 从 projects/biaoxun 搬入 utils/；content/ 目录由 content_pipeline 继续产出。

**内容产线**（本地，不在引擎内）：`WeAppForge/pipeline/content_pipeline.py` 增批处理循环+PDF 压缩腿+进库钩子（catalog/chapters/FTS 同步建索引）——Edge headless 仅本地跑（ECS 无 Edge，PDF 预生成后上传，content_pipeline.md §10 坑）。

## 七、部署拓扑

```
ECS 47.120.43.20（阿里云，SSH 不对公网，通道=云助手 RunCommand）
├─ /opt/xueyuan/                          # 与 /opt/qianwen 平行，互不覆盖
│  ├─ services/xueyuan-engine/xueyuan_engine/
│  ├─ data/secrets/{xueyuan_mp.secret, virtual_pay_xueyuan.secret, xueyuan_engine_hmac.key}
│  ├─ data/xueyuan/{db.sqlite, pdfs/, posters/}
│  └─ venv/                               # 独立 venv：fastapi uvicorn[standard] curl_cffi jieba Pillow pypdf（阿里云 pypi 镜像）
├─ /etc/systemd/system/xueyuan-engine.service
│    [Unit] After=network.target
│    [Service] WorkingDirectory=/opt/xueyuan/services/xueyuan-engine
│    ExecStart=/opt/xueyuan/venv/bin/python -m uvicorn xueyuan_engine.app:app --host 0.0.0.0 --port 8871 --log-level warning
│    Restart=always  RestartSec=3         # kill -9 后 3s 自动拉起（FR-P0-10/NFR-11）
│    [Install] WantedBy=multi-user.target
└─ 双层墙：ufw 放行 8871/tcp → 阿里云安全组放行 8871（后者仅用户控制台可开——开闸请示一次到位）
```

- **健康探针**：公网 `GET /health`→200 {ok:true}（无鉴权、不泄内部态）；kill 主进程→systemd 拉起→探针恢复（验收判据 7）。
- **共存互不干扰**：8864=laya-server、8869=qianwen-engine、8871=xueyuan-engine、8881/8882=nginx 站点——端口/venv/DB/systemd unit/secret 文件集五独立；云助手部署脚本只写 /opt/xueyuan 前缀。
- **提审生产域名**：小程序正式环境 request 须 https+备案域名→nginx 反代 `https://{域名}/api/v1`→127.0.0.1:8871（域名与备案 **TBD 用户定**；开发/体验版可 http://47.120.43.20:8871 + 开发者工具「不校验合法域名」）。
- **本地 dev 惯例**：`uvicorn xueyuan_engine.app:app --port 8872`（云 8871 的本地影子位；**8870=qianwen-engine 在役门实例专属，勿占**——2026-09-28 实测撞车教训）；测试双闸 `XY_DEV_LOGIN=1`（照抄 QW_DEV_LOGIN：code 直映射 dev openid）。
- **重部署**：ecs_deploy 脚本换装（ENGINE 指向 xueyuan-engine、前缀 /opt/xueyuan、端口 8871），从零到公网探针 200 全程 ≤30 分钟演练一次（NFR-14）。

---

## 附：NFR→设计条目覆盖索引

NFR-01→§三A2/§四②｜NFR-02→试读章进包秒开（A3）+catalog 双源（包内 catalog.json 先渲染）｜NFR-03→链路②-7 流式水印｜NFR-04→§五-1｜NFR-05→§五-2/4｜NFR-06→§五-3｜NFR-07→提审类目口径（mp_review_compliance，运营项不属架构件）｜NFR-08→披露文案为前端+harness 断言（API 供给 refund_policy_url/价格锚数据）｜NFR-09→链路③附条件赠送语义/无概率玩法｜NFR-10→A5/API_DESIGN §二-503 契约｜NFR-11→A7/systemd/前端降级｜NFR-12→notify.py 日报腿｜NFR-13→virtual_pay.py 对账三腿（API_DESIGN §四）｜NFR-14→§七重部署。
