# 环节7 调研摘要：Agent 自我进化 / 技能沉淀系统（super-skill 自举对象）

日期：2026-09-13 ｜ 调研代理：PAI-Station V3 R07 ｜ 条目：36 项（全部真实 URL，星数/引用数经 GitHub API 与 Semantic Scholar API 实证；未核实处已标注）

调研背景：工作站运行时的能力自进化 + 开发期 super-skill 自动升级。已在 C 盘的 super-skill V4.1（idea-intake / research-orchestrator / proposal-forge / 14-Phase / post-run-evolution / darwin-evolution / buglog）作为嫁接基线对照。

---

## 一、全景表（36 项，按 A-G 分类）

### A. 技能库先驱（5 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 1 | [Voyager](https://github.com/MineDojo/Voyager) | 7,194★ MIT，引用 3.4k+ | 技能库模式鼻祖：skill=可执行 JS 代码+GPT-4 描述嵌入检索，新世界可整体复用 | 5 |
| 2 | [SkillWeaver](https://arxiv.org/abs/2504.07079) | 引用 136，[代码](https://github.com/OSU-NLP-Group/SkillWeaver) 156★ MIT | web agent 自学技能固化为 API；强 agent 技能可迁移给弱 agent | 5 |
| 3 | [ASI: Agent Skill Induction](https://arxiv.org/abs/2504.06821) | 引用 90，[代码](https://github.com/zorazrw/agent-skill-induction) 46★ | 任务执行中在线「归纳-验证-使用」程序化技能（轨迹遍历抽取） | 5 |
| 4 | [NSI: Lifting Traces to Logic](https://arxiv.org/abs/2605.01293) | 引用 8，ICML 2026 poster | 轨迹提升为逻辑接地的模块化程序技能（ASI 直系后继） | 4 |
| 5 | [Agent Learning via Early Experience](https://arxiv.org/abs/2510.08558) | 引用 62 | 经验蒸馏为三类符号知识：事实洞察/任务捷径/通用启发式，免微调复用 | 4 |

### B. 官方技能体系与生态（10 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 6 | [Anthropic Agent Skills 发布](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) | 官方博客 2025-10-16 | SKILL.md 文件夹+渐进式披露，三端（Code/claude.ai/API）可移植 | 5 |
| 7 | [agentskills.io](https://agentskills.io) | 官方背书标准站 | Agent Skills 开放规范的权威入口（anthropics/skills README 指定） | 5 |
| 8 | [anthropics/skills](https://github.com/anthropics/skills) | 176,007★ | 官方技能示范库；skill-creator（生成技能的技能）原发布于此（**现路径 404，新位置未核实**） | 5 |
| 9 | [Claude Code skills/subagents/hooks 文档](https://code.claude.com/docs/en/skills) | 官方文档（三页均 200） | 运行时能力扩展三件套：能力包/隔离代理/生命周期硬约束 | 5 |
| 10 | [skills.sh](https://skills.sh) | The Agent Skills Directory | 技能目录+CLI 安装器（npm 之于技能生态的雏形） | 3 |
| 11 | [obra/superpowers](https://github.com/obra/superpowers) | 285,825★ MIT | 社区技能框架+方法论；writing-skills 元技能=「教 agent 写技能」最佳实践 | 4 |
| 12 | [awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills) | 74,923★（ComposioHQ，已迁移） | 生态最全策展清单=免费需求情报+采购目录 | 4 |
| 13 | [SkillsMP](https://skillsmp.com) | 运行中市场 | Codex 与 Claude 双端技能市场（标准脱离单厂商的信号） | 3 |
| 14 | [OpenClaw](https://github.com/openclaw/openclaw) | 389,532★ | 开源个人 AI 工作站；技能生态爆发：[awesome-openclaw-skills](https://github.com/VoltAgent/awesome-openclaw-skills) 52,529★ 收 5,400+ 技能、医疗垂直库 3,004★ | 4 |
| 15 | [ClawHub](https://github.com/openclaw/clawhub) | 9,415★ MIT | 官方技能注册表：发布/版本化/向量搜索/审核钩子/CLI API | 5 |

### C. 从失败学习 / 经验回放（5 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 16 | [Reflexion](https://arxiv.org/abs/2303.11366) | 引用 5,179（NeurIPS 2023） | 失败→文字教训→情景记忆→下次注入（最轻量经验闭环） | 4 |
| 17 | [Self-Refine](https://arxiv.org/abs/2303.17651) | 引用 4,601（NeurIPS 2023） | 同轮生成→自评→修正迭代（单任务内质量回路） | 3 |
| 18 | [AWM: Agent Workflow Memory](https://github.com/zorazrw/agent-workflow-memory) | 469★ Apache-2.0，引用 268 | 轨迹→可复用工作流归纳入库；离线/在线双模；可泛化到未见网站 | 5 |
| 19 | [Memento](https://arxiv.org/abs/2508.16153) | 引用 100 | 案例（文本轨迹）检索+自适应改写≈不微调 LLM 的 agent 微调（官方仓库未核实） | 4 |
| 20 | [Agent KB](https://github.com/OPPO-PersonalAI/Agent-KB) | 451★ Apache-2.0，引用 82 | 跨域经验提炼为 insight 条目，manager 检索复用（OPPO 工业界出品） | 3 |

### D. 自动设计 agent（6 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 21 | [ADAS](https://github.com/ShengranHu/ADAS) | 1,638★ Apache-2.0，引用 313（ICLR 2025） | Meta Agent Search：code agent 在代码空间开放探索发明 agent 设计并归档 | 4 |
| 22 | [Darwin Gödel Machine](https://arxiv.org/abs/2505.22954) | 引用 218；[jennyzzt/dgm](https://github.com/jennyzzt/dgm) 2,313★；[官方页](https://sakana.ai/dgm) | 自改代码+SWE-bench 验证+全历史归档回滚，20%→50%；论文如实报告进化会停滞/漂移 | 5 |
| 23 | [AlphaEvolve](https://arxiv.org/abs/2506.13131) | 引用 836（DeepMind 页面本网络不可达，未核实） | MAP-Elites+程序数据库+LLM 变异+自动评估级联=可验证目标下的代码进化 | 4 |
| 24 | [OpenEvolve](https://github.com/codelion/openevolve) | 7,356★ Apache-2.0 | AlphaEvolve 开源实现，接任意 LLM API 即用（代码类技能进化免自研） | 4 |
| 25 | [Alita](https://arxiv.org/abs/2505.20286) | 引用 115 | 能力缺口→现场从 GitHub 上下文造 MCP 工具（最小预定义） | 3 |
| 26 | [AgentSquare](https://github.com/tsinghua-fib-lab/AgentSquare) | 231★ | 规划/推理/工具/记忆四模块分解+进化搜索组合 agent 架构（arXiv ID 未核实） | 3 |

### E. 提示/策略进化（4 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 27 | [DSPy](https://github.com/stanfordnlp/dspy) | 37,990★ MIT | 「编程而非提示」，提示/演示=可优化参数，内置 MIPROv2/GEPA/Koopo | 5 |
| 28 | [GEPA](https://arxiv.org/abs/2507.19457) | 引用 368（独立仓库未核实，已并入 DSPy，[dspy.ai](https://dspy.ai) 有文档） | 反射式提示进化：从执行 trace 反例反思变异+Pareto 选择，胜 RL 且便宜一个量级 | 5 |
| 29 | [TextGrad](https://github.com/zou-group/textgrad) | 3,725★ MIT，引用 218 | 文本梯度反传：任何文本由批评反馈自动「求导」优化 | 3 |
| 30 | [Hermes Agent Self-Evolution](https://github.com/NousResearch/hermes-agent-self-evolution) | 5,316★（无 license 文件，注意） | DSPy+GEPA 进化 skills/工具描述/系统提示/代码；eval 自动出题+约束闸（测试/体积/基准），$2-10/次 | 5 |

### F. 工程化模式（4 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 31 | [OpenWolf](https://github.com/cytostack/openwolf) | 2,281★ AGPL-3.0，2026-08 活跃 | buglog 模式源头；2026 已演进为跨 Claude Code/Codex/OpenCode 便携项目记忆+token 记账 | 5 |
| 32 | [claude-mem](https://github.com/thedotmack/claude-mem) | 93,751★ Apache-2.0 | hooks 驱动的跨会话持久上下文：自动捕获→压缩→检索 | 4 |
| 33 | [Letta（原 MemGPT）](https://github.com/letta-ai/letta) | 24,715★ Apache-2.0 | 内存块+自编辑记忆+sleep-time compute（空闲离线自我优化） | 4 |
| 34 | [Constitutional AI](https://arxiv.org/abs/2212.08073) | 引用 3,654 | 依明文原则自我批评修订=「把教训写成规则」的学术原型 | 4 |

### G. 风险与对齐（2 项）

| # | 名称 | 规模（实证） | 一句话 | 相关度 |
|---|------|------|--------|--------|
| 35 | [A Survey of Self-Evolving Agents](https://arxiv.org/abs/2507.21046) | 引用 109 | What/When/How/Where 四问框架，含「何时不该进化」讨论 | 5 |
| 36 | [Claude Code permissions/hooks](https://code.claude.com/docs/en/permissions) | 官方文档（200） | 人审闸门的工程实现：allow/deny/ask 清单+宿主层强制钩子，不依赖模型自觉 | 4 |

> 未核实汇总：AgentSquare 的 arXiv 编号；AlphaEvolve 官方博客页（deepmind.google 本网络 000/404，以 arXiv 为准）；GEPA 官方独立仓库（以 DSPy 集成为准）；skill-creator 在 anthropics/skills 重组后的新路径（原路径 404）；Memento 官方代码仓库；Apollo Research 站点（本网络不可达，弃用）。

---

## 二、推荐自进化架构：五段式「经验→技能固化」流水线（skill-forge）

**一句话**：以 SKILL.md 开放标准为存储格式，按「触发→案例→升格→验证→注册」五段流水线把运行经验固化成带回归考卷的可执行技能包，进化引擎外包给 DSPy/GEPA+OpenEvolve，人审闸由宿主 hooks 强制。

### 1. 触发层（何时进化）
- **四类信号**（复用 V2 post-run-evolution 信号分公式 (Impact×Frequency×Feasibility)/Risk，阈 12）：
  - 失败信号：run-ledger 的 error/重试/回滚——buglog 15 类正则自动捕获（已验证有效，保留）
  - 重复信号：同类操作/相似检索命中 ≥3 次——AWM 式轨迹归纳
  - 缺口信号：用户显式需求/工具缺失——Alita 式（可触发现场造 MCP 工具）
  - 停滞信号：质量分连续 N 项目无提升（V2 stagnation 保留）
- **执行时机分层**（Letta sleep-time 模式+我们的晚间长跑纪律）：任务中只写 Reflexion 式轻量条目（失败教训一句话+事故链接）；夜间空闲批处理跑重活（归纳/进化/回归）。

### 2. 固化层（技能怎么长出来）
- **三层技能分型**（Early Experience 分类学）：knowledge（事实/情境洞察）/ shortcut（任务级捷径）/ heuristic（通用启发式）。
- **两阶升格（防膨胀的关键）**：经验先进**案例库**（Memento 式文本案例+Jaccard 相似检索，buglog 即此层）；复用≥N 次或信号分过阈，才由元技能（skill-creator 式，参照 superpowers writing-skills 规范：触发条件显式+反例列示）升格为正式技能包。
- **技能包结构**（agentskills.io 规范+三代学术结论）：
  ```
  skill-name/
  ├── SKILL.md      # 接口：触发条件、前置/后置条件（NSI 逻辑接地）、反例
  ├── scripts/      # 本体：可执行代码（Voyager/SkillWeaver——代码技能为主，文档技能为辅）
  └── evals/        # 考卷：自动生成的验收用例（Hermes eval-first）
  ```
- **提示类资产**一律 DSPy 模块化，用 GEPA 反思进化（从失败 trace 反例变异，非手调）。

### 3. 验证闸（怎么知道有效）
- **eval-first**（Hermes 实证）：先自动生成 eval 数据集，再生成候选变异；没有考卷就没有进化。
- **三闸**：①eval 通过率不降；②体积上限（SKILL.md<500 行、包<若干文件，ClawHub/Hermes 同款 size limits）；③冒烟测试在 subagent 沙箱跑通（Claude Code subagents 隔离）。
- **客观适应度**（DGM 教训）：以基准分/通过率做适应度，**绝不自评**。
- **永久归档**：所有版本与执行 trace 归档（DGM archive），支持一键回滚到任意祖先版本。

### 4. 版本管理层
- ClawHub 式注册表 schema：语义版本+向量检索+CLI API+使用计数/效果分（V2 capsule 的 usage_count 已有，扩展为注册表字段）；本地以 skills-lock.json 锁定依赖版本（已有）；技能带**保质期**字段，超期未复用自动降级回案例库。
- **GC 规则**：使用计数低+效果分低+体积超标 → 降级归档而非删除（保留在 git 历史与案例层）。

### 5. 人审与安全层（「进化提案永不自批」的落地）
- **宿主强制而非提示自觉**（Claude Code permissions 模式）：进化学得的写权限收敛到独立目录/独立身份，PreToolUse hooks 拦截「自写自批」——改 super-skill 核心文件、hooks、权限配置的动作一律触发 ask。
- **分级审批**：低风险（文案/参数微调）自动+事后报备；中风险（新增/修改技能包）生成 PR 式进化提案等人批；高风险（改规则/宪法/hooks/自身进化器）冻结等人。
- **冻结与回滚条件**（DGM 停滞实证）：连续 N 次进化无提升 or 指标漂移超阈 → 自动冻结+回滚+人审复盘。
- **预算闸**：GEPA 单次 $2-10，高频任务级进化会失控——月度进化预算上限，夜间批处理摊薄成本。

### 嫁接到 super-skill V4.1（具体动作）
1. `post-run-evolution` 改造为 skill-forge 触发器：保留信号公式与七步复盘，输出从「直接 mutation」改为「案例条目+进化提案 PR」。
2. `darwin-evolution` 的自研 GEP 变异循环**外包**：提示/文档类走 DSPy+GEPA，代码类技能走 OpenEvolve——自研进化引擎是负资产。
3. `buglog` 保留为案例层第一级，新增「案例→技能」升格通道与阈值。
4. 14-Phase 的 Phase 12 之后自动挂夜间流水线（与「长跑任务晚间执行」纪律对齐）。
5. 开发期自举：super-skill 自身升级走同一条流水线吃狗粮；元技能（skill-creator 式）生成/修订子技能可半自动，改核心须人批。

---

## 三、Top 5 缝合推荐

1. **SkillWeaver**——技能的正确抽象=API/可执行工具而非提示片段；练习精化+强→弱跨模型迁移，证明技能库是可跨模型存活的资产。
2. **Anthropic Agent Skills 标准（agentskills.io）+ ClawHub 注册表**——格式与分发直接吃生态：OpenClaw 5,400+ 技能、Codex 双端市场都在同一 SKILL.md 规范上，我们只造「工厂」不造「格式」。
3. **Hermes Agent Self-Evolution**——目前唯一开箱即抄的完整自进化流水线（eval 自动出题→GEPA 变异→约束闸→落盘，$2-10/run），补上我们缺的「自动出考卷」环节。
4. **AWM（Apache-2.0）**——run-ledger→工作流沉淀的最直接学术对标，离线/在线双模可逐行参考实现。
5. **Darwin Gödel Machine**——归档+回滚+客观适应度的安全范式，且论文自己证明开放进化会停滞/漂移=人审闸与冻结条件的必要性实证（正反教材一体）。

---

## 四、3 条硬启示

1. **技能=可执行代码+描述+检索键**：Voyager→SkillWeaver→ASI/NSI 三代连续收敛于同一表示，纯文档技能上限低。SKILL.md 是给人与检索器的接口，scripts/ 才是复用本体——我们的技能包必须代码优先。
2. **验证先于变异（eval-first）**：Hermes/DGM/AlphaEvolve 的共同存活条件是有客观评估器；没有考卷的自进化必然产出「自我感觉良好」的腐化技能库。先建考卷，再谈进化。
3. **技能是跨模型可携带资产**：SkillWeaver 强→弱 agent 迁移、GEPA 跨域迁移、claude-mem/OpenWolf 跨 harness 记忆、ClawHub/SkillsMP 跨厂商市场——按开放标准（SKILL.md）存技能=工作站资产不随模型迭代作废；锁死单一 API 等于自毁护城河。

---

## 五、风险与对策

| 风险 | 实证 | 对策 |
|------|------|------|
| **自我修改失控/漂移** | DGM 论文如实报告：开放式进化会停滞，且出现 reward hacking 式走偏 | 冻结条件（连续 N 次无提升/指标漂移>阈→自动回滚祖先版本）；人审分级（提案永不自批）；hooks 宿主层硬闸（不靠提示自觉） |
| **技能库膨胀/腐化** | 技能市场 5,400+ 条目无人审计；无 GC 的记忆库必然退化 | 两阶升格（案例库缓冲）；体积上限；使用计数+效果分 GC；保质期字段；向量检索按需加载（渐进式披露） |
| **供应链/提示注入** | 外来 SKILL.md 是任意文本指令（awesome 清单与市场来源混杂）；OpenWolf 为 AGPL-3.0 不可直接内嵌商用 | 外来技能先过提示注入扫描（ClawHub moderation hooks 同款）+沙箱 subagent 试运行；许可审查入采购流程 |
| **进化成本失控** | GEPA 单次 $2-10 便宜，但任务级高频触发会指数放大 | 月度进化预算闸+夜间批处理+信号分阈值（低分信号只进案例库不触发进化） |

---

*调研方法注记：WebSearch/webReader 配额中途耗尽（2026-09-26 重置），全部数据改经 GitHub REST API（星数/许可/活跃度）、Semantic Scholar batch API（论文标题/年份/引用数）、Crossref、raw.githubusercontent README 抓取与直连 HEAD 探测实证；文中「已验证」均指 HTTP 200 或 API 实测返回。*
