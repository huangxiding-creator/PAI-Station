# DIGEST — 环节6：用户建模（"比用户更懂用户"）

> 调研日期 2026-09-13。31 项入库（`_all.json`），全部真实 URL；GitHub star/许可为 gh API 当日实测，产品站点为直连验证；受阻项已逐条标注。
> 与 v1/v2 docket 去重：screenpipe / Rewind / Microsoft Recall / ReMe(openhuman) / OpenViking / openhuman 已收录于旧卷，本文仅在架构中引用，不重复立项。
> 通道说明：WebSearch 周限额尽（9-26 重置）后切换 gh API + 官网直 curl + Bing 双通道验证；arXiv API/Semantic Scholar 被同 IP 并行代理打满，论文 ID 改经官方 repo README 与权威 survey 清单（Agent-Memory-Paper-List）交叉核实。

## 一、全景表（按 A-F）

### A. 用户记忆系统（8 项）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [mem0](https://github.com/mem0ai/mem0) | ★65,197 | Apache-2.0 | 两阶段管线：抽取用户事实→ADD/UPDATE/DELETE/NOOP 冲突消解（arXiv:2504.19413） | 事实抽取+更新决策管线直接抄，OSS 可配本地模型 | 5 |
| [Zep/Graphiti](https://github.com/getzep/graphiti) | ★30,836 | Apache-2.0 | 双时间线知识图谱：每条事实带 valid_from/invalid_at（arXiv:2501.13956） | "用户变了"的一生公民问题——事实失效不删除、演化可追溯 | 5 |
| [Letta](https://github.com/letta-ai/letta) | ★24,715 | Apache-2.0 | core memory（persona/human 块）由 LLM 自编辑；MemGPT（arXiv:2310.08560） | 画像常驻上下文+自我编辑=普适建模最小架构 | 5 |
| [memobase](https://github.com/memodb-io/memobase) | ★2,894 | Apache-2.0 | 用户画像+事件时间线为中心，<100ms 纯 SQL 直查；900 轮对话 vs mem0 实测 | 低延迟画像直查路线（免向量检索）；评测协议可复用 | 5 |
| [TencentDB-Agent-Memory](https://github.com/TencentCloud/TencentDB-Agent-Memory) | ★26,492 | 自定义（需审） | L0 会话→L1 原子→L2 场景→L3 人格四层蒸馏+版本化技能库+Wiki/CodeGraph | 最完整的画像分层开源实现，中文一手，可 standalone 自部署 | 5 |
| [ChatGPT Memory](https://help.openai.com/articles/8590148-memory-faq) | 亿级用户 | 闭源 | 双系统：离散 saved memories（可查看可编辑）+ 全历史按需检索（[逆向分析](https://embracethered.com/blog/posts/2025/chatgpt-how-does-chat-history-memory-preferences-work/)） | 工业界收敛答案：画像条目层+全量检索层双层并存 | 4 |
| [Claude Memories/CLAUDE.md](https://simonwillison.net/2025/Sep/12/claude-memory/) | 千万级 | 闭源机制公开 | 每 Project 独立记忆池；用户级/项目级 Markdown 指令文件 | "Markdown 即画像载体"+项目分域防串味 | 4 |
| [character.ai](https://character.ai/) | 头部平台 | 闭源 | 角色人设长期保持（细节未核实，国内直连受阻） | 反面对照：黑箱人设不可审计，工作画像必须透明 | 2 |

### B. 数字孪生/人格建模（4 项）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [Stanford 千人数字孪生](https://arxiv.org/abs/2411.10109) | 1052 人×2h 访谈 | arXiv 开放 | 2 小时结构化访谈→智能体复刻：GSS 复现 ~85%、大五 r≈0.80 | 建模上限证明；全盘文档+聊天=无限长访谈，可超过它 | 4 |
| [Delphi](https://www.delphi.ai) | 商业运营中 | 闭源 SaaS | "Digitize Your Mind"：喂全部书籍/播客/推文→可对话专家分身（首页 Lessig 分身：140 万词+5.6K 推文） | 语料喂养型分身产品形态；云端无隐私=本地版的对立卖点 | 3 |
| [Sotopia](https://github.com/sotopia-lab/sotopia) | ★331，ICLR'24 spotlight | MIT | 开放社交环境评人格化 agent（arXiv:2310.11667），系列含 sotopia-π 人类反馈迭代 | "像不像本人"的评测方法学（双盲对话对照） | 3 |
| [MindBank.ai](https://www.mindbank.ai) | 域名已死 | 闭源 | 个人孪生创业项目，2026-09 域名跳转无关页面（细节未核实） | 警示样本：纯云端个人孪生无变现闭环易死 | 2 |

### C. 写作/工作风格建模（3 项）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [PAN Authorship Verification](https://pan.webis.de) | 常设评测实验室 | 学术开放 | 作者身份验证/风格混淆长期基准（站点直连 200 验证） | 风格画像可被"是不是本人写的"检验——风格一致性自测 | 3 |
| [awesome-cursorrules](https://github.com/PatrickJS/awesome-cursorrules) | ★40,774 | CC0 | 数千条按技术栈组织的代码风格规则社区库（Cursor/Copilot instructions 工业惯例） | 风格即规则即 exemplar：自动归纳"个人 cursorrules"比训练风格模型便宜百倍 | 4 |
| [Voyager](https://github.com/MineDojo/Voyager) | ★7,194 | MIT | 自动课程+技能库：成功解法固化为可检索可组合代码技能（arXiv:2305.16291） | "做事方式=可执行技能卡+复用+组合"范式源头 | 3 |

### D. 知识沉淀（9 项）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [Sleep-time Compute](https://arxiv.org/abs/2504.13171)（[code](https://github.com/letta-ai/sleep-time-compute) ★137/MIT） | 论文+代码 | MIT | agent 空闲期"预思考"重写自己的记忆块，计算从 test-time 前移 | "夜间整理白天素材"正名论文，与本地调度天然契合 | 5 |
| [cognee](https://github.com/topoteretes/cognee) | ★30,655 | Apache-2.0 | ECL 管线（抽取-认知-加载）→自托管知识图谱记忆引擎 | L3 领域知识层引擎候选 | 4 |
| [Khoj](https://github.com/khoj-ai/khoj) | ★37,292 | AGPL-3.0 | 自托管第二大脑：文档问答+自动化+深度研究，可全本地 | 个人知识库 agent 全栈形态参照（AGPL 传染注意） | 3 |
| [Smart Connections](https://github.com/brianpetro/obsidian-smart-connections) | ★5,448 | 自定义 | 本地嵌入模型找相关笔记，零 API key 零上传 | 隐私标杆：嵌入本地算、数据不出库 | 4 |
| [Obsidian Copilot](https://github.com/logancyang/obsidian-copilot) | ★7,708 | AGPL-3.0 | vault 对话 copilot，本地/云混合 | "用户可编辑知识镜像+对话入口"产品化样板 | 3 |
| [Logseq](https://github.com/logseq/logseq) | ★44,878 | AGPL-3.0 | 隐私优先本地大纲知识库 | 纯 Markdown 镜像可被 Obsidian/Logseq 双开（互操作） | 3 |
| [HanLP](https://github.com/hankcs/HanLP) | ★36,491 | Apache-2.0 | 中文分词/NER/依存/语义角色/指代消解全家桶，本地部署 | 中文实体链接主力：文档→实体→个人 KG 基座 | 4 |
| [PaddleNLP UIE](https://github.com/PaddlePaddle/PaddleNLP) | ★12,973 | Apache-2.0 | schema 驱动零样本中文信息抽取 | "抽什么"声明式配置化；与 GLM 抽取互补 | 4 |
| [LTP](https://github.com/HIT-SCIR/ltp) | ★5,259 | 需审 | 哈工大中文 NLP 工具链 | 重要实体抽取双引擎交叉验证件 | 3 |

### E. 纵向记忆固化（5 项）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [MemoryBank](https://arxiv.org/abs/2305.10250) | AAAI 2024 | 论文开放 | 艾宾浩斯遗忘曲线做记忆强度衰减（回忆即强化） | 防僵化另一半：常用偏好上浮、过时偏好下沉（衰减检索分） | 4 |
| [A-MEM](https://github.com/agiresearch/A-mem)（arXiv:2502.12110） | ★1,177 | MIT | Zettelkasten 式记忆卡：新条目触发邻居卡片演化 | 画像条目"活卡片"：证据可挂、新旧互链、受触发演化 | 4 |
| [MemOS](https://github.com/MemTensor/MemOS)（arXiv:2507.03724） | ★11,300 | Apache-2.0 | 记忆当 OS 资源：MemCube 统一调度参数化/激活/明文记忆 | 情景→语义固化的调度词汇表：夜间该升格谁/压缩谁/转存谁 | 4 |
| [Memory Survey](https://arxiv.org/abs/2512.13564)（[清单库](https://github.com/Shichun-Liu/Agent-Memory-Paper-List) ★2,378） | 2025-12 综述 | 开放 | agent 记忆全景分类：参数化 vs 上下文、读写操作、固化路径 | 选型地图与术语对齐器 | 4 |
| [Generative Agents](https://github.com/joonspk-research/generative_agents)（arXiv:2304.03442） | ★22,094 | Apache-2.0 | 记忆流+recency/importance/relevance 三因子+定期反思升格 | 夜间反思生成画像洞察的机制原型，直接可抄 | 4 |

### F. 工作流挖掘（2 项 + A/C 类交叉）

| 项目 | 规模 | 许可 | 一句话 | 对 V3 的价值 | 相关度 |
|---|---|---|---|---|---|
| [Agent Workflow Memory](https://arxiv.org/abs/2409.07429) | 论文（Wang et al.） | 开放 | 从历史轨迹归纳可复用 workflow（guided/autonomous 两式），显著提升 agent 成功率 | F 类核心答案："用户怎么做事"=轨迹→workflow 库→新任务先查库 | 5 |
| [PM4Py](https://github.com/process-intelligence-solutions/pm4py) | ★1,024 | AGPL-3.0 | 事件日志→过程模型/瓶颈/变体的过程挖掘标准库 | 用户行为日志当事件日志挖流程——AWM 的可解释非 LLM 通道 | 3 |
| （交叉）TencentDB Skills / Voyager / cursorrules | — | — | 版本化技能卡+触发边界+验证规则；技能库自归纳；风格规则库 | L4 做事流程层的三块积木 | 4 |

## 二、推荐用户建模架构（缝合结论）

**一句话：五层画像 + 双时间线 + 夜间整理 + 全程人可编辑——画像本体是带生命周期的结构化条目（非向量黑箱），白天采集粗抽、夜里固化反思、检索时时间加权。**

### 画像分层（各层采集来源与更新机制）

| 层 | 内容 | 采集来源（白天） | 更新机制 | 主要参照 |
|---|---|---|---|---|
| L1 身份事实 | 姓名/角色/组织/设备/关系/稳定习惯 | 对话显式自述、文档元数据（署名/模板/路径）、通讯录 | mem0 式 ADD/UPDATE/DELETE 决策 + Zep 双时间线（新证据→旧条目 invalid_at，不删可溯） | mem0 + Zep + memobase |
| L2 偏好风格 | 写作风格/称谓偏好/工具偏好/禁忌 | 初稿→终稿 diff、采纳/拒绝/改写行为、显式反馈 | 风格 exemplar 库（不是文字画像！）：按任务类型存最相似 3-5 段历史成稿片段，生成时 few-shot 注入；每次改写即新 exemplar，滑动窗口保鲜 | cursorrules + ChatGPT 双系统 |
| L3 领域知识 | 项目/概念/实体的个人语义网 | 全盘文档→MD（MarkItDown/MinerU/docling，v1 已选）、代码库 CodeGraph | 增量扫描（凌晨 1:00）+ HanLP/UIE 实体链接入个人 KG；KG 镜像为 Obsidian Markdown（可读可编辑，改动回写） | cognee + HanLP/UIE + openhuman Memory Tree 结论 |
| L4 做事流程 | "用户做调研报告/写周报/发通知"的标准动线 | agent 执行轨迹（trace）、用户手动操作序列（文件/网页时间线） | AWM 式轨迹归纳→技能卡（版本+触发边界+执行步骤+验证规则，TencentDB/Voyager 形态）；新轨迹相似度>阈值则合并，<阈值则分化新卡 | AWM + TencentDB Skills |
| L5 成果库 | 历史终稿/报告/代码成果，带质量分 | 验收通过的产出物、用户存档行为 | 按"任务类型×质量分"索引，作为 few-shot exemplar 与 L2 风格基准；终稿与初稿 diff 回流 L2 | Voyager 技能库 + 个人 corpus 常识 |

### 夜间整理模式（sleep-time compute 设计，1:00-6:00 低负载窗口）

1. **固化**（MemOS 调度思想）：当日情景记忆去重合并；出现≥N 次的偏好从"情景"升格为"语义"写入 L1/L2，带 confidence 与证据链。
2. **遗忘**（MemoryBank 艾宾浩斯）：全库记忆强度按衰减函数下调；当天被检索/确认过的条目回升——检索分=(相关度×recency×importance)（Generative Agents 三因子的直接沿用）。数据永不物理删除，只降权重。
3. **反思**（Generative Agents reflection）：对近 3 天事件跑高阶洞察（"用户连续三次把 AI 的被动语态改成主动"→生成风格洞察，标记"待确认"），次日用户一键确认才转正。
4. **图谱整理**（cognee/A-MEM）：新实体入链、指代消解、卡片互链演化（A-MEM 的邻居触发更新）。

### 防僵化与可解释性（内建而非补丁）

- 每条画像条目四元组：`值 + confidence + last_confirmed + evidence 溯源链接`；低置信条目不进生成上下文，只进确认队列。
- 检索一律 recency 加权：三个月未被任何证据强化的偏好自动降权——画像跟着人走。
- 全部画像镜像为 Obsidian Markdown（用户可直接改，改完回写+该条 confidence 置满）——学 openhuman "No vector-soup black box"，Claude CLAUDE.md 证明此工程路线成立。
- 临时会话/隐私目录（如 `_credentials/`）永不进画像采集（openhuman temporary chats 思路 + 本站 v1 隐私规范）。

## 三、Top5 缝合推荐

1. **TencentDB-Agent-Memory**（★26,492）——L0→L3 四层蒸馏+版本化技能卡+Wiki/CodeGraph 全形态直接参考；中文一手文档，standalone 自部署；唯一注意：许可为自定义需法务过目（只借架构思想，不搬代码即可绕开）。
2. **Letta**（★24,715）——core memory 自编辑块（human 块=用户画像块）+ sleep-time 夜间整理，普适建模的最小可行内核；Apache-2.0，可接本地 GLM 链。
3. **mem0**（★65,197）——事实抽取+四操作冲突消解管线的事实标准；中文社区实测充分，OSS 版完全本地可跑。
4. **Zep/Graphiti**（★30,836）——双时间线事实生命周期，防画像僵化的机制底座；自托管（Neo4j/FalkorDB）。
5. **Agent Workflow Memory**（arXiv:2409.07429）——L4 做事流程层的唯一强论文：轨迹→可复用 workflow，guided/autonomous 两式都给出做法。

## 四、3 条硬启示

1. **全球头部方案全部收敛到"结构化条目+显式生命周期"，没有一家用纯向量做画像本体**——mem0 四操作、Zep 双时间线、Letta 自编辑块、TencentDB L0-L3、ChatGPT 离散记忆层；向量只配做检索。谁把画像做成向量黑箱，谁就在防僵化、可解释、可编辑三个维度集体出局。
2. **"用户变了"必须是一等公民设计**——Zep 给事实标失效时间、mem0 显式 UPDATE/DELETE、MemoryBank 遗忘曲线、ChatGPT 关记忆再开会从残留历史重建：四家头部为画像演化各显神通。没有时间轴的画像三个月后必然固化成错误人格，而错误画像会通过生成内容反噬用户的自我认知（画像反身性）。
3. **建模上限根本不在算法在采集覆盖**——Stanford 用 2 小时访谈就复刻了 85% 的社会调查回答；Delphi 喂 140 万词+5.6K 推文就能开收费分身。装在个人电脑上的工作站坐拥用户全盘文档+全部聊天+每次修改 diff，等于一场永不结束的深度访谈——PAI-Station 的护城河是"采集面×夜间整理"，而非更好的抽取算法。

## 五、风险

- **画像错误固化（stereotype lock-in，最高风险）**：低置信度早期画像→影响生成→用户被动适应→行为数据反过来"证实"错误画像，闭环自强化。缓解：置信度门限（低置信不进上下文）、时间衰减（三月无强化即降权）、待确认队列（重要画像变更需用户次日确认）、反例保留（用户纠正永远优先于推断）。
- **隐私（画像是全机最敏感资产）**：画像=职业+健康+关系+财务的全息侧写。要求：本地加密存储（SQLite+SQLCipher）；最小披露——云端模型只送当前任务所需切片，绝不送画像全量；导出即明文，需显式授权+脱敏选项；临时会话与凭据目录硬编码进采集黑名单；画像删除权=一键清空且可验证（学 ChatGPT 记忆管理的可关闭/可清除）。
- **记忆基准互相打架**（v1 docket 已有结论，本次复证）：LoCoMo 等厂商自测基准不可尽信（mem0/Letta/Zep 各说各话）；memobase 的 900 轮真实对话对比是少数第三方视角。选型以自建评测为准：固定 30 轮中文真实任务+人工画像评分。
- **许可暗雷**：TencentDB-Agent-Memory（自定义许可）、Smart Connections（NOASSERTION）、LTP（未声明）、Khoj/Obsidian Copilot/PM4Py（AGPL 传染）——一律只借思想不搬代码，或换 Apache/MIT 等价件（mem0/Letta/cognee/HanLP 均干净）。

## 附：本次受阻与未核实清单（诚实账）

- MindBank.ai：域名已死，产品细节未核实（历史资料不足，仅记录死链事实）。
- character.ai：国内直连 000 受阻，Memory/Persona 功能细节未核实，仅作反面对照项。
- PersonalLLM（arXiv:2410.08547，"personal facts/偏好适配"研究）：WebSearch 限额+arXiv API 限流+Bing 污染三通道受阻，ID 未经二次核实，未入库——待限额恢复后补验。
- PAN 各届 authorship verification 任务子页 404/未逐一核实，仅实验室主站（pan.webis.de，HTTP 200）为实。
- Bing 国内版对长英文查询返回污染结果（翻译站/词典页），本次所有产品结论均以官网直连或 gh API 官方 README 为准。
