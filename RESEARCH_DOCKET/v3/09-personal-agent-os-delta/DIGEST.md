# DIGEST — 环节9：个人 Agent OS 最新格局（V2 后增量，2026-09-13）

> 增量调研：与 `RESEARCH_DOCKET/RESEARCH_DIGEST.md`（2026-09-05，350 仓）+ V2 六分卷（2026-09-11）去重。
> 方法：WebSearch/webReader 配额耗尽（9-26 重置），全程改用 gh api（已认证，5000/h）+ HN Algolia API + 官方站直抓（curl）交叉核实。星数/版本均为 2026-09-13 实时值。
> 明细：`_all.json`（41 项）。

## 一、全景表（按 A–F 分类，41 项）

### A. V2 已录项目动态（8 项）

| 项目 | 规模（Δ vs V2） | 2026-09 前后新进展 | 许可证 | 相关度 |
|------|----------------|-------------------|--------|--------|
| [OpenClaw](https://github.com/openclaw/openclaw) | 389,533★ (+600) | 全年大戏：01-29 二次改名定名；02-07 VirusTotal 扫 ClawHub 技能；**04 月两波平台封杀**（Anthropic 禁 Claude Code 订户跑 OpenClaw，HN 1099pt；Google 限 AI Ultra 用户，802pt）；05-05 官方自省文《Had a Rough Week》；05-14 OpenAI 模型改走 Codex app-server harness；06-01 NVIDIA 合作 SkillSpector；**07-08 成立 OpenClaw Foundation（非营利+全职队）**；07-30 LTS+成熟度记分卡；**08-30 OpenClaw 2.0**（安装简化+浏览器一等公民）；09-03 macOS 新安装器+Win NVIDIA RTX 本地模型；现 v2026.9.4 | MIT | ★★★★★ |
| [NanoClaw](https://github.com/gavrielc/nanoclaw) | 30,748★（新录） | "500 行 TS 容器化 Clawdbot"（HN 533pt）长成 30k★ 容器隔离轻量替代，连 WA/TG/Slack，v2.3.0 | 待核 | ★★★★★ |
| [ZeroClaw](https://github.com/zeroclaw-labs/zeroclaw) | 32,778★（新录，02-13 创建） | 单 Rust 二进制个人 agent：30+ 渠道、70+ 供应商（Ollama/LM Studio 本地栈全支持）、无订阅、可跑树莓派，v0.8.5 | MIT/Apache 双 | ★★★★ |
| [nanobot (HKUDS)](https://github.com/HKUDS/nanobot) | 48,064★ (+338) | v0.3.0（07-25），发版降为月级；11 语言 README+微信/飞书社群 | MIT | ★★★ |
| [openhuman](https://github.com/tinyhumansai/openhuman) | 39,717★ (+281) | v0.63.12（08-07 后暂停月余）；'subconscious loop' 定位，社区喊话"OpenClaw is toast" | GPL-3.0 | ★★★ |
| [QwenPaw](https://github.com/agentscope-ai/QwenPaw) | 34,857★ (−62 微降) | v2.2.1 三连 beta（09-08~11）；独立文档站+PyPI；底座 AgentScope 31,485★ v2.0.8 | Apache-2.0 | ★★★ |
| [screenpipe](https://github.com/mediar-ai/screenpipe) | 21,546★ | **YC S26**（Launch HN 07-23）；定位升级为"为 Claude/Codex/OpenClaw 等 agent 提供屏幕+音频上下文，并从行为自动生成 agents/skills/automations"；app-v2.7.30 周更 | MIT | ★★★★★ |
| browser-use / UFO² / Agent-S3 / UI-TARS-desktop / OpenViking | 114,387 / 9,715 / 12,275 / 38,941 / **36,849★(+1,247)** | browser-use 0.13.10 稳态；UFO v3.0.8、Agent-S v0.3.2 慢节奏；UI-TARS-desktop 平缓；**OpenViking 09 月连发 v0.4.19+Go SDK**，两个月 +1.2k★ 仍猛 | MIT/Apache | ★★★★（Viking）/★★ |

### B. Agent 框架最新格局（9 项）

| 框架 | 规模/版本 | 关键事实 | 内核适配度 |
|------|----------|---------|-----------|
| [Claude Agent SDK](https://github.com/anthropics/claude-agent-sdk-python) | 8,086★ v0.2.152 日更 | 2.0.0 起 Claude Code SDK 正式更名 Agent SDK（官方 changelog 原文）；harness 全量库化（subagents/hooks/skills/MCP/权限）；生态：ACP 适配器 2,520★、TS 开源替代 2,739★、kode-agent-sdk 398★；**官方网关变量 CLAUDE_CODE_GATEWAY_*** | **首选**：我们开发底座即 Claude Code，程序化复用已验证机制 |
| [OpenAI Agents SDK/AgentKit](https://github.com/openai/openai-agents-python) | 29,391★ v0.22.2 | AgentKit 2025-10-06 DevDay 发布；10-30 拒 1200 行 A2A PR（生态墙） | 备选：绑定 OpenAI |
| [Google ADK](https://github.com/google/adk-python) | 21,516★ **v2.9.0（2.x 线）** | 与 A2A+A2UI（12-15 发布）打包成互操作栈 | 仅 A2A 场景 |
| [Microsoft Agent Framework](https://github.com/microsoft/agent-framework) | 13,496★ dotnet-1.21.0 | 2025-10-01 官宣 AutoGen+Semantic Kernel 收敛于此；11-20 官方集成 AG-UI；AutoGen 60,949★ 转维护 | 不选：云绑定 |
| [AG2](https://github.com/ag2ai/ag2) | 4,920★ **v1.0.5（已发 1.0）** | AutoGen 社区分叉毕业 1.0 | 不选 |
| [CrewAI](https://github.com/crewAIInc/crewAI) | 58,419★ 1.15.21 | 稳态，无新事 | 不选：角色层冗余 |
| [LangGraph](https://github.com/langchain-ai/langgraph) | 41,542★（1.0 已于 2025-10 发布） | 1.0 后稳态；LangChain 提 ambient agents 概念+开源 [Agent Inbox](https://github.com/langchain-ai/agent-inbox)（1,088★） | 按需薄用（V2 结论维持） |
| [smolagents](https://github.com/huggingface/smolagents) | 29,298★ v1.26.0 | 稳态 | 轻量备选 |
| [Pydantic AI](https://github.com/pydantic/pydantic-ai) | 19,887★ **v2.43.0（2.x 线）** | v2 已发；martinfowler《用 Pydantic-AI 自建 CLI coding agent》197pt 出圈 | 类型安全备选 |
| [Mastra](https://github.com/mastra-ai/mastra) | 27,984★ core@1.66.0 | TS 侧事实标准 | 非我们栈 |

### C. 桌面常驻 agent 新品（10 项）

| 产品 | 规模 | 关键事实 |
|------|------|---------|
| [Goose (Block)](https://github.com/block/goose) | 54,174★ v1.50.0 | **2025-12-09 随 Linux Foundation 成立 AAIF 捐入基金会**（锚定=MCP+Goose+AGENTS.md）；桌面+CLI+API 三形态；70+ MCP extensions+skills；"not just for code" |
| [Warp](https://warp.dev/blog) | 64,992★ | 2026-09 新推 **Warp Factories**："fleets of coding agents across your SDLC" |
| [Cursor](https://cursor.com/changelog) | 专有 | **Projects**（协调者 agent 云上自有电脑跑大工程、watch Slack/定时/盯 PR、合盖不停）；事件驱动"always-on agents operate as a system"+/goal 长目标；子 agent 各自 VM；self-hosted workers 支持 computer use；Worker Pools 休眠唤醒；**Origin 自托管代码仓（GitHub 不在路径上）**；skill=Custom Mode |
| [Devin/Cognition](https://www.cognition.ai/blog) | **$2B 融资@$48B 估值（09-08 Series E）** | 09-10 自研 SWE-2 模型+收购 Dioxus；**09-11 Devin Desktop&CLI 推 Fusion 本地 harness**；Windsurf 并购满一年；FedRAMP+能源部 MOU |
| [Open Interpreter](https://github.com/openinterpreter/open-interpreter) | 68,306★ | **彻底转向**："coding agent for open models like Kimi K3 and GLM 5.3"，Rust 核心 rust-v0.0.42 早期 |
| [LocalAGI](https://github.com/mudler/LocalAGI) | 1,972★ v2.9.0 | 隐私优先自托管平台（Go），全本地模型栈 |
| [OneCLI (YC S26)](https://github.com/onecli/onecli) | 3,469★ v2.6.0 | Launch HN 08-19：沙箱化 agent harness，"每员工一个安全个人 agent" |
| [letta-code (Letta/MemGPT)](https://github.com/letta-ai/letta-code) | 3,317★ | **重大转型**：npm 分发的记忆型 harness（stateful agents with memory/identity），桌面+终端+App Server+Slack/TG/Discord 渠道+TS SDK+跨机记忆云 |
| EverOS | 12,913★ v1.3.1 | 无 9 月新事，维持 V2 观测 |
| mypaios | 78★ | 无变化 |

### D. 协议生态（6 项）

| 协议 | 规模 | 关键事实 |
|------|------|---------|
| [MCP](https://github.com/modelcontextprotocol/modelcontextprotocol) | servers 90,284★；registry 7,240★ v1.8.1 | **2025-12-09 MCP 捐入 Linux Foundation AAIF**（与 Goose、AGENTS.md 同为锚定项目）；registry 时间线：09-08 预览→GitHub MCP Registry 09-17→10-24 API 冻结 v0.1→"app store for MCP servers"；规范 2026-07-28 新版 |
| [A2A](https://github.com/a2aproject/A2A) | 25,747★ v1.0.1 | 1.0 已发但采用存疑（HN 06-18 "Is anyone using A2A?" 96pt；OpenAI 拒 PR） |
| [AG-UI](https://github.com/AG-UI-Protocol/ag-ui) | 15,859★ **09-11 刚发版** | agent→前端事件流协议；2025-11-20 微软官方集成；Google 12-15 发竞争性 A2UI |
| [Agent Skills 标准](https://agentskills.io) | anthropics/skills 176,007★ (+1,631) | **已独立成开放标准站**（Specification/Client Showcase/创作者+实现者指南/Discord）；与 MCP 定型为互补：Skills=教怎么做（知识包），MCP=能做什么（工具）——**不会取代 MCP** |
| AGENTS.md | AAIF 锚定项目之一 | 随 AAIF 中立化 |
| [agentic-inbox 形态](https://github.com/cloudflare/agentic-inbox) | Cloudflare 版 7,388★；LangChain 版 1,088★ | "agent inbox"成 2026 产品形态关键词：agent 主动请求/摘要/审批进收件箱，人类批量处理；Cloudflare 官方入场 |

### E. Claude Code 生态（5 项）

| 资产 | 规模 | 关键事实 |
|------|------|---------|
| [Claude Code 2.x](https://github.com/anthropics/claude-code) | 144,864★ **v2.1.270（09-12，日更）** | 官方 changelog 全量核实：2.0.0（2025-09-29）=原生 VS Code+/rewind+**SDK 更名 Agent SDK**+--agents；**2.1.x 线**=skills 热重载+`context: fork`+`agent` 字段；**Claude in Chrome**（组织管控）；**Workflow 工具**（脚本 API/schema 输出/并发 1-256/断点续作，描述 5.7k→1k token）；plugin eval（JSON/HTML 报告）；/output-style；**/teleport + /remote-env 远程控制**；Ctrl+B 统一后台化；MCP list_changed；language 设置 |
| [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) | 53,947★ | 社区总入口 |
| [claude-code-templates](https://github.com/davila7/claude-code-templates) | 30,670★ v1.29.5 | 组件模板 CLI |
| [awesome-claude-code-subagents](https://github.com/VoltAgent/awesome-claude-code-subagents) | 25,032★ | 100+ 专用子 agent 清单 |
| [superpowers (obra)](https://github.com/obra/superpowers) | 285,825★ (+3,873/2 天) v6.3.0 | 技能库继续狂飙 |

### F. 同类愿景与中国动向（9 项）

| 产品 | 规模 | 关键事实 |
|------|------|---------|
| [Olares](https://github.com/beclab/Olares) | 5,267★ 1.12.6 | **"Personal Cloud OS for Always-On Agents"+卖硬件**：Olares One（RTX 5090 Mobile+96GB RAM 3.5L 主机，2025-11 发布）；自然语言运维 OS+应用市场；中国团队三语 README | AGPL |
| [CoWork-OS](https://github.com/CoWork-OS/CoWork-OS) | 452★ v0.5.52 | **词义上最像直接竞品**："Local-first personal agentic OS and everything app"（代码/邮件/研究/浏览器/文档/agent/渠道/自动化一锅端，多供应商 harness）——但无感知、无主动服务，是"工作台 App" | MIT |
| [hermes-life-os](https://github.com/Lethe044/hermes-life-os) | 190★ v1.33.0 | "learns who you are, gets smarter every day"：情绪/饮食/睡眠记录→模式发现→晨晚报节律 | MIT |
| [OpenDAN-Personal-AI-OS](https://github.com/fiarete/OpenDAN-Personal-AI-OS) | 2,057★ | 2024 概念鼻祖，半休眠——证明名词不新、闭环才稀缺 | MIT |
| [moltworker+飞书桥+中文安装器](https://github.com/cloudflare/moltworker) | 9,956/4,242/3,422★ | OpenClaw 爆发期三大周边（Cloudflare 官方运行器/飞书渠道桥/中文一键部署）**全部在 04 月封杀潮后停滞**——中国 IM 需求被验证、供给断供 | — |
| [扣子/Coze](https://www.coze.cn) | coze-studio 21,580★ v0.5.1 | coze.cn 定位"AI 办公助手一站式平台"（写作/PPT/表格/设计/播客/生图）；云端 SaaS 路线 | Apache(底座) |
| [夸克](https://www.quark.cn) | 国民级 App | 官网自述"AI 旗舰应用"（超级框）；深度 9 月动态未核实（搜索配额受限） | 专有 |
| 小米超级小爱 | 未核实 | 检索受限未核实，待配额恢复补查 | 专有 |
| [agentscope](https://github.com/agentscope-ai/agentscope) | 31,485★ v2.0.8 | QwenPaw 底座框架 2.x 稳态 | Apache |

## 二、格局判断

**赛道地图（谁在做 24/7 个人 agent OS）：**
1. **开源极客位已被三级占满**：OpenClaw 389k★（全家桶网关）→ ZeroClaw 32.8k★（Rust 极简）→ NanoClaw 30.7k★（容器安全），外加 nanobot/openhuman/QwenPaw 三个 3-5 万★位——通用"个人 agent 网关"已是红海，且头部已基金会化（OpenClaw Foundation 07-08、Goose+MCP 入 AAIF 12 月）。
2. **商业云端位被 IDE 巨头吃掉**：Cursor Projects"合盖不停+watch Slack+事件驱动常驻 agent 系统"、Cognition $48B 估值+Devin Desktop Fusion 本地 harness、Warp Factories agent 舰队——**"always-on agent"这个词已被他们用商业产品定义**，但全部面向开发者、全部云端优先。
3. **硬件位有人押注**：Olares 卖 3.5L RTX 5090 主机配 AGPL 个人云 OS——验证了需求但要求用户买新硬件。
4. **感知位只剩一家且已成"卖水人"**：screenpipe（YC S26）把自己定位成所有 agent（Claude/Codex/OpenClaw…）的屏幕+音频上下文层——它不抢 OS 位，给所有 OS 位供水。
5. **空白在哪**：(a) **普通人现有笔记本**（不买新硬件、不写 prompt、不装 Docker）的 24/7 感知-执行工作站——Cursor/Devin 服务开发者、OpenClaw 系服务极客、Olares 服务硬件党，无人服务"中文职场普通人"；(b) **中国 IM 一等公民**——飞书桥 4.2k★ 后停滞半年，供给真空；(c) **中文职场技能蒸馏+JTBD 主动服务**——所有玩家都在"工具调用"层卷，无人做"何时该打扰你"的判断层。

**我们 100× 的差异化定位**：所有竞品的共同盲区="感知（screenpipe 卖水）× 中国 IM（断供真空）× 中文职场技能（无人蒸馏）× 零成本模型（GLM 免费链，连 Open Interpreter 都已默认面向 GLM/Kimi）× 绿色便携现有 Windows 笔记本（无人家路线）"五线交点。任何单项我们都不是第一，但**五线交点无人占位**——这正是"站在巨人肩膀"的结构性机会：每个器官用全球最强件（V2 缝合图仍成立），缝合层做中文职场闭环。

## 三、Top 5 缝合推荐

1. **screenpipe**（MIT，YC S26）——感知器官直接消费：本地屏幕+音频→agent 上下文管线已产品化，且其"从行为自动生成 skills/automations"已验证我们"技能蒸馏"方向；我们补中文 OCR/微信纯视觉/JTBD 打分。
2. **Claude Agent SDK**（MIT）——工作站内核：把 Claude Code 已验证的 hooks/skills/subagents/权限/会话机制程序化为产品内核，经官方 gateway 变量可接 GLM 免费链；开发底座与产品内核同源=最低迁移成本。
3. **NanoClaw 的容器隔离思想**（30.7k★ 验证的安全共识）——24/7 无人值守自主执行的沙箱范式：Windows 下以 Docker/沙箱作业对象落地"每任务一隔离"，这是技能市场安全（ClawHub×VirusTotal×NVIDIA 同题）的执行侧答案。
4. **letta-code**（Apache-2.0）——记忆器官参照：记忆/身份/学习型 stateful agent 的 harness 级实现（桌面+渠道+SDK 全齐），其记忆抽象可直接缝合进我们三级记忆。
5. **Agent Skills 开放标准（agentskills.io）+ MCP registry**——技能与工具市场的双协议直通车：兼容 SKILL.md=接入 176k★ 生态冷启动，直连官方 registry=工具发现安装不自造；再以 agent-inbox 交互范式（Cloudflare/LangChain 已定型）做 JTBD 主动服务的出口。

## 四、三条硬启示

1. **平台封杀是真实存在的生死线**：OpenClaw 389k★ 也没能豁免——2026-02 Google 限流、2026-04 Anthropic 直接禁止 Claude Code 订户跑 OpenClaw（HN 1099pt/827 评），逼出 OpenClaw 05-14 改走 Codex 原生 harness、07 月基金会化。**启示**：任何"复用某家订阅"的架构都是定时炸弹；必须 API 计费+多供应商（GLM 免费链主+备援供应商热切换），并预置"供应商画像指纹"降敏策略。
2. **技能供应链安全已从加分项变入场券**：OpenClaw 一年内连做 VirusTotal 扫描、NVIDIA SkillSpector、Skill Card 溯源、LTS 成熟度记分卡；NanoClaw 用容器隔离起家拿 30k★。**启示**：我们的技能市场 Day 1 就要内置技能卡（来源/权限/diff 审计）+隔离执行+成熟度标记，"进化"绝不能以安全换便利。
3. **头部集体基金会化=通用层的战争结束了**：MCP+Goose+AGENTS.md 进 AAIF、A2A 进 LF、OpenClaw 自建 Foundation——协议与通用网关被中立化后，竞争全面转向垂直场景层。**启示**：不要在"通用个人 agent 网关"上正面硬刚（会被 390k★ 的免费巨物碾平），要打"中文职场+微信生态+现有笔记本"这个巨头结构性看不见的纵深位。

## 五、风险（大厂/OSS 巨头碾压路径）

- **Cursor/Cognition 下探路径**：Cursor 已有"watch Slack/定时/事件驱动常驻 agent+合盖不停"，若把 Projects 从"代码工程"泛化为"个人事务工程"并推出桌面常驻版，凭借资本（$48B 估值弹药）和品牌可瞬间定义品类。对策：用"中文 IM+本地感知+零成本"三壁垒抢时间窗，先占"普通人笔记本"心智。
- **OpenClaw 生态碾压路径**：389k★+基金会+全职团队，若 Foundation 决定做"中国 IM 一等公民+本地感知"（其 09-03 已在补 Windows 本地模型体验），可凭社区势能横扫。对策：其 React/TS 极客栈与"自架网关"心智转换成本高，我们守住"绿色便携双击即用+中文职场开箱技能"体验差。
- **Cloudflare/微软基础设施绑定路径**：moltworker（Workers 跑 OpenClaw）、Agent Framework×AG-UI、agentic-inbox——云厂商用免费基础设施把 agent 运行时圈进自家。对策：坚持本地优先+数据不出机，把"隐私+离线可用"做成它们结构上给不了的承诺。
- **协议风险**：Agent Skills 标准由 Anthropic 主导（虽已中立站化），若标准朝闭源客户端倾斜需保底自研技能格式的双向转换层。

---
*核实说明：全部星数/版本为 2026-09-13 gh api 实测；OpenClaw 事件线来自 openclaw.ai/blog 官方博文（当日抓取）+HN Algolia 存档；Cursor/Warp/Cognition/扣子/夸克来自官网当日抓取自述；小米动向检索受限标注未核实。*
