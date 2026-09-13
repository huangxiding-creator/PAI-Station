# Track 03 DIGEST — 记忆 / 上下文工程 / 个性化基础设施（2025-2026 新进展）

- 生成：2026-09-13；条目：28（`_all.json` 同目录）
- 检索链：WebSearch/webReader 均命中周限额（09-26 恢复）→ 降级 gh CLI（search + api，全部条目元数据实证）+ 代理 curl 验证产品页可达性。arXiv API 429，论文 ID 均取自官方仓库 README 内嵌链接。
- 基线排重：已对照 `_baseline_v3_names.txt`（427 项），下列均不在基线内。

## 逐项摘要

### 仓库 / 产品

**1. ECC**（github.com/affaan-m/ECC，257k★，2026-01）— 2026 年最爆的「agent harness 操作系统」：68 agents、292 skills、hooks、记忆、instincts（本能）、持续学习、AgentShield 安全扫描，一键装进 Claude Code/Codex 等 harness。把记忆与技能打包成「可安装的 OS 层」而非独立应用。它的 instincts 是预反射行为层，与 memory 并列为一等概念。

**2. beads**（github.com/gastownhall/beads，27k★，Steve Yegge）— 基于 Dolt（SQL+git 语义数据库）的分布式图谱议题跟踪器，为编码 agent 提供持久结构化记忆：依赖图驱动长程任务，`bd ready` 让工作节点可声明可认领。记忆=数据库里的可分支、可合并、可回滚的工作单元图。

**3. context-mode**（github.com/mksglu/context-mode，22k★）— 自称「上下文问题的另一半」：工具输出沙箱化（宣称 98% token 缩减）+ 会话记忆持久化。核心洞见：窗口污染主要来自工具输出而非对话本身。

**4. Second-Me**（github.com/mindverse/Second-Me，15.7k★）— 开源「AI 第二自我」：用用户自己的数据训练私有自我模型并部署，配套 AI-native Memory 论文体系（arXiv 2406.18312 / 2503.08102）与 home.second.me 托管。个性化=把用户建模成模型本身，而非给通用模型挂记忆。

**5. OpenSquilla**（github.com/TokenRhythm/opensquilla，7k★）— 「同预算、更强智能密度」的微内核 token 高效 agent，CLI/WebUI/chat 三端。把每 token 智能密度作为第一设计约束。

**6. ai-memory**（github.com/akitaonrails/ai-memory，6.6k★）— 编码 agent CLI 的长期记忆 + 跨厂商交接（handoff）：解决换 agent 就失忆。记忆可携带性成为一级卖点。

**7. engram**（github.com/Gentleman-Programming/engram，6.6k★）— agent 无关的持久记忆服务：单 Go 二进制、SQLite+FTS5、MCP/HTTP/CLI 多协议暴露，即插即用。「记忆作为本地常驻服务」的形态收敛。

**8. openhanako / HanaAgent**（github.com/liliMozi/openhanako，6.5k★）— 中文社区爆款「有记忆、有灵魂的私人 AI 助理」，跨平台 Apache 2.0。验证了中文用户对常驻+人格+记忆复合体的强需求。

**9. obsidian-mind**（github.com/breferrari/obsidian-mind，4.6k★）— 「自组织 Obsidian 仓库」：agent 自主整理 vault 结构作为持久记忆（服务 Claude Code/Codex/Gemini CLI）。self-editing memory 落到最大众的知识库载体。

**10. obsidian-second-brain**（github.com/eugeniughelbur/obsidian-second-brain，4.4k★）— 7 个 CLI agent 的记忆以纯 markdown 存进 Obsidian vault。确认「记忆必须人机双读」是用户真实偏好。

**11. basic-memory**（github.com/basicmachines-co/basic-memory，3.9k★）— markdown 优先的知识记忆 MCP server：本地文件即知识库。markdown 为源、索引为衍生物，记忆永不锁死。

**12. LangMem**（github.com/langchain-ai/langmem，1.7k★）— LangChain 官方记忆 SDK：热路径（对话中即时记录/搜索）与冷路径（后台蒸馏）双通道，语义/情景/程序性记忆分类 API，可接任意存储。

**13. gsd-pi**（github.com/open-gsd/gsd-pi，1.2k★）— 元提示+上下文工程+规格驱动：让 agent 长时间自主工作不迷失大图景。长程自主性靠目标结构的持续注入而非更多记忆。

**14. Context-Engine MCP**（github.com/Context-Engine-AI/Context-Engine，400★）— 「Agentic Context Compression Suite」：上下文压缩工具集以 MCP 形式提供，压缩能力工具化、由 agent 自主调用。

**15. engrim**（github.com/timgordontg/engrim，239★）— 「通用跨模型情景记忆标准」：本地优先、项目作用域 SQLite 引擎，跨 Antigravity/Claude Code/Cursor/Windsurf 保住架构决策与项目状态。记忆互操作标准之争的参赛者。

**16. MineEcho**（github.com/Health-Yang/MineEcho，218★）— 本地优先个人助理 Memory OS：L0-L3 分层记忆、Wiki++ 知识、技能路由、TokenLess 上下文缩减。与 PAI-Station 定位最接近的中文同行之一。

**17. episodic-memory (obra)**（github.com/obra/episodic-memory，476★）— superpowers 作者新作：对编码 agent 历史会话语义检索，专攻「当时为什么这么决定」的决策理由回忆，包括被否决的备选方案。

**18. Semiont**（github.com/The-AI-Alliance/semiont，91★）— AI Alliance（LF）的源引语义知识平台：人机共享工作区，对领域知识标注/连接/富化/治理，构建可信上下文层；单静态二进制分发。中立基金会下场做上下文层。

**19. Friend**（friend.com，产品，stars=null）— 常驻可穿戴 AI 伴侣吊坠，全天候聆听+情感记忆连续性（域名 curl 200 已验；产品细节本轮未再核验）。

**20. LLM-UM-Reading**（github.com/TamSiuhin/LLM-UM-Reading，154★）— LLM 用户建模论文清单（配套 DEBULL 综述）：偏好推断、行为模拟、个性化生成的学术地图。

**21. agent-infrastructure-landscape**（github.com/MrPeppersDev/agent-infrastructure-landscape，3★）— 「912 个记忆系统 × 68 列」对比目录，带类型化边与引用。赛道过热到需要目录治理的直接证据。

### 论文（含官方代码）

**22. MemoryAgentBench**（github.com/HUST-AI-HYZ/MemoryAgentBench，451★，ICLR 2026，arXiv 2507.05257）— 增量多轮交互下评记忆四能力：准确检索（AR）、测试时学习（TTL）、长程理解（LRU）、冲突消解（CR）；自建 EventQA 与 FactConsolidation 数据集。

**23. MemRL**（github.com/MemTensor/MemRL，171★，arXiv 2601.03192）— 在情景记忆上做运行时强化学习的自进化 agent：非参数、稳定推理与可塑记忆解耦、以 RL 选择记忆动作替代被动相似度检索。

**24. Nemori**（github.com/nemori-ai/nemori，207★，arXiv 2508.03341）— 事件分割理论+预测加工双控制环的自组织记忆基质：多轮对话切成主题情景、蒸馏持久语义、统一检索面；由「预测误差」驱动记忆写入。

**25. MemAgent**（github.com/firstbatchxyz/mem-agent，89★，arXiv 2507.02259）— RL 训练的恒定显存 agent：分段读取+覆盖策略处理百万级 token 上下文；被 Yandex 评测选为基座。「读什么丢什么记什么」本身是被训练出的策略。

**26. StructMemEval**（github.com/yandex-research/StructMemEval，12★，arXiv 2602.11243）— 评记忆**结构**而非内容：计数/树状/状态机/推荐四类任务检验记忆内部结构的正确性。评测风向从「记住什么」转向「记成什么结构」。

**27. Temvera**（github.com/suanlab/temvera，0★，PVLDB 在投）— 度量已部署 agent 记忆的双时态（bi-temporal）与删除语义：记忆的有效期与「被遗忘权」能否被正确执行。数据库社区把 agent 记忆当数据库审计。

**28. agentdescent**（github.com/Birfy/agentdescent，221★，Zenodo DOI）— 「梯度下降，但参数是 agent」：skills/prompts/harness 的 diff 是梯度、聚合器是优化器的并行异步自进化框架。

---

## 对百倍升级的信号（≥5）

1. **记忆主权层是空位，不是记忆引擎**——agent-infrastructure-landscape 目录里已有 912 个记忆系统，但 ai-memory/engrim/obsidian-second-brain 全在解决「记忆怎么跟人走、跨 agent 走」。V4 最该做的不是第 913 个引擎，而是：markdown 为源 + 一套导入/导出/审计/遗忘协议，让 PAI-Station 成为用户记忆的法定持有者——谁换 agent 都带着它走。
2. **上下文经济学 = 24/7 工作站的第一指标**——context-mode（工具输出沙箱 98% 缩减）、OpenSquilla（同预算更高智能密度）、Context-Engine MCP（压缩工具化）共同指向：把「每 token 智能密度」列进进化环的一级度量，上下文管理（压缩/回捞/取舍）应成为技能资产的一等成员而非框架黑盒。
3. **记忆正确性有了硬标尺，可直插进化环做回归**——MemoryAgentBench 四能力（尤其冲突消解：新事实必须推翻旧画像）+ StructMemEval 结构测试（计数/状态机一致性）+ Temvera 删除/双时态审计。PAI-Station 夜间进化环应内置这三类自检：画像改写、结构回归、遗忘合规，进化才敢全自动。
4. **从被动检索到主动记忆策略**——MemRL（RL 选记忆动作）、Nemori（预测误差驱动写入：意外才记）、MemAgent（学习读/丢/记策略）。对照 PAI-Station 的静态 RRF：检索打分可挂任务成败回传、写入可由预测偏差触发——记忆系统从检索引擎升级为策略网络，是被动→主动的分水岭。
5. **决策记忆 + 情景粒度是被低估的记忆类型**——obra/episodic-memory 专攻「当时为什么这么决定（含被否方案）」，nemori 主张对齐人类情景粒度、简单方法可敌复杂框架。PAI-Station 补一层「决策记忆」能让进化环不再重复提出已被否决的路线；情景边界切分比向量切分更接近人的回忆方式。
6. **记忆=可认领的工作单元图（beads 路线）**——把任务与记忆统一为 Dolt 图上可声明、可认领、可分支回滚的节点，长程任务的断点续跑与多 agent 并行就有了硬骨架；257k★ 的 ECC 则证明「记忆+instincts+skills 打包成 harness OS」是用户想要的分发形态——PAI-Station 的进化闭环可以以 harness 插件形态反向输出给别人的 agent。
7. **个性化有两条纵深可挖**——Second-Me（用户建模成可外派的自我模型）与 LLM-UM 学术图（画像可用于行为预测与预执行）。PAI-Station 画像五层之上加「自我代理外派」与「预测用户下一步并预执行」，即从工具跃迁为分身。

## 网络与方法说明

- WebSearch / webReader 全周限额（reset 2026-09-26 15:20 UTC），本轮未用其产出任何条目；全部 28 条经 gh CLI（search/api）实证 star 数与创建日期，论文 arXiv ID 取自官方 README 链接；friend.com 经代理 curl HTTP 200 验证，其产品细节标 null 未编造。
- 未尽事项：ArcMemo / MACLA / STALE 等新基准仅在第三方 dataset-reports 中被并列提及，本轮未能独立核实原文，未收录；OpenAI Atlas 等产品页（chatgpt.com/atlas）代理不可达，未收录。待限额恢复后可补一轮。
