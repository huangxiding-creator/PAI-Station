# 四大直接竞品深度解剖（2026-09-05 实测 README 全文精读）

## 1. openhuman（39,436★｜GNU｜Rust+Tauri｜tinyhumansai）
- **架构**：三合一——大脑（记忆）/编排者/研究员。Memory Tree→SQLite+Obsidian Wiki 镜像（可读可编辑 Markdown，拒绝向量黑箱）
- **杀手锏**：①TokenJuice 工具输出压缩 80%；②100+ OAuth 集成+5000 MCP+90k Skills；③auto-fetch 20 分钟同步一次喂大脑；④split brain（快反射 agent 分诊 + 深推理核）；⑤agent 经济（@handle、Signal 加密 A2A、x402 USDC 悬赏交易）；⑥工作流=agent 提案→画布审阅→批准门（n8n 式）
- **17 通道**：TG/Discord/Slack/WhatsApp/Signal/iMessage+原生邮件——**无飞书/钉钉/企微，微信无**
- **收费**：订阅制（含托管搜索/媒体生成），可 BYO key/Ollama 混合
- **可借鉴**：Markdown 记忆树（用户可审计可编辑）、工作流画布审批、TokenJuice 式压缩、split brain 双路由（与我们 System-1/2 设计不谋而合）
- **击败点**：中国 IM 零覆盖、无中文职场场景、订阅收费（我们零成本）、GNU 传染性协议、西式 OAuth 栈在国内企业不可用

## 2. nanobot（47,726★｜HKUDS 港大数据科学实验室｜Python）
- **架构**：极简 agent loop 内核（消息进→LLM 决定工具→记忆技能按需注入），WebUI/TUI/聊天 App 三形态，gateway --background 守护
- **通道**：Telegram/Discord/**WeChat/Feishu/QQ**（社区贡献，近期更新含 QQ 重连修复）/Slack/Email/Mattermost
- **能力**：工具（文件/shell/搜索/MCP/cron/子 agent）、Dream 长期记忆、模型路由、OpenAI 兼容 API
- **可借鉴**：极简内核哲学（我们同走 Python 轻核）、通道插件化、Kimi/MiniMax 开源伙伴运营模式
- **击败点**：无全盘感知（不读文件系统全量/屏幕/音频）、无企业规则学习、无技能蒸馏、无画像、无商业模式、终端安装门槛

## 3. QwenPaw（34,919★｜Apache-2.0｜阿里 AgentScope 团队）——最正面威胁
- **架构**：AgentScope 2.0 Agent OS 重写。三支柱/每 agent：Resources（磁盘透明）+Governance（allow/deny/ask/sandbox）+Sandbox（Win 用 AppContainer）
- **中国通道一等公民**：钉钉/飞书(Lark)/微信/QQ/Discord/TG/iMessage——单实例全通道
- **记忆**：ReMe v0.4 自进化个人知识库（对话+资源→可读可编辑可搜索互联的 Markdown 记忆）；Scroll Context（逐轮持久化、被逐出内容索引可召回，绝不摘要掉）
- **模型**：QwenPaw-Flash 2B/4B/9B 本地免费 + 14+ 云厂商；v2.2 多用户 Hub、统一市场、Mail
- **安全五层**：内核沙箱/Tool Guard（命令注入检测）/File Guard/Skill Scanner/Access Policy——**值得整体对标移植**
- **桌面 App**：仅 Beta（Tauri 壳），主形态仍是 pip/Console/TUI
- **可借鉴/直取**：五层安全体系、Scroll Context、ReMe 式 Markdown 记忆、通道实现参考
- **击败点**：记忆只从"对话+你主动给的资源"进化——**不感知整台电脑**（无全盘扫描/屏幕/音频/内网）；无初终稿 diff 技能蒸馏；无用户/企业画像报告；无主动 JTBD 引擎；无满意度计费生态；桌面端不成熟

## 4. OpenViking（35,602★｜字节火山引擎｜AGPLv3 核+Apache CLI）——关键可缝合件
- **本质**：自进化上下文数据库。viking:// 虚拟文件系统统一记忆/资源/技能，agent 用 ls/tree/find 浏览自己的上下文
- **L0/L1/L2 三层加载**：每条内容写入时处理为 抽象(约100 token)/概览(约2k)/详情，按需下钻——**输入 token 降 34-91%、延迟降 58-66%**
- **基准（LoCoMo）**：OpenClaw 原生 24.2%→82.1%、Hermes 33.4%→82.9%、Claude Code 57.2%→80.3%；tau2-bench 任务成功率 +6.9~+11.9pp
- **会话→记忆**：session commit 后异步抽取用户偏好与 agent 经验入长期记忆（=我们的⑤自学习，且有 VLDB 2026 论文 VikingMem 背书）
- **集成形态**：独立 HTTP 服务（天然进程隔离，规避 AGPL 传染）+ MCP 客户端 + LangChain
- **结论**：**采纳为 PAI-Station 的本地 sidecar 上下文引擎**（独立进程+HTTP），同时保留 SQLite 直查兜底；其 viking:// 分层思想移植到我们的检索 API 设计

## 综合击败矩阵（PAI-Station 独有交集）
全盘感知（文件/屏幕/音频/会议/内网）× 中国四 IM × 零成本智谱链 × 初终稿技能蒸馏 × 三模型画像报告 × JTBD 主动引擎 × 满意度计费技能市场 × 绿色便携桌面端——四家竞品每家最多命中 2 项。
