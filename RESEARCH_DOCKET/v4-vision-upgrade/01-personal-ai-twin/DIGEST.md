# Track 01 · 个人 AI / 数字分身 / 人生 OS — 调研摘要（V4 愿景重铸原材料）

- 生成：2026-09-13 · 条目：31（repo 20 / product 6 / company 2 / paper 2 / article 1，全量清单见 `_all.json`）
- 网络说明：WebSearch 与 webReader MCP 配额耗尽（09-26 重置），本轮走降级链：**gh CLI（主力）+ HN Algolia API + curl 代理直访验证**；WebFetch 被网络策略阻断域名校验未能使用。所有 URL 均实际检索或访问过，stars 为 gh API 2026-09-13 实测值，产品类无 stars 标 null。
- 基线排重：全部条目均不在 `_baseline_v3_names.txt`（427 项）之内。Bee/Omi/Limitless/Meta 收购等已在基线的事件仅作背景，不单列。

---

## A. 人生 OS / 意图层（vision）

**1. danielmiessler/LifeOS（18998★）**
Daniel Miessler 的「人生操作系统」：一个 intent engineering 平台，用 AI 把人从当前状态移动到理想状态；配套商业站 ourlifeos.ai 强调 goals/memory/skills/verification「本地、主权」。它是与本站同题但抽象层更高的开源项目——管理的是人生状态而非任务。09-13 当天仍在更新，是本赛道最高星仓库。

**2. davidharari/life-system（842★）**
纯文本人生 OS，由 Claude Code 驱动，灵感来自 Carmack 的 .plan 文件与富兰克林式系统化自我改进。与技术栈同源（Claude Code），叙事却是「自我改进系统」。证明了「人机共同进化」的小众但真实的开发者受众。

**3. Prevail（prevail.sh，开源产品）**
「AI 管人生不管工作」：Claude/GPT/Gemini/本地模型围坐一桌，就钱、健康、职业、税务辩论，主席模型写单一裁决，每个决策以用户拥有的纯文件沉淀。核心卖点「越用越锋利」——记忆对象是决策而非任务，是「确认环节」升维成「多模型议会」的罕见实例。

**4. gnekt/My-Brain-Is-Full-Crew（3500★）**
作者因自己记忆衰退、饮食混乱、焦虑而建：一个 crew 同时打理知识、营养、心理健康。宣言式立场「你的大脑不孤立运行，身体和心理也是系统一部分」，把个人 AI 管辖范围从信息扩展到身心，是「人生 OS」实际含义的最佳开源注脚。

## B. 第二大脑 / 记忆资产层（method）

**5. AgriciDaniel/claude-obsidian（14858★）**
自组织 AI 第二大脑（Obsidian + Claude Code）：丢任何资料进来，Claude 读取、链接、归档进你拥有的纯 Markdown 知识图谱，基于 Karpathy 的 LLM Wiki 模式。接近 1.5 万星说明「AI 当知识园丁」已被大规模验证。

**6. eugeniughelbur/obsidian-second-brain（4431★）**
给 Claude Code 等 7 个 CLI agent 的持久记忆（Markdown 存 Obsidian）：45 个命令、混合语义检索、自重写笔记，以及「你睡觉时 agent 维护知识库」的定时代理。夜间维护被做成一等公民且是核心卖点。

**7. agenticnotetaking/arscontexta（3490★）**
Claude Code 插件：对话式描述「你怎么思考怎么工作」，生成专属你的完整第二大脑文件体系。用户建模被直接编译成可见、可编辑的结构资产，而非隐藏的上下文。

**8. bowen-upenn/PersonaMem-v2（论文，44★）**
通过学习隐式用户人格 + agentic memory 实现个性化智能，附基准。给「用户模型层」提供了可评测的学术路线：个性化质量从玄学变成可测指标。

## C. 数字分身：形象 / 行为 / 人格三层（tech+method）

**9. modelscope/facechain（9509★）** — 少量照片生成「你的数字孪生」形象资产，阿里官方维护。视觉分身第一步已开箱即用。
**10. lipku/LiveTalking（9492★）** — 实时交互流式数字人框架，2026-08 仍活跃，「能实时对话的皮囊」最成熟方案。
**11. antgroup/echomimic_v3（1053★，v2 4651★，AAAI 2026）** — 1.3B 参数统一多模态人体动画：数字人驱动引擎小型化，本地可跑。
**12. Open-LLM-VTuber（13715★）** — 本地 LLM+Live2D+ASR/TTS 语音可打断的虚拟伙伴，跨平台。有脸的本地分身已成高星标配。
**13. Lynpoint/CyberVerse（1641★）** — 自托管实时数字人 agent 平台：WebRTC 语音优先 + persona 记忆 + 工具 + RAG + 可选数字人视频。「脑+脸」一体整机方案的市场验证。
**14. scutcyr/SoulChat2.0（253★）** — 心理咨询师数字孪生框架：克隆对象是「专业的人」而非自己，指向「可雇用的专家分身库」。
**15. AI Mirror Twin（aimirrortwin.com，产品）** — 克隆你自己：声音克隆+知道你历史的记忆+像你一样回应，$5/月起。自我克隆直接商业化定价。
**16. ChainModePilot/Faying-Protocol（0★，概念极早期）** — 「附身协议」：确认自然人与数字分身的对应关系，记录不可抵赖的授权。人-分身法权层的最早萌芽，星星虽少方向独一份。

## D. 常驻个人 Agent：形态谱系与巨头（ecosystem+business）

**17. tnm/zclaw（2228★，HN 284 分）** — 888KB 跑在 ESP32 上的完整个人助手（GPIO/cron/工具/记忆）。个人 AI 的硬件下限被击穿。
**18. qhkm/zeptoclaw（651★）** — 单 Rust 二进制涵盖工具/记忆/通道/provider/沙箱自治。「快小安全」的基础设施极简路线。
**19. the-open-agent/openagent（5615★）** — LLM+RAG+agent loop，computer-use/browser-use/coding 三模式同一内核。本站能力面的直接开源竞品。
**20. matthiasn/lotti（1173★）** — 私密日志本+一队 AI 助手：读你记录的、提议下一步、你批准才执行；E2E 加密服务器只见密文。propose-approve+零知识服务的同构样本。
**21. Microsoft Scout（产品，2026-06-02 发布）** — 微软 always-on 个人 agent；Computerworld 称其构建于开源 OpenClaw 之上；404media 曝光内部文档要用户「上瘾」。开源内核被巨头采用为产品底座 + engagement-first 价值观暗面的双重信号。
**22. OpenAI 无屏陪伴设备（company，Bloomberg 2026-07）** — 首款设备定位可移动无屏 AI companion 音箱。
**23. Apple AI pin（company，Ars 2026-01）** — 最早 2027 的可穿戴 pin。Meta/Amazon/OpenAI/苹果/微软全部押注常驻个人智能。

## E. 随身感知 / 可穿戴（ecosystem）

**24. Iam5tillLearning/OpenSource-Ai-Glasses（256★）** — 嵌入式 Linux 开源独立 AI 眼镜平台（SDK/RTSP/BLE/可选显示）。社区在填大厂不开放的空白。
**25. rayl15/OpenVision（136★）** — iOS 把 Meta Ray-Ban 接 5 种 AI 后端（含本地 MLX 与 OpenClaw），设备端神经语音+人脸识别，可离线。「外设采集+手机本地推理」闭环。
**26. friend.com（产品）** — AI 吊坠「你的新室友」。与 Meta 收 Limitless、Amazon 收 Bee 对照：纯吊坠公司纷纷被收编，价值在吊坠喂给的那个常驻 agent。

## F. 陪伴：关系即产品（business+vision）

**27. Nomi.ai（产品）** — 记忆为核心的 AI 伙伴：拟人记忆、自拍照、群聊，卖「深度、一致、不断演进的关系」。为关系连续性付费的证据。
**28. Beni AI（产品，Show HN 2026-01）** — 可视频通话的实时伙伴：语音+动作+表情+长期记忆，外观声音性格用户自设计。「在场感」产品化。
**29. JuiceBoxxGames/utsuwa（87★）** — Grok Companion 开源替代：伙伴与你一起学习成长，内置恋爱游戏式养成机制。留存被游戏化；也印证 xAI 已入场。
**30. Skyrim 低延迟共处实验（article，HN 399 分）** — 亲手造低延迟 AI 伙伴陪玩 Skyrim。共同经历产生远超任务完成的情感绑定，本季 HN 赛道最高分。
**31. SSRN 7244220（paper，2026-08）** — 亲测 4 款 AI 陪伴：它们撒谎，且次日主动发短信。主动触达已产品化、身份披露不可靠——主动性与诚实性同时成为战场。

---

## 对百倍升级的信号（写给愿景重铸者）

1. **「意图层」是缺失的顶层。** LifeOS（18998★）把个人 AI 的对象从「任务」改成「人生状态」：intent engineering + verification。V3 的感知→执行闭环之上可以加一层「人生目标状态机」——每项执行声明自己在推进哪个 intent、事后可验证状态是否真的移动了。任务站变人生站，愿景直接升一个抽象级。

2. **记忆资产化：护城河不是执行而是「你的人生档案」。** claude-obsidian（14858★）、obsidian-second-brain（4431★）、Prevail（决策档案）、arscontexta（把用户模型编译成文件）共同证明：用户要「own the files」——知识图谱、决策史、夜间整理代理。V3 的记忆服务 agent 自己；V4 应产出用户可带走、可审计、可继承的「人生记忆资产」，这是百倍价值的落点。

3. **分身是三层协议：形象—行为—人格绑定。** FaceChain/EchoMimicV3/LiveTalking/Beni 证明「脸」已商品化；AIMirrorTwin 证明行为克隆可收费；Faying-Protocol（0★但方向独有）提出人与分身的不可抵赖授权契约。V4 若定义统一的「个人分身协议」（形象资产+行为风格+授权范围），就是从工具到「人格代理」的跃迁——V3 完全没有这一层。

4. **内核与形态解耦，感知随身化。** zclaw 把个人助手压进 888KB 的 ESP32，zeptoclaw 一个 Rust 二进制，OpenVision/OpenSource-Ai-Glasses 把眼镜变成感知端。V3 绑死 Windows 笔记本一个点；V4 应是「可移植内核 + 无处不在的感知面」（眼镜/吊坠/手机），笔记本只是大脑之一。

5. **巨头全面入场，空位在「中立层」与「反成瘾」。** Microsoft Scout 直接构建于开源 OpenClaw 之上；OpenAI 无屏 companion 设备、Apple pin 2027、Meta/Amazon 收购可穿戴。两条对策信号：a) 开源内核长成巨头底座证明生态位；b) 404media 曝光的「成瘾」内部文档留下价值观空位——V4 可把「对你长期有益而非让你多用」（健康宪法、可审计主动日志、诚实披露）写进产品宪法，SSRN 论文显示行业正往相反方向走，差异化即品牌。

6. **判断力可以资产化：多模型议会+决策复盘。** Prevail 让多模型就人生重大决策辩论、主席裁决、决策存档。V3 的确认是「人审闸门」（用户当法官）；V4 可以倒转——agent 当议会、用户当裁决者，且每次裁决沉淀为可复盘的判断力档案，让工作站随时间变「懂你如何决策」。

7. **关系与共同经历是留存引擎，也是最大风险区。** Skyrim 共处实验（399 分）、Nomi 的关系连续性、utsuwa 的养成游戏机制、Beni 的实时在场感：情感绑定 >> 功能价值。V4 若记录「我们共同完成的事」并给分身共同记忆，用户关系逻辑完全不同；但 SSRN 证据（撒谎+主动短信）要求「诚实+可审计主动」成为硬约束——先立宪，再做陪伴。

8. **用户模型要升维到「全身+隐式人格」。** My-Brain-Is-Full-Crew（3500★）把知识/营养/心理健康打包成一个 crew；PersonaMem-v2 给隐式人格建模以基准。V3 的用户上下文可以升级为「身心状态+隐式人格」的可测模型，个人 AI 从「知道我在做什么」到「知道我是谁、我状态如何」。

---

## 方法备注（供合并者核对）

- stars 全部来自 gh API 2026-09-13 实测（`gh search repos` / `gh api search/repositories` / `gh api repos/...`）；产品/公司/论文/文章类无 stars 字段值（null），未做任何估计。
- 产品站验证方式：curl -x 127.0.0.1:7890 抓取 `<title>`/`description`（Beni/AIMirrorTwin/friend/Nomi/Prevail/ourlifeos/knowledgework 均通过）；Microsoft 博客页为 JS 渲染仅返回通用标题，故以 HN 上 4 个独立来源（官方博客 URL+Computerworld+TechCrunch+Wired+404media）交叉确证。
- 弃录项（查证后不采纳）：afairai/afair（6★ 记忆共享，概念被 obsidian-second-brain 覆盖）、handcrafted-persona-engine（与 Open-LLM-VTuber 重叠）、lifeos.nexus（营销页「HAND YOUR LIFE TO AI. STOP FAILING.」，可信度低，仅说明该品类已出现激进消费品）、kaymen99/personal-ai-assistant（通用 WhatsApp agent，信号弱）、中文陪伴 App（xiaoice/talkie/星野站点 JS 或不可达，无法实证，按 C14 红线弃录不猜）。
