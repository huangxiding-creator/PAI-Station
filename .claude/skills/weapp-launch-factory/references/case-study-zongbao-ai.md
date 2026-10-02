# 总包AI顾问（zongbao-ai）全弧线案例研究：从一句话想法到提审上线

> 事实源：`E:\AI-Station\WeAppForge\RUN_LEDGER.md`（83 条台账）、`qianwen-gc-proposal.md` 记忆档、`_proposals/qianwen-gc/`（PROPOSAL+SCORECARD）、`_proposals/qianwen-100x/`（PROPOSAL+SCORECARD+GAP_REPORT+RESEARCH_DIGEST）。全部版本号/数字/路径照抄源文件。

## 0. 一页速览

| 项 | 值 |
|---|---|
| 产品 | 总包AI顾问——工程行业免费公益 AI 问答小程序（终态 v0.7.0 起付费墙拆除；100× 弧线期曾为两级产品=付费 KB 专业解答+免费智谱快答，见 §3） |
| appid | 真身 `wx5cee1574ce45819b`（该号带 2025-05 外包「哈萨藏」线上版 1.0.7 包袱）；早期 v0.1.x 曾打在用户另一号 `wxd096fc6994ef6f48`（总包千问；**注意：该号 0930 起已转役为「总包说」官网小程序主号，做 appid 差分对照时选别的对照号**） |
| 前端 | 原生小程序（WeAppForge/projects/biaoxun，0929 更名 `zongbao-ai`）：ask/answer/pot/zhiku/my 五页 + home 跳板页 |
| 引擎 | FastAPI + uvicorn + SQLite（services/qianwen-engine），ECS 47.120.43.20:8869，systemd `qianwen-engine.service` 常驻 |
| 域名 | 三切轨：gcbrain.top（备案卡壳）→ api.yrecepc.cn（1001 在役）→ **ai.epcschool.top**（1002 终轨，Tencent 云全栈） |
| 最终形态 | v0.7.6，robot 上传 124,008B，BOOT-SIM 241/241 |
| 周期 | 2026-09-28 → 2026-10-02，五天 |
| 版本数 | 25 个（v0.1.0→v0.7.6）；上传累计用 robot1-10 + 命名号「总包君」（轮转机制=robot 1..30 循环游标） |
| 结局 | 1002 10:12:15 提审成功（审核版本 0.7.6 · 审核中）；此前 0.7.4 拒审（AI 标识公告）已根治 |

## 1. 想法与调研

**用户初步想法**：把秘塔「工程大脑」包装成小程序，卖 10 秒带出处的专业答案。0928 五腿前的第一轮调研（RESEARCH_DOCKET 111 docs / 6 渠道）实测推翻了字面方案：

- 秘塔 search-api 计费标签全集=全网/文库/学术/图片/视频/播客，**没有「专题/知识库」项**——工程大脑只活在网页版 cookie 会话里；
- 秘塔 API 积分是独立池且当时=0；每次全网问答 1 点=¥0.0108（1 元收入毛利 98%）。

**结论翻案**：字面上的「包装工程大脑 API」不成立，但用户要的是「工程大脑级的答案能力装进小程序」→ 双引擎（KB 网页直连为主腿 + search-api 外援腿）。

**0929 深夜 100× 弧线五腿调研**（RESEARCH_DOCKET/{internal-audit, github-chat, github-render, web-competitors, web-ux}，台账另记 idea-seed 腿）→ RESEARCH_DIGEST → GAP_REPORT G1-G12。**市场空白实证**（DIGEST 原文）：「全网未发现『工程垂直 × AI 问答 × 小程序』同构产品」；法律 AI 全是通用法域、建筑产品全是课程/题库/真人问答——「窗口有限，速度即护城河」。第一轮提案另实证「全行业无 1 元级按次 AI 问答（最近先例=律品法律 9.9 元/次）」。

**调研纪律**：星数/许可证/维护状态当日实测；明确排除清单（towxml 挤占 2MB 主包、Vant/TDesign 整库、lottie canvas 瓶颈、weapp-qrcode 前端码不可归因、katex-mini 无 LICENSE、GPL 的 ChatGPT-MP 只学模式禁抄码、「AI 生成」警示标签=信任悖论降信任）。

## 2. 提案与决策

两次提案两道 SCORECARD 门，均在开发之前：

| 提案 | 日期 | 评分 | 用户批准 |
|---|---|---|---|
| qianwen-gc（总包千问） | 0928 | feasibility 0.85 / user_value 0.88 / monetization 0.82 / tenx 0.99 → **0.888 proceed**（tenx_qualified 3162×） | 「全部批准，全部开发」（C8 全自主） |
| qianwen-100x（v0.6.0 弧线） | 0929 深夜 | 四维 0.93/0.90/1.00/0.85，台账记加权 **0.818 proceed** | 预授权原话：「完成这个提案之后，请你自主的进行那个开发实施。然后的话推送到小程序的后台里面去。确保这个小程序是可以使用的。」 |

**架构三次用户纠偏（记忆档判词：「09-28 实弹翻案，用户三次纠偏全对」）**：
1. 主引擎=工程大脑 KB 网页直连（`POST /api/knowledge/chat`，We-AIPO 契约，curl_cffi chrome 指纹绕 TLS WAF，网页积分池免费 100 点/天≈3 点/问），search-api 降为外援腿——不是给 API 套壳。
2. 智谱免费链 key 位置：agent 曾误断「无 zhipu key」，用户两连纠正——key 就在超级AI工作站 `E:/AI-Station/config/llm.secret.ini`。教训：找 key 前先翻 PAI-Station 配置。
3. 免费成本铁律（用户令）：只有工程大脑答题烧 KB 积分，其余全链免费。

**节奏决策**：09-28 提审暂缓令在效期间全走开发版/体验版通道交付；0930 用户提审 0.7.1；1002 提审前三线终验=用户令「功能+提审填写都确认才提交」。

## 3. 架构定型

```
小程序（原生, zongbao-ai）
   │  BASE_URL → https://ai.epcschool.top（史: IP→gcbrain→yrecepc→epcschool）
   ▼
FastAPI+uvicorn+SQLite @ ECS 47.120.43.20:8869（systemd 常驻 Restart=always）
   ├─ /api/ask          工程 KB 直连（唯一付费位 ~3点/问，curl_cffi 绕 WAF）
   ├─ /api/answer/{aid}/followup  智谱免费链接地追问（双限额）
   ├─ /api/answer/{aid}/digest    tldr3×60字+related3×40字（一次生成永久缓存）
   ├─ /api/answer/{aid}/poster    Pillow 750×1334 海报+wxacode 码（BLOB 缓存）
   └─ zhipu.py 免费池：429→冷却120s切模型 / 1113 摘链 / 1301 立即失败
       glm-4-flash-250414 → glm-4.7-flash → glm-4.5-flash，双 key
```

- **两级产品语义**（100× 提案核心支点）：「贵的答案只买一次，便宜的解释无限次」——工程大脑·专业解答（付费 KB）+ 智库助手·快答（免费智谱以本篇全文接地，界面明标「快答 · 基于本篇解答」）。
- **免费成本架构对账**（SCORECARD free_cost_fit=1.0）：KB 日积分消耗不升；追问/digest=智谱；海报=纯 Pillow；digest/海报每答案只算一次成本。
- **本地双实例**：生产 8869 + 带闸测试 8870（`global.__QW_BASE__` 覆盖口），harness 打 8870 不停机生产。
- **时区无关北京日**：`_today()=gmtime(time+8h)`；追问日界 `now-((now+8*3600)%86400)`。

**配方（照抄源文件的可复用片段）**：
- followups 表迁移（只增不删铁律）：
```sql
CREATE TABLE IF NOT EXISTS followups (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  aid TEXT NOT NULL, openid TEXT NOT NULL,
  question TEXT NOT NULL, answer TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL DEFAULT 'pending',   -- pending|ready|error
  error_text TEXT DEFAULT '', created_at REAL
);
CREATE INDEX IF NOT EXISTS idx_followups_aid_openid ON followups(aid, openid);
-- answers 表新增列（ALTER 只加不改）：tldr / related（JSON 数组）、poster BLOB 缓存
```
- 虚拟支付双签名（真机 -15005/-15006 按官方签名详解校前缀一处改）：`pay_sig`=appsecret 腿拼 `requestVirtualPayment&` 前缀；`signature`=session_key 腿拼 `VirtualPayment&` 前缀（键隔离/逐字节绑定/中文不转义，5 向量单测）。
- 智谱免费池熔断语义：429→冷却 120s 切模型；429+1113 余额耗尽→摘链；400+1301 内容审核→立即失败；模型序 glm-4-flash-250414→glm-4.7-flash→glm-4.5-flash。
- 接地追问提示词骨架（100× 提案实测 1.9s/153 字）：「只依据『专业解答』回答追问；先核对解答中适用前提是否满足，再下结论；信息不足时如实说明并建议就这一点发起新的正式咨询。要求：结论先行，条理清晰，引用解答原文关键句，300 字内。【原始问题】…【专业解答】…【用户追问】…」。
- 追问护栏：每答案每人 ≤10 问/天+全局 20/天/人，正文 ≤200 字；未配置智谱=503 无 KB 回落（免费铁律——KB 永不兜底保积分池）。

## 4. 开发迭代节奏

五天四波用户令驱动的密集迭代（详见附录A）：

| 日 | 波次 | 用户令 | 关键功能 | 关键坑 |
|---|---|---|---|---|
| 0928 | v0.1.x→v0.2.6 | 「全部批准」「自行测试优化+美观流畅」「上云」「顶级排版」「接1元解锁虚拟支付」改名令 | 三页问答壳→异步流水线→ECS 上云→md2blocks 排版→虚拟支付双签名→改名总包AI顾问 | appid 抄错一字符；WXML `{{!question.trim()}}` 禁方法调用；tabBar 页 fixed 被原生 tabBar 盖点击 |
| 0929 | v0.3.1→v0.5.1 | 「顶级 UI」「桌面自测台彻底优化」三连令、语音三连令、九点令、「一定不要再犯了」 | 工程蓝图 UI 重做；导出 docx/pdf；语音全功能又全撤；6次/天+四动作赠次；锅圈页；home 跳板根治 404；智谱免费链 | robot 顶替钉位；无路径入口按线上 1.0.7 老表解析；store.init() `_LOCK` 不可重入 |
| 0930 | v0.6.0→v0.7.1 | super-skill 全步令（调研→提案→自主开发→推送后台） | 追问对话流/要点速览/相关问题/分享海报四端点；域名换轨 gcbrain+备案攻坚 | `.format()` 花括号；GBK ✓ 字符；POSTER_QR_ENV_VERSION 误置 release |
| 1001-1002 | v0.7.2→v0.7.6 | 十一点令（周换装/计数/授勋/复制下线/锅圈百条）；「功能+提审填写都确认才提交」 | yrecepc 域名+全链模拟器自测；周换装主题 7×52；付费墙拆除后合规三线 | 0.7.4 拒审（AI 标识公告）；mp 控制台翻译扩展 span 坑 |

迭代机械学：`forge deliver` 一条命令=编译闸+harness+上传+体验码推企微（v0.2.x 时代单次上传 6-9s）；每次换版交付双码（体验版码+开发版码）；引擎改动走 ECS 分片部署+py_compile+重启+生产 smoke。

## 5. 测试门

三道门随版本单调增长，无一回退：

| 版本 | BOOT-SIM（客户端模拟） | 引擎 tests |
|---|---|---|
| v0.2.0-0.2.5 | harness 26 断言 | — |
| v0.4.0/v0.4.1/v0.4.2/v0.4.3 | 59→61→67→71 | — |
| v0.5.0 / v0.5.1 | 98 / 109 | 27/27 / 28/28 |
| v0.6.0 / v0.7.0 / v0.7.1 | 126 / — / 158 | 38/38 / 46/46 |
| v0.7.2 / v0.7.3 / v0.7.6 | 175 / 205 / **241** | 47/47 |

- **BOOT-SIM 检查名示例**（照抄台账）：「WXML 零方法调用绑定」「预填线」「四端点」「entrancePath 显式页」「优雅降级全查」「home 四查」「无跳板页」「全包 walk 零老标讯字样」。
- **引擎测试纪律**：fixture 默认禁 zhipu 全离线——本地有真 zhipu.secret 时测试必须 mock，否则碰真网；test_poster_env_cache_separation 改方向无关断言（不假设默认值）。
- **1001 模拟器全链自测（零缺陷门）**：automator(9420)+IDE CDP(9333) 六腿全绿且逐条对生产 DB 核验——真 KB 咨询 2271 字/14.9s、额度 6→5、追问智谱接地、点赞+奖次、海报缓存、home 跳板 reLaunch 干净栈、全页 walk 零 JS 错误。
- **1002 提审前三线终验**：①API 面 root/pot/quota 401 fail-closed；②模拟器六页巡检 ask/pot/zhiku/my/legal/answer 0 错误+额度链 login→token→quota 200+答案页 14 blocks；③表单六项核对（版本描述 187/200 旧文案→重写 184/200、测试账号=无需登录、企业微信=否、隐私指引=采集用户隐私、订单 path 空、不加急）。

## 6. 部署上云

**v0.2.3 上云四步（0928，用户令「上云」根治手机网络不可达）**：
1. 通道=ECS 云助手 RunCommand（SSH 22 不对公网）；qw_engine.tgz 分片 b64 上传（4 片×16000）；3 密钥落 `data/secrets/`；venv+fastapi/uvicorn/curl_cffi（阿里云镜像）。坑：Ubuntu24 缺 python3-venv 须先 apt 装。
2. systemd `qianwen-engine.service`（Restart=always 开机自启）。
3. **双层墙铁律**：阿里云 SG AuthorizeSecurityGroup 8869 + ECS 本机 ufw 都要放行（ufw active+deny incoming 易漏）→ 公网探针 401/106ms。
4. 云端双冒烟：假 code 登录→微信 40029（appid/secret 链路通）+ 真实 KB 单问 1044 字/4 引用/16.3s——**metaso cookie 不绑家宽 IP**，上云最后未知数消除。

**域名三切轨史**（每次都是「上一轨的死因→下一轨的选型」）：
| 轨 | 结局 | 死因/根因 |
|---|---|---|
| epcschool.top（0930 弃） | 80 口 403 Non-compliance | 腾讯备案接入≠阿里云，跨商墙；certbot HTTP-01 预签也被阿里云边缘层截胡 403（容器内 Host 探针 404=自家 nginx 没轮到执行）——**证书只能备案通过后签** |
| gcbrain.top（0930 注册） | 备案卡步 4（传图+人脸） | 正规 ICP 备案无 OpenAPI；DrissionPage 登录被阿里云防自动化拦截（密码正确也报密码错误）→ 用户接管手输；备案期 80 段 301→444 关站合规 |
| api.yrecepc.cn（1001） | public443=200 在役 | 用户已备案域，子域 A 记录手加；ecs_yrecepc_ignite.py 点火（ACME webroot→443 ssl proxy→探针）；坑=`tail -6` 只截到捐赠 banner 致成功判据假阴性 |
| **ai.epcschool.top（1002 终轨）** | BASE_URL 已切+request 合法域名已加 | apex=总包学园已备案域，Tencent 云全栈（回到 epcschool 但换云商根治跨商墙） |

**部署配方**：增量部署脚本族（ecs_deploy_v060.py / ecs_deploy_v073.py，tar 45-47KB→4-5 片 12K b64）；云助手回包状态字段=**InvocationStatus**（等 Status 必超时）；RunCommand 内容上限约 16KB，app.py 17364B 须 printf 分片追加；`--CommandContent` 必须纯文本（SQL 本体 b64 直灌绕引号地狱）。真 DB=`/opt/qianwen/data/qianwen/db.sqlite`（qianwen.db 是空壳诱饵）。

## 7. 体验版联调

**钉位事故三次复发与根治链**（本案最大教训簇）：

| 次 | 表象 | 根因 | 修法 |
|---|---|---|---|
| 1（0928-0929） | 扫码「页面不存在」 | 同目录并存两个同名辈前端，误把 `projects/qianwen` v0.1 孤儿（12.7KB，旧号时代/LAN BASE_URL）传上开发位 | 0.2.7 直发真身（41,144B）+ 孤儿改名 `projects/_orphan_qianwen_v01_勿发布` 永绝后患 |
| 2（0929） | 0.4.0 用着正常，14:10 后复发 | miniprogram-ci **同一 robot 再上传会替换该机器人名下开发版本记录**，体验版钉着该记录时即被顶掉 | robot 1..30 轮转（robot_cursor.txt+registry 审计）+上传后自动通道体检 |
| 3（0929 深夜-0930） | 重钉 0.5.0 后仍 404 | **一切无路径入口（控制台体验码/最近使用/会话卡）默认页解析都参照线上版 1.0.7 老页面表**——check_path=true 探针逐页枚举实证老表恰好 {home/home, my/my}；用户钉位停在 0.4.2（无 home 页） | 包级根治：`pages/home/home` 兼容跳板页（落地即 `wx.reLaunch('/pages/ask/ask')`+switchTab 兜底+蓝图闪屏），app.json 五页 home 殿后——不依赖任何码/钉位状态 |

**永不404码配方**：wxacode `page="pages/home/home"`（新老包双环境都在表）+ `env_version=trial` + `check_path=false` → 任何解析路径必命中（qr_trial_v060b_home 在役）。0930 用户重钉 0.6.0 后确认「可以正常看到了」——home 跳板机制首次真机实证闭环。

**判据方法箱（教训：错判据比无判据更危险）**：
- check_path=true 探针只按线上版已发布表校验（钉位健康时真页面也 41030）→ 原探针=恒假阴性机器，已废；
- **钉位无 API 判据**（重选体验版只有用户控制台能做）；真判据=用户手机扫显式 page 码 + 引擎雷达（answers 表最新成功咨询时间 vs 上传时间，零流量=入口层死）；
- 桌面微信当试验台：weixin://dl/business/?t= 协议拉起+PrintWindow 截图+像素探针辨版本（导航栏 RGB(202,58,58) 红=老版 ≠ #1e5eff 蓝）；但桌面账号疑无体验版权限，**手机=终审**（四连负结果定论）；
- 给用户的换版指令必须含「钉完立刻自测」环节+永不404码——钉位状态是换版事故的唯一变量。

**交付通道双保险**：微信桥 ilink 发件箱（`~/.wechat-claude-code/outbound-spool/` JSON {text,file}）+ 桌面弹码（桥 0930 14:06 起 ret:-2 死通道时的 sanctioned 兜底；坑=python subprocess 弹窗阻塞→拆 bash 直弹）。机器人无感知验证：UPLOAD_OK 后自动跑 TRIAL_HEALTH 通道体检探针（CHANNEL_OK）。

## 8. 提审合规

**0.7.4 拒审根因**：《关于「人工智能生成合成内容需增加显著标识」公告》——AI 生成内容缺显著标识（拒审详情页 audit_id=599847676 失败原因 1 实锤）。

**修复（0.7.5 起）**：合计 12 个显著标识位=10 前端位（ask 首屏 / answer 页首+正文尾+追问尾 / pot 页首+列表尾 / 隐私弹窗 / 用户协议 / home 跳板 / 导出 MD 尾注）+ 2 海报位（poster.py:211+231 渲进图片本体）。逐位 grep 审计表见 mp-compliance-gates.md 门 1（台账 #79 记 9+2 系少数漏计，以代码实测为准）。

**双 agent 全面审查**（静态代码+合规两路并行）：CRITICAL 0；HIGH-1=诱导分享（运营规范 3.2.1 分享+1 次利益激励）→ 0.7.6 分享激励下线（open-type=share 纯分享，赠次留有用/纠错/共享入锅圈三真实互动）；A1=剪贴板隐私（运行时实证 wx.getPrivacySetting 契约 live+setClipboardData 通过=已声明）。

**v0.7.6 合规终版**：分享激励下线+隐私协议措辞对齐静默登录（openid 凭证收集明示）+导出空 b64 防护+超时 300s→120s。BOOT-SIM 241/241、编译 0 错 0 警、robot 上传 124,008B。

**提审向导配方（Vue 控制台，mp 控制台自动化三坑全入库）**：
- 须知弹窗 checkbox 单击后必验 `cb.checked`（input+label 双匹配会翻成不勾）；同 tick 连点 checkbox+下一步 Vue 不消化，分两次 eval；
- 版本描述 textarea 用原生 setter+input 事件喂 Vue v-model，**counter 184/200 与回读一致才算吃进**；
- 提交按钮是 `<a class="btn btn_primary">` 非 button；翻译扩展把按钮文本包进 `<span data-component="translate">`（真按钮=文本 span 的 `closest('button')`，XPath text() 匹配会失明）；
- 「选为体验版」按钮绝不能用祖先遍历定位（曾误点 0.4.2 行弹出危险切换对话框），正确=`.code_version_log` 块内按版本号文本锚定；
- 链路：须知勾选→安全测试继续提交→主表单→页面回「已提交审核」；终验=审核版本 0.7.6 · 审核中 · 2026-10-02 10:12:15。

**发布后一行令**：`POSTER_QR_ENV_VERSION` trial→release（config.py:79 + ECS + CloudBase 同步）——posters 表按 env 隔离自动失效重生成。⚠ 反面教训：正式版未发布前置 release=海报码开出旧 1.0.7（曾双端误置，已根治回 trial）。

## 9. 可复用结论（十条金律）

1. **台账胜过文档**。83 条 RUN_LEDGER 每行=时间/动作/实测结果/下一步，五天后任何事故都能回溯到分钟级。案例证明：记忆会骗人（「0.2.7 时代 ask 居首仍翻车」的历史实证靠台账钉死），落盘数据不会。
2. **提案门先行，SCORECARD 定生死**。两次大弧线都走「调研→DIGEST→GAP→PROPOSAL→SCORECARD→用户批准→开发」，0.888/0.818 双 proceed；tenx 指数（3162×）逼着回答「凭什么比现状好十倍」。
3. **免费成本架构是设计出来的，不是省出来的**。唯一付费位（KB ~3 点/问）之外，追问/速览/海报全部落在免费链（智谱池+Pillow+客户端），且 digest/海报每答案只算一次成本——free_cost_fit 打满 1.0 的方法=对账表逐行算成本。
4. **贵的答案只买一次，便宜的解释无限次**。两级产品（付费专业解答+免费接地快答）同时拿下毛利与体验，是本案的产品支点，可迁移到任何垂直问答品类。
5. **钉位是换版事故的唯一变量**。robot 轮转防顶替、home 跳板页通吃所有入口、永不404码（显式 page+check_path=false）三件套后，404 整类问题消失；换版指令必须含「钉完立刻自测」。
6. **判据要用数据，不能用理论**。check_path 探针恒假阴性教训：每个「体检探针」上线前先问它在 sick 和 healthy 两种状态下各回什么；雷达（DB 计数 vs 上传时间）才是入口层死活的真判据。
7. **appid/目录名/机器人名是三类「一字符事故」源**。appid 抄错一字符的表象=账号被注销（40013 invalid appid + getrandstr -1 empty content）；同名辈目录骗人传错包。对策=逐字符 diff+差分对照（同机同网打另一 appid 三连过）+孤儿改名封死。
8. **上云双层墙+分片部署是 Windows 工作站到 Linux ECS 的标准通道**。云助手 RunCommand（SSH 不对公网）+b64 分片（16KB 上限）+systemd 常驻+SG/ufw 双放行；回包状态字段=InvocationStatus。
9. **合规是提审前最后一道测试门，不是事后补救**。AI 标识公告、运营规范 3.2.1 诱导分享、隐私措辞对齐实际收集行为——双 agent（代码+合规）审查+三线终验（API 面/模拟器六页/表单六项）后才点提交。
10. **用户纠偏全对，用户令原文进台账**。「全部批准」「上云」「顶级排版」「功能+填写都确认才提交」等令词+预授权原话照抄归档——五天 25 版的节奏全靠这些授权点支撑全自主执行，事后可审计。

## 附录A. 版本全表

| 版本 | 日期 | robot | 包大小 | 断言/测试 | 一句话 |
|---|---|---|---|---|---|
| v0.1.0/v0.1.1 | 0928 午 | —（wxd096 号） | — | — | P0 首航上包（work/upload_qianwen.mjs） |
| v0.2.0 | 0928 12:11 | — | — | 26 | 客户端 12 文件重写+wxml_lint 闸首战 |
| v0.2.1 | 0928 13:30 | — | — | 26 | 真机点击根因修复（tabBar 盖按钮） |
| v0.2.2 | 0928 14:35 | — | — | 26 | 异步流水线+进度事件流+失败退次 |
| v0.2.3 | 0928 14:55 | — | — | 26 | 上云：BASE_URL→47.120.43.20:8869 |
| v0.2.4 | 0928 15:34 | — | — | 26 | md2blocks 排版革命+改名总包千问 |
| v0.2.5 | 0928 15:5x | — | — | 26(+D 场景) | 虚拟支付接线（pay_sign 双签名） |
| v0.2.6 | 0928 16:2x | — | — | 26 | 改名总包AI顾问（9 处） |
| v0.2.7 | 0928 | — | 41,144B | — | 真身直发（孤儿误传事故修正） |
| v0.3.1 | 0929 | — | — | — | 「工程蓝图 Blueprint」UI 全重做 |
| v0.4.0 | 0929 | robot1 | 66,842B | BOOT-SIM v3 59/59 | 咨询增强（题库/导出/语音守卫） |
| v0.4.1 | 0929 | — | — | 61/61 | 语音全功能（插件声明+pluginInfo 铁证） |
| v0.4.2 | 0929 晚 | robot2 | 98,215B | 67/67 | 老痕清零+目录更名 zongbao-ai |
| v0.4.3 | 0929 晚 18:59 | robot3 | 98,899B | 71/71 | 语音交互重做（partial 实时填框） |
| v0.5.0 | 0929 23:0x | robot4 | 69,462B | 98/98；tests 27/27 | 九点令收官（语音全撤/赠次/锅圈） |
| v0.5.1 | 0929 23:2x | robot5 | 71,151B | 109/109；tests 28/28 | home 跳板 404 终局根治+智谱免费链 |
| v0.6.0 | 0930 00:1x | robot6 | 81,907B | 126/126；tests 38/38 | 100× 弧线：追问/速览/相关问题/海报 |
| v0.7.0 | 0930 01:38 | robot7 | — | tests 46/46 | 引擎付费墙拆除+POSTER_QR_ENV 根治（域名换轨前包） |
| v0.7.1 | 0930 13:2x | robot8 | 89,878B | 158/158 | 域名版提审候选（gcbrain BASE_URL） |
| v0.7.2 | 1001 | robot9 | 99,161B | 175/175 | yrecepc 域名版（智库页 7 查） |
| v0.7.3 | 1001 13:4x | robot10 | 119,443B | 205/205；tests 47/47 | 十一点令：周换装/授勋/锅圈百条 |
| v0.7.4 | 1002 前提审 | — | 台账未记 | — | 拒审版（AI 标识公告，audit_id=599847676） |
| v0.7.5 | 1002 | — | 台账未记 | — | 标识位补齐版（12 前端+2 海报） |
| **v0.7.6** | **1002 09:57:33** | robot（总包君） | **124,008B** | **241/241；编译 0 错 0 警** | **合规终版，10:12:15 提审成功** |

## 附录B. 坑索引（表象→根因→修法）

**appid/账号**
- CI 门 `getrandstr` 回 `-1 empty content` + `cgi-bin/token` 回 40013 invalid appid，像账号被注销 → appid 抄错一字符（f→b）→ appid 与密钥文件名逐字符 diff+差分对照。

**钉位/体验版**
- 换版后扫码「页面不存在」→ ①robot 顶替自己名下记录 ②误传孤儿包 ③无路径入口按线上 1.0.7 老表（恰好 {home/home, my/my}）解析默认页 → robot 1..30 轮转+孤儿目录改名+pages/home/home 跳板页（app.json 五页 home 殿后）。
- check_path=true 探针恒 41030 → 它只按线上版已发布表校验 → 探针作废，改用「扫显式 page 码+引擎雷达（answers 最新成功时间 vs 上传时间）」。
- 码扫出旧版页面 → 码未带显式 page 或 check_path 未关 → `getwxacodeunlimit {"page":"pages/home/home","env_version":"trial"}` + check_path=false。

**域名/备案**
- 80 口 403 Non-compliance → 备案接入商与云商不一致（跨商墙）→ 换同云商已备案域（epcschool.top 最终走 Tencent 云全栈）。
- certbot HTTP-01 预签 403 unauthorized → 未备案域名在大陆 ECS 80 口被阿里云边缘层截胡 → 证书只能备案通过后签（DNS-01 为 fallback）。
- 备案表单提交硬卡 → `tag:textarea` 首匹配=隐藏 JSON 槽，备注文本灌进名称字段 → 备注真身用 placeholder「请根据实际情况填写备注内容」匹配；名称含长文标点必触发驳回风险。
- DrissionPage 登录两次「密码错误」→ 阿里云防自动化拦截（字段值 JS 校验无误）→ 用户接管手输+只读监视器盯 URL。

**合规**
- 拒审「AI 生成内容缺显著标识」→ 2026 标识公告 → 12 前端位+poster.py:211+231 海报双标识。
- HIGH=诱导分享 → 运营规范 3.2.1 分享+利益激励 → 分享激励下线，赠次只挂真实互动（有用/纠错/共享入锅圈）。

**Node/工具链**
- miniprogram-ci 崩 `getItem is not a function` → Node 25 的 global.localStorage 形状不符 → `NODE_OPTIONS=--no-experimental-webstorage`；corecompiler 子进程同样崩且表象=exit 0 假成功 → `work/localstorage-shim.cjs` + `NODE_OPTIONS=--require <shim>` 父子同注。
- forge 编译 spawn ENOENT → `'..'+projectPath` 缺分隔符/work 下跑致 work/work/ 双层路径 → 从 WeAppForge 根目录跑。
- WeAppForge package.json `type:module` 感染项目 .js → 项目落 `{"type":"commonjs"}` 就地覆盖。

**Windows/编码**
- GBK 控制台 print ✓ 字符崩 → 检查名不用特殊符号。
- python subprocess 跑 `cmd //c start` 阻塞挂死 120s → 拆 bash 直接跑。
- NSIS 后台任务 cwd 漂移 → exe 绝对路径+`/S /D=<盘符路径>`（/D 最后、无引号）。

**引擎/Python**
- `str.format()` 模板里字面 JSON 报 KeyError '"tldr"' → 花括号必须 `{{}}` 转义。
- store.init() `_LOCK` 不可重入差点死锁 → 持锁上下文内联 SQL，不调 init()-系助手。
- views/shares 迁移「未生效」→ store.init() 懒触发且 health 不触 DB → 直跑 store.init() 后 PRAGMA 确认；每次请求路径首触即幂等补列。
- wx 上传远端目录 PathNoWritePermission 假象 → 远端目录须先 mkdir。
- SimHei 无 •/｜ 字形 → 用 ·/；替代（提审前换思源黑体，登记在案）。

**小程序前端**
- WXML 绑定禁方法调用（`{{!question.trim()}}`=提问按钮死锁）→ canAsk 全部 JS 侧计算+wxml_lint 常驻闸。
- tabBar 页 `position:fixed bottom:0` → 原生 tabBar 盖住按钮吃点击+toast 一闪=「没反应」 → 常规文档流+红卡常驻+失败弹窗化。
- harness 假 40029 → api.js require 在 `global.__QW_BASE__` 之前，config 提前求值打生产 → require 顺序修正。
- 插件未在控制台添加就 app.json 声明 → 传包被拒 → 先控制台「设置-第三方设置-插件管理」添加（UPLOAD_OK 回包 pluginInfo 带回插件本体=添加生效铁证）。

**mp 控制台自动化**
- 按钮点了没反应 → 翻译扩展把文本包进 `<span data-component="translate">` → 真按钮=文本 span 的 `closest('button')`。
- checkbox 勾了 Vue 不认 → input+label 双匹配翻成不勾 → 单击后必验 `cb.checked`；同 tick 连点分两次 eval。
- textarea 填了 counter 不动 → Vue v-model 不吃直接 value 赋值 → 原生 setter+input 事件，counter 与回读一致才算吃进。
- 选体验版误点他行 → 祖先遍历定位 → `.code_version_log` 块内按版本号文本锚定。
