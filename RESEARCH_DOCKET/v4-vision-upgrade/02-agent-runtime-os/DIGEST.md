# Track 02 摘要：Agent 运行时 / 网关 / 编排 / Agent OS（2026 新格局）

- generated: 2026-09-13 | 条目：40（repo 35 / product 4 / company 1），全部经 gh API 或 curl 代理实测验证
- 本轮网络降级说明：WebSearch 与 webReader MCP 周配额耗尽（09-26 重置）；Google 域经代理不可达；arxiv API 无响应。故 OS-1 论文、Windows Agent Foundry、Cisco AGP 三项因无法验证真实 URL 而**未收录**（C14）。产品类条目元数据标 null 处均已在 source_note 交代。
- 基线对照：427 个 V3 已调研名（含 OpenClaw/LangGraph/CrewAI/smolagents/AutoGen/Mastra/Agent SDK/Goose/Dify/Coze/Letta/moltworker 等）零重复；本目录聚焦其后新生的运行时/网关/编排/OS 层。

## 一、Agent OS 叙事成型（2026 最强新叙事）

- **OpenFang**（18.2k★，2026-02 建）：Rust 单二进制"Agent Operating System"，137K LOC/14 crates/2600+ 测试/零 clippy 警告，明言"不是 chatbot 框架"。用传统系统软件的工程质量标准做 agent OS，7 个月冲到 18k star，是本轮最凶猛的新项目。
- **AOS Community Edition（Unicity）**（8.5k★，2026-07 建）：企业开源的"开放 agent 操作系统"社区版——aos CLI + HTTP API + 22 个签名 capsules + 离线安装器 + Sigstore 溯源 + runtime-compatibility.toml。它把"OS"落实成了可安装、可验证、可升级的发行版工程。
- **elizaOS/eliza**（19.3k★）：从 web3 agent 框架改定位为"开源 agentic 操作系统"，配研究站 elizaresearch.ai。Agent OS 已从论文词变成产品品类名。
- **AIOS**（6.4k★）：学术系源头——LLM 当内核、agent 当进程，调度/上下文/内存全部按 OS 资源抽象。为"agent 调度器"提供了研究词汇表。
- **OpenBitFun**（2.1k★）：Rust 运行时 + 桌面应用，主打"Code Agent 的深度 + 编码之外的开源通用能力"。是 PAI-Station 产品形态最直接的开源对位物，但没有感知→发现→进化环。

## 二、运行时原语：审批、断点、可验证性

- **Open Multi-Agent**（6.9k★，2026-03 建）：自托管 TS agent 运行时，口号"Own it, approve it, audit it"——后果性操作等待持久化、防篡改的审批；每次运行留下可离线逐字节验证的运行记录。把人审闸门从 UI 功能做成运行时内建能力，与本站"确认"环节直接同题。
- **google/ax（Agent Executor）**（2.0k★，2026-03 建）：Google 开源分布式 agent harness 运行时：可挂起/恢复镜像动态供给隔离环境、单写者架构、事件日志、计算层 actor 级恢复。明确把 Resumption 当第一性设计。
- **Cloudflare Agents SDK**（5.5k★）：Durable Objects 上的常驻有状态 agent，休眠近零成本、毫秒唤醒、内建人机通道。"可休眠的常驻"给出服务器端经济学答案。
- **Atmosphere**（3.8k★）：JVM 可移植 agent 运行时，一个 @Agent 类跨 12 框架，WebSocket/SSE/gRPC 全通，原生 MCP+A2A+AG-UI 且人工审批内建。反锁定 + 协议全兼容的样板。
- **AWS Strands harness-sdk**（7.2k★）：官方把仓库从 `sdk` 改名 `harness-sdk`——AWS、ruflo、DeepCode 三方共同把"harness"确立为一级词。
- **agno**（42.1k★）：build/run/manage 三段论的全栈 agent 平台（原 Phidata），框架平台化的代表。

## 三、网关层独立成层（2025-2026 收敛最快的层）

- **agentgateway**（4.8k★）：Rust 写的"面向 agent 与 MCP 服务器的下一代代理"，Envoy 思想移植 agent 流量，协议在网关处收敛。
- **agent-router（原 Envoy AI Gateway）**（2.1k★）：Envoy 系 AI 网关独立成品牌（envoyproxy/ai-gateway 已迁移），统一生成式 AI 接入。
- **Higress**（9.4k★）：阿里系云原生网关全面 AI 化，MCP 托管 + agent 流量治理 + 插件市场，与 Envoy 系构成东西两派。
- **casdoor**（14.4k★）：老牌 IAM 把官方描述改成"Agent-first IAM / MCP & agent 网关+认证服务器"——身份层软件集体转向 agent。
- **Arcade**（公司，arcade.dev）："agent 的工具网关"：SaaS 工具统一成带 OAuth 代办的受控工具层，agent 不再直持用户凭证。
- **mac-agent-gateway**（91★）：把 Apple 原生应用（Reminders/Messages）经本地 HTTP 暴露给 agent——"本机 OS 应用 API 化"的空白地带信号，Windows 侧无对应物。

## 四、沙箱与执行隔离商品化

- **E2B**（13.8k★）：企业级 agent 沙箱事实标准，开源+云双形态。
- **Daytona**（71.7k★）：转型为"运行 AI 生成代码的安全弹性基础设施"，证明执行隔离独立成赛道。
- **Dormice**（1.1k★，2026-07 建）："agent 沙箱界的 SQLite"：自托管、E2B 兼容、单机沙箱永生、idle 零成本——个人机形态的沙箱平替。
- **microsandbox**（8.2k★）：本地优先 microVM 运行时+库，自包含可嵌入，适合个人硬件。
- **kubernetes-sigs/agent-sandbox**（3.8k★）：K8s SIG Apps 官方 Sandbox CRD——为"隔离、有状态、单例"的 agent 负载提供声明式标准 API，官方确认 agent 是新 workload 类别。

## 五、编排界面与实例管理

- **oh-my-claudecode**（39.1k★，2026-01 建）："团队优先"的 Claude Code 多 agent 编排，8 个月 39k star，多 agent 团队化是当下最陡需求曲线。
- **vibe-kanban**（28.1k★，2025-06 建）：看板式同时驾驶 Claude Code/Codex 等任意 agent，"看板=队列+状态+审批"成为编排界面事实标准。
- **GitHub Agent HQ**（产品）：GitHub 官方多 agent 指挥部（Claude/Codex 同场调度），编排能力平台化、官方化。
- **kagent**（3.7k★）：agent 即 K8s CRD，声明式生命周期+工具绑定，微软/谷歌工程师发起。
- **ClawManager**（1.9k★）：K8s 原生 agent 实例管理控制面——多运行时并存时的实例池/配额/编排层，一个新品类的雏形。
- **ruvnet/ruflo（原 claude-flow）**（72.3k★）：自称"原初 agent harness"：swarm、自治工作流、联邦、向量 RAG 一体，harness 心智的流量之王。
- **Yeachan-Heo/oh-my-claudecode** 之外，**HKUDS/DeepCode**（16.5k★）把 harness 与 Loop Engineering 学科化（arXiv:2512.07921）。
- **Upsonic**（8.0k★）：主打生产可靠性（内建测试/验证）的自主 agent 框架，质量转向信号。
- **PocketFlow**（11.2k★）："100 行框架 + Let Agents build Agents"，对重型框架的反动，价值在方法论与教学资产。
- **Eino（字节 CloudWeGo）**（13.0k★）：豆包/扣子背后生产级 Go 编排栈开源——编排内核快速贬值的中国队证据。
- **OpenHands**（87.7k★）：事件流+沙箱+可插拔 agent 的开源标杆，从 runtime 长成商业平台（All Hands AI）的路径样本。

## 六、托管大厂全栈与个人硬件

- **AWS Bedrock AgentCore**（产品）：Runtime/Identity/Gateway/Browser/Memory/Observability 六件套——云厂商给出的 agent 平台参考架构清单。
- **Modal Agents**（产品）：agent 成 serverless 一等原语，按活跃计费、闲置免费——agent 成本模型被重写。
- **Google Jules**（产品，URL 本轮不可达、元数据 null）："提交-离开-回收 PR"的异步后台 agent 被大厂产品化到主流入口。
- **PhoneClaw**（1.2k★）：手机变成本地 agent 运行时（端上模型+Mac 网关重推理），多机体个人工作站的端云分层样本。
- **docker/compose-for-agents**（1.0k★）：Docker 官方 agent 栈 compose 样例集，"整栈一份 compose"的交付形态。
- **obot**（1.0k★）：开源 AI 治理平台——策略/审计/合规作为独立层产品化。

---

## 对百倍升级的信号（10 条）

1. **审批密码学化**（Open Multi-Agent）：确认闸门从"弹窗+日志"升级为"防篡改审批账本 + 每次运行可离线逐字节验证的 run 记录"。PAI-Station 的确认→交付若带上签名收据与可验证回执，就在个人 agent 里做到了没人做到的信任层。
2. **断点续跑升为运行时原语**（google/ax：可挂起镜像+事件日志+单写者；Cloudflare DO 休眠）：本仓"夜间长跑+断点续跑"从脚本技巧升维为运行时能力——合盖/断电/迁移无损，24/7 常驻的正确形态是"可休眠的常驻"（感知层微功耗值守+执行层按需唤醒）。
3. **发行版化**（AOS-CE 签名 capsules+离线安装+兼容性清单；OpenFang 单二进制）：PAI-Station 已有干净房闸+851 tests，缺的是"OS 发行版"形态：安装器、签名组件、升级通道、技能兼容性清单。技能市场应从"能装"升级到"可信安装"。
4. **内嵌 mini 网关**（agentgateway/Higress/agent-router/Arcade/casdoor）：所有模型/工具/外发流量统一过本机网关（限额、审计、脱敏、协议适配）。本仓亲历的协议漂移之痛（wrweb/metasa）与账号安全问题，都因"技能各自直连"而起——网关是单一修补点；账号安全可升级为"工具身份代理"（技能拿短期最小凭证而非主账号）。
5. **agent 是新 workload，单机缺一个控制面**（K8s agent-sandbox CRD、kagent、ClawManager）：云原生侧已把 agent 实例做成声明式对象。个人机侧没人做——PAI-Station 若先做出 Windows 单机版 Sandbox/Agent API（声明式 agent 编成文件：角色+权限+预算，可 diff 可回滚），就是这一层在个人场景的标准制定者。
6. **编排界面=看板**（vibe-kanban 28k★、Agent HQ、oh-my-claudecode）：确认环节应是"发现池→待批→执行中→待验收→已交付"的看板状态机，批准对象是"一支编队（角色+预算+交接协议）"而非单任务。
7. **交付礼仪对齐大厂**（Jules/AgentCore/Modal）：批准任务=批准预算（活跃成本+闲置成本公示）、晨间简报、diff 验收、进度可中断。个人 agent 体验的及格线已被大厂抬高。
8. **沙箱的个人机形态是空白**（Dormice"E2B 兼容 idle 免费"、microsandbox 本地优先）：PAI-Station 应做"个人 agent 基础设施的 SQLite"——每任务默认一次性微沙箱，隐私/离线/零边际成本是个人机对云 agent 的结构性优势。
9. **Windows 本机应用 API 网关无人占位**（mac-agent-gateway 91★ 证明需求、Windows 无对应物）：把 Outlook/微信/待办/系统功能暴露为带权限位的本地 HTTP API，比做通用执行更稀缺——这是 PAI-Station 独占生态位的机会。（注：Windows Agent Foundry 因本轮 URL 无法验证未收录，桌面 OS 官方平台动向待补录。）
10. **命名与叙事换轨**（AWS 改名 harness-sdk、ruflo 自称 harness、DeepCode 立 Loop Engineering、PocketFlow 让 agent 造 agent）：2026 语境的一级词是 harness/loop/workload，不是框架/chatbot。PAI-Station 对外叙事建议"personal harness OS + 技能资产循环工程"，且编排内核不自研、吃 Eino/agno 红利，把自研预算全押感知/进化/信任三层护城河。
