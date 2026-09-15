# Docket 11 — 感知型意图识别（从电脑动态信息识别用户任务与意图）

调研时点：2026-09-15 ｜ 代理：v3r11 ｜ 数据源：GitHub REST API 两批一手实测（`_recon/gh_survey_out.tsv`+`gh_survey2_out.tsv`，0.8s/7s 限速纪律）、metaso 学术检索 2 轮（scholar：GUI agent 综述 + 桌面活动任务识别学术脉络）、本项目 `paistation.sense` 源码对照
说明：WebSearch 配额耗尽（2026-09-26 重置），按预案降级 GitHub API + metaso；stars 为 2026-09-15 实测值；Magentic-One 原仓 404（已归档改名）弃收。

## 总量

- `_all.json`：**71 条**（要求 ≥30），全部 9 字段；仓库 57 + 学术论文/系统 14
- 覆盖矩阵：perceptual-context 12 / gui-grounding 10 / cua-framework 11 / intent-nlu 11 / memory-selfevolve 4 / process-mining 2 / benchmark 2 / awesome-index 5 / academic 14
- C14 抽查通过（JSON 可解析 + schema 合规 + relevance 无越界）

## 核心判别：意图识别有两个世界，PAI 要的是后者

| | 执行型 CUA | **感知型意图发现（PAI 的世界）** |
|---|---|---|
| 输入 | 用户显式指令（"帮我订机票"） | 无指令，只有动态信息流（窗口/文件/语音/剪贴板/屏幕） |
| 难点 | grounding + 多步规划 | **意图本身未知**：他在干什么？想要什么？何时该开口？ |
| 代表 | UI-TARS / Agent-S / UFO / browser-use | TaskTracer 系学术 20 年 + screenpipe/MIRIX/银甲虫 |
| 对 PAI 价值 | 感知升级件（grounding 模型可插拔）+ 推理分级模板 | **主体架构**：事件流→意图→记忆→主动服务 |

学术脉络 20 年一以贯之：TaskTracer(2005)「任务=持续+资源组绑定」→ SWISH(2006)「标题语义+切换历史聚类」→ TaskPredictor/2(2007/09)「单窗分类+Viterbi 序列融合+在线学习」→ SummAct(2025)「LLM 行为摘要→子目标→高层意图（+21.9%）」。工程界三档成熟度：录制检索档（screenpipe/Windrecorder/OpenRecall）、记忆分档（MIRIX/银甲虫）、执行档（CUA 全家）。

## Top 12 精选（按对 PAI-Station 的启示强度）

| # | 项目 | Stars | 为什么入选 |
|---|------|-------|-----------|
| 1 | **银甲虫 silver-beetle** | 3 | 与 PAI 感知→意图→记忆链路**几乎同构**的独立最小实现：窗口+文件活动+剪贴板类型+屏幕理解+本地 LLM→日报/时间线/项目记忆/上下文接力。信号选型（三源）与产出形态直接可抄的骨架 |
| 2 | **UI-TARS（字节）** | 38979 | 感知升级最高标杆：截图→结构化理解免 UIA；System-2 三件套（任务分解/反思/**里程碑识别**）同时是意图推理提示工程模板 |
| 3 | **xvfeng 车载助手** | 17 | **双层意图识别+无关语义拒识**（400+技能）方法论实证：小模型粗筛→大模型细判→置信不足输出"无关"。PAI 拒识门的直接模板 |
| 4 | **TEXTOIR（清华 thuiar）** | 254 | "开放意图识别"= PAI 需求的学术命名：已知意图分类+开放意图发现+新意图归纳三模块，工具包可直接用作 L1 候选算法 |
| 5 | **SummAct（2025 论文）** | — | 感知型意图识别 SOTA 形态=「行为摘要」而非「逐步分类」，ICL 路线免微调领先基线 21.9%——PAI L2 慢通道的同款设计 |
| 6 | **OmniParser（微软）** | 25389 | 屏幕感知升级首选件：截图→可交互元素结构化清单，与 UIA 双通道互补；CC-BY-4.0 |
| 7 | **MIRIX** | 3441 | 屏幕活动→六类记忆（core/episodic/semantic/procedural/resource/knowledge-vault）完整映射表，与 PAI profile 五层互为校对清单 |
| 8 | **ActivityWatch** | 18887 | window/AFK bucket 模型=事件流分段现成范式（意图识别第一道工序）|
| 9 | **UItron（2025 论文）** | — | 复杂度自适应三档推理：简单直接答/复杂先 think/最难强制**观察屏幕变化**再判——PAI L2 路由表照抄 |
| 10 | **TaskPredictor 系（2007/09 论文）** | — | 「单窗分类+Viterbi 序列融合」抑制窗口级抖动+「功能操作→工作流→任务」三层抽象，与 PAI 事件→活动段→意图直接对应 |
| 11 | **OpenCUA / AgentNet（港大）** | — | 数据飞轮完整模板：演示→带反思的状态-动作对→模型进化。PAI 每次晨报修正都应落 (segment, gold_intent) 样本 |
| 12 | **graphiti（Zep）** | 30872 | 时序知识图谱：bi-temporal 模型（有效时间≠录入时间）与 PAI profile 双时间线同款设计，意图上下文图谱化升级位 |

候补：OpenAdapt（活动→可验证程序，技能 forge 取证标准）、AppAgent→AppAgentX（先探索建文档再依文档行动+经验→技能升格）、AWM（抽象工作流记忆单元）、pm4py（意图序列→工作流发现的算法箱）、Rasa（意图-槽位标注体系工业标准）、IntelliQ（意图→槽位→NL2API 中文完整样例）。

## 七层收敛方法论（顶级方法论栈，自下而上）

1. **事件流分段（segmentation）**——意图识别的第一道工序。AFK/焦点窗口变更/空闲超时切出活动段（ActivityWatch bucket；TaskPredictor 实时切换检测的似然比检验+Viterbi）。**不切段的意图识别=窗口级抖动灾难**。
2. **L1 快通道**——毫秒级、处理 95% 流量：窗口标题+进程+文件路径+剪贴板类型 → 轻量嵌入/规则（SWISH 特征组合 20 年最优：零成本、跨应用、语言鲁棒）；输出候选意图+置信度，Viterbi 平滑。
3. **L2 慢通道（复杂度分级）**——段级摘要→LLM 推理意图+槽位+证据。UItron 三档路由：简单段直判（复用 L1 候选）/复杂段 think/最难段**强制引用屏幕变化证据**再判。SummAct 证明「行为摘要」形态优于逐步分类，ICL 免微调。
4. **双层意图+拒识门**——粗分类→细意图→低置信度输出"无关"（xvfeng 车载 400+ 技能实证）。**对主动式助理，不误触发是生死线**：拒识不是失败路径，是一等公民输出。
5. **时序记忆增强**——意图→用户/项目长期记忆→反哺识别（SE-GA 分层记忆；AWM 抽象工作流检索；MIRIX 六类；graphiti bi-temporal）。分层是记忆的必要条件，三方互证。
6. **纠正飞轮（ICL 先于微调）**——用户修正→(segment, gold_intent) 样本库→检索增强进 prompt（OpenCUA 状态-动作对范式；TaskPredictor2 在线学习原型；LongPerceptualThoughts 指出后续蒸馏回 L1 的降本路线）。
7. **感知升级件（grounding 即插）**——OCR/窗口文本不够时→OmniParser 结构化解析→UI-TARS 级端到端理解，作为 tiers 感知档位升级位（低配 dsh-grounding 式本地 OCR 兜底存在性已证）。

另两条架构判断（来自 Agent S3/UFO 的反面经验）：意图发现与动作执行**必须解耦成两个循环**（UFO 双 agent 分工）；意图层**无编排层级**、直接函数管线（Agent S3 去 manager-worker 教训）。

## PAI-Station 落位设计（`paistation/intent/` 新包）

底座已备：M1 语音事件流（voice.utterance）+ M2 文件水位线（fs_watcher）+ M2.6 云文档（cloud.doc.change）+ 屏幕 vision 增量（screen.py/vision.py/incremental.py）——**六路信号源已齐，缺的正是中间的意图层**。

| 组件 | 职责 | 复用 | 外部参照 |
|------|------|------|---------|
| `segmenter.py` | AFK+焦点变更+空闲超时→ActivitySegment；段内信号聚合 | sense 事件流 | ActivityWatch bucket、TaskPredictor 切换检测 |
| `l1_fast.py` | 段特征（标题/进程/路径/剪贴板类型）→嵌入+规则→top-k 候选意图+置信度；Viterbi 平滑 | memory/hybrid 的 HashingEmbedder→bge-m3 升级位 | SWISH、TEXTOIR、TaskPredictor |
| `l2_slow.py` | 段摘要→LLM→intent+slots+evidence；三档复杂度路由 | execute/LlmGateway（多供应商 failover） | UItron、SummAct、Agent-S bBoN（模糊段多假设自评） |
| `reject_gate.py` | 双层置信度门：低于阈值→输出 irrelevant，零打扰 | proactive/InterruptionBudget 0.6 门升级 | xvfeng 拒识、车载 400+ 技能 |
| `intent_memory.py` | 意图→profile 五层+项目工作流记忆（抽象 workflow 可检索） | profile/ProfileModel（M5）、夜间整理 | SE-GA、AWM、MIRIX、graphiti |
| `flywheel.py` | 晨报确认/修正→(segment, gold_intent) 样本库→ICL 检索增强 | proactive/ConfirmCenter（M3）、skills/forge（M6） | OpenCUA、TaskPredictor2 在线学习 |
| 感知升级位 | OmniParser 式结构化解析挂 screen.py 视觉通道 | tiers 三档（M6.1） | OmniParser→UI-TARS→本地 OCR 兜底 |

验收金标准建议：借 MIntRec 标注规范+OSWorld 评估结构，建「意图版金标准集」：真实活动段→期望意图（含拒识样本），CI 跑分——延续本项目金标准问答集 20 条的惯例。

## 分组统计与结构洞察

| 类别 | 数量 | 代表 | 共性结论 |
|------|------|------|---------|
| perceptual-context | 12 | screenpipe 21576★、Windrecorder 3938★、MIRIX 3441★、银甲虫 3★ | 录制检索档最成熟（万星级）；**意图+记忆+接力全链路的实现全部小星星**——蓝海在"理解"，不在"录制"；中文/Windows 原生实现稀缺 |
| gui-grounding | 10 | UI-TARS 38979★、OmniParser 25389★ | 感知升级件供应链成熟，即插即用；纯视觉路线（免 UIA）已到生产可用 |
| cua-framework | 11 | browser-use 114628★、pi 105116★、UFO³ 9730★ | 意图已知世界的工程巅峰；对 PAI 是模板库（双 agent 解耦/bBoN/探索-部署两阶段）而非竞品 |
| intent-nlu | 11 | rasa 21324★、moonshine 11071★、TEXTOIR 254★ | 工业级=意图+槽位标注体系；学术前沿=**开放意图识别**（发现新意图）；中文小项目的方法论密度高（双层+拒识+槽位） |
| memory-selfevolve | 4 | mem0 65290★、graphiti 30872★ | 记忆基建万星级成熟，自建无必要；bi-temporal 时序图谱=意图上下文底座首选 |
| process-mining | 2 | pm4py 1027★ | 事件日志→流程模型的算法箱现成（注意 AGPL 隔离） |
| benchmark | 2 | OSWorld 3142★ | 真实环境评估范式可借 |
| awesome-index | 5 | acu 1758★ | 后续追踪哨点 |
| academic | 14 | TaskTracer→SummAct 20 年脉络 | 「特征分类+序列融合」经典内核未变，LLM 时代升维为「行为摘要+开放发现+拒识」 |

## 与九大难点/既有里程碑的衔接

- H1 语音感知（已过）→ 意图层是 H 系列的下一个纵深：感知的终点是理解，理解的单位是意图
- M3 打扰预算 0.6 置信度门 → 拒识门的前身，本卷将其升级为「双层意图+拒识」一等公民
- M5 profile 五层 ↔ MIRIX 六类：互为校对，补 resource（任务-资源关联，TaskTracer 假设）
- M6 skill forge ↔ AppAgentX/OpenCUA：意图确认记录即技能案例的上游
- FR16 成果反推 ↔ 飞轮：同一条"修正→样本→进化"数据线

## 方法论与局限

- stars/许可证/活跃：GitHub REST API 2026-09-15 两批实测（38+12 已知仓库核验 + 24 个检索查询）；2 个查询 403 限额损失（已知损失面：无）
- 5 个 404 仓库经 `in:name` 精查全部找回正确归属（SeeClick→njucckevin、UGround→OSU-NLP-Group、Aria-UI→AriaUI、AppAgent→TencentQQGYLab）；Magentic-One 确认原仓已删，仅存第三方 demo 仓，弃收
- metaso q2（学术综述问法）两次 [5000] 失败弃用；q1（GUI agent 综述）+ q3（桌面活动任务识别学术脉络）成功——后者挖出 TaskTracer→SummAct 20 年主线，是本卷最重要的学术增益
- silver-beetle/Screen-Mate 等低星项目收录以「技术路线价值」为纲（与第 10 路 stars 门槛不同），已在 lesson 字段说明理由
- 论文类条目 evidence 为 metaso 检索（二手转述），未逐篇核对原文 PDF；stars 为 null 不计入数值统计
