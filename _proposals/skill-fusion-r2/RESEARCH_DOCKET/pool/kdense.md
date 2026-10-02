# skill-fusion-r2 提取报告：K-Dense-AI/scientific-agent-skills（29 技能深读）

- 深读日期：2026-09-26；提取员：t1-kdense
- 仓根事实：166 技能、MIT、v2.68.0、arXiv:2609.00065；CI 强制「凡带 scripts/ 必有 tests/」+ Cisco skill-scanner 安全扫描 + 仓级结构契约（frontmatter/链接解析/脚本可解析/--help 行为）。本清单 29 个中 22 个有测试、7 个无（见各节）。
- 读取方法：29 个 SKILL.md 全文；assets/scripts/references 关键文件抽查（脚本读头部 40-60 行验工程真伪）；tests/ 目录逐技能核对。
- 对照基线：EPC100 工程研报工厂 + 调研方法论栈（conductor/弹药池+饱和引擎/Manus 军团/Jev-Laya 判断层/七步法/后置链）；空白 W1-W9；红线（免费优先/密钥永不入库/黑名单/只增不删）。

> 交付节奏建议（先说结论）：本仓对本战场最值钱的 5 件 = market-research-reports（证据双账本）、scientific-writing（行内 claim/evidence 绑定+人工放行门）、liteparse（W4 主腿）、exploratory-data-analysis（能力分层矩阵=W2 同构）、arbor（dev/test 合并门+executor 契约=W5+达尔文环）。负面名单见文末。

---

## 1. paper-lookup（v2.2，K-Dense，有测试）

- **一句话定位**：18 个学术 API（PubMed/PMC/EuropePMC/bioRxiv/medRxiv/arXiv/OpenAlex/Crossref/S2/CORE/Unpaywall/OpenCitations/PubTator3/Zenodo/Figshare/ROR/BioStudies/DOAJ）的统一检索技能，核心教义=「这些 API 会在 HTTP 200 里失败」。
- **核心机制**：7 步 Core Workflow（定义检索契约→选库→读 per-库 hazard 参考→优先用捆绑脚本→有界调用→响应当不可信第三方数据→带出处返回）；错误恢复 5 步；穷尽检索 4 律（先 count→确定性分页→count 对账→fail visible not plausible）。
- **数据契约**：输出格式四段（Retrieval Summary/Results/Provenance/Warnings）；脚本退出码语义化——paginate.py **exit 4=走完但少记录**、jats_to_text.py **exit 2=无正文仅元数据**、arxiv_atom.py exit 3=错误 feed(200)/5=限流；标识符对照表（DOI/PMID/PMCID/arXiv/W/OpenAlex/S2 hex/ROR/OCI/Zenodo concept≠version）。
- **可移植做法**：①W7 学术检索聚合直接抄「选库路由表 + per-库 references hazard 文件」结构，把 cnki 单点扩成多源（中文源需自补，本仓无中文库）；②「先 count 后分页再对账」纪律接到弹药池采集完整性判断；③ paginate.py 的 key 脱敏（api_key/email/mailto 从 provenance 里抹掉）符合密钥永不入库红线，模式可搬 conductor。
- **质量评价**：真好。证据：paginate.py docstring 实录 bioRxiv cursor=绝对 offset、/details/ 每页 30 而 /pubs/ 100、「错步 cursor 返回 200 且看似成功」——hazard 是真踩过写下来的；stdlib-only、多数库免 key（符合免费优先）。测试：fixtures+test_scripts.py。无脱节。

## 2. market-research-reports（v1.3，K-Dense，有测试）★ 本仓第一名

- **一句话定位**：可审计的市场研报工厂——claim↔source 双账本 + TAM/SAM/SOM 情景测算 + 发布门，几乎是 EPC100 研报流水线的同构物。
- **核心机制**：10 步 workflow（研究契约→证据计划 8 级源分级→源账本→claim 账本→情景化 sizing→带不确定性的预测→客户/一手研究→竞品与集中度→单位口径归一→起草评审）+ Release Gate 10 条硬门。
- **数据契约**（照录字段）：`source_ledger.csv`：source_id,title,publisher,url,source_type,publication_date,retrieval_date,geography,currency,base_year,price_basis,measure_type,unit,taxonomy,taxonomy_version,revision_status,method,sample,limitations,license_or_terms,archive_path；`claims_ledger.csv`：claim_id,claim_text,claim_type,source_ids,calculation_id,assumption_ids,location,as_of_date,geography,currency,base_year,price_basis,measure_type,unit,taxonomy,taxonomy_version,revision_status,confidence,notes；sizing JSON：每分量带 disjoint `coverage_key`+共享 `denominator_id`（防重复计入六条禁令）；manifest：historical_period/forecast_period/retrieval_cutoff。8 个 stdlib CLI（validate_evidence_ledger/audit_claim_citations/calculate_market_sizing/forecast_sensitivity/validate_competitor_matrix/check_unit_consistency/generate_report_scaffold/_common）。
- **可移植做法**：①双账本 CSV schema 原样借给 EPC100 研报：source_ledger 接渠道账本（conductor 已有渠道概念，补 method/sample/limitations/revision_status 字段），claims_ledger 接终稿审计（「一句段尾引用不支持无关句子」「聚合器与原始源不算独立佐证」两条规则直接写进红队 prompt）；②TAM 双算+coverage_key 防重接到研报市场规模章的确定性计算（calculate_market_sizing.py 可直接改用）；③Release Gate 10 条改写为 W6 验收门初稿。
- **质量评价**：真好。脚本抽查 audit_claim_citations.py：共享 _common.py 校验件（MAX_ROWS/require_unique_identifiers/write_json_report），工程真。claim 规则细到「absence of public feature evidence means unknown, not no」。测试有。唯一注意：LaTeX 模板需 XeLaTeX（可选，不绑服务）。

## 3. peer-review（v2.2，K-Dense，有测试）

- **一句话定位**：保密同行评审草案流水线：intake 授权门→报告规范选择→claim-证据矩阵→统计/可复现/伦理/图表/引文审→双通道输出→lint。
- **核心机制**：Mandatory 安全边界（未授权不看不引）→ **Intake gate**（validate_review_intake.py，状态到 `READY_FOR_LOCAL_REVIEW` 才放行，validator 拦 8 类未声明项）→ 11 步评审工作流（含 9 级方法统计审查顺序）→ 双通道分离（给作者 vs 给编辑）→ lint_review.py（通道混分/占位符/辱骂词表/角色越权短语/行动性字段，输出行号+规则 ID 不回显正文）。
- **数据契约**：review_intake_template.json（授权/利益冲突/评审模型/venue 政策/删除保留计划）；claim_evidence_matrix.csv（location/claim_id/支撑 result-ID/方向量级对齐/替代解释/请求动作）；7 个 CLI 清单见 Local tool index。
- **可移植做法**：①红队腿（W9 三新件之一）直接用「lint 输出规则 ID 不回显文本」+ claim_evidence_matrix 模式改造 EPC100 自复盘/质量审；②「修订工作流：记录评论→分类（editorial/scientific/statistical/policy/unresolved）→**先改登记表再改散文**→重跑受影响审计」接到研报修订循环（终稿迭代时先改 claims 登记再改 md）。
- **质量评价**：真好。脚本本地确定性、无网络无 LLM。测试有。

## 4. bgpt-paper-search（v1.1，第三方 BGPT，无测试）✗ 负面

- **一句话定位**：调远程商业 MCP（bgpt.pro）搜「全文抽取的结构化实验数据，25+ 字段/篇」。
- **核心机制**：无流程无门——配置 MCP→调 search_papers 工具，文档 75 行到顶。
- **数据契约**：宣称返回 title/authors/journal/year/DOI/methods/results/sample sizes/quality scores/conclusions，但**无任何 schema 照录、无字段定义、无失败模式**。
- **可移植做法**：唯一可借的是反面教材——它的「结构化全文字段检索」需求画像证明 W7 聚合值得做，但应按 paper-lookup 的 hazard-文件纪律自建而非依赖此服务。
- **质量评价**：明确负面。①绑死商业服务（免费 50 次/网络，之后 $0.01/结果，违反免费资源优先红线）；②与同仓 paper-lookup 的文档深度相比是断崖（无 references/无 scripts/无 tests/无退出码）；③「25+ fields」是营销话术 unverifiable；④ skill-author=BGPT 非本仓，README 自己承认社区贡献审核有限——本技能就是证据。不建议引入。

## 5. scholar-evaluation（v2.2，K-Dense，有测试）

- **一句话定位**：对学术作品的定性优先评审 + 低风险评估流程审计；永不对人打分排名。
- **核心机制**：硬边界（禁人事/招生/基金/奖项决策）→ 指标代理禁令（JIF/h-index/引用数/机构声望不许入评分，rubric validator 会拒）→ 8 步工作流，其中第 5 步**三态评分**：`rated`（带锚点分+有界不确定度+证据 ID）/`missing`（null 分）/`not_applicable`（null 分+理由）——**缺失不编码为 0**；第 6 步本地质检 5 CLI（validate_rubric/calculate_scores/check_traceability/summarize_agreement/weight_sensitivity/check_process）。
- **数据契约**：rubric_template.json（content_validity 默认 `not_established`，无证据不许改）；evaluation_template.json（三态+锚点+不确定度+evidence IDs）；evidence_manifest（只存稳定定位符不存正文）；process_checklist_template「故意未确认、fail closed」；允许数据分类枚举 `synthetic|public_scholarly_work|deidentified_low_stakes`。
- **可移植做法**：①校准账本（W9）：weight_sensitivity.py（权重扰动+排序不稳性）思路直接用于 Jev/Laya 判断层的权重敏感性与「结论是否被单一渠道权重驱动」检验；②三态证据状态接到 conductor 完备门：渠道缺席应记 missing/unavailable 而非折算成「无证据」，与 folklore 的状态机互证。
- **质量评价**：真好。「解释规则」节明确「分数是序数非自然测量、归一化不修复证据不全、agreement≠validity」——反过度声明纪律一流。测试有。

## 6. statistical-analysis（v1.2，K-Dense，有测试）

- **一句话定位**：引导式统计分析：检验选择→假设检查→效应量→功效→APA 报告，外加统计诚信七律。
- **核心机制**：6 步弧（先定问题再碰数据→检视→选检验→假设检查→检验必带效应量→APA 报告）；假设违反处置表；版本坑实录（pingouin 0.6 列名改版、ArviZ 1.x 默认 89% 区间、单侧 Bayes factor 被静默丢弃）；统计诚信 7 条（确认性/探索性区分、不许购物显著性、多重比较校正、非显著≠无效应、显著≠重要、缺数据先懂机制、可复现）。
- **数据契约**：assumption_checks.py API（comprehensive_assumption_check/check_normality/check_homogeneity_of_variance/check_regression_diagnostics/detect_outliers）；效应量基准表（Cohen's d 0.2/0.5/0.8 等）；4 个 APA 报告模板（t 检验/ANOVA/回归/贝叶斯）成文照录。
- **可移植做法**：①APA 模板结构（描述统计→统计量→效应量+CI→假设检查→含非显著全量报告）改造成 EPC100 研报数据结论段的文风门；②「planned test 先定后跑」纪律接到七步法 S1（立题时冻结分析口径，防事后挑口径）；③ assumption 门模式接判断层评估前的先决条件检查。
- **质量评价**：真好（文档/代码耦合紧，版本兼容注记是实测产物）。缺点：依赖重（pingouin/pymc/arviz），对研报场景多数用不上；战场只用其报告模板与纪律即可，不必装栈。

## 7. venue-templates（v1.3，K-Dense，有测试）

- **一句话定位**：投稿模板技能，核心不是 LaTeX 而是「时效规则必须现场核验 + 合规便签留档」。
- **核心机制**：Mandatory Currency Rule（给页限/匿 名/style 名前必须开官方源+记录 URL+日期）；verification-first 5 步；**compliance note**（Target/Official source/Checked/规则字段，写进工作文档使后续验证可复现）；bundled 资产明确标「scaffold≠官方模板」；validate_format.py 查页数+嵌入字体出报告。
- **数据契约**：compliance note 文本块（照录：Target: ICML 2026 main track, initial submission / Official source: URL / Checked: 2026-07-20 / Main-text limit / Anonymity / Official template）；资产状态表（每 .tex 标 generic-scaffold/wrapper-requires-official-sty）；Final Compliance Checklist 10 项。
- **可移植做法**：W1 报告样式门的直接答案：①每份 EPC100 交付在排版前写一条样式 compliance note（样式基线来源/核对日期/页数口径/字体基线），md2docx/md-to-typeset-docx 排版前后各核一次；②「快照」（W9 三新件之二）与此同构——样式快照+日期+来源 URL，漂移可检。validate_format.py 的「helper 只能证明页数和字体、不能证明边距合规」的诚实边界声明值得照抄进 W1 门的说明。
- **质量评价**：真好。年度会议快照带年份标注+维护节规定「年specific 主张只能查官方源后替换」。测试有。

## 8. hypothesis-generation（v2.2，K-Dense，有测试）★ ACH 同构

- **一句话定位**：把观察变成一组带边界条件的候选假设+判别性预测+可预登记分析计划；假设永远是 candidate 不是发现。
- **核心机制**：12 对象定义表（observation/question/hypothesis/mechanism/estimand/prediction/alternative explanation/null/negative control/operationalization/analysis plan/evidence——「不许塌缩标签」）；12 步工作流：安全门→冻结观察（先记录后解释）→框架化问题（PICO 不是万能模板）→**带日期的检索边界**→**先造对手再选检验**（9 类 rival：机制/测量伪影/混杂/选择/碰撞条件/反向因果/时序边界/随机涨落/另尺度竞争机制）→声明 claim 类型与 estimand→推导判别性预测（含「何结果与候选不相容」）→操作化→设计匹配→**防 HARKing（接触结果前时间戳问题/候选/预测/分析）**→复制计划→人工问责。
- **数据契约**：hypothesis_record_template.json、prediction_rival_matrix_template.csv、falsification_controls_template.json、search_boundary_template.json、evidence_ledger_template.csv；7 个 CLI（validate_hypothesis_schema/check_operationalization/validate_prediction_matrix/**lint_causal_claims**/check_falsification_controls/audit_evidence_ledger/generate_preregistration_scaffold）；退出码 0/1/2 语义。
- **可移植做法**：①饱和引擎 ACH 腿直接升级：prediction_rival_matrix.csv 的「每候选×每 rival 的相容/不相容预测」矩阵就是 ACH 诊断性证据表的标准实现，接到 R1'-R3' 饱和判定；②lint_causal_claims.py（抽查确认实现：CAUSAL_RE 词表 causes/leads to/increases… + 内联 `[claim:...]` 标签校验 + claim 类型一致性）几乎可以原样接后置链终稿 lint——把因果动词改成研报版的「将导致/有望拉动」词表；③「not located within the documented search boundary ≠ 不存在」措辞接弹药池有效性判断与完备门话术。
- **质量评价**：真好。stdlib-only、非评分（「不许自动打分选假设」）。测试有。

## 9. scientific-writing（v2.1，K-Dense，有测试 3 个文件）

- **一句话定位**：证据可追踪的科学写作：行内 claim/evidence ID 绑定 + 本地一致性审计 + 人是唯一放行者。
- **核心机制**：三条铁律（保密/不捏造/证据绑定——「检索片段、生成摘要、记忆、别人的参考文献都不算验证」）；12 步：脚手架（fail-closed、含 lint 会拒的占位符）→选报告规范→建证据记录→**只从已记录证据做提纲**→起草不加事实→方法-结果对账→引文/claim 审计→作者权与披露→声明核验→图表按需→非评分规范覆盖→lint 与批准（`submission_ready` 只有人能置 true、去 DRAFT 横幅须人批准）。
- **数据契约**：ID 体系 **E**(源)/**C**(claim)/**N**(数字)/**M**(方法)/**O**(结局)/**R**(结果)；行内标注语法 `[claim:C001] [evidence:E001,E002]`；claim 文本在 CSV 里存**哈希**而非原文；consistency_manifest 供 check_consistency.py 对账；8 个 CLI。
- **可移植做法**：①行内 ID 绑定语法接到 EPC100 终稿 md：写稿阶段每段带 `[claim:Cxx] [evidence:Sxx]`，audit_claims.py 改造后成为交付前自动门（W6 内容腿）——发布版再机械去标签，源稿留绑定；②「先改登记表再改散文」与 peer-review 同律，统一进修订流；③ N/M/O/R 数字一致性 manifest 专治「摘要的数和正文不一致」——后置链 brief 生成时可跑同构检查。
- **质量评价**：真好。曾删掉自家 LaTeX 模板，理由是「貌似可交付的占位稿可能带病出门」——这个取舍本身就是 W1/W6 设计教材。测试 3 文件（含合成稿件夹具）。

## 10. scientific-visualization（v1.2，K-Dense，有测试）

- **一句话定位**：诚实编码优先的出版级图表技能：先保科学含义再谈好看，交付时检查文件本身而非信任绘图默认。
- **核心机制**：6 步（定义证据与目的地→选诚实编码→无障碍内建→scoped styles 实现→显式导出+出处→检查比对评审）；诚实编码清单（条形含零基线、缺失与剔除显式分开、双轴慎用、面积缩面积不缩半径、log 轴声明零负处理）；导出器拒绝隐式覆盖、原子写、provenance 侧车。
- **数据契约**：export_figure(provenance={raw_data,transformations,uncertainty,missing_data}, write_manifest=True)；publisher_profiles.json（官方源快照带日期）；assets 三个 .mplstyle（publication/nature/presentation）+ color_palettes.py（Okabe-Ito/Paul Tol 带元数据）；CLI：image_metadata.py（TIFF/DPI/alpha/ICC 检查）/palette_audit.py（WCAG sRGB 对比度+灰度筛查）/export_plan.py/style_preview.py。
- **可移植做法**：W3 出版级图表主件：①图表 provenance 侧车 manifest（原始数据路径/变换/不确定度/缺失处理）作为 EPC100 图表交付标配——宣传三件用图从此可溯源；②palette_audit+okabe_ito 色板接到 dataviz 统一色规；③「检查交付文件而非信任默认」（DPI=像素/最终英寸）接 docx 排版后的图件抽检。
- **质量评价**：真好。版本钉死快照（matplotlib 3.11.1/seaborn 0.13.2/plotly 6.9/kaleido 1.3）+「非传递锁」的诚实声明。测试有。

## 11. arbor（v1.2，K-Dense，有测试）★ W5+达尔文环

- **一句话定位**：自主优化循环（HTR 假设树精炼）：协调者持有持久假设树，隔离子代理执行单假设实验，dev 赢必须过 held-out test 门才能合并。
- **核心机制**：先钉任务元组 `(M_0, O, E_dev, E_test)`（没有干净 dev/test 切分就自己造并声明）；6 步循环 Observe（从树不是从记忆重接地）→Ideate（条件于树证据）→Select（非纯分数最大化，选信息量）→Dispatch（worktree 隔离并行）→Backpropagate（**洞察上传播是主要收益源**，论文消融：无洞察反馈的树 54.5% 低于无树平铺 63.6%、全系统 81.8%）→Decide（prune 记原因成负约束 / merge gate：只在 fresh worktree 跑 E_test，不过门=信号不是障碍）。
- **数据契约**（照录）：`.arbor/tree.json`（节点=`<h, iota, mu>`：hypothesis/insight/metadata{status,dev_score,test_score,result,branch_ref,depth}）+`.arbor/run.json`（objective/evaluators/budget/M_best）；节点状态机 `VALID_STATUS = {pending, running, executed, merged, pruned, root}`（tree.py 源码确认）；executor 契约 4 返回：dev_score/result/insight/branch_ref，且**执行者不得在指标停滞时改假设**（否则证据语义破坏）。
- **可移植做法**：①W5 多 worker 编排契约：executor-brief.md 模板 + 4 字段返回契约 + 「假设绑定不可漂移」纪律直接搬给 Manus 军团 worker 下发（research_plan 下发腿已有，补结构化返回与漂移禁令）；②方法进化达尔文环升级：把渠道/方法试验记录进 .arbor/tree.json 式持久状态（洞察上传播+prune 原因留存），merge gate 与 E1/E2/E3 三门同构——LayaForge 的 gate_ckpt.py 已经是 dev/test 门的实例，arbor 给出「树形组织多次试验」的完整状态方案。
- **质量评价**：真好。tree.py 是真状态管理器（校验、原子性、observe 投影），非伪码。测试有。

## 12. markdown-mermaid-writing（v1.1，社区贡献 Apache-2.0，无测试）△ 保留

- **一句话定位**：把「markdown+mermaid」立为文档默认标准：mermaid 是源、图是衍生物。
- **核心机制**：三阶段论（Phase1 mermaid-in-md 永远必做=source of truth；Phase2 python 图=数据图才用；Phase3 AI 图=仅润色）；24 种图型 references 逐个成文件 + 9 个文档模板；accTitle/accDescr 无障碍标注。
- **数据契约**：templates/ 9 模板 + references/diagrams/24 图型速查（use case→diagram type→file 的映射表）。
- **可移植做法**：①过程附录与自复盘的架构/流程图默认 mermaid（git diff 友好、免渲染依赖），比截图适合只增不删的仓内沉淀；②「use case→图型」映射表可直接并入 EPC100 附录写作指引。
- **质量评价**：保留意见。声称「teaches you — and enforces a standard」但**无脚本无测试无 lint， Enforcement 无牙**，是纯风格文档；社区技能混入本仓的典型（无测试即违反仓规的「有 scripts 必有 tests」，它靠没有 scripts 绕过）。参考价值真实（24 图型映射很全），但按纸面纪律要求应点名：文档承诺>执行机制。

## 13. matplotlib（v1.2，K-Dense，有测试）△ 平庸

- **一句话定位**：matplotlib 包技能：OO 接口推荐、多子图三法（grid/mosaic/GridSpec）、导出要点。
- **核心机制**：层级概念（Figure/Axes/Artist/Axis）+两接口对比+常用工作流；constrained layout、dpi/bbox_inches 陷阱。
- **数据契约**：无自有 schema（包技能）。
- **可移植做法**：仅作图表脚本的陷阱参考（bbox_inches='tight' 改页面尺寸、savefig dpi），并入 dataviz/W3 的实现参考层；不引入为独立技能。
- **质量评价**：平庸（对本战场）。内容正确、测试有，但全是教科书知识，与 scientific-visualization 重叠且后者高一个层级——此技能自己也把「出版级多面板」让给 scientific-visualization。增量小。

## 14. neurokit2（v1.2，K-Dense，有测试）域外

- **一句话定位**：生理信号（ECG/EDA/EEG 等）研究工作流的包技能，钉 0.2.13 快照。
- **核心机制**：证据截止日纪律（stable wheel vs dev 文档版本双记）；Required data contract 8 条（采样率/单位/时钟漂移/极性/缺失/事件基准/预处理顺序/被试级分组防泄漏——「永不从列名推断单位」）；inspect-before-transform。
- **数据契约**：数据契约 8 条本身即 schema（signal identity/sampling Hz/unit/clock/polarity/missing/event onsets 0-based?/grouping）。
- **可移植做法**：数据契约 8 条模式借给渠道数据 intake（尤其「单位/口径不许从字段名推断」与「分组键防泄漏」两条，接到弹药池入池校验）。其余域外不用。
- **质量评价**：真好（域内）；对本战场仅契约模式可借。

## 15. pptx-posters（v2.2，K-Dense，有测试 4 文件）★ W6 答案

- **一句话定位**：从作者批准的本地 manifest 生成 macro-free PPTX 海报；整个技能是一座 fail-closed 要塞。
- **核心机制**：8 条 Hard gates（内容未定/任何 claim 未决/会议印刷要求未确认/**批准未绑定当前 manifest 内容哈希**/资产越界或未哈希/输入带宏或外链/需自动开 PowerPoint/脚本报 blocker——任一不满足就停）；manifest 故意无效直到全部替换 token 解析；生成后再跑包安全检查+布局检查+人工无障碍门。
- **数据契约**：poster_manifest.json（每元素 source_id/author_verified/author_approved、资产本地路径+小写 SHA-256、QR 可见回退 URL、阅读顺序与设计矩形、对比度对）；**批准机制：先 `--print-content-hash` 得内容哈希交作者，作者批准记录 approver+时间戳+哈希，任何非批准编辑使批准失效**；CLI 7 个（validate_manifest/generate_poster/inspect_pptx/check_layout/inventory_images/check_palette/plan_export）；inspect_pptx 拒绝清单（宏/VBA/ActiveX/OLE/外链关系/zip 路径伎俩/超高压缩比）。
- **可移植做法**：①W6 交付物可用性验收门的核心机制直接搬：终稿 docx/宣传件发布前算内容哈希，验收记录绑定哈希，任何后改动自动失效须重验——「批准是内容的函数不是时间的函数」；②inspect_pptx 的包安全检查清单并入 md2docx/md-to-typeset-docx 后置链的产物抽检（docx 也是 zip，同构）；③「有效 DPI=像素/最终放置英寸」这类口径声明模式用于 W1。
- **质量评价**：真好，本仓工程最重的技能。测试 4 文件（含生成冒烟+静态+合成海报夹具）。

## 16. networkx（K-Dense，无测试）△ 平庸

- **一句话定位**：NetworkX 包技能：图创建/算法/生成器/读写/可视化五大能力 references。
- **核心机制**：标准包技能结构；Quick Reference 双表。
- **数据契约**：无自有 schema。
- **可移植做法**：证据图谱（AI-Station 已有 29e12f3 证据图谱落地）如需图算法（中心性/社区检测/路径），此技能的 references/algorithms.md 可作速查；不引入。
- **质量评价**：平庸（对本战场）。无脚本无测试（纯文档绕过仓规测试门），内容本身正确但对已有证据图谱工程增量小。

## 17. scientific-critical-thinking（v1.3，K-Dense，无测试）△ 保留

- **一句话定位**：批判性评估科学主张的纯参考技能：七能力区+GRADE/Cochrane ROB 框架。
- **核心机制**：七能力（方法学批评/偏倚检测/统计评估/证据质量/逻辑谬误/设计指导/主张评估）各成 references；批评结构五段（Summary/Strengths/Concerns 按 critical-important-minor 分级/建议/总评）；GRAID 四级+降级五因子。
- **数据契约**（GRADE 照录）：High→降级因子=risk of bias/inconsistency/indirectness/imprecision/publication bias；四級 High/Moderate/Low/Very Low 定义成文。
- **可移植做法**：①弹药池 GRADE 分级的执行口径：目前「GRADE 分级」是一句标签，这里给出了可操作的降级五因子判定表——把每条弹药从「标了 GRADE-2」变成「GRADE-2 因为间接性+不精确」可解释记录；②logical_fallacies.md + common_biases.md 作红队腿（W9）的 prompt 素材库。
- **质量评价**：保留。文档扎实（references 六件全），但无脚本无测试纯纸面；视觉腿依赖 OpenRouter 付费 API（虽 optional，仍触免费优先红线——同病见 research-grants）。价值在 GRADE 表与谬误清单，值得抽 references 不值得整技能引入。

## 18. vaex（K-Dense，无测试）△ 平庸/域外

- **一句话定位**：out-of-core 大表处理包技能（HDF5/arrow 内存映射）。
- **核心机制**：六大能力+Quick Start+三个 Pattern（CSV→HDF5/高效聚合/虚拟列）。
- **数据契约**：无。
- **可移植做法**：无（EPC100 数据量级用不到；且 vaex 上游维护活跃度弱于 polars，同仓自有 polars 技能更合理）。
- **质量评价**：平庸。无脚本无测试；对本战场无关。列在此仅因清单分值排序带入。

## 19. clinical-decision-support（v2.2，K-Dense，有测试）

- **一句话定位**：研究级临床决策支持**评估工件**生成（非临床使用）：GRADE 证据档案、聚合队列表、模型评估、决策逻辑追溯。
- **核心机制**：硬安全边界→Data Gate（拒患者级数据/本地 only/披露阈值先定）→**必备工件头**（artifact_type/status/owner/意图/禁用清单/数据级别/人工审批边界/监控与退役预期，外加固定声明「Not for patient care」）→按需选工件→本地跑→按工件配比人工评审。
- **数据契约**：7 对 asset↔script 一一对应表（validate_cds_artifact/evidence_profile_check/model_biomarker_evaluation/cohort_table_generator/survival_plan_validator/decision_logic_traceability/deidentification_checklist）；evidence_profile_template.json（GRADE 档案）。
- **可移植做法**：①GRADE evidence profile 的 JSON 模板+check 脚本借给弹药池：每条关键弹药一张证据档案（偏倚/间接/不精确/不一致逐项过账）；②decision_logic_traceability（决策逻辑可追溯矩阵）模式接 conductor：每个调度决策（为何此渠道被排除/采纳）留矩阵行，完备门审计有据；③必备工件头 schema 借给 EPC100 研报元数据头（status/owner/审批边界/禁用声明）。
- **质量评价**：真好（机制完全域无关）。stdlib-only。测试有。

## 20. clinical-reports（v2.1，K-Dense，有测试）

- **一句话定位**：从已验证 source-fact manifest 生成临床报告**草稿结构**：只有事实 ID 支持的字段才能填，输出永远带 DRAFT 横幅。
- **核心机制**：Input Gate 7 条（目的明确/数据类允许 synthetic|deidentified|aggregate/授权记录/本地可行/最小必要/**每字段有 fact ID**/评审 owner 已定）；Route-before-draft 表（11 种报告类型→CARE/ACR/CAP/CONSORT/SPIRIT/ICH E3/E2A/E2D 映射）；填充纪律：null 只在 fact ID 支持时替换、`not_applicable_with_rationale` 须评审人给理由、原始记录与草稿分离。
- **数据契约**：provenance_manifest_template.json（本地定位符/字段路径/验证状态/验证人角色/验证日期/**SHA-256 值哈希**，不复制源内容）；draft_status 字段冻结；4+ 个结构校验 CLI。
- **可移植做法**：W6 内容腿同构：①「verified fact ID 才能填字段」改成「过账渠道 ID+弹药 ID 才能落笔」，终稿每个数字可回溯到渠道账本行；②SHA-256 值哈希接证据防篡改（弹药入库时哈希，引用时校验）；③ DRAFT 横幅+draft_status 冻结接到「过程附录 vs 终稿」的版本区分（发布件无横幅=已过门）。
- **质量评价**：真好。「宁缺勿编」纪律到字段级。测试有。

## 21. exploratory-data-analysis（v1.2，K-Dense，有测试）★ W2 同构

- **一句话定位**：有界本地 EDA：能力分层矩阵+机器可读能力注册表，未知格式 fail closed。
- **核心机制**：非协商边界（一切当不可信数据/不自动删离群点/EDA 不做确证结论）；**能力矩阵四层**：Automated core（csv/tsv/json）→Automated optional（npy/npz/h5/fasta/fastq/png/tiff 逐格式标定检查深度）→Reference-only（PDB/BAM/VCF/parquet 等 20+ 格式只给参考须另行验证）→**Unsupported：fail closed，先问格式再谈内容**；Safe I/O 契约 8 条（拒 URL/../symlink/特殊文件；64MiB 默认 512MiB 硬顶；签名校验不用内容嗅探；原子写；--force 才覆盖；永不联网）；版本基线表（verified 2026-07-23，逐包 pin）。
- **数据契约**：capability_manifest.py 机器可读注册表（`list`/`inspect data.csv --root /approved/project`）；默认输出「tokenized identifiers」（确定性假名≠匿名化的诚实声明）；--reveal-identifiers 才显受控字段名。
- **可移植做法**：W2 分级工作流的机制蓝本：①四层能力分层直接映射 light/medium/heavy——每渠道一张能力矩阵（自动核心=API 稳定端点；自动可选=需登录态/限流；参考=人工流程；不支持=黑名单/fail closed），conductor 出队时按任务档位过滤渠道；②capability registry（可 inspect 单文件的机器可读清单）接到渠道注册表，完备门可程序化读；③ 64MiB/原子写/--force 契约并入渠道采集脚本的 I/O 纪律。
- **质量评价**：真好。「No automated row below implies exhaustive semantic validation」的反过度声明贯穿。测试 2 文件。

## 22. markitdown（v2.2，K-Dense，有测试）

- **一句话定位**：微软 MarkItDown 0.1.6 的包装技能：异构文档→markdown（面向索引/RAG 而非高保真排版）。
- **核心机制**：**Choose the Right Path 路由表**（本地文件 convert_local/字节流 convert_stream/远程先自查再 convert_response/扫描件 OCR 插件/需要 bbox→改用 LiteParse/合并拆分→pdf skill）；extras 分装按需装（pdf,docx,pptx,xlsx vs audio/youtube/azure）；inspect_installation.py 自检。
- **数据契约**：路由表本身（需求→路径→工具）；无自有 schema（包技能）。
- **可移植做法**：W4 辅腿：①docx/pptx/xlsx 旧研报回灌弹药池时用 convert_local 转 md；②「选对解析器」路由表模式搬到 EPC100 文档 intake 决策（哪类文件走 liteparse、哪类走 markitdown、哪类走 pdf 工具）。
- **质量评价**：良。官方工具包装、本地可离线（URL/音频/Azure 腿除外——那些不用即符合免费红线）。测试有。

## 23. research-grants（v1.3，K-Dense，无测试）△ 保留/域错配

- **一句话定位**：NSF/NIH/DOE/DARPA/台湾国科会基金申请书写作指南（纯参考）。
- **核心机制**：机构化差异表（各机构 mission/页限/评审标准/预算规则）+ 组成件逐节指导 + 重投响应策略。
- **数据契约**：无脚本无 schema（assets 为参考模板性质）。
- **可移植做法**：仅一条：**「按资助方分档的评审标准差异表」**模式借给宣传三件的受众分层（公众号/知乎/头条各有隐含评分口径，可做成同构差异表）。基金写作本体与行业研报域错配。
- **质量评价**：保留。无脚本无测试；视觉腿依赖 OpenRouter 付费 API（触红线，同 scientific-critical-thinking）；对战场增量最低的 K-Dense 自家技能之一。

## 24. scientific-brainstorming（v1.2，K-Dense，有测试）

- **一句话定位**：证据感知的科学 ideation 主持流程：独立生成先于交流、全程五标签、不自动选赢家。
- **核心机制**：活动分离律（ideation/证据评估/假设验证/伦理审查/临床建议互不越界）；7 条操作规则——标签制 `idea|assumption|prediction|located evidence|decision` 不许混；**先独立后曝光**（面对面轮转会阻塞产出、示例会锚定）；保留少数派/弃权；**评分前先定标准与方向**；文献检索放在首轮独立生成之后并重开 ideation（防锚定也防把检索不全当研究空白）；不自动选 winner（分数是可追溯决策辅助）。
- **数据契约**：idea 记录 schema（照录）：稳定 ID+一句话陈述/贡献者 ID+阶段 `independent|discussion|post-check`/**origin `human|AI-assisted|literature-inspired|mixed|other`**/假设/预期观察/不确定度/可能反证/文献 source IDs/AI 工具披露。
- **可移植做法**：①W8 选题简报 schema：idea 记录字段表（ID/stage/origin/assumptions/disconfirming evidence）直接作为选题池条目结构——比现无 schema 的选题流立即可用；②「独立生成先于曝光」接到 Jev/Laya 判断前：多渠道证据汇总先各自独立初判再合议（防渠道间锚定）；③「origin 标注」接到弹药池（每条弹药记是人采/机采/文献启发，Manus 军团产物自动标 AI-assisted）。
- **质量评价**：真好。「创造力方法不必然改善原创性」的证据边界声明很克制。测试有。

## 25. uncertainty-and-units（v1.1，K-Dense，有测试）★ 工程气质

- **一句话定位**：物理单位追踪+测量不确定度传播（pint/uncertainties/GUM），专治「跑起来不报错且给出貌似合理的数」。
- **核心机制**：11 条 non-negotiable（单位在输入端挂、只在输出端剥、函数边界转换；测量模型先显式写出含零估计修正；每个输入四元组=估计值/标准不确定度/分布/自由度；Type B 除数规则；先辨相关性；灵敏度系数读预算；**GUM 线性化用 Monte Carlo 旁证（JCGM 101 条款 8）**；k 从有效自由度；先舍入不确定度再对齐数值；±必须声明含义；**报告前量纲合理性 sanity check**）。
- **失败目录**（照录）：`.magnitude` 在未知量纲上剥单位；offset 温度须 delta_ 单位；dBm 直接相加得荒谬量纲；序列化往返摧毁相关性（x-x=0±0）；absolute_sigma 缺省静默重标协方差。
- **可移植做法**：①EPC100 数字门：终稿数字核查腿加「量纲/量级合理性」检查——研报里「装机容量 GW vs 万千瓦」「投资额亿元/万美元」口径错与量级错正是此类静默失败，规则化成 lint（口径单位显式声明+量级与已知特征尺度比对）；②±和区间口径规范（k 值/覆盖概率/方法必须声明）接到市场预测章的区间话术统一；③失败目录的写法（每个失败给可运行反例）值得作为 EPC100 内部 hazard 文档的文体标准。
- **质量评价**：真好。本仓对工程研报战场气质最合的技能之一。测试有。

## 26. folklore-variant-evidence（v1.0，第三方 Helena Bio，无测试）域外/借契约

- **一句话定位**：单一 GRCh38 变异→结构化公共证据+ACMG/AMP 决策支持的托管 MCP 技能（基因领域，无 key 免费）。
- **核心机制**：输入边界（只收一个公共变异标识，拒患者语境）；**六态结果枚举 `resolved|ambiguous|not-found|invalid|unsupported|unavailable`**——ambiguous 要人工选、**「工具调用失败必须保存为 availability 问题，不得重释为无证据」**；tools/list 现场核验目录而非信模型记忆。
- **数据契约**：六态枚举 + canonical_key 回链 + provenance（source URL/date/snapshot）。
- **可移植做法**：六态枚举接 conductor 渠道账本：渠道回包应区分「查无此数据」与「服务不可用/被拦」——完备门过账时二者含义完全不同（前者可结案后者须补采）。这与本地 metaso 漂移经验（漂移≠无数据）完全同构，值得落成账本字段级规范。
- **质量评价**：良好但域错配（基因变异）+托管第三方服务依赖（免 key 但外发查询）。本体不引入；契约模式白拿。

## 27. liteparse（v1.2，K-Dense，有测试）★ W4 主腿

- **一句话定位**：本地布局感知文档/PDF 解析：per-token bounding box JSON + OCR + 页面栅格，无云 API。
- **核心机制**：何时用/何时不用路由表（markdown 摄取→markitdown；合并拆分→pdf skill；稠密表格/手写/生产云管线→LlamaParse）；CLI `lit parse`（--format json/--no-ocr/--target-pages "1-5,10"）；字节/stdin 入口；批量文件夹摄取。
- **数据契约**（照录）：JSON 每页 `text_items[]`：item.text/item.confidence/item.font_name/item.font_size/item.x/item.y/item.width/item.height；output_formats.md 全量字段；页面可渲 PNG 供多模态。
- **可移植做法**：W4 PDF/文献结构化解析的主实现：①研报/文献 PDF→bbox JSON，引用可钉到**版面坐标**（对齐 Paperclip 式行级钉引思路），弹药入库带定位；②页面 PNG 渲染给视觉复核腿（图表页转图给 vision 判断，配合 W3）；③--target-pages 做大 PDF 抽查页采样（符合「有界」纪律）。Apache-2.0、本地免费，符合红线。
- **质量评价**：真好。Rust 核心+Python 绑定，pin 2.0.0。测试有。

## 28. ontology-term-resolution（v1.2，K-Dense，有测试）

- **一句话定位**：自由文本→本体 term ID 的解析与校验：「**永不凭记忆写 ID，也永不未经核验就接受 ID**」。
- **核心机制**：规则（形似实非的 UBERON:0002108 是小肠不是肝，下游无人能catch）；服务分工表（OLS 定谳/Bioregistry 查前缀/ZOOMA 提议 OLS 决定）；检索阶梯 `exact(label/synonym)→token→fulltext` 首中即停并报告命中策略；**match_type 必读**（exact_label/exact_synonym 安全、partial=OLS 对不存在字符串的最佳猜测须人裁、unresolved 合法）；validate 检 obsolete→replacement；退出码 1=有失败 2=网络/用法错→**可直接当 CI 门**。
- **数据契约**：resolve_terms.py 输出列（query/rank/curie/label/ontology/match_type/strategy/defining_ontology）；validate_terms.py 输出列（id/status/actual_label/ontology/replacement/detail）；--input 批量 + --strict + --branch 限定子树。
- **可移植做法**：①引用/标识核验门：DOI/标准号/法规条号与本体 ID 同病（「格式对、看着像、实际错」）——把「产出即查证、批量 --strict、obsolete→替代」模式接到研报引用清单自动核验（配合 paper-lookup 的 DOI 解析）；②行业分类码/国标代码同构（研报里的 GB/T 4754 行业代码可做本地枚举表+同样的 strict 校验）；③「凭记忆写 ID=错」写进渠道采集纪律（端点/参数不许凭记忆，须读 references）。
- **质量评价**：真好。stdlib-only、公共 API 免 key。测试有。

## 29. pathml（v1.2，K-Dense，有测试）域外

- **一句话定位**：计算病理（全切片图像）本地研究工作流包技能。
- **核心机制**：安全边界（PHI/去标识/按患者切分）+版本考古：PyPI 3.0.5 vs GitHub 3.0.6/3.0.7 漂移实录、无 Requires-Python 声明须实测、**上游 GPL-2.0 与本技能 MIT 的许可分层警示**。
- **数据契约**：h5path 数据管理约定；无通用 schema。
- **可移植做法**：版本考古+许可核查清单模式（PyPI/Release/ReadTheDocs 三源对账）借给渠道工具引入流程——opencli/调研 CLI 四件套引入时同构核验。
- **质量评价**：真好（域内）但域外；对战场仅方法论可借。

---

## 跨技能共性模式（模式级发现）

**P1. 双账本 + 行内绑定 + 确定性本地审计 + 人工放行（四件套）**
出现于 market-research-reports（S/C 账本）、scientific-writing（E/C/N/M/O/R+`[claim:]` 行内标注）、clinical-reports（fact manifest+SHA-256）、peer-review（claim_evidence_matrix）、hypothesis-generation（evidence_ledger+search_boundary）。共同点：ID 体系稳定、审计脚本 stdlib-only 确定性可重跑、**放行权永远在人/门**（submission_ready 只有人能置 true；READY_FOR_LOCAL_REVIEW 才放行）。这是「机器管一致性、人管判断」的干净分层——EPC100 后置链可以直接拷骨架：渠道账本（已有）+ 弹药账本（已有）之间补 claims_ledger 与行内绑定语法，终稿审计从「人读」变「脚本对账+人抽查」。

**P2. 状态机枚举 + fail closed + 「缺失不折算」**
arbor `{pending,running,executed,merged,pruned,root}`；folklore 六态 `resolved|ambiguous|not-found|invalid|unsupported|unavailable` 且「失败≠无证据」；scholar-evaluation 三态 `rated|missing|not_applicable` 且不许编码为 0；EDA 第四层 Unsupported=fail closed；pptx-posters manifest 故意无效直到全部解析。共性：**每个技能都把「没拿到」细分为多种含义并禁止静默降级**。conductor 完备门最该吸收这条：渠道过账状态从「done/未 done」细化到「无数据/不可用/被拦/超时」，静默缺席才真正可判。

**P3. hazard 文档化：把「会在 200 里失败」写成资产**
paper-lookup 每库 references 附 quiet-failure 节+paginate exit 4「走完但少记录」；uncertainty-and-units 给每个静默失败配可运行反例；statistical-analysis 记版本坑（ArviZ 默认 89%、单侧 BF 静默丢列）。与本项目 metaso 端点漂移、laya 信封坑的应对经验完全同构。可移植做法：把「渠道 references 文件 + 已知漂移/hazard 节 + 语义化退出码」定为 EPC100 渠道文档标准格式，漂移处置知识入档而非散在 memory。

**P4. dev/test 双评估器 + 内容哈希绑定批准**
arbor：E_dev 随便用、E_test 只在 merge gate、dev 赢 test 输=过拟合警告；pptx-posters：批准绑定 manifest 内容哈希、任何编辑使批准失效。共性：**「胜出」必须过一扇搜索过程没碰过的门；「批准」是内容指纹的函数不是时间戳的函数**。LayaForge E1/E2/E3 三门已是前者实例（可补 arbor 的树形试验组织与洞察上传播）；W6 应直接采后者。

**P5. 能力分层矩阵 + 机器可读注册表 + 路由表**
EDA 四层能力矩阵+capability_manifest.py；markitdown「Choose the Right Path」；liteparse「When Not to Use」；ontology 服务分工表。共性：**不假装全能——每格式/每需求显式声明支持深度，不支持的 fail closed 并指路**。W2 分级工作流照此把 17+ 渠道做成档位矩阵（自动核心/自动可选/参考/黑名单），conductor 出队可程序化消费。

## W1-W9 覆盖一行表

| 空白 | 覆盖 | 来源技能与要点 |
|---|---|---|
| W1 报告样式门 | **强** | venue-templates（compliance note+validate_format+「helper 不能证边距」诚实边界）+ scientific-visualization（publisher_profiles 快照） |
| W2 分级工作流 | **强（同构）** | exploratory-data-analysis（四层能力矩阵+机器可读注册表+fail closed） |
| W3 出版级图表 | **强** | scientific-visualization（provenance 侧车+palette_audit+image_metadata 查交付物）+ pptx-posters + matplotlib（参考层） |
| W4 PDF/文献结构化解析 | **强** | liteparse（per-token bbox+OCR+页面栅格+页子集）+ markitdown（路由+通用转 md） |
| W5 多 worker 编排契约 | **中强** | arbor（executor-brief+4 字段返回契约+worktree 隔离+假设绑定禁漂移）；缺多协调者联邦，单协调-多执行模式可先用 |
| W6 交付物可用性验收门 | **最强** | pptx-posters（内容哈希绑定批准+包安全检查）+ clinical-reports（fact ID 才能填字段+SHA-256 值哈希+DRAFT 冻结）+ scientific-writing（submission_ready 人工门） |
| W7 学术检索聚合 | **强但中文缺口** | paper-lookup（18 API 路由+hazard 文件+count 对账）；无中文库，cnki 外的中文源须自建同构 |
| W8 选题简报 schema | **中** | scientific-brainstorming（idea 记录：ID/stage/origin/假设/反证）+ hypothesis-generation（search_boundary 记录「查过什么没查到」） |
| W9 三新件未实施 | **全覆盖** | 校准=scholar-evaluation（weight_sensitivity+排序不稳性+三态评据）；快照=venue-templates compliance note+各技能 verified-on-date 版本基线表；红队=hypothesis-generation（rival 矩阵+因果 lint）+ peer-review（规则 ID lint+双通道） |

## 诚实纪律汇总（负面/保留名单）

明确负面 1 个 + 保留 5 个 + 平庸 1 个 = 7/29 ≈ 24%（达标 ≥20%）：

1. **bgpt-paper-search（负面）**：商业 MCP 绑定（$0.01/结果，违免费优先红线）、75 行薄文档、无 schema 无脚本无测试、「25+ 字段」不可验证。第三方混入件的质检样本。
2. **markdown-mermaid-writing（保留）**：自称 enforce 无任何执行机制（无 lint/无脚本/无测试），纯风格文档；参考价值（24 图型映射）真实。
3. **research-grants（保留）**：域错配（基金申请）+ OpenRouter 付费依赖（触红线）+ 无脚本无测试。
4. **scientific-critical-thinking（保留）**：纸面参考无执行件；OpenRouter 付费依赖同上；价值仅 GRADE 降级表与谬误清单（抽 references 即可）。
5. **networkx（平庸）**：无脚本无测试，与已有证据图谱工程增量小。
6. **vaex（平庸）**：无脚本无测试、上游维护弱、战场无关。
7. **matplotlib（平庸偏良）**：教科书内容，战场增量小，被自家 scientific-visualization 覆盖。

另注（仓级观察）：①每个 SKILL.md 末尾强制重复同一段 arXiv 引用说明（29×14 行），营销噪音真实存在；②「无 scripts 即绕过测试门」是仓规漏洞——本清单 7 个无测试技能全部恰好没有 scripts；③bgpt/folklore 等第三方技能与 K-Dense 自家技能质量差距明显，引入该仓时应优先取 skill-author=K-Dense Inc. 的条目；④所有抽查脚本（paginate/tree/audit_claim_citations/lint_causal_claims）均为真实现，文档-脚本耦合紧，**未发现纸面设计（文档有脚本缺/脱节）个案**——本仓的脱节形态是「无执行件的纯文档技能」而非「文档超前于脚本」。
