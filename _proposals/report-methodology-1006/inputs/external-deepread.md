# 输入件 5：外部 Top 项目深读汇编（14 项目）

> 来源：top-projects-deepread workflow wf_25eedeb2-787（15 agents / 1,428,395 tokens / 59 tool uses / 490s，2026-10-06）。
> 每项目一 agent 读 GitHub README（+1-2 架构文档），模式只写 README 真有的事实。

## 一、逐项目深读笔记

## bytedance/deer-flow

# bytedance/deer-flow 深读（README 两份）

**前提修正**：主仓库已是 DeerFlow 2.0——推倒重写的通用 "super agent harness"，与 v1 零代码共享；「planner/researcher/coder/reporter 报告管线」在维护分支 `main-1.x` 的 README。两份均读。

## 1) 架构与角色分工（1.x README「Architecture」，LangGraph 状态图）
- **Coordinator**：入口，管理流程生命周期，向 Planner 委派
- **Planner**：任务分解出结构化计划；判断上下文是否足够、决定继续调研还是出报告（调度大脑）
- **Research Team**：Researcher（web 搜索/爬虫/MCP 采集）+ Coder（Python REPL 现算数据）
- **Reporter**：末段聚合、结构化、成报告
规划=Planner，执行=Researcher/Coder；**无专职内容验收角色**，Reporter 只聚合。2.0 里验收由 lead agent 兼：子代理回传结构化结果，「lead agent verifies and synthesizes」（2.0「Sub-Agents」）。

## 2) 调研→写作→质检流程
- 规划前置人审：human-in-the-loop，计划先呈审，`[ACCEPTED]`/`[EDIT PLAN]` 反馈重生成，可 `auto_accepted_plan` 跳过（1.x「Human in the Loop」）
- 模糊题先多轮澄清再开工（「Intelligent Clarification」）
- 流程参数化：`--max_plan_iterations`（默认1）/`--max_step_num`（默认3）
- 报告后编辑：Notion 式块编辑（tiptap）+AI 润色/缩短/扩写（「Report Post-Editing」）
- 一次调研多形态：报告→podcast 音频、PPT（marp）（「Content Creation」）
- 断点续跑：LangGraph checkpoint 存 Postgres/Mongo+对话回放（「Checkpointing」）
- 质检：**无内容级门**，只有 LangGraph Studio 逐步 trace 调试

## 3) 值得抄的模式
1. **计划人审门**：计划先审后执行+结构化反馈标签（1.x HITL）——我们 RQS 门制的同构验证
2. **Coder 独立角色**：Python REPL 进调研管线，数据现算入报告而非只摘抄
3. **成品后编辑层**：块编辑+AI 局部改写，报告是可编辑活文档
4. **一研多态产出**：报告→播客→PPT 单管线复用
5. **验收判据机器化**（2.0）：`acceptance_criteria` 如 `file:xx non-empty`/`json-valid`，三态判定 holds/does not hold/UNVERIFIED，证据不足显式暴露
6. **子代理=优化非默认**（2.0）：只在并行延迟/专业能力/上下文隔离有净收益时委派，lead 验证综合；技能按需渐进加载保 context 瘦

## 4) 局限（不抄）
- 无内容级事实核查/红队角色——验收止步文件级与 JSON 语法级
- 默认深度浅：1 轮规划×3 步计划，离「顶级研报」差数量级
- 1.x 报告线已进维护分支，主线转向通用 harness，报告不再是核心产品
- 火山引擎生态绑定贯穿全文（Doubao/InfoQuest 推荐）
- 引用非硬门：1.x README 未展开引用机制；2.0 可点击引用仅限 RAG 私有知识
- 报告生成归入 16vCPU/32GB 重载档（2.0 Deployment Sizing）

出处：raw README@main 与 @main-1.x，段名均已标注。

---

## Alibaba-NLP/DeepResearch

## 1) 架构与角色分工
单agent「deep research assistant」+五类工具，**无独立规划/写作/验收角色**；质检内嵌系统提示词：多源交叉验证、剔除过时虚假信息、区分事实与推测（inference/prompt.py 原文）。Heavy 模式用 IterResearch 迭代增强（README「Two Inference Paradigms」）。

## 2) 调研→写作→质检流程
仓库止步「信息寻求+作答」，无长文成稿模块；报告结构化在同门 WebWeaver 论文：**动态大纲组织 web 级证据**（README「Agentic LLM family」节）。双车道：ReAct=诚实评测腿，Heavy=测试时扩展冲峰值（inference/ 下双实现）。

## 3) 值得抄的模式
1. **双车道分层**：同一 agent 分「评测诚实腿/重模式冲质量」两档（README）
2. **工具面五原语**：搜索(SERPER+学术)/读页(JINA)/摘要(另配廉价模型)/文件解析/Python沙箱（README「Tools」+prompt.py）
3. **全自动合成数据管线**贯穿预训练→SFT→RL（README「Key Features」）
4. **RL 细节**：严格 on-policy 定制 GRPO+token 级策略梯度+leave-one-out+负样本选择性过滤（README）
5. **动态大纲当报告脊柱**（WebWeaver，README 引用）
6. **生产实证**：高德行程+通义法睿可溯源司法结论（官方博客602550）

## 4) 局限（勿抄）
无独立验收角色，质检靠提示词自律；无写作/成稿模块，基准全 QA 型（BrowseComp/SimpleQA）；工具链绑外部付费 key（SERPER/JINA）；128K 上下文对长报告偏紧。

来源：[GitHub README](https://github.com/Alibaba-NLP/DeepResearch) · [官方博客](https://www.alibabacloud.com/blog/602550)

---

## langchain-ai/deepagents

## langchain-ai/deepagents 深读纪要（来源：仓库 README + README 链接的官方 overview 概念页，未再抓更多）

定位：**"The batteries-included agent harness"**，README 自认 "Inspired by Claude Code"。原则四条：Opinionated（默认面向 long-horizon 多步任务）/ Extensible（免 fork 替换任何件）/ Model-agnostic / Production-ready（底座 LangGraph，LangSmith 追踪评估）。

**1) 架构与角色分工**：三层。主 agent=规划+集成者（plan / 读写文件 / 自管上下文）；子 agent=临时执行者（fresh context 隔离、自主跑完、**single handoff 只回传一份最终报告**）；人=验收者（interrupt_on 在工具调用前暂停，可批准/加指导/改输入/拒绝）。无独立质检角色。

**2) 调研→写作→质检流程**：README **没有**报告专用管线——quickstart 仅单 agent 一句 "Research LangGraph and write a summary"。流程全靠 harness 原语组装：虚拟文件系统当共享工作区、工具输出卸载落盘、长线程自动摘要、子 agent 隔离重活。

**3) 值得抄（5+1 个，注明出处）**：
- **子 agent 隔离+单次交接**（overview/Subagents）：重活在独立上下文跑完、压缩成一份报告回传——正对我们的"每章独立调研腿/写作腿"，防上下文污染。
- **上下文卸载**（README "Context management: summarize long threads and offload tool outputs to disk"）：调研素材落盘不占主上下文。
- **文件权限 first-match-wins、子 agent 继承更窄权限**（overview/Permissions）：可做"采集腿只读弹药池、写作腿只写 draft 目录"的角色最小权限。
- **Skills 渐进披露**（overview/Skills）：启动只读 SKILL.md frontmatter，任务需要才载全文——研报方法论按需加载。
- **write_todos 状态机**（overview/Task planning）：pending/in_progress/completed 持久化在 agent state，进度可流式+断点接续。
- **interrupt_on 人审门**（overview/HITL）：昂贵/破坏性操作前暂停等人——发布/推送前硬门同构。

**4) 不抄的局限**：验收全靠人，**无自动质检 agent**（我们的 RQS 门体系它没有）；子 agent 无状态、不能多轮回话，不适合审稿往返；planning v0.7 起 opt-in 且只是 todo 清单，无依赖调度/DAG；安全模型是 "trust the LLM"（边界靠工具/沙箱而非模型自律，需自建闸）；整栈绑 LangGraph/LangSmith 生态，不必照搬。

---

## langchain-ai/open_deep_research

## langchain-ai/open_deep_research 深读（README + configuration.py）

**1) 架构与角色分工**：按职责设四个独立模型位（README「LLM」节）：Summarization（gpt-4.1-mini，摘搜索结果）/ Research（驱动搜索单元）/ Compression（压缩子代理发现）/ Final Report（写终报）。configuration.py 里有监督环：max_researcher_iterations（默认6）=「Research Supervisor 反思并追问」的次数；另有 allow_clarification（默认开）允许开跑前向用户追问。注意：题设的 supervisor+research-team 拓扑实为 README「Legacy」节的 legacy/multi_agent.py 旧实现，README 明言旧版 less performant；现行版是单研究员+反思环+可选并发子单元（默认5、上限20，注释警告并发易撞限流）。

**2) 调研→写作→质检流**：网页正文截 5 万字符（max_content_length）→摘要→压缩→终报模型成稿。**质检不在管线内**：靠外部 Deep Research Bench（100 道博士级任务、50 英+50 中、22 领域、RACE 分=Gemini 当判官对专家金标准报告评分）。旧版 workflow 曾有人工审批报告大纲+逐节带反思的顺序写作。

**3) 值得抄的模式**：① 按角色分模型并各配 max_tokens——成本分级（README LLM 节）；② 开跑前 clarification 追问（configuration.py）；③ 全链有界：反思 6 轮/单步工具 10 次（max_react_tool_calls）/并发 5——预算护栏；④ 压缩层垫在终稿前防上下文爆炸；⑤ 金标准+LLM 判官的外部基准，逐次记录成本/Token（Defaults：$45.98、5800 万 token、RACE 0.4309）；⑥ 保留 legacy 双实现当「思路博物馆」供对照。

**4) 不抄的局限**：无管线内质检门，成稿即出厂；单轮 $46-187 纯付费 API 重炮；单一搜索 API 而非多渠道语料；现行版为简洁主动放弃多代理分工——与我们全渠道+饱和门的重装备路线相反。

---

## AutoSurveys/AutoSurvey

# AutoSurvey 深读笔记（README + 其所引 NeurIPS 2024 论文摘要）

来源：github.com/AutoSurveys/AutoSurvey README（Usage/Evaluation/Installation 段）+ README 引用条目指向的 arXiv 2406.10252 摘要。

## 1) 架构与角色分工
README 正文极薄（架构在 figs/overview.png 图内不可读），分工写在它实现的论文摘要里：**规划**=检索+大纲生成步（outline generation）；**执行**="subsection drafting by specialized LLMs"，专职 LLM 并行起草各小节；**整合**=integration and refinement；**验收**="rigorous evaluation and iteration"，由独立脚本承担。

## 2) 调研→写作→质检管线（有报告产出，重点）
- **库先行**：build_database.ipynb 预建 530k arXiv 摘要嵌入库（nomic-embed-text-v1），生产时纯检索；
- **一条命令产报告**：main.py --topic 进 → --section_num 7 × --subsection_len 700 结构化拆解 → 产出落 ./output/；
- **两级参考预算**：大纲吃 --outline_reference_num 1500 篇粗参考，每小节精写只用 --rag_num 60 篇；
- **独立验收**：evaluation.py 对 output/ 成品单独打分，论文摘要称其闭环为"evaluation and iteration"。

## 3) 值得抄的模式（带出处）
1. **两级检索预算分离**（README Usage 参数）：大纲要广 1500、正文要精 60，粗筛与精写用不同弹药量；
2. **长度乘积式规划**（README 首段+参数）：8k-64k token 目标拆成 节数×小节长度，报告长度是显式参数不是玄学；
3. **生成/评估分家**（README Evaluation 段）：评估器独立成文件，可对存量产出单独复跑；
4. **嵌入库先于调研**（README Installation）：语料入库后再生产，检索不打活网；
5. **引用+内容双维质量分**（README 首段实验主张）；
6. **专职 LLM 分节起草**（论文摘要）：并行单元是小节而非整篇。

## 4) 明显局限（不抄）
- 语料封闭：仅预建 arXiv CS 单库，全文库须私下联系获取——无多渠道活网调研；
- 生成与评估同依赖 GPT-4o 类 API，自评偏差 README 未处理，无人工基准描述；
- 仓库 50 commits、无架构文档，README 复现细节不足。

---

## Narcooo/inkos

## InkOS（Narcooo/inkos，10.1k star，AGPL-3.0）

**先纠偏**：README 自述是"Story Creation AI Agent"（小说/剧本/翻译/互动影游），**不是研报系统**；但其「写作-审稿-修订+长期记忆」架构与研报线同构，模式可移植。

**1) 架构与分工**：pi-agent 统一 harness——模型只理解/提议/调用能力，宿主管确认、状态、原子落盘与产物真实性判定。8 角色：Radar（趋势，可插拔可跳过）、Planner（出本章意图 must-keep/must-avoid）、Composer（选上下文并记录保护层级/检索/压缩 trace）、Architect（建书设定）、Writer（写正文）、Settler（typed tool 交有证据 state delta，宿主校验应用）、审稿 Agent（定性 observation）、Reviser（显式修订）。

**2) 报告管线**：每章按"语义工作集→规划→写作→状态投影→observation→原子提交"；write next=plan→compose→write→review→commit 唯一链路。技术校验门控落盘，语义反馈不转为失败态；修订是独立显式动作，完成后留新 observation 与可追溯版本。

**3) 值得抄（带出处）**：
- **observation 不定罪**：审稿只记有证据观察，不阻塞不改完成态，修订另行发起（「定性审稿」「可靠性保障」节）；
- **权威/投影分离**：state/*.json（Zod 校验）=唯一权威，*.md=人读投影，memory.db（FTS5/BM25）=可重建检索投影非事实源（「长期记忆」节）；
- **三层控制面**：author_intent.md（长期）+current_focus.md（近 1-3 章）+每章 intent/context/trace.json 实录真实入模来源（「输入治理控制面」节）；
- **原子文件集+快照+文件锁/Action 队列**，杜绝"状态已推进、正文未落盘"（「可靠性保障」节）；
- **按 agent 粒度多模型路由**：写手贵模型/审计廉价模型，未配回退全局（「多模型路由」节）；
- **forecast 分支推演**：2-5 条隔离候选只存计划不动正史，正史变更后旧推演标过期（「剧情多线推演」节）。

**4) 不抄**：无信源/引用核验——审稿查角色记忆、伏笔、节奏而非事实核查；字数治理明言"不截断、不因偏差判失败"，与研报硬门冲突；无独立验收人，无自动闭环门。

---

## 666ghj/BettaFish

# BettaFish（微舆）深读笔记

纯Python零框架的中文多Agent舆情研报系统，产出交互式HTML/PDF/MD报告（README「项目概述」「系统架构」节）。

## 1) 架构与角色分工
- 三调研Agent并行：Query（网页搜索）/Media（多模态）/Insight（私有库挖掘），各带专属工具集与统一节点管线（nodes/：search→formatting→report_structure→summary）；Report Agent专职产出。
- 规划分散在各Agent内部决策模块（先概览搜索、再自定分块研究策略）；协调与"验收"交给ForumEngine的LLM主持人，无独立评审Agent。

## 2) 调研→写作→质检管线（README「一次完整分析流程」表）
用户提问→三Agent并行概览→自定分块策略→多轮循环{主持人引导专项搜索+反思机制→ForumEngine监控Agent发言并生成引导→各Agent经forum_reader工具读论坛调整方向}→Report Agent收全量结果+论坛记录→IR中间表示（动态选模板/样式、多轮生成元数据、装订成IR）→分块质量检测→渲染交互式HTML。

## 3) 值得抄的模式（带出处）
1. **论坛协作机制**：monitor.py监控Agent日志→llm_host.py生成主持人引导→utils/forum_reader.py回读，多轮辩论防单模型同质化（README优势4+ForumEngine目录）。
2. **报告五段流水线**：模板选择→布局→篇幅→章节→渲染，总调度在ReportEngine/agent.py（template_selection/document_layout/word_budget/chapter_generation四节点）。
3. **Document IR解耦**：章节级JSON+ir/schema.py与validator.py校验，内容与渲染分离；regenerate_latest_html/md/pdf.py可从最新章节JSON重装订换格式，重渲染零重写。
4. **篇幅预算前置**：word_budget_node先生成字数规划与章节指令，再写正文——先定预算后动笔。
5. **图表校验+修复闭环**：chart_validator.py+chart_repair_api.py，图表坏了有专门修复API。
6. **快速重试位**：report_engine_only.py跳过三调研腿、直读各引擎最新产物文件重出报告，专供"对结果不满意快速重试"。

## 4) 明显局限（不抄）
- GPL-2.0+免责声明严禁商用， license有传染性。
- 质检仅"分块质量检测"+图表/结构校验，README未见信源证据核验/引用审计层。
- 自建爬虫+情感模型（BERT/GPT-2/Qwen LoRA）重资产绑定舆情场景；"预测"层外挂在另一仓MiroFish，本仓不含。

---

## FinRobot (AI4Finance-Foundation)

# FinRobot 深读笔记（主 README + finrobot_desktop/README.md）

**1) 架构与角色分工**：V2 生产版 9 agent——Lead Agent 做编排路由（规划层），5 个角色化管线 agent（data/analysis/modeling/synthesis/report）顺序执行（执行层），bull/bear/judge 3 个辩论 agent 对抗后裁决；验收不靠人，靠 6 个审计算子 + artifact「输出契约门」把关。

**2) 调研→写作→质检（报告管线）**：7 条类型化管线（equity_research/DCF/comps/LBO/DDM/earnings/IC-memo）产出 13 章 artifact（投资论点、财务、估值、敏感性、催化剂…）；每步带 validator + 重试，拒绝开放式 agent 对话。质检双闸：数字层——32 个纯 Python 算子算 DCF/WACC/Monte Carlo，LLM 只叙述不产数；叙事层——narrative_divergence、narrative_numeric_grounding 等 6 个审计算子发货前核对叙事与数字，漂移即拦。

**3) 值得抄的模式**：
1. 「models reason, software computes, agents orchestrate, systems verify」——模型可替换，工具/工作流/验证基础设施才是可靠性来源（主 README 哲学段）。
2. 数字/叙事硬分离 + 全溯源：「The model never emits a figure that cannot be traced back to a call in compute/」（desktop README）。
3. 管线=类型化步骤 + 逐步校验重试，取代自由会话（desktop README "What makes it production" 列表）。
4. 多法三角验证诚实降级：DCF/forward-P/E/EV:EBITDA 分歧 2.6x 即扣发点位目标、只出区间并注明假设出处（desktop README football-field 图注）。
5. agent 指令即 markdown（agents/instructions/*.md），改行为不动 Python。
6. 7 数据源 failover + 健康态（cooling down 等）+ 入口校验拒脏载荷，坏数据进不了计算层。

**4) 不抄的局限**：输入仅一个 ticker，数据源全是行情/SEC/FMP 类结构化供给，没有开放 web 调研采集层（不如我们全渠道完备门打法）；审计只做数字接地，不核外部事实真假；单机单用户桌面产品形态，无量产调度线。

---

## TauricResearch/TradingAgents

## TauricResearch/TradingAgents — 对「研报生产线」的可抄设计（全部出自 README 实文）

### 1) 架构与角色分工
模拟真实交易公司（LangGraph 编排）。**分析师团队**：基本面/情绪/新闻/技术四分析师，各配专属工具；**研究团队**：多+空两研究员；**交易员**：综合各方报告定时机与仓位；**风控团队**：评估并调整策略、出评估报告；**组合经理**：终审批准/否决提案。规划/验收=两个 Manager（跑 deep 模型），执行=分析师/辩手/交易员（跑 quick 模型）。

### 2) 调研→写作→质检管线
四分析师**并行**各出报告 → "research debate starts once all of their reports are in"（汇齐才开辩的 join 门）→ 多空结构化辩论 N 轮 → 研究经理综合 → 交易员成稿 → 风控再辩一轮出评估 → 组合经理批。产出=报告树 + `complete_report.html` 单页（v0.6.0），且**本次运行的全部设置记录进每份报告**（v0.5.2）。

### 3) 值得抄的模式（附出处）
1. **多空辩论取代单点写作**：正反方强制对抗 + 风控二次评审，轮数可配 `max_debate_rounds`/`max_risk_rounds`（Researcher Team 节 + CLI 节）。
2. **双模型分层 + 分层分供应商**：quick 模型干分析师/辩手/交易员，deep 只给两个 manager，且各层可跑不同 provider（Python Usage 节，v0.6.0）。
3. **决策记忆闭环**：memory log 常开；后续运行分析期间**顺手结算**历史决策（真实收益+区域基准 alpha）生成一段反思，PM 读同标的近期决策+跨标的教训；结算失败不阻断、报告注明（Persistence and Recovery 节）。
4. **Point-in-time 完整性**：过去日期只读当日已披露数据（SEC EDGAR as filed），无法保证就明说 withheld，杜绝前视（Fundamentals as filed 节，v0.5.0）。
5. **数据接地防幻觉**：公司身份在任何 agent 运行前确定性解析；价格/指标声明锚定 verified snapshot，根治"搞错公司/编造价格"（Reproducibility 节）。
6. **崩溃可续**：逐节点 checkpoint，断点续跑，成功自动清理（Checkpoint resume 节）。

### 4) 局限（不抄的部分）
README 自认：LLM 非确定性、同输入两跑两样、推理模型无视 temperature；社交/新闻源对历史日期仍返回"现在"内容；自称 research scaffold 而非可复利策略；场景是单标的交易决策，没有长文研报的章节规划/引用溯源/多轮改稿层——这部分我们须自建。

---

## IAAR-Shanghai/SurveyX

# SurveyX 深读（出处：仓库 README + tasks/workflow/ 目录 + README 所引 arXiv:2502.14776）

**1) 架构与角色分工**：全自动 LLM 流水线，人只守两端——输入端给 title+key_words+参考文献(.md)，输出端人工验收（README 免责声明：生成内容仅供研究辅助，须用户核实）。规划=大纲层（先出 outlines.json 再写正文）；执行=编号脚本；验收=人 + 论文的系统评测框架。

**2) 调研→写作→质检**：调研腿在开源版离线化为「文献统一转 .md 入库」（全量版另有 paper 数据库+爬虫+关键词扩展+双层语义过滤，README Notice 明说）。管线=01_fetch_data→02_clean_data→03_gen_outlines→04_gen_content→05_post_refine→06_gen_latex 出 PDF（README Usage + 仓库目录实证）。

**3) 值得抄的模式**：
- ①两段式范式：Preparation（建领域知识库/AttributeTree 预处理）→Generation（arXiv 摘要），正合我们「先建库再写报」；
- ②大纲先行：03 生成 outlines.json 作为后续写作的契约文件；
- ③任务级输出目录：outputs/<时间戳_关键词>/ 唯一文件夹存 survey.pdf+outlines.json+latex/+tmp 中间件，全程留痕、可断点审计重跑（README Usage）；
- ④编号脚本+offline_run 一键全跑双模式：步进调试与全量生产兼得（README）；
- ⑤模型端点集中配置 src/configs/config.py（REMOTE_URL/TOKEN/embedding），换模不改码（README）；
- ⑥开源裁剪边界：重依赖功能留网站版，开源保最小可离线复现链（README Notice）。

**4) 不抄的局限**：开源版无实时在线检索与多模态解析（README 自认缺失），我们的研报线必须在线采集；质检仅「人工核实」免责声明，无自动评分门禁；引用质量增强属全量版，开源版无引用核验腿。

---

## RUC-NLPIR/WebThinker

# WebThinker→研报生产线可抄模式（仅 README 实录，NeurIPS 2025 / RUC-NLPIR）

**1) 架构与角色分工**：双模型——主推理模型(QwQ-32B)负责规划决策，搜索/浏览/起草全在思考流内完成，明确不走"RAG+预定义工作流"，单次生成端到端(Overview)；辅助模型(Qwen2.5-32B-Instruct)干执行层脏活：网页阅读、报告写作/编辑、评估(Quick Start·Model Serving)。验收交给外部裁判：解题用 Qwen2.5-72B 抽答案判分，报告用 DeepSeek-R1+GPT-4o 双裁判。

**2) 调研→写作→质检管线**：调研腿=Deep Web Explorer——搜索→点击链接/按钮导航页面→抽取→据初检结果发起 follow-up 搜索、遍历更深链接直到信息收齐。写作腿=Autonomous Think-Search-and-Draft 边查边写，三工具闭环：(1)按章起草 (2)检查当前报告(自我验证) (3)编辑报告，保证全面、连贯、适应新发现(Key Features)。

**3) 值得抄(6条带出处)**：①报告三工具「起草/查/改」——写作是思考中可调用动作而非末尾一步(Key Features)；②follow-up+深链直到收齐——可对齐我方弹药饱和门(Deep Web Explorer)；③双模型分层：贵模型只决策、便宜 instruct 模型执行散文——省成本(Quick Start)；④报告评估用 listwise 双裁判模型间对比而非单分(Evaluation)；⑤--max_search_limit=15 每会话搜索预算硬闸(Parameters Explanation)；⑥与 Grok3 DeeperSearch/Gemini2.0 Deep Research 对标的 30 篇报告全存 ./outputs/——金标准对照库做法(Report Comparison)。

**4) 不抄的局限**：单体思考流、无多 agent 并行，非工厂化；报告质检纯 LLM 主观排序，无字数/引用/渠道完备等客观门；搜索腿单一引擎(Bing/Serper 参数)无多渠道账本；online DPO(按推理准确性/工具使用/最终输出构造偏好对)属模型训练层，提示词工程管线拿不来。

---

## HKUDS/AI-Researcher

## HKUDS/AI-Researcher 深读（NeurIPS 2025 Spotlight；事实全部出自仓库 README，arXiv 2505.18705）

**1) 架构与角色分工**：三阶段流水线。阶段一「文献综述+选题」三角色：Resource Collector（arXiv/IEEE Xplore/ACM/GitHub/HuggingFace/数据集自动采集）→ Resource Filter（引用数、代码维护度、数据完整性+相关性筛高影响资源）→ Idea Generator（定研究方向）。阶段二 Design→Implementation→Validation→Refinement 迭代环，Research Agent 在 Docker 容器内跑实验。阶段三 Writer Agent 成稿。质检独立交给专门 Evaluator Agents，人只出题不介入。

**2) 报告管线**：两级输入协议——L1=用户给详细 idea；L2=只给参考文献、系统自产 idea 再实施。三阶段后 Writer Agent 用 hierarchical writing 整合选题动机/方法框架/实验结果生成全长论文；paper_agent/writing.py 与 research_agent（run_infer_level_1/2.sh）解耦，研究完成后写作腿可单独起跑。

**3) 值得抄的模式**：
- 双模型成本分层：COMPLETION_MODEL（贵）+CHEEP_MODEL（haiku 级）经 litellm 路由（.env.template）；
- 采集与过滤分设角色，过滤用可量化指标（引用/维护度/完整性）而非模型自评；
- 验收即基准：人类专家论文作 ground truth + 五维 Evaluator Agent（新颖性/实验全面性/理论根基/结果分析/写作质量），基准数据+构建管线全开源可定制；
- 写作腿独立可执行，与研究腿文件级解耦；
- 迭代精炼环配 MAX_ITER_TIMES 硬上限防失控；
- 一条产线兼容「详单」与「只有原料」两档输入。

**4) 不抄的部分**：域限定 ML 算法（vq/gnn/推荐/扩散等），须 Docker+GPU 真跑实验，重基建；宣称"removes the need for manual intervention"、无人工闸门（我们有硬门/waivers 更稳）；文档承诺"on its way"实际缺位；README 示例命令硬编码 OPENAI_API_KEY，属密钥泄漏反面教材。

---

## SkyworkAI/DeepResearchAgent

## SkyworkAI/DeepResearchAgent 深读（仅 README 实证）

先说关键：现 main 分支 README 已整体改写为「Autogenesis 自进化协议」（RSPL 资源层/SEPL 进化层）；层级多智能体内容存于改版前 README（末版 4acd4c7，2025-09）与仓库简介、论文 AgentOrchestra（arXiv 2506.12508）。以下按层级版提炼。

**1) 架构与分工**：两层。Top-Level Planning Agent 负责理解/分解/规划、派发子任务并动态协调；下层五种专职 agent——Deep Analyzer（深析输入、提关键点与隐含需求）、Deep Researcher（检索+综合，自动产出研究报告/知识摘要）、Browser Use（网页搜索/抽取/采集）、MCP Manager（工具动态发现/注册/执行，本地+远程）、General Tool Calling。子 agent 已封装为 function call 供规划器调度（Updates 2025.05.30）。

**2) 报告管线**：README 只到「Browser Use 取实时信息→Deep Researcher 检索综合并自动成报告」。无独立写作 agent、无质检/验收 agent（Novel Writing Agent 仍在 TODO）——报告环节是其最薄一环。

**3) 值得抄**（出处均为 README 各节）：
- 子代理即工具：函数调用式派发，规划/执行界面极简（Updates 2025.05.30）；
- 分析/调研/采集三角色分离，先提需求再调研（Architecture）；
- MCP Manager 动态挂本地/远程工具，渠道即插即用（Architecture）；
- Python 沙箱：import 控制/受限 builtins/资源限额（Features，docs/python_interpreter_sandbox.md）；
- MMEngine 配置组合装配 agent/工具/模型，因 TOML 不够灵活而换（Updates 2025.07.07）；
- GAIA 按难度分档验收（Experiments：Test 均 83.39，L1 93.55/L3 65.31）。

**4) 不抄**：无质检/反思角色、报告不分段管线；层级架构已被官方自己改掉，非终态；评测只有 GAIA 通用基准，无研报质量门；Imagen/Veo3 图视频生成与研报无关。另：新版 Autogenesis README 的 Act→Observe→Optimize→Remember 闭环与资源版本化（可溯源、可回滚）倒值得单独抄。

---

## Cinnamon/kotaemon

# Cinnamon/kotaemon 深读纪要（对「报告名→顶级研报生产线」的启示）

**项目定位**：开源 RAG 文档问答工具（GitHub 25.8k star）。README 明言双重身份：既是给终端用户的 RAG 问答 UI，也是给开发者自建 RAG 管线的框架（`pip install -e "libs/kotaemon[all]"` + `libs/ktem` 双库分层）。

## 1) 架构与角色分工

- **三层用户嵌套模型**（README 首屏 ASCII 图）：End users（用 app）⊃ Developers（`import kotaemon` 自建管线）⊃ Contributors（提 PR 改进）。对我们=「一份代码三层交付」：研报生产线既是内部工厂，也应是可复用的框架层+面向读者的产品层。
- **双库分工**：`kotaemon`=RAG 管线原语库；`ktem`=应用层（UI/设置/编排），reasoning 管线以类路径注册（如 `ktem.reasoning.simple.FullQAPipeline`）进 `KH_REASONINGS` 列表即上 UI。引擎与应用解耦、注册式插拔。
- **验收者=用户而非自动门**：无规划/执行/验收的多 agent 分工，质量靠 retrieval 相关度与 citation 透明度兜底。

## 2) 调研→写作→质检流程

它是问答工具，**无长文研报管线**。流程为：索引（多 loader：Azure DI/Adobe/Docling/PaddleOCR，全文+向量双库）→ 混合检索（hybrid full-text & vector + re-ranking）→ 推理生成（simple/分解/ReAct/ReWOO 四档 reasoning pipeline，UI 可切换）→ **引文回链验收**：答案默认带 detailed citations（含 relevant score），在浏览器内 PDF viewer 中高亮定位原文，检索低相关时显式警告。质检内嵌于「每句话可回溯到原文高亮」的呈现层。

## 3) 值得抄的模式（出处：README Key Features / flowsettings 段）

1. **引文=带分数+原文高亮跳转**（Advanced citations with document preview）：研报每条结论标注来源相关度分，点击跳到原文页高亮——可直接移植为研报引用验收 UI。
2. **低相关检索显式警告**（"Warning when retrieval pipeline return low relevant articles"）：把检索质量门做成用户可见信号，而非静默。
3. **推理分档可切换**（KH_REASONINGS 四管线）：simple→分解→agent 递进，对应研报「单源速答→多跳深查」分级调度。
4. **混合检索+re-ranking 为默认底线**（Hybrid RAG pipeline："sane default"）：全文+向量双腿+重排，防止纯向量漂移。
5. **多模态解析 loader 可插拔**（Settings→File loader 选 Azure/Adobe/Docling/PaddleOCR）：解析层接口化，图表/表格随问题进上下文。
6. **一切可配置进 UI**（Configurable settings UI，含 prompts）：连 prompt 都在界面上可调，便于非编程角色迭代质量。

## 4) 明显局限（不抄的部分）

- **无报告产出能力**：单轮/多跳 QA 而非长文档生成，缺写作、结构化成稿与成稿质检环节。
- **无多 agent 规划-执行-验收分工**：质量依赖单管线默认值，无自动化评审门。
- **交互式 Gradio 单机形态**：非流水线/批产架构，无任务编排与状态机。
- **README 自承文档未完成**（"more instruction WIP"），GraphRAG 依赖有版本冲突坑（需卸载重装 hnswlib）。

**一句话**：抄它的「引文即验收」呈现层范式（分数+高亮回跳+低相关警告）与注册式管线插拔，不抄它的单机问答定位。

## 二、合成器去重总表与最独特模式

# 《外部 Top 项目深读汇编》（14 项目 · 模式合并去重版）

> 日期：2026-10-06 · 用途：report-methodology-1006 方法论 v1 的外部模式总源，与《Manus 线重点借鉴报告》（输入件4，模式编号 M01-M62）、《Manus 复刻双 clone 融合方案》（输入件3，模式编号 = 其 §1.1/§1.2 表 #1-#63）三源合一，供合成器统一去重挂 S0-S6。
> 输入 14 项目：bytedance/deer-flow（1.x 报告线 + 2.0 harness 双读）、Alibaba-NLP/DeepResearch（下称 通义DR）、langchain-ai/deepagents、langchain-ai/open_deep_research（下称 ODR）、AutoSurveys/AutoSurvey、Narcooo/inkos、666ghj/BettaFish、AI4Finance-Foundation/FinRobot、TauricResearch/TradingAgents、IAAR-Shanghai/SurveyX、RUC-NLPIR/WebThinker、HKUDS/AI-Researcher、SkyworkAI/DeepResearchAgent（下称 SkyworkDRA）、Cinnamon/kotaemon。
> 口径：只收各笔记「值得抄」模式；各项目自认局限/不抄项不入表（一句带过：deer-flow 无内容级核查且默认深度浅、通义DR 无成稿模块、deepagents 验收全靠人、ODR 单轮 $46+ 无管线内质检、AutoSurvey 语料封闭单库、inkos 无信源核验、BettaFish GPL 传染严禁商用、FinRobot 无开放 web 采集层、TradingAgents 自认 scaffold 非复利策略、SurveyX 开源版无在线检索、WebThinker 单体无工厂化、AI-Researcher 域限 ML+无人工闸、SkyworkDRA 报告环节最薄且架构已被官方改掉、kotaemon 无报告产出能力）。
> 阶段定义：S0 意图解析 / S1 初步框架 / S2 定向调研 / S3 最终框架 / S4 边写边收集 / S5 质量门 / S6 交付复利 / 横切。

---

## 一、全部模式去重总表（65 条，按 S0-S6 + 横切挂点）

### S0 意图解析

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P01 | 开跑前澄清追问（模糊题多轮问清再开工，可配置开关） | deer-flow（Intelligent Clarification）、ODR（allow_clarification 默认开） | S0 |
| P02 | 两级输入协议（L1 用户给详单 / L2 只给原料系统自产 idea 再执行） | AI-Researcher、SurveyX（title+key_words+参考文献） | S0 |
| P03 | 深析前置角色（先拆输入提关键点与隐含需求，再进调研） | SkyworkDRA（Deep Analyzer） | S0 |

### S1 初步框架

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P04 | 计划人审门（计划先呈审，结构化反馈标签批/改，可跳过；工具调用前暂停等人） | deer-flow（ACCEPTED / EDIT PLAN / auto_accepted）、deepagents（interrupt_on） | S1（兼 S5 人审门） |
| P05 | 大纲先行·大纲即契约（结构化骨架文件先于正文，成为后续写作契约） | SurveyX（outlines.json）、AutoSurvey（outline generation）、通义DR（WebWeaver 动态大纲组织 web 级证据） | S1→S3 |
| P06 | 概览搜索先行再定策略（并行概览一轮，再自定分块研究策略） | BettaFish（三 Agent 并行概览） | S1 |
| P07 | forecast 分支推演（2-5 条隔离候选只存计划不动正史，正史变更后旧推演标过期） | inkos（剧情多线推演） | S1/S3 |
| P08 | todo 状态机（pending/in_progress/completed 持久化于 agent state，进度可流式+断点接续） | deepagents（write_todos） | S1/横切 |

### S2 定向调研

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P09 | 多腿角色化并行调研（各腿配专属工具面） | deer-flow（Researcher+Coder）、BettaFish（Query/Media/Insight）、TradingAgents（四分析师）、SkyworkDRA（五专职 agent） | S2 |
| P10 | follow-up+深链直到收齐（搜索→点链导航→抽取→据初检再搜更深链接） | WebThinker（Deep Web Explorer） | S2 |
| P11 | 反思/迭代调研环（supervisor 反思追问，有界轮数后收敛） | ODR（max_researcher_iterations=6）、通义DR（IterResearch Heavy）、AI-Researcher（Design→Validation 迭代环+MAX_ITER） | S2 |
| P12 | 采集与过滤分设角色+可量化过滤指标（引用数/代码维护度/数据完整性，非模型自评） | AI-Researcher（Resource Collector / Resource Filter） | S2 |
| P13 | 嵌入库先于调研（语料先入库建索引，生产期纯检索不打活网） | AutoSurvey（530k arXiv 嵌入库）、SurveyX（Preparation/AttributeTree） | S2 |
| P14 | 混合检索+re-ranking 默认底线（全文+向量双腿加重排，防纯向量漂移） | kotaemon | S2 |
| P15 | 数据源 failover+健康态+入口校验（多源降级、cooling down 状态、脏载荷拒进计算层） | FinRobot（7 源） | S2/横切 |
| P16 | Point-in-time 完整性（过去日期只读当日已披露数据，无法保证就明说 withheld，杜绝前视） | TradingAgents（SEC as filed） | S2/S5 |
| P17 | MCP 动态工具总线（本地+远程工具动态发现/注册/执行，渠道即插即用） | SkyworkDRA（MCP Manager） | S2/横切 |
| P18 | 多模态解析 loader 可插拔（Azure DI/Adobe/Docling/PaddleOCR 按需换） | kotaemon | S2 |
| P19 | Python 沙箱现算（数据在调研管线内现算入报告，而非只摘抄） | deer-flow（Coder REPL）、通义DR（沙箱工具）、SkyworkDRA（import 控制/受限 builtins/资源限额）、AI-Researcher（Docker 实验环） | S2 |
| P20 | 论坛协作互证（监控 Agent 日志→LLM 主持人生成引导→forum_reader 回读，多轮调整方向防单模型同质化） | BettaFish（ForumEngine） | S2/S5 |

### S3 最终框架

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P21 | 篇幅/长度显式乘积规划（总长=章数×节长，报告长度是显式参数；先定字数预算再动笔） | AutoSurvey（section_num×subsection_len）、BettaFish（word_budget_node 前置） | S3 |
| P22 | 两级检索预算分离（大纲吃 1500 篇粗参考，每小节精写只用 60 篇——粗筛与精写不同弹药量） | AutoSurvey（outline_reference_num / rag_num） | S1/S4 |
| P23 | 充足度判定门控成稿（判断上下文是否足够，够→出报告、不够→继续调研） | deer-flow（Planner 调度大脑） | S3/S2 |

### S4 边写边收集

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P24 | 起草/自查/编辑三工具闭环（按章起草、检查当前报告、编辑报告——写作是思考流中可调用动作而非末尾一步） | WebThinker（Autonomous Think-Search-and-Draft） | S4 |
| P25 | 小节级并行起草+层级写作（并行单元=小节而非整篇） | AutoSurvey（专职 LLM 分节起草）、BettaFish（chapter_generation 节点）、AI-Researcher（hierarchical writing） | S4 |

### S5 质量门

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P26 | 多空辩论+二次评审+终审（正反强制对抗 N 轮→综合→风控再评→经理批准；轮数可配） | TradingAgents（bull/bear+风控+组合经理）、FinRobot（bull/bear/judge）、BettaFish（论坛多轮辩论） | S5 |
| P27 | 验收判据机器化三态（acceptance_criteria 如 file:xx non-empty / json-valid，判定 holds / does not hold / UNVERIFIED，证据不足显式暴露） | deer-flow 2.0 | S5 |
| P28 | 数字/叙事硬分离+数字全溯源（models reason, software computes——模型永不产不可追溯到 compute 调用的数字；32 个纯 Python 算子算 DCF/WACC/MC） | FinRobot | S5/横切 |
| P29 | 多法三角验证诚实降级（DCF/forward-P/E/EV:EBITDA 分歧 2.6x 即扣发点位目标，只出区间并注明假设出处） | FinRobot（football-field） | S5 |
| P30 | 类型化 artifact 契约门（13 章 artifact 逐步 validator+重试；章节级 JSON+schema/validator 校验；Zod 校验+技术门控落盘，语义反馈不转失败态） | FinRobot、BettaFish（IR schema+分块质量检测）、inkos | S5 |
| P31 | 生成/评估分家（评估器独立成文件，可对存量产出单独复跑打分） | AutoSurvey（evaluation.py）、AI-Researcher（Evaluator Agents）、WebThinker（外部裁判）、ODR（Deep Research Bench） | S5 |
| P32 | 金标准+LLM 判官基准（专家报告作 ground truth，判官打分，逐次记录成本/Token） | ODR（RACE=Gemini 判官，100 博士级任务）、WebThinker（30 篇报告对照库+DeepSeek-R1+GPT-4o listwise 双裁判）、AI-Researcher（五维评估+人类论文） | S5 |
| P33 | 图表校验+修复闭环（chart_validator+专门修复 API，图表坏了有修复腿） | BettaFish | S5 |
| P34 | observation 不定罪+修订独立显式（审稿只记有证据观察，不阻塞不改完成态；修订是独立动作，完成后留新 observation 与可追溯版本） | inkos（定性审稿/可靠性保障） | S5 |
| P35 | 数据接地防幻觉（公司身份在任何 agent 运行前确定性解析；价格/指标声明锚定 verified snapshot） | TradingAgents（Reproducibility） | S5/横切 |
| P36 | 引文即验收呈现层（引用带 relevant score+浏览器内 PDF 原文高亮跳转；检索低相关显式警告而非静默） | kotaemon、AutoSurvey（引用+内容双维质量分） | S5/S6 |
| P37 | 质检纪律内嵌系统提示词（多源交叉验证、剔除过时虚假、区分事实与推测） | 通义DR（inference/prompt.py） | S5 |
| P38 | GAIA 按难度分档验收（L1/L3 分档报分，暴露难度衰减） | SkyworkDRA（Test 83.39，L1 93.55 / L3 65.31） | S5 |

### S6 交付复利

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P39 | 一研多态产出（一次调研→报告/播客音频/PPT 多形态复用同管线） | deer-flow（marp 播客/PPT）、BettaFish（HTML/PDF/MD） | S6 |
| P40 | Document IR 解耦（章节级 JSON 中间表示+schema 校验，内容与渲染分离；regenerate_* 从最新章节 JSON 重装订换格式，重渲染零重写） | BettaFish（ir/schema.py+validator.py） | S6 |
| P41 | 快速重试位（跳过三调研腿、直读各引擎最新产物文件重出报告，专供对结果不满意快速重试） | BettaFish（report_engine_only.py） | S6 |
| P42 | 决策记忆闭环（memory log 常开；后续运行分析期间顺手结算历史决策真实收益+区域基准 alpha 生成反思，PM 读同标的近期决策+跨标的教训；结算失败不阻断只注明） | TradingAgents | S6 |
| P43 | 资源版本化自进化闭环（Act→Observe→Optimize→Remember，资源可溯源可回滚） | SkyworkDRA（Autogenesis/RSPL+SEPL） | S6 |
| P44 | 运行设置随报告留痕（本次运行全部参数记录进每份报告） | TradingAgents（v0.5.2） | S6 |
| P45 | 写作腿文件级解耦（研究完成后写作腿可单独起跑） | AI-Researcher（paper_agent/writing.py 与 research_agent 解耦） | S6/横切 |
| P46 | 成品后编辑层（Notion 式块编辑+AI 润色/缩短/扩写——报告是可编辑活文档） | deer-flow（tiptap） | S6 |
| P47 | legacy 双实现思路博物馆（旧架构仓库保留供对照学习） | ODR（legacy/multi_agent.py） | S6 |
| P48 | 一码三层交付（终端用户产品/开发者框架/贡献者三层同仓共存） | kotaemon（End users⊃Developers⊃Contributors） | S6 |

### 横切层

| # | 模式 | 项目 | 挂阶段 |
|---|---|---|---|
| P49 | 子代理隔离+单次交接（fresh context 跑完重活压缩成一份报告回传；子代理=优化非默认，只在并行延迟/专业能力/上下文隔离有净收益时委派，lead 验证综合；子代理封装为 function call 供规划器调度） | deepagents、deer-flow 2.0、SkyworkDRA、ODR（并发子单元默认 5 上限 20） | 横切 |
| P50 | 上下文卸载+压缩层（工具输出卸载落盘+长线程自动摘要；正文截断 5 万字符→摘要→压缩子代理垫在终稿前防上下文爆炸） | deepagents、ODR（Compression 模型位） | 横切 |
| P51 | 多模型成本分层路由（按角色配模型+各自 max_tokens；quick/deep 分层且各层可跨供应商；per-agent 粒度路由+未配回退全局；litellm 双档 COMPLETION/CHEEP；贵模型只决策便宜模型执行散文；摘要另配廉价模型） | ODR（四模型位）、TradingAgents、WebThinker、inkos、AI-Researcher、通义DR | 横切 |
| P52 | 全链有界预算护栏（反思 6 轮/单步工具 10 次/并发 5；每会话搜索上限 15；规划迭代与步数参数化；迭代精炼硬上限 MAX_ITER_TIMES） | ODR、WebThinker（--max_search_limit）、deer-flow（--max_plan_iterations/--max_step_num）、AI-Researcher | 横切 |
| P53 | 文件权限最小化（first-match-wins，子代理继承更窄权限→可做采集腿只读弹药池/写作腿只写 draft 的角色分区） | deepagents（Permissions） | 横切 |
| P54 | 指令/Skill 即文件+渐进披露（启动只读 SKILL.md frontmatter，任务需要才载全文；agent 行为=markdown，改指令不动 Python） | deepagents（Skills）、FinRobot（agents/instructions/*.md） | 横切 |
| P55 | 权威/投影分离（state/*.json 唯一权威、*.md 人读投影、memory.db FTS5/BM25=可重建检索投影非事实源） | inkos（长期记忆） | 横切 |
| P56 | 原子落盘（原子文件集+快照+文件锁/Action 队列，杜绝「状态已推进、正文未落盘」） | inkos（可靠性保障） | 横切 |
| P57 | 配置集中+注册式插拔（模型端点集中 config；MMEngine 配置组合装配 agent/工具/模型；类路径注册进列表即上 UI） | SurveyX（src/configs/config.py）、SkyworkDRA、kotaemon（KH_REASONINGS） | 横切 |
| P58 | 步进/全量双模式（编号脚本步进调试+offline_run 一键全跑） | SurveyX（01_fetch→06_gen_latex） | 横切 |
| P59 | 任务级输出目录全程留痕（outputs/<时间戳_关键词>/ 存成品+大纲+latex+tmp 中间件，可断点审计重跑） | SurveyX | 横切/S6 |
| P60 | 推理分档可切换（simple→分解→ReAct/ReWOO 四档 reasoning pipeline，UI 切换=单源速答→多跳深查分级调度） | kotaemon | 横切 |
| P61 | 双车道（ReAct=诚实评测腿 / Heavy=测试时扩展冲峰值，同 agent 两档） | 通义DR（Two Inference Paradigms） | 横切/S5 |
| P62 | 全自动合成数据+RL 训练管线（预训练→SFT→RL 贯穿；严格 on-policy GRPO+token 级策略梯度+leave-one-out+负样本选择性过滤） | 通义DR | 横切（训练层） |
| P63 | join 门（全部分析师报告汇齐才开辩——「research debate starts once all of their reports are in」） | TradingAgents | 横切/S2 |
| P64 | 断点续跑 checkpoint（LangGraph checkpoint 落 Postgres/Mongo+对话回放；逐节点 checkpoint，成功自动清理） | deer-flow（Checkpointing）、TradingAgents（Checkpoint resume） | 横切/S6 |
| P65 | 工具面最小五原语（搜索 SERPER+学术 / 读页 JINA / 摘要另配廉价模型 / 文件解析 / Python 沙箱） | 通义DR（Tools+prompt.py） | 横切 |

**去重说明**：人审门两源（deer-flow 计划呈审 / deepagents interrupt_on）合并为 P04；多模型分层六项目互证合并为 P51（最强共识模式）；辩论三源（TradingAgents/FinRobot/BettaFish 论坛）合并为 P26 与 P20 两条（对抗结构 vs 主持人协作机制不同）；「沙箱」四源合并为 P19（现算用途）并与 M50（生命周期）分立；评估相关拆三条（P31 分家/P32 基准/P38 分档，机制不同）；大纲相关并 P05（骨架契约）；「先概览再定策略」并 P06。

---

## 二、与《Manus 双 clone 融合方案 49 模式》《Manus 线 45 模式》可能重复的模式点名（提示合成器去重）

> 判定依据：融合方案=输入件3 §1.1/§1.2 表编号 #1-#63；Manus 线=输入件4 M01-M62。重复度分高（同机制，必须合并）/中（同族不同变体，合并时保增量）/低（概念近机制异，防误合并）。

| 本表# | 本表模式 | Manus 线对应 | 双clone融合对应 | 判定与合并提示 |
|---|---|---|---|---|
| P04 | 计划人审门 | M01 Plan Mode 计划审批门 | — | 高。合并取并集：Manus 版多「计划=唯一事实源，确认前不动工」；deepagents 版多「工具调用前暂停+批准/指导/改输入/拒绝」四动作 |
| P08 | todo 状态机 | M06 todo.md+尾部复诵 | #15 计划状态机（4 态独立于执行者） | 高。Manus 版多「尾部复诵防 lost-in-the-middle」增量，合并勿丢 |
| P05 | 大纲先行·大纲即契约 | M08 立骨架先行 | #6 计划 JSON 契约（Step 四字段） | 高（家族同构）。融合版是 JSON 契约化加强，SurveyX outlines.json 是文件级实例 |
| P49 | 子代理隔离+单次交接 | M11 星型并行+第 9 项编造阈值 | #18 RESPONSE_FORMAT 信封 / #19 共享黑板 | 高。M11 的「每子任务全新上下文+子代理互不通信+第 9 项起编造阈值」是本表没有的增量，须随合并带入 |
| P50 | 上下文卸载+压缩层 | M21 文件系统即终极上下文 + M25 Condenser 可插拔压缩 | #51 记忆滑窗 100 条 | 高 |
| P51 | 多模型成本分层路由 | M52 三层 LLM 分流（reasoning/basic/VL 分 key） | #53 角色→LLM 档位一张表+实例缓存 | 高。本表 6 项目互证=最强共识模式，合成器按「共识确认」处理而非新模式 |
| P52 | 全链有界预算护栏 | — | #50 token 预算计入工具描述 + #60 差异化步数预算 + #61 全局超时闸 | 高 |
| P19 | Python 沙箱现算 | M50 沙箱零信任+生命周期 | （融合 N4 为反面不抄项） | 中。沙箱现算（用途层）与沙箱生命周期（隔离层）是两层，建议分立两条 |
| P17 | MCP 动态工具总线 | M53 MCP 工具总线 | #55 MCP 归一化清洗 + #56 服务器说明书注入 | 高 |
| P54 | 指令/Skill 即文件+渐进披露 | M40 Skill 三级渐进披露（L1/L2/L3 token 预算） | — | 高（同源 Agent Skills 规范）。Manus 版多 L1~100token/L2<5k/L3 按需的量化分级 |
| P64 | 断点续跑 checkpoint | M44 contextTransfer + M58 确定性重放崩溃恢复 | （融合 N2 反面：两 clone 无持久化） | 中高 |
| P39 | 一研多态产出 | M45 多形态交付套件（文档/PPT/表格/网页/播客） | — | 高 |
| P36 | 引文即验收呈现层 | M28 证据链全程溯源 + M62 反编造令（≥1 URL/2000 字） | — | 中。呈现层验收 vs 过程链溯源是两门，建议分立但合并统计口径（Manus 线 4.2 已有同类合并先例） |
| P31/P32 | 生成/评估分家+金标准判官 | M59 GAIA 跑分+速度叙事 | — | 中。P38（SkyworkDRA GAIA 分档）与 M59 直接同源，必并 |
| P65 | 工具面最小五原语 | M15 工具五件套（browser+shell+编辑器+搜索+沙箱） | — | 高（命名即撞，内容微差：JINA 读页 vs browser） |
| P20/P26 | 论坛互证 / 多空辩论 | M14 多专家并行探索+交叉验证（3 专家+1 统筹） | — | 高。合并时保本表增量：辩论有裁决角色与轮数参数，论坛有主持人引导+回读闭环 |
| P37 | 质检纪律内嵌提示词 | — | #36 反幻觉写作纪律（Data Integrity 整节五条） | 高 |
| P27+P23 | 三态判定 + 充足度门控成稿 | M17 完成判定门控终稿合成（账本判定完成才准合成 final answer） | — | 中。门控位置同构、判据机制不同（账本事实 vs 机器可查 acceptance_criteria 三态）——可并为「完成判定门」族下两变体 |
| P42 | 决策记忆闭环 | M38 Project 自学习闭环（用户批准才生效） | — | 中。家族相似（战后复盘沉淀）；本表增量=用真实收益结算当 ground truth，非 LLM 自评 |
| P07 | forecast 分支推演 | M41 Branch 上下文分叉 | — | 低-中。概念近（分叉/隔离）、机制异（叙事候选推演过期制 vs 上下文继承分叉），合成器勿误合并 |
| P15 | 数据源 failover+健康态 | — | #21 多引擎梯次降级（注册表+fallback 链+全败睡 60s 重试≤3） | 高。FinRobot 版多「入口校验拒脏载荷+cooling down 健康态」 |
| P06 | 概览搜索先行 | — | #4 规划前先搜（search_before_planning 注入规划 prompt） | 高 |
| P11 | 反思/迭代调研环 | M31 Progress Ledger 每步自省 + M30 停滞计数器→动态重规划 | — | 中 |
| P21 | 篇幅乘积规划 | M04 质量硬条款内化（字数/章节数硬条款进计划逐步验收） | — | 中 |
| P25 | 小节级并行起草 | M19 多文件工作区（章分存后合并，中位 22 文件） | — | 中 |
| P24 | 起草/查/改三工具闭环 | M18 77% 写增量生长（搜×5→写×1 节奏） | — | 中高（边写边收集同族） |
| P60 | 推理分档可切换 | — | #5 深思考开关（deep_thinking_mode 一行 if 切 basic↔reasoning） | 中 |
| P13 | 嵌入库先于调研 | M05 首步盘家底 | — | 低（家族相似：先吃存量，机制不同） |

**点名结论**：上表 28 行即三源合一时的主要撞车区。其中 P51（多模型分层）、P49（子代理隔离）、P05（大纲先行）、P04（人审门）为三源全撞的四大共识模式——合成器应作「业界收敛证据」收录一份，把各家增量（编造阈值/尾部复诵/JSON 契约/唯一事实源语义）并入对应条目而非另立新行。

---

## 三、最独特的 5 个模式（14 项目中仅此一家，且两份 Manus 清单均无对应物）

1. **P34 observation 不定罪+修订独立显式（inkos）**——审稿 Agent 只记录有证据的定性观察，不阻塞流程、不改完成态；修订是独立显式动作，完成后留新 observation 与可追溯版本。独有性：其余 13 家的质检全是「门/分/辩论」式阻断或放行，无人把「审稿意见」与「修订执行」解耦成两条异步链；Manus 两清单亦无（M32 keep-wrong-stuff-in 是留失败痕迹，非审稿解耦）。对 S5 的启示：审稿结论可以只入账不拦路，由独立修订腿消费——与 waivers 留痕机制天然互补。
2. **P29 多法三角验证诚实降级（FinRobot）**——同一标的用 DCF/forward-P/E/EV:EBITDA 三法交叉，分歧超 2.6x 即扣发点位目标、只出区间并注明假设出处。独有性：其余项目的对抗（辩论/论坛/多专家）产的是「谁对」，无人做「多法数值发散→诚实降级输出形态」；Manus 无对应。对 S5 的启示：own_calculations 可升一级——不止算得对，还要多法互证，发散即降级为区间结论。
3. **P16 Point-in-time 完整性（TradingAgents）**——历史日期只读当日已披露数据（SEC as filed），无法保证就明说 withheld，杜绝前视偏差。独有性：13 家中唯一做时点完整性约束的（其余最多做时效性过滤）；Manus 无对应。对 S2/S5 的启示：行业研报引用历史数据（历史市占率/旧政策/旧产能）时应挂「时点锁」——只准用当期已披露口径。
4. **P22 两级检索预算分离（AutoSurvey）**——大纲阶段吃 1500 篇粗参考、每小节精写只用 60 篇，粗筛与精写用不同弹药量。独有性：其余项目的检索预算是单一上限（如 WebThinker 每会话 15 次），无人按「框架阶段 vs 精写阶段」分档配弹；Manus 无对应。对 S1/S4 的启示：与弹药门 v3 的分层预算（T1/T1+T2/封顶）同构，可直接把「框架腿宽带/章节腿窄带」写进 tier_router 派单。
5. **P36 引文即验收呈现层（kotaemon）**——每条引用带 relevant score、点击跳 PDF 原文页高亮定位，检索低相关时显式警告而非静默。独有性：13 家中唯一把质检做进「呈现层」（每句话可回溯到原文高亮）的；Manus M28 是过程链溯源，不是成品内的可视化回链。对 S5/S6 的启示：研报成品的引用位可带来源相关度分与原文锚点跳转，把 RQS 引用门的结果直接交给读者可验。

**落选遗珠（一行备查）**：P55 权威/投影分离（inkos，工程独有但属存储设计）；P42 真实收益结算闭环（TradingAgents，与 M38 家族近似故让位）；P27 三态判定（deer-flow，与 M17 门控同位故让位）；P33 图表修复闭环（BettaFish，价值高但机制窄）。

---

## 收口

三源合并后的格局：**Manus 双 clone 给 agent 标准件、Manus 线给上下文工程与复利件、本汇编 14 项目给「研报域专用件」**——其中 S5 质量门侧的增量最厚（P26-P38 共 13 条，Manus 两清单在此层最薄），S6 交付复利侧与 Manus 线撞车最多（合并时以本表第二节点名为准）。65 条去重总表中，六项目互证的 P51 与多源互证的 P04/P05/P49/P50 可视为业界收敛共识；本表第三节 5 条独有模式是外部扫荡相对两份 Manus 报告的净新增量，建议合成器在 v1 方法论中逐条挂门验证。

### 最独特 5 模式（合成器判）
1. P34 observation 不定罪+修订独立显式（inkos）：审稿只记有证据观察不阻塞不改完成态，修订是独立显式动作并留可追溯版本——14 家中唯一把审稿与修订解耦成两条异步链，Manus 两清单亦无
2. P29 多法三角验证诚实降级（FinRobot）：DCF/forward-P/E/EV:EBITDA 三法分歧超 2.6x 即扣发点位目标、只出区间并注明假设出处——唯一做「多法数值发散→诚实降级输出形态」的项目
3. P16 Point-in-time 完整性（TradingAgents）：历史日期只读当日已披露数据（SEC as filed），无法保证就明说 withheld 杜绝前视——13 家中唯一做时点完整性约束
4. P22 两级检索预算分离（AutoSurvey）：大纲吃 1500 篇粗参考、每小节精写只用 60 篇——唯一按「框架阶段 vs 精写阶段」分档配弹的检索预算设计
5. P36 引文即验收呈现层（kotaemon）：引用带 relevant score+PDF 原文页高亮跳转+低相关显式警告——唯一把质检做进成品呈现层（每句话可回溯原文高亮）的项目
