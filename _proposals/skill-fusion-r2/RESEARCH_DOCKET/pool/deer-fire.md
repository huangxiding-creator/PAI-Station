# 技能深读提取报告：deer-flow(6) + firecrawl-workflows(4) + wshobson-agents(5)

提取员：t1/deer-fire 组 ｜ 日期：2026-09-26 ｜ 目的：技能融合提案原料
基线：EPC100 工程研报工厂 + 调研方法论栈（conductor/弹药池+饱和引擎/Manus军团+Jev判断层/七步方法论/后置链）；空白 W1-W9；红线：免费优先/密钥不入库/黑名单/只增不删。

---

## A. deer-flow 组（字节跳动 DeerFlow 2.0 技能层）

仓背景：DeerFlow 2.0 = 开源 super agent harness（LangGraph 后端，编排子代理/记忆/沙箱），`skills/public/` 下 20+ 技能，有 **skill-review CI**（.github/workflows/skill-review-ci.yml 对 skills/public/** 变更触发评审+豁免清单）——技能本身进 CI 门，工程成熟度高。

### A1. consulting-analysis（t1 得分 25，本组最高）
- **一句话定位**：两阶段咨询级研报技能——Phase1 只产分析框架（骨架+数据需求清单），Phase2 只产终稿，中间数据采集明确交给别的技能。
- **核心机制**：Phase1 六步（1.1 识别核心实体/领域 → 1.2 从 7 大类 30+ 框架库选 2-4 个互补框架[SWOT/PESTEL/Porter/VRIO/STP/BCG/TAM-SAM-SOM/AARRR/RFM/JTBD/DuPont/DCF/蓝海/价值链/Gartner hype/GE-McKinsey 等] → 1.3 章节骨架[每章 Analysis Objective/Analysis Logic/Core Hypothesis] → 1.4 每章数据需求表 → 1.5 每章可视化与论证结构计划 → 1.6 汇总输出）；Phase2 五步（验输入 → 映射结构 → **先全部出图再写文**[Step 2.3] → 按图锚→数据对照→综合分析写每节 → 结构自检门）。硬门：ZERO HALLUCINATION（缺数据就写"数据不可得"，图必须反映缺失现实如断线）；P0 缺失必须在报告里 flag；每子节 ≥200 字分析段；末尾 References 按 GB/T 7714-2015。
- **数据契约**（本组最值钱）：① 数据需求表字段：`# | Data Metric | Data Type(Quantitative/Qualitative/Mixed) | Suggested Sources | Search Keywords | Priority(P0/P1/P2) | Time Range`；② 每章可视化计划：Chart Type/Title/X-Y Data Mapping（映射回数据需求编号）+ 对比表列设计 + What→Why→So What 论证骨架；③ 交接包（Data Package）= Data Summary + Chart Files + External Search Findings(URLs)；④ 图文件约定 `charts/chapter_{N}_{chart_index}.png`；⑤ Core Hypothesis 每章显式预注册。另有文风契约：output_locale=zh_CN、麦肯锡/BCG 语气、标题禁词表（"解密/DNA/图景/解锁"禁用）、禁水平线、千分位英文逗号、结论段禁止 bullet。
- **可移植**：≥3 条。① **W8 选题简报 schema 的现成答案**——把 Phase1 输出的"数据需求表+Data Collection Task List"直接定为 EPC100 S1 立题拆解的机读产物，Search Keywords 列直接喂 conductor 出队（这是七步方法论 S1→渠道调度器之间缺失的那根线）；② **W3 出版级图表的流程面**——"图表先于叙事全部生成"[Step 2.3] 与"缺数据图表必须断线"接到 EPC100 后置链排版腿（与 md-to-typeset-docx 配合），chart data mapping 回指数据需求编号=图的溯源键；③ 每章 Core Hypothesis 预注册接到饱和引擎 ACH 假设对抗的假设登记位；④ P0/P1/P2 优先级枚举可直接并入完备门过账字段。
- **质量评价**：真好——证据：框架选择五原则（含 Data-Feasible 降级原则：数据拿不到的框架要换）、正反例（Bad/Good insight 链）、双 checklist、示例全流程。缺陷：无 scripts/references/evals，纯 prompt 技能；两阶段交接假设宿主 harness 会搬运 Data Package（在我们的栈里要自己接线）。

### A2. systematic-literature-review（得分 25）
- **一句话定位**：五阶段系统性文献综述：arXiv 检索 → **子代理并行抽取** → 主题综合成稿，附带完整触发评测集。
- **核心机制**：Phase1 计划（一次只问一个合并澄清问题；50 篇硬上限）→ Phase2 检索（**只准跑一次**、禁止改词重试、2-3 核心关键词+用 `--category`/`--start-date` 收窄而非堆词、永远 relevance 排序[submittedDate 是陷阱，文档明说]）→ Phase3 并行抽取（**强制 task 子代理，禁止主上下文内联抽取、禁止 python -c**）→ Phase4 综合（必须产出 Themes[3-6]/Convergences/Disagreements/Gaps，"只列论文不综合=失败模式"）→ Phase5 存档 `slr-<topic-slug>-<YYYYMMDD>.md`+present。
- **数据契约**：① 检索脚本 JSON 字段：`id/title/authors/abstract/published/updated/categories/pdf_url/abs_url`（id 规范化为裸 arXiv id）；② 子代理抽取 schema：`arxiv_id/title/authors/published_date/research_question/methodology/key_findings(3-5条)/limitations`；③ **并发决策表**：MAX_CONCURRENT_SUBAGENTS=3、每批 ~5 篇、1-50 篇逐档给出轮次布局（如 20 篇=2 轮 3+1），并警告运行时会**静默丢弃**超额派发（LLM 不会被告知）；④ 子代理回包前缀协议（`Task Succeeded. Result: ` 需剥离）；⑤ 与兄弟技能的路由契约：单篇论文 → academic-paper-review。
- **可移植**：① **W5 多 worker 调研编排契约的直接蓝本**——"任务量→批次→轮次"决策表+静默丢弃警告，正是 Manus 军团 150 账号分批派发要的形状（我们现有 conductor 只有资源互斥，没有量-批-轮查表契约）；② **W7 学术检索聚合**：arxiv_search.py 免费无 key 可直装为 conductor 新渠道（补 cnki 单点之外的英文腿）；抽取 schema 直接给 Jev/LayaForge 判断层做文献腿的输入 types；③ evals.json 含**负触发评测**（eval#4：给单篇 URL 应不触发本技能而路由到兄弟）——负触发模式可给 conductor 渠道路由做回归集；④ Themes/Convergences/Disagreements/Gaps 四段综合结构可做饱和引擎"饱和判据"的产出 schema。
- **质量评价**：真好，本组工程冠军——证据：arxiv_search.py 头部 23 行设计注记（requests/urllib 双跑、NS_MAP 防解析坑、id 规范化、50 篇钳制全部写明）、5 个 eval 含 2 个负触发、模板三分支（apa/ieee/bibtex，arXiv 必须 @misc 的坑写明）。无脚本文档脱节。保留：绑定 DeerFlow 运行时的 `/mnt/skills/` 路径与 `task` 工具名，移植要改路径与派发原语。

### A3. academic-paper-review（得分 21）
- **一句话定位**：单篇学术论文的顶会级同行评审生成器（NeurIPS/ICML/Nature 模板）。
- **核心机制**：Phase1 理解（元数据表→六段深读顺序[摘要引言→相关工作→方法→实验→讨论局限→结论]→**逐条 Claims 抽取**：每条 Claim+Evidence+Strength[Strong/Moderate/Weak]）→ Phase2 批判（文献定位检索式×5；方法学六维 1-5 打分表：Soundness/Novelty/Reproducibility/Experimental Design/Statistical Rigor/Scalability；贡献五级枚举 Landmark/Significant/Moderate/Marginal/Below threshold）→ Phase3 综合模板（S1-S3/W1-W3、Questions for Authors、Minor Issues、总评 Accept/Weak Accept/Borderline/Weak Reject/Reject + Confidence High/Medium/Low）。附论文类型适配表（Empirical/Theoretical/Survey/Systems/Position 各自侧重）与六条评审陷阱（"评你希望作者写的那篇而不是交来的这篇"等）。
- **数据契约**：Claims 表（Claim/Evidence/Strength）；六维打分表；判定枚举两套（Accept 五档 + Confidence 三档 + Contribution 五档）；评审模板字段全固定。
- **可移植**：① 六维方法学 rubric + Claims/Evidence/Strength 抽取表可直接做 Jev 判断层的评审腿 prompt 契约（现在 Jev 判断层缺结构化打分 rubric）；② Accept×Confidence 双轴判定枚举可做 EPC100 红队腿（S3）与自复盘的 verdict schema；③ 对 EPC100 场景：工程行业研报引用的第三方研究/白皮书可用此模板做"引用源可信度评审"接到 GRADE 分级辅助。
- **质量评价**：真好（rubric 具体、反例具体、模板完整）；缺陷：无 evals（同仓 SLR 有而它没有，不对称）、无脚本，纯 prompt；对工程研报战场属于"判断层原料"而非端到端技能。

### A4. github-deep-research（得分 19）
- **一句话定位**：四轮递进式 GitHub 仓库深研：API 铁证 → 发现 → 深查 → 深潜，产出带时间线与置信度分级的报告。
- **核心机制**：R1 GitHub API（脚本 10 命令：summary/info/readme/tree/languages/contributors/commits/issues/prs/releases）→ R2 发现（3-5 搜）→ R3 深查（5-10 搜+fetch）→ R4 深潜（commit 史/issue/PR 演进）。**信源五级权重**（官方文档>技术博客>验证媒体>社区讨论>社媒）；**置信度表**：High 90%+（官方+多源互证）/ Medium 70-89%（单可靠源）/ Low 50-69%；**内联引用强制** `[citation:Title](URL)` 紧跟每个外部论断（有好/坏对照例）；"日期从 commits/PRs 验证，比文章可靠"；时间线用 Mermaid gantt。
- **数据契约**：报告模板占位符全集（REPOSITORY_* 14 字段、PHASE_N_NAME/PERIOD/CONTENT、CONFIDENCE_LEVEL）；输出文件名约定 `research_{topic}_{YYYYMMDD}.md`。
- **可移植**：① **置信度-信源分级对照表直接并轨弹药池 GRADE 分级**（我们 GRADE 有级无"什么源配什么级"的判据表，这张表补判据）；② github_api.py 免费无 key（token 可选 env）= conductor 可收编的免费渠道，EPC100 写公司技术栈/供应链情报时用；③ R1→R4 轮次预算（3-5/5-10/10+ 搜索量梯度）是 W2 分级工作流的轮次预算参照；④ "commit 日期>文章日期"的证据定年纪律可写进弹药池元数据规范。
- **质量评价**：中上——SKILL.md 偏简（模板占位符靠 assets/report_template.md 补）、无 evals；**点名缺陷**：github_api.py 的 urllib 回退分支拼 query 参数不 URL 编码（`"&".join(f"{k}={v}")`），多词参数会炸——同仓 arxiv_search.py 文档里明确修了这个坑并自称"同 github_api.py 模式"，即两个脚本一修一未修，工程不一致实锤。

### A5. claude-to-deerflow（得分 13）
- **一句话定位**：DeerFlow 2.0 实例的 HTTP API 客户端技能（12 个操作：健康检查/流式发消息/续线程/列模型技能代理/开关技能/记忆/上传 PDF/PPTX/XLSX/DOCX 自动转 Markdown/线程检索）。
- **核心机制**：env 三变量解析 URL（DEERFLOW_URL/GATEWAY/LANGGRAPH）；SSE 事件解析（metadata/values/messages-tuple/end）；chat.sh 脚本=健康检查→建线程→流式收集→打印，错误处理到位（HTTP 码检查、线程解析失败即退）。
- **数据契约**：**四档模式契约**（本技能最值钱的概念）：flash/standard/pro/ultra = 三个布尔 (thinking_enabled, is_plan_mode, subagent_enabled) 的组合阶梯；上传件转 Markdown 的端点约定；SSE 回包结构说明。
- **可移植**：四档模式阶梯=**W2 分级工作流(light/medium/heavy) 的枚举设计先例**（用最少开关位表达算力/深度档位，接到 conductor 出队参数与 EPC100 报告档位）；SSE 流式收集模式对长跑任务遥测有参照。除此之外对我们价值低——它绑死"先部署一个 DeerFlow 2.0 服务"（localhost:2026），是别家 harness 的遥控器。
- **质量评价**：文档与脚本一致、质量不差，但**保留意见**：对本战场属"别人的系统集成件"，除非决策层决定起 DeerFlow 服务，否则只有模式阶梯概念可拿。不直配。

### A6. newsletter-generation（得分 12）
- **一句话定位**：四阶段行业简报/新闻信生成（Morning Brew/TLDR 风格），四种版式骨架+信源评选标准。
- **核心机制**：Phase1 参数表（格式/受众/语气/长度/栏目数）+ 四版式骨架（每日快讯/周报/深读/**行业简报七段**含 Regulatory & Policy Changes——对工程行业版式有直接参照）；Phase2 检索策略模板（**强制用 `<current_date>` 造查询词，"Never use hardcoded years"**）+ 信源评选六维（Recency/Authority/Uniqueness/Relevance/Actionability/Diversity）；Phase3 分栏目写法+受众语气校准表（Technical/Executive/General 各带例句）；Phase4 组装+11 项质检 checklist（**每条事实必须有源链接**）。
- **数据契约**：四种版式骨架的结构枚举；11 项 checklist；输出 `newsletter-{topic}-{date}.md`。
- **可移植**：① 行业简报七段骨架（含监管政策段）接到 EPC100 后置链宣传三件腿（WeAIPO 自媒周更版式）；② `<current_date>` 时钟纪律与我们"测试夹具时钟陷阱"记忆同构，可作为宣传链产物的日期断言门；③ 信源六维评选表可给 conductor 渠道质量分提供维度参照。
- **质量评价**：中上——版式与 checklist 扎实、`<current_date>` 纪律难得；缺陷：无脚本无 eval，纯 prompt；"调研质量决定简报质量"一句带过、实际采集腿全靠外技能。

---

## B. firecrawl-workflows 组（Firecrawl 官方 16 工作流技能仓，本组 4 个）

仓背景：单仓 16 个 SKILL.md（全部无脚本无 eval），CI 镜像到 firecrawl/skills 目录仓；authoring 规范在 skills/firecrawl-workflows/references/workflow-authoring.md：**七点清单**（首段点名真实用户产出/只问阻塞性问题/说明要收集的工件/定终稿形状/有引用期望/标注可并行项/保持 harness 无关措辞）+ 轻量 onboarding（先推断，最多 1-3 问）+ **Automation Inputs 约定**（每个工作流可表达为 `workflow/cadence/inputs/output` 的 YAML，技能自带调度器不必需）。**全部技能声明 `inputs: FIRECRAWL_API_KEY required`——绑死商业付费服务，直接采用违反"免费资源优先"红线；可移植的是模式不是服务。**

### B1. firecrawl-research-papers（得分 11）
- **一句话定位**：基于 Firecrawl 论文索引（PubMed/bioRxiv/medRxiv/arXiv）的文献综述工作流：语义检索→种子扩展→**正文内验证**。
- **核心机制**：五件套工具契约——`search_papers(query,k)` 语义搜摘要 / `related_papers(seed_ids,intent,mode=similar|citers|references,k)` 引文图扩展 / `inspect_paper(id)` 取规范元数据 / `read_paper(id,question)` **对单篇正文做定向提问验证**（"验证承重论断，不求逐篇总结"）；查询类型→打法映射表（单篇点名/按描述/枚举型/性质型/排行型[先 web 找榜再映射回论文]/约束验证型）；反复澄清"categories:['research'] 是网页过滤不是论文索引"这个易混点（文档里写了两遍）。
- **数据契约**：终稿骨架 Abstract/Key Papers/Themes And Consensus/Open Questions And Debates/Emerging Trends/Sources + **Rerun Inputs 块**（workflow/topic/target_count/output——可复跑契约）。
- **可移植**：① **citers/references 双向引文扩展模式**（从强种子向引用族扩展而非只取首个命中）是 W7 学术检索聚合的召回腿设计（实现层可用免费 Semantic Scholar/OpenAlex API 替代付费 Firecrawl——其他组有对应技能，勿用本服务）；② read_paper 的"id+question 定向验证"模式=Jev 判断层"只验承重论断"的免费替代可用 LayaForge 做（拿问题回查原文段落）；③ Rerun Inputs 块=conductor 任务的复跑参数契约，可并入渠道账本。
- **质量评价**：设计真好（工具区分、打法映射、易混点反复澄清、负边界"Not the paper index, despite the name"），但**保留**：无脚本无 eval、纸上工作流，且索引覆盖偏生物医学（对工程行业研报直接命中率低）；付费依赖。

### B2. firecrawl-market-research（得分 10）
- **一句话定位**：市场/财务指标采集工作流：并行五路（公司财务/市场指标/行业趋势/新闻与分析师/信源验证）产出对比表报告。
- **核心机制**：onboarding（≤1-3 问）→ Firecrawl search/scrape 采集（IR 页/SEC 文件/财报/行业报告）→ 并行分工 → 终稿骨架（Market Overview/Company Profiles/**Comparison Tables**/Trends And Outlook/Sources/Rerun Inputs）。质量门：关键数字尽量交叉验证、冲突数据必须标注、**每个指标必须带期间和单位**、不给投资建议。
- **数据契约**：Rerun Inputs（query/companies/data_points=all|financial|metrics|trends/output=json|markdown）。
- **可移植**：① "指标必须带期间+单位"纪律接到 EPC100 弹药池元数据 schema（时点数据无期间=废数据，这条应进池子准入门）；② data_points 枚举（all/financial/metrics/trends）可作百强榜逐家研报的采集参数面。价值有限——**平庸**：75 行全貌，本质是给 firecrawl CLI 套了张提示皮肤，五路并行、对比表、质量门都是一句话带过，无任何执行细节。
- **质量评价**：平庸偏薄（对照同仓 deep-research 的深度即见差距）；付费绑定；无脚本无 eval。

### B3. firecrawl-deep-research（得分 8）
- **一句话定位**：报告级深研工作流，**用一个入场问题（跑多久）定三档深度**，强制含反方观点腿。
- **核心机制**：onboarding 唯一必问："How long do you want this research task to run?" → 映射深度档：**Quick（几分钟：3-5 查询×5-10 源）/ Thorough（10-15 分钟：5-10 查询×15-25 源）/ Exhaustive（不限：10+ 查询×25+ 源，含一手源与反方源）**；已带全文的搜索结果禁止重刮；description 里有整段**反触发声明**（"不要用于产品挑选/top-N/快速查询——那种请求别用本技能"）；与 research-papers 的交接契约（证据基是文献就移交，两条腿都要就各自跑再在本技能合成）；并行按**研究角度**分工（概览/技术细节/市场背景/**反方观点与风险**/一手源），每个研究员必须回"claims + source URLs + source quality notes + uncertainty"。
- **数据契约**：深度档枚举 quick/thorough/exhaustive（带量化预算）；终稿骨架 Executive Summary/Key Findings/Detailed Analysis/**Contrarian Views And Risks**/Open Questions/Sources/Rerun Inputs（topic/depth/output）。
- **可移植**：① **W2 分级工作流的最简实现范本**——"跑多久"一问定档+每档量化预算（查询数×源数），直接搬到 EPC100 报告档位（light=快讯/medium=标准/heavy=深度）与 conductor heavy 窗参数化；② 反方观点专职研究员=饱和引擎红队腿（W9）的分工模板；③ "研究员回包必须含 source quality notes + uncertainty"四件套=Manus 军团 worker 回包 schema 的直接参照（W5）；④ 反触发声明写法（大段"Do not use for..."）值得抄进我们每个技能的 description 防误触发。
- **质量评价**：真好（档位量化、反触发、交接契约、防重刮都实在）；保留：无脚本无 eval，执行全押在 firecrawl CLI 上，付费依赖。

### B4. firecrawl-lead-research（得分 8）
- **一句话定位**：会前客户情报简报（公司/人物/动态/谈资/痛点假设/切入点）。
- **核心机制**：四路并行（公司档案/近期动态/人物/行业痛点）→ 简报骨架（Company Overview/Recent Activity/Key People/**Talking Points 5-7 条**/Likely Pain Points/Outreach Angle/Sources/Rerun Inputs）。质量门：**事实与推断痛点明确分离**、禁止编造个人信息。
- **数据契约**：Rerun Inputs（company/person/context）。
- **可移植**：诚实说**对本战场接近零**——销售场景产物。勉强可拿两点：① "事实/推断分离"双清单格式可给 EPC100 报告里"数据陈述 vs 分析师判断"的分栏样式（W1 样式门的一个条目）；② 若做"百强榜企业高层画像"附录可借用骨架。**不建议纳入融合清单**。
- **质量评价**：作为技能不差（紧凑、有质量门），但与工程研报战场错位；付费绑定；无脚本无 eval。

---

## C. wshobson-agents 组（wshobson/agents 插件市场仓，本组 5 个）

仓背景：多插件市场（.claude-plugin/.codex-plugin/.cursor-plugin 三发行面），每插件=agents/commands/skills 三层；技能普遍采用**导航层 SKILL.md + references/details.md 渐进披露**模式（热提示小、模板沉到冷文件）。

### C1. block-no-verify-hook（得分 10）
- **一句话定位**：PreToolUse 钩子配置技能：拦截 agent 用 `--no-verify`/`--no-gpg-sign` 绕过 git 钩子。
- **核心机制**：matcher 限定 Bash → 从 `$TOOL_INPUT` 用 printf+grep -E 检测 git 命令带绕过旗标 → **exit 2 整体拦截**（退出码契约：0 放行/1 警告放行/2 阻断）；扩展模式演示（加 --force、`rm -rf /` 守卫、多钩子叠加）。
- **数据契约**：settings.json hooks 结构模板 ×3（项目级/全局/叠加）；退出码枚举 0/1/2。
- **可移植**：模式价值大于内容：**PreToolUse 出队闸**可把 conductor 的 domain_blocklist 从"任务出队时检查"下沉到"工具调用时硬拦"——例如拦 WebFetch/curl 命中黑名单域名、拦 metaso search-api 的批量调用（积分制付费资源批量禁用令的执行层 enforcement）、拦对生产目录的删除类命令（只增不删红线的机械执行）。exit-2 阻断契约是我们纪律条令变钩子的通道。
- **质量评价**：小而正确——退出码契约讲清、verification 步骤给了、可扩展性演示了；缺陷：无测试、grep 正则对 `env git commit --no-verify` 这类前缀变体会漏（自己未讨论绕过面）；对本战场需改造而非直用。

### C2. parallel-debugging（得分 9）
- **一句话定位**：用 ACH（竞争性假设分析）做并行根因调查：六类失效假设生成→并行取证→仲裁定根因。
- **核心机制**：六类假设生成框架（Logic Error/Data Issue/State Problem/Integration Failure/Resource Issue/Environment，每类 4-5 条子模式）；证据强度表（Direct 强/Correlational 中/Testimonial 弱/Absence 可变）；file:line 引用强制；置信度三档（High>80% 多直接证据+完整因果链/Medium 50-80%/Low<50%）；四步仲裁（归类 Confirmed/Plausible/Falsified/Inconclusive → 多确认则按置信度排序 → 复合问题判定 → 修复验证 checklist）。
- **数据契约**（在 references/hypothesis-testing.md）：假设任务模板（**先预注册 confirming evidence 与 falsifying evidence 两列判据**）、证据报告模板（Verdict/Confidence/Confirming Evidence/Contradicting Evidence/Causal Chain/Recommended Fix）、ASCII 仲裁决策树、按错误类型的常见假设组合表（"500 错误"三假设、"本地好线上坏"三假设等）。
- **可移植**：**W9 三新件里 ACH 腿的现成操作化**——① "先预注册证实/证伪判据再调查"直接接到饱和引擎 ACH 假设对抗（我们设计了 ACH 但没落地操作模板，这套假设任务模板+仲裁决策树就是落地件）；② Verdict 四枚举（Confirmed/Plausible/Falsified/Inconclusive）可做判断层 verdict schema；③ 六类失效框架可改造成"研报论断失效六类"（数据错/口径错/时效错/因果错/外推错/利益偏向）用于红队腿。注意 SKILL.md 没有链接 references 文件（见质量评价）。
- **质量评价**：内容真好（预注册证伪判据是全套精华），但**点名缺陷**：SKILL.md 全文未提及 `references/hypothesis-testing.md`——最重的模板/决策树成孤儿文件，agent 按文档走根本不会读它（同仓 data-storytelling/on-call 都正确写了"详见 references/details.md"，唯独它漏了），文档-资产脱节实锤；无测试。

### C3. data-storytelling（得分 8）
- **一句话定位**：把数据变成决策叙事的演示/报告写作模式库（叙事弧+三支柱+三个成品框架）。
- **核心机制**：故事结构 Setup→Conflict→Resolution；叙事弧六拍（Hook/Context/Rising Action/Climax/Resolution/Call to Action）；三支柱表（Data=证据/Narrative=意义/Visuals=清晰）；**Do/Don't 各五条**（先讲 so what、三的法则、别数据倾倒、别先讲方法论）。
- **数据契约**（references/details.md）：三个完整成品框架——Problem-Solution 故事（Hook 带金额锚点→Insight→Solution→Expected Impact→CTA）、Trend 故事（before/after 对比表）、**Comparison 故事（带权重评分矩阵：Factor/Weight/两案得分/加权总分）**；可视化技法（渐进揭示等）。
- **可移植**：① **W3 出版级图表的叙事面**——图不是画出来就完，data-storytelling 的"Hook 数字锚点+对比表+加权矩阵"是图表配套叙事模板，接到 EPC100 行业时序面板与报告对比章节（与 dataviz skill 的图形规范互补：一个管画、一个管讲）；② 加权评分矩阵可直接用于百强榜"区域/赛道优先级"类章节的样式；③ "先讲 so what"接入 brief（后置链 brief 腿的段落顺序门）。
- **质量评价**：真好——SKILL.md 正确引用 references/details.md（渐进披露的标准做法）、成品框架是完整可仿写的范文而非抽象原则；缺陷：无测试、无量化证据（纯方法论），对"出版级"只覆盖叙事维度不覆盖排版维度（W1/W3 各覆盖一角）。

### C4. on-call-handoff-patterns（得分 8）
- **一句话定位**：值班交接模式库：五组件交接文档+30 分钟重叠协议+全套模板。
- **核心机制**：交接五组件表（Active Incidents/Ongoing Investigations/Recent Changes/Known Issues/Upcoming Events）；时序协议（交方 15 分钟写文档+15 分钟同步会；接方 15+15+5 分钟验证告警）；Troubleshooting 五问五答（含"时差没法同步会→退异步模板+语音备忘"）；**交接完成门：每个 section 必须至少一条记录或显式 'None'，否则不算交接完成**。
- **数据契约**（references/details.md）：完整交接文档模板——状态枚举（Investigating/Monitoring）、每项调查含 Status/Started/Impact/Context/Next Steps(checkbox)/Resources(dashboard 链接+线程链接)；Recent Changes 分三表（Deployments 版本表/Config 变更/基础设施）；已解决事件含 Duration/Root Cause/Resolution/Postmortem 链接/Follow-up tickets。
- **可移植**：**W5 多 worker 编排契约的交接层**——① 7×24 EPC100 工厂与 Manus 军团的 worker 换班/任务移交可直接套"五组件+状态枚举+Next Steps checkbox"结构（现在我们只有任务卡，没有 worker 间交接件契约）；② "每 section 必须有条目或显式 None"=完备门思想在交接层的应用，可进 conductor adopt/收编流程；③ 与"长跑任务晚间执行+断点续跑"记忆直接咬合：夜跑交接文档就是断点续跑的说明书。
- **质量评价**：真好——模板是填好内容的范文不是空壳、Troubleshooting 直面真实失败模式；缺陷：SRE 语境包装（PagerDuty/Grafana 字眼需替换）、无测试。

### C5. protect-mcp-setup（得分 8）
- **一句话定位**：Claude Code 工具调用的密码学治理：Cedar 策略前置评估 + Ed25519 签名回执（哈希链、可离线验证）。
- **核心机制**：PreToolUse 跑 Cedar 策略评估（deny 即 exit 2 阻断）；PostToolUse 签回执含 input_hash/decision/policy_digest/parent_receipt_id（链式）；策略文件示例含 permit/forbid 双向（禁命令链 `;`/`&`/`|`、禁 `$` 展开、禁重定向、禁 `..` 路径逃逸、禁 rm -rf）；evaluate.sh **fail-closed**（无 tool_name 拒绝、npx 跑不起来拒绝——"宁可错杀不放行"）；离线验证 `npx @veritasacta/verify`，篡改 receipt 必须验签失败。
- **数据契约**：回执 JSON schema 全集：`receipt_id/receipt_version/issuer_id/event_time/tool_name/input_hash/decision/policy_id/policy_digest/parent_receipt_id/public_key/signature`（Ed25519 RFC8032 + JCS RFC8785）；测试目录 12 项往返测试表（含**篡改检测回归守卫**：翻转 decision 字段必须验签失败 exit 1）+ 只需 python3 的 CI 静态校验脚本。
- **可移植**：① **渠道账本/弹药池溯源的防篡改底座**——签名回执链可给 conductor 渠道过账记录与 GRADE 评级记录加"事后不可篡改"属性（W9 校准账本没有落地的，回执链就是账本的数据结构参照；可不引外部 npm 包，只抄 schema+哈希链思想用本地实现）；② fail-closed 钩子设计原则（评估器失败=拒绝而非放行）应写进 conductor 出队闸与 domain_blocklist 执行器；③ Cedar 式 permit/forbid 成对策略（白名单+显式黑名单双向）比我们单黑名单更完备，forbid 列表（管道/重定向/路径逃逸）可直接充实拦截面。
- **质量评价**：**本组唯一带完整测试套件的技能**（12 项往返测试+CI 静态校验+fixtures），工程质量全组最高；保留：依赖作者自有 npm 生态（protect-mcp@0.7.4 + @veritasacta/verify，veritasacta.com/IETF draft），第三方信任锚——按免费优先红线可抄设计不可引依赖。

---

## 跨技能共性模式（≥3 条）

1. **"框架先行、数据后采"的两阶段交接契约**（consulting-analysis Phase1/2 + Data Package、SLR Phase1 计划先行、firecrawl onboarding→collection）：先生成**机读的数据需求清单**（指标/类型/信源/关键词/优先级/时间窗），采集按单执行，终稿只准消费清单内数据（缺了要显式 flag）。→ 我们七步方法论 S1 缺的正是一个可执行的 Data Collection Task List 产物 schema；这是本组对主战场最系统的贡献。
2. **一问定档的分级阶梯**（firecrawl-deep-research"跑多久"→Quick/Thorough/Exhaustive 带查询数×源数预算；claude-to-deerflow flash/standard/pro/ultra 三布尔；SLR 篇数上限）：深度档位=量化预算表，不是形容词。→ W2 的实现范式。
3. **信源层级→置信度映射表无处不在**（github-deep-research High/Medium/Low 判据表、parallel-debugging 证据强度四型+置信度三档、firecrawl 各 Quality Bar、academic-paper-review Strength 三档）：独立于业务内容的通用证据分级语言，与我们 GRADE 分级同构——补的是"什么源配什么级"的判据面。
4. **负触发/路由契约进 description 与评测**（SLR eval#4 单篇论文应路由给兄弟技能；firecrawl-deep-research 整段"Do not use for..."；SLR 与 academic-paper-review 互写边界）：技能间分流不只是"何时触发"，还有"何时必须让位"，且用负向 eval 固化。→ conductor 渠道路由回归集与技能防误触发都该抄。
5. **Rerun Inputs / 复跑参数块**（firecrawl 四技能末尾全部带 `workflow/inputs/output` YAML 块；SLR"检索只准跑一次"；on-call 交接文档即断点说明书）：把工作流表达成可被调度器重放的参数契约。→ conductor 任务卡可加 rerun 块。
6. **渐进披露（导航层 SKILL.md + references/details.md）**（wshobson 5 个里 3 个如此且 2 个正确回链；deer-flow 用 templates/ 沉引用格式）：热提示保持小，模板范文沉冷文件——但 parallel-debugging 的孤儿 references 证明**不回链等于白写**，采用该模式必须配"SKILL.md 必须显式指向冷文件"的检查项。
7. **选择性验证腿**（read_paper"只验承重约束"、academic-paper-review 逐条 Claims 抽取、consulting-analysis 可追溯性条款）：全量核验不可负担，验证预算只花在承重论断上——与 Jev"只占免费做不到的原语位"纪律同源。

## 本组对 W1-W9 空白覆盖一行表

| 空白 | 覆盖情况 | 最佳供给者 |
|---|---|---|
| W1 报告样式门 | 部分覆盖（文风契约+双 checklist+事实/推断分栏样式） | consulting-analysis（Phase2 格式标准+禁词表）、B4 的事实/推断分离 |
| W2 分级工作流 | **强覆盖（模式级）** | firecrawl-deep-research（一问定档+量化预算）、claude-to-deerflow（四档模式阶梯） |
| W3 出版级图表 | 部分覆盖（流程面+叙事面，无生成代码） | consulting-analysis Step2.3 图先行、data-storytelling（对比表/加权矩阵叙事） |
| W4 PDF/文献解析 | 弱覆盖且绑服务 | B1 read_paper 正文定向问答（模式）、A5 上传转 Markdown（端点） |
| W5 多 worker 编排 | **强覆盖** | A2 并发决策表+静默丢弃警告、C4 交接五组件+完成门、B3 角度分工+回包四件套 |
| W6 交付物验收门 | 部分覆盖 | C5 签名回执链（可证执行记录）、各 Quality Bar/checklist |
| W7 学术检索聚合 | **直接命中（免费腿）** | A2 arxiv_search.py 免费可直装 + B1 引文扩展模式（用免费 API 替实现） |
| W8 选题简报 schema | **最强单点命中** | A1 数据需求表六字段 + Data Collection Task List |
| W9 三新件 | 直接命中两腿 | C2 ACH 操作化（预注册证伪判据+仲裁树）、B3 反方观点腿、C5 回执链=账本数据结构 |

## 诚实纪律核对
负面/保留意见技能：B2（平庸：提示皮肤、细节全无）、B4（战场错位，不建议融合）、A5（绑死别家 harness，仅概念可取）、B1（付费+索引偏生物医学+纸面工作流）、C2（孤儿 references 脱节点名）、B 组全体（FIRECRAWL_API_KEY 商业绑定违反免费红线，只搬模式不搬服务）、A4（urllib 回退不编码的脚本缺陷点名）= 7/15 ≈ 47%，超过 20% 要求。
