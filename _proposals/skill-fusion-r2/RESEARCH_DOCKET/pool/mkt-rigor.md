# T1 提取报告：marketingskills / rigorpilot / awesome-claude-skills / riekelt-technical-writer（27 技能）

- 提取员：mkt-rigor（T1 清单四节）
- 日期：2026-09-26；方法：SKILL.md 全读 + 关键 references/scripts 抽读（脚本读头部核工程性）+ 仓 README 架构理解
- 仓根：
  - `vendor/skillsweep/marketingskills`（Corey Haines，MIT，~40 技能，product-marketing 上下文文件为全网基座；每技能带 evals/evals.json；有 Partner 赞助治理）
  - `vendor/skillsweep/llllllllama-rigorpilot-skills`（RigorPilot，MIT，9 技能+shared/scripts；本地回归 80/80；外部复现套件 4/4）
  - `vendor/skillsweep/awesome-claude-skills`（ComposioHQ 精选；composio-skills 子目录全部绑 rube.app MCP）
  - `vendor/skillsweep/riekelt-technical-writer`（11 技能一核十专；两个 subagent + 两个 slash command；单测试文件）

---

## A. llllllllama-rigorpilot-skills（9，本组重点）

架构：一个大脑（ai-research-reproduction 持 references 共享原则库）+ 八个叶子技能。每个技能 SKILL.md 都有「When to apply / When not to apply / Clear boundaries / Input expectations / Output expectations」五段式，职责边界零重叠（路由即契约）。所有叶子引用 `../ai-research-reproduction/references/agent-operating-principles.md` 作为共享操作原则——技能间引用走相对路径，形成 DAG。

### A1. ai-research-reproduction（主入口，评分最高的单技能）
- **一句话定位**：README 优先的深度学习仓库复现编排器——选出最小可信目标，有界执行，证据落盘，fail-closed。
- **核心机制**：Fast Path 5 步（plan-only 出候选 → 带 plan fingerprint 执行指定 cmd-XX → verify-output → 交付即停）；信任目标四级选择（documented inference → evaluation → training startup/partial → full training 须用户显式确认）；Patch Boundary（优先命令行/env/依赖修复而非改码；必须改则开 `repro/YYYY-MM-DD-short-task` 分支 + PATCHES.md 记录 README 保真度影响）。
- **数据契约**（本组最高价值，照录）：
  - 输出包 `repro_outputs/`：`SUMMARY.md / COMMANDS.md / LOG.md / SCIENTIFIC_CHANGELOG.md / COMPARABILITY_REPORT.md / status.json / ANNOTATED_README.md / PATCHES.md`
  - `status.json` 键（节选）：`schema_version, selected_goal, goal_priority, status, documented_command_status, documented_command_id, documented_command_kind, selection_fingerprint, command_candidates, execution_mode, stage_results, observed_metrics, best_metric, result_match, patches_applied, readme_fidelity, highest_patch_risk, evidence_level, assumptions, unverified_inferences, protocol_deviations, human_decisions_required, next_safe_action, artifact_provenance, verified_commit_count`
  - 枚举：status=`success|partial|blocked|not_run`；evidence_level=`direct|mixed|inferred`；result_match.status=`matched|mismatched|not_evaluated`（matched 须显式期望指标+容差；只有 observed metrics 一律 not_evaluated）
  - 运行时状态机：`created -> running -> success|failed|timed_out|cancelled|blocked`，恢复追加 `interrupted|orphaned`；重试新建 run 带 `retry_of`+`attempt` 不覆盖旧证据；每个命令持久化 `_runtime/<run_id>/{spec.json,state.json,events.jsonl,resources.jsonl,stdout.log,stderr.log}`；空 `CANCEL` 文件即取消信号
  - **plan fingerprint fail-closed**：执行必须携带规划期指纹，README/命令集变了先失败而不是悄悄跑别的命令；setup/download 命令永远不可被选为目标
- **可移植**（3 条）：
  1. `result_match` 三态 + 「过程成功≠验收成功」直接焊到 W6 交付物可用性验收门：EPC100 后置链终稿出站前加一个独立 result_match 对象，expected 由选题简报/金标准给出，缺容差即 not_evaluated 不许放行。
  2. `_runtime/<run_id>/` 全生命周期证据目录（events.jsonl+stdout/stderr 完整保留、summary 只放截断尾部）接 conductor 渠道执行腿，替代现在"日志散落"的现状；重试不覆盖旧证据 = 只增不删红线的具体实现样板。
  3. plan fingerprint 机制接到 W5 多 worker 编排：Manus 军团下发任务时任务单带指纹，worker 环境里的命令集/渠道清单变了则 fail-closed，防"任务漂移后仍交货"。
- **质量**：真好的证据——orchestrate_repro.py 2516 行实存、README 自曝「standalone model runner 无成功 live-model 验收（三次 HTTP 502）」、外部套件 commit-pinned 且 0 API 调用；无单测目录但 tests/ 有 trigger_cases.json+readme_selection_cases.json 用例库。缺点：体量重（~2500 行编排器对一个"skill"而言），文档要求正常路径不读实现，上手成本高。

### A2. ai-research-explore（候选探索车道）
- **一句话定位**：显式授权后的候选级 DL 研究探索——campaign 冻结任务/数据/评测/预算，双循环节奏，产出绝不冒充可信成果。
- **核心机制**：双循环（外循环=理解仓库/冻结/想法门控；内循环=单变量候选→smoke→证据→排名）；lane 安全（须 explicit authorization + durable `current_research` 锚点）；lookup 源解析优先级：本地 Zotero → seed sources → repo-local locators → public locators → 可选 web。
- **数据契约**：campaign 核心七字段 `current_research, task_family, dataset, benchmark, evaluation_source, sota_reference, compute_budget`（其余 candidate_ideas/variant_spec/idea_policy 等全是可选）；lookup 记录 schema（record_schema.py 照录）：`source_type, provider_type, locator_type, raw_locator, normalized_id, title, url, authors, year, venue, repo_full_name, doi, arxiv_id, evidence_class, evidence_weight, resolved_at, cache_hit, parse_status, fetch_status, provider_metadata, source_repo, source_file, source_symbol, origins, extracted_from_repo_paths, selection_hints`；evidence_class 优先级 `seed_only(0) < repo_local_extracted(1) < parsed_locator(2) < external_provider(3)`；想法硬门：`baseline gate ≠ abandon, single_variable_fit≥0.6, interface_fit≥0.5, patch_surface≤0.7, dependency_drag≤0.7, eval_risk≤0.6, short_run_feasibility≠blocked`，软排名正贡献（expected_upside/rollback_ease/innovation_story_strength…）负贡献（implementation_risk/eval_risk/patch_surface…），每张 ranked card 记录每字段 provenance。
- **可移植**：①campaign 七字段即 W8 选题简报 schema 的现成骨架（task_family→行业赛道，evaluation_source→验收口径，compute_budget→调研预算）+ 想法硬门/软排名直接是选题漏斗的量化门；②evidence_class 四级+evidence_weight 接弹药池 GRADE 分级作细化维度（把"来源等级"从渠道级下钻到记录级）；③「冻结 evaluation_source/sota_reference，不许默默换尺子」= ACH 假设对抗的固定基线纪律。
- **质量**：真好——orchestrate_explore.py 2521 行 + passes/ 九个阶段脚本齐备，lookup providers 可插拔（arxiv/doi/github/url + optional）；同样偏重。

### A3. analyze-project
- **一句话定位**：只读仓库审计——结构/入口/config 关系图 + 可疑实现模式标记。
- **机制**：read-mostly；可疑模式标 heuristic 不标 confirmed bug。
- **契约**：`analysis_outputs/{SUMMARY.md, RISKS.md, status.json}`。
- **可移植**：RISKS.md 的「启发式≠证实缺陷」分级接到渠道逆向 channel_reverse 的风险登记；对上游开源调研渠道（opencli 等）入库前跑一遍只读审计。
- **质量**：单脚本 analyze_project.py 在位；薄但边界清晰，中上。

### A4. explore-code
- **一句话定位**：隔离分支上的候选代码移植/改造叶子（模块移植/backbone 适配/LoRA 插入）。
- **机制**：source-anchored 拷贝优先于自由重写；必须记录为何是候选而非已验证贡献 + 回滚方式。
- **契约**：`explore_outputs/{CHANGESET.md, SCIENTIFIC_CHANGELOG.md, COMPARABILITY_REPORT.md, TOP_RUNS.md, status.json}`。
- **可移植**：COMPARABILITY_REPORT（比较边界声明）模板接 EPC100 研报「口径变化披露」节——数据口径/样本窗变了必须显式声明不可直接比较，接饱和引擎。
- **质量**：plan_code_changes.py 在位；与 explore-run 输出契约完全同构（好复制），中上。

### A5. minimal-run-and-audit
- **一句话定位**：单命令执行+证据归一化报告腿（smoke/inference/evaluation）。
- **机制**：命令标注 documented/adapted/inferred 三级溯源；「文档建议≠已执行命令」分离 provenance 与 execution。
- **契约**：输入四项（goal/runnable commands/env assumptions/patch metadata）；输出入 `repro_outputs/` 同包。
- **可移植**：documented/adapted/inferred 三级标注直接给 conductor 渠道账本用——每个渠道抓到的数据标"渠道原生/已适配/推断"，完备门过账时区分。
- **质量**：run_command.py+write_outputs.py 在位；中上。

### A6. run-train
- **一句话定位**：保守训练执行腿（startup verify/short-run/full kickoff/resume 四模式）。
- **契约**：`train_outputs/{SUMMARY,COMMANDS,LOG,SCIENTIFIC_CHANGELOG,COMPARABILITY_REPORT}.md + status.json`；保留 config/seed/checkpoint/log/metric 证据。
- **可移植**：四 run-mode 枚举对应 W2 分级工作流的 heavy 档内部分级；对 LayaForge 夜训管线（22:07 schtask）是现成的状态报告模板——status.json 的 partial/resumed/kicked-off 区分比现在的 train_log.json 更诚实。
- **质量**：run_training.py 在位；中上，与 A5 有轻微重复（设计如此：叶子可独立）。

### A7. env-and-assets-bootstrap
- **一句话定位**：conda 优先的环境与资产路径保守规划腿。
- **契约**：输出=环境笔记/候选 conda 命令/资产路径计划/未解决依赖风险（无固定文件名，弱于兄弟技能）。
- **可移植**：「missing conventional directories alone 不证明缺资产」这条防误判纪律（output-spec 里也有）接渠道健康检查——渠道 404 不等于渠道死亡，须区分"探针失明"与"真死"（与 Manus 区域墙 urllib 探针失明教训同构）。
- **质量**：四脚本在位但输出契约最松；中。

### A8. explore-run
- **一句话定位**：有界探索执行计划腿（小_subset 验证/短周期 guess-and-check/批量 sweep）。
- **契约**：`variant_axes`（候选维度网格）、`subset_sizes`、`short_run_steps`、`selection_weights`（cost/success_rate/expected_gain 三因子，默认保守）、`primary_metric`+`metric_goal`；预执行排名=启发式，跑过后必须切换到真实证据排名。
- **可移植**：cost/success_rate/expected_gain 三因子加权排名接 conductor 出队优先级（现在 7min tick 的 FIFO 可升级为该评分）；「跑过后禁继续纯启发式排名」接自复盘。
- **质量**：plan_variants.py 在位；中上。

### A9. safe-debug
- **一句话定位**：traceback/CUDA OOM/NaN loss 的保守诊断腿——先诊断后补丁，人批后才动码。
- **契约**：`debug_outputs/{DIAGNOSIS.md, PATCH_PLAN.md, status.json}`。
- **可移植**：DIAGNOSIS→PATCH_PLAN 两段式（诊断与修法分离+显式审批门）接 LayaForge/渠道栈的故障处理 SOP；「debug 修复≠研究贡献，若改实验含义必须声明」的思想映射到「修渠道≠调研进展」。
- **质量**：safe_debug.py 在位；薄但干净；中上。

**rigorpilot 总评**：本组工程含金量第一。九技能全部脚本在位、无文档-脚本脱节；README 诚实披露未验收项（model runner 502、A/B uplift 未跑）；CI validate + 本地回归 80/80。风险：复杂度高，全盘移植等于引入一个小框架——应择机制移植（fingerprint/result_match/runtime 目录/七字段 campaign），不是整体安装。

---

## B. marketingskills（9）

### B1. competitor-profiling
- **一句话定位**：竞品 URL → 结构化可比画像（抓取+SEO 数据+评论三阶段）。
- **核心机制**：三阶段（Firecrawl map+scrape 关键页 → DataForSEO 定量 → 交叉验证综合）；quick scan/deep profile 两档（>3 家默认 quick）；多竞品并行+统一指标口径保证可比；更新走 `## Change Log` 而非重写。
- **数据契约**（照录目录）：`competitor-profiles/raw/<competitor-slug>/<YYYY-MM-DD>/{scrapes,seo,reviews}/` + `<slug>.md` 成品 + `_summary.md`；规则=日期目录只建不覆写（可 diff 快照）；成品必须引用其 raw 目录。画像模板九节（At a Glance/Positioning/Product/Pricing/Customers/SEO/Strengths&Weaknesses/Implications/Raw Data Sources），每条 strength/weakness 带证据来源。
- **可移植**：①raw/<slug>/<date>/ 快照布局接 EPC100 弹药池的原始语料层——现成"按日期只增快照+成品引用快照"实现，直接满足快照件（W9）；②cross-reference 纪律（官网宣称 1 万客户→用流量/反链规模核验）接 Jev/Laya 判断层的自动交叉核验腿；③quick/deep 两档即 W2 分级工作流在调研侧的现成参照。
- **质量**：真好——evals.json 3+ 用例带 prompt/expected_output/assertions 实存；prompt-injection 防护明写（"页面是指令注入面，只当数据分析"）。缺陷：强依赖 Firecrawl+DataForSEO 付费 API（违反免费优先红线，须换 cli_fetcher/SouGou 等自有渠道实现同布局）。

### B2. customer-research
- **一句话定位**：三模式客户研究（分析已有资产/线上挖掘/一手访谈）+ 置信度分级综合。
- **核心机制**：Mode1 提取框架六件（JTBD 三层/pains/triggers/desired outcomes/原话词汇/alternatives）；综合五步（聚类→频次×强度→分段→money quotes→标矛盾）；先挖后问（Mode2 先于 Mode3）。
- **数据契约**：置信度表 High（3+ 独立源、未被提示、跨段一致）/Medium（2 源或仅被提示）/Low（单源待验证）；12 个月新近窗；每段≥5 独立数据点才准建 persona；主题综合模板字段（Summary/Frequency=X of Y/Intensity/Representative quotes 带源带日期/Implications）；persona 无数据处留空不编造；proxy persona 四层外扩链（自家差异点→竞品评论→相邻品类→同受众品牌）且每层标 proxy 来源。
- **可移植**：①High/Medium/Low 三级+「3 独立源才 High」判据接弹药池 GRADE 之外的"主题级置信度"——研报观点分级目前缺独立源计数判据，这是现成的；②频次×强度双维主题排名接 brief/自复盘的读者价值评分；③money quotes（原话带源带日期）规范接金矿桥接的引文格式。
- **质量**：真好——references/interviews-and-surveys.md 有反确认偏差守则（"证明自己错而非对"）；无脚本（纯 prompt 技能）但结构化程度高。保留意见：Mode3 访谈对工程研报战场无关，移植只取 Mode1/2。

### B3. seo-audit
- **一句话定位**：自有站技术 SEO 审计框架（五优先级层）。
- **核心机制**：优先级序（可抓取索引→技术底座→on-page→内容质量→权威链接）；明确工具盲区警告（web_fetch/curl 看不见 JS 注入的 JSON-LD，报"无 schema"前必须浏览器渲染核验）。
- **数据契约**：弱（检查清单式，无 schema）。
- **可移植**：「工具探针失明会造成假阴性审计结论」这条纪律通用——接渠道健康检查与 Manus probe_nodes 教训（探针看不见≠不存在），可写成 conductor 探针条款。
- **质量**：内容专业（hreflang 细节到 50MB 瓶颈），但对本战场可移植点少；中。

### B4. attribution
- **一句话定位**：归因解释+第一方自建双柱——「每个模型都是一种意见」的诚实归因框架。
- **核心机制**：六模型对照表每行带"它如何撒谎"；三测量范式（MTA/MMM/incrementality）按预算×周期选型；冲突数字调和五步（先定 conversion 唯一真源→跨平台永不求和→只读方向一致→self-reported 仲裁→预算化解释 gap）；盲点清单（direct/branded search/dark social/AI traffic）。
- **数据契约**：Attribution Readout 输出模板（The question/Source of truth/What each source says 表/Model comparison/Confidence & gaps/Recommendation）；CRM 落字段 `source + confidence + basis(journey-linked|self-reported|campaign-window fallback)`。
- **可移植**：①「多源各报各数→永不跨源求和→方向一致即可信」的调和协议正是 EPC100 多渠道数字打架时的现成仲裁规则（不同渠道对同一行业规模给出冲突数字时）；②`basis` 三态（实证链/自报/窗口兜底）给 GRADE 加一个"数字怎么来的"溯源字段。
- **质量**：真好——文案级诚实（"我们给你可辩护一致的数字，不给唯一真数"），references 四篇配套；无脚本；对本战场取思想不取工具。

### B5. prospecting
- **一句话定位**：ICP → 经资格评分的线索表（四分支：SaaS/B2B/本地 SMB/需求信号）。
- **核心机制**：五阶段共享框架（定义 ICP→2-3 倍超额建候选池→逐个资格核验带证据 URL→Hot/Warm/Cold/Skip 评分→出表+Top targets）；demand-signal 分支=找早期客户时"证据引用优先于公司画像"。
- **数据契约**：lead sheet 必含列 `score, business, contact, why-it's-a-prospect, source(s), confidence, last verified date`；置信度 High=两独立源或官方页 / Medium=一可信源+一致佐证 / Low=存疑并标不确定项；八条合规护栏（无批量抓取/无验证码绕过/保留来源 URL+日期/GDPR…）。
- **可移植**：①「每条资格判定必须附证据 URL×1-2，never assert without backing」接完备门——渠道逐条过账时每渠道一条证据链接；②last verified date 列接渠道账本的新鲜度字段；③合规护栏与账号安全四件套（节流/冷却/限额/熔断）同构，可互查补漏。
- **质量**：真好——demand-signals.md 把"早期需求发现"从列表覆盖转向证据密度，与弹药门槛"有效性判断通过才计数"同构。依赖 Apollo/Clay 等付费源但明示免费+浏览器降级路线。

### B6. ai-seo
- **一句话定位**：让 AI 引擎引用你的内容——平台分治 + 可抽取性结构 + 引用/推荐阶梯。
- **核心机制**：Google 官方立场（别为 AI 分块写内容）vs 其他引擎（奖励可抽取结构）双轨；query fan-out（覆盖 topical cluster 而非单页单词）；引用阶梯四级（Retrieved→Cited→Mentioned→Recommended）+ 影子级 recommended-against——「被引用≠进推荐名单，推荐由全网共识决定」。
- **数据契约**：AI visibility 审计表（query×平台×cited?×竞品 cited?）；extractability 十项检查表（首段定义/自含答案块/带源统计/对比表/FAQ/schema/作者资质/6 个月内更新/标题匹配查询模式/AI bot 放行）；OKF（Google Open Knowledge Format）知识包：YAML frontmatter（type 必填，title/description/resource/tags/timestamp 建议）+ markdown 正文 + 互链 + 可选 index.md。
- **可移植**：①引用阶梯四级直接接 WeAIPO 自媒矩阵的效果度量——宣传三件之后衡量"被 AI 检索/引用/提及/推荐"四层而非只看阅读量，recommended-against（被点名劝退）尤其值得监控；②OKF 知识包格式接调研语料的对外发布层（研报 md → agent 可读 bundle），也是内部知识库（05 智库）的互链审计副产品；③「自含答案块+带源统计+明确日期」结构规范接 W1 报告样式门的 AI 可读性子项。
- **质量**：真好且新知密度高（69% 自夸榜单引用反把买家推给竞品的数据；OKF 诚实定级为"协议层下注，当下无爬虫收益"）。v2.5.0 维护勤；无脚本。

### B7. content-strategy
- **一句话定位**：内容选题规划——searchable/shareable 双轴 + 内容即产品。
- **机制**：hub-spoke 结构建法、use-case 公式（persona+use-case）、打分排序（此处未读到打分公式全文）。
- **可移植**：searchable（接存量需求）vs shareable（造新需求）二分接 EPC100 选题双轨——行业研报=searchable 主轴，方法论文章=shareable 主轴，选题漏斗分轨评分。
- **质量**：平庸偏上——框架清晰但通用管理学味道浓，对本战场可取的就是双轴一招；无数据契约无脚本。

### B8. copy-editing
- **一句话定位**：七遍扫改稿法（每遍只查一个维度，遍间回看）。
- **机制**：Sweep1 Clarity → 2 Voice/Tone → 3 So What → 4 Prove It → 5 …（后续遍含具体性/结构/语法类）；「So What 测验」每句追问所以呢；「Prove It」每断言要证据。
- **可移植**：七遍扫= W1 报告样式门的轻量执行器——终稿后置链加一个多遍单维度审校 pass（尤其 Prove It 遍：每条数字断言回查弹药池出处），比一把梭审校漏检低。
- **质量**：中——纯 prompt 技能无脚本无 schema，但「分维多遍+遍间回看」是可取的审校工艺；与 riekelt reviewing-technical-prose 相比是浅版。

### B9. sales-enablement
- **一句话定位**：销售物料工厂（10-12 页 deck 框架/单页/异议库/demo 脚本）。
- **机制**：deck 11 节叙事弧（问题→代价→变局→方案→走查→证据→案例→实施→ROI→价格→CTA）；按买家类型三叉（技术买方/经济买方/champion 各自强调什么）。
- **可移植**：11 节 deck 弧 + 买家三叉表接宣传三档的"深水区"档——研报改写成对客户的 pitch 材料时直接套；「销售只信销售用过的东西=终端验收」思想接 W6。
- **质量**：中——模板熟套，无 schema 无脚本；对非销售战场价值有限。

**marketingskills 总评**：文档工程一流（每技能 evals.json+版本号+触发词超长 description+互链 Related Skills），但全仓零脚本（除仓级 validate 脚本），纯知识型技能；付费工具依赖普遍（Firecrawl/DataForSEO/Apollo），移植须换免费渠道实现。B1/B2/B4/B5/B6 五个是真金。

---

## C. awesome-claude-skills（7，ComposioHQ 精选）

### C1. content-research-writer
- **一句话定位**：人机协作写作伴侣（大纲/引用/hook/逐节反馈）。
- **机制**：8 步协作流（理解项目→协作大纲→调研加引→改 hook→逐节反馈→保声线→引用管理→终审）；文件布局 outline/research/draft-vN/final/feedback 分离。
- **可移植**：research.md 与 draft 分离 + draft-vN 版本化，接后置链排版回归的"改稿可追溯"小招。
- **质量**：**平庸（负面样本）**——无脚本、无门、无 schema，全是示例对话；示例引用"[needs source]"自己都标不出处；号称 research 实则全靠模型自由检索无渠道纪律。与本仓 ZBBrain-Write/MetaArticle 同类且不更强。

### C2-C6. composio-skills 五件（ahrefs/hunter/semrush/apify/firecrawl-automation）
- **一句话定位**：五个商业 API 的 MCP 调用说明书（全走 rube.app 中间层）。
- **共同机制**：Setup（加 Composio MCP→连账号）→ Core Workflows（每工具 4-6 个：参数表+示例 prompt）→ **Known Pitfalls** → Quick Reference 表。
- **数据契约**：仅工具参数级（如 Ahrefs `target/date/country/mode/select/where`；Firecrawl `formats/onlyMainContent/waitFor/actions`）；无自有输出 schema。
- **可移植**：①**Known Pitfalls 段是唯一真金**——如「Ahrefs select 列必填且列名错即炸」「offset 已弃用改游标」「mode=subdomains 默认会爆量」「Hunter 空 results 不是错误」「Firecrawl credit 省用=先小集测试」——这些坑若未来接任何 SEO/抓取商业 API 都直接复用；②Quick Reference 工具速查表格式可借给渠道 CLI 登记簿（渠道名/工具 slug/必填参数一行表）；③「API unit 成本随列不同」的计量警示与 metaso 积分制纪律同构。
- **质量**：**保留意见（集体）**——绑死 Composio 商业中间层（rube.app MCP），违反免费资源优先红线，五个全部不可直接采用；且 Ahrefs/Semrush/Hunter 本体也是付费服务。作为"参数说明书"写得规范（pitfalls 实用、无假大空），但本质是厂商文档镜像，无独立工程。apify/firecrawl 两件若已有原生 API key 则比走 Composio 更符合红线。

### C7. lead-research-assistant
- **一句话定位**：ICP 匹配线索研究助手（fit score 1-10+触达策略）。
- **机制**：6 步（懂产品→定 ICP→找信号→打分→出结构化卡片→下一步）；强调"从代码库目录运行以自动理解产品"。
- **可移植**：输出卡片字段（Why fit/Priority Score/Decision Maker/Value Proposition/Conversation Starters）可裁给 EPC100 客户试点交付的"每家客户一卡"格式。
- **质量**：**平庸（负面样本）**——与 C1 同病：无脚本无渠道纪律，示例效果全凭模型发挥；与 marketingskills/prospecting 相比是粗糙前身，取 B5 弃 C7。

**awesome-claude-skills 总评**：7 件中 5 件商业绑定、2 件平庸。本组价值集中在 composio 五件的 Known Pitfalls 知识与"工具速查表"格式，不在技能本体。这与"ComposioHQ 精选"的名头形成落差——精选=生态推广位。

---

## D. riekelt-technical-writer（2）

（背景：本仓 11 技能共享一核 technical-writing，其 references/style.md=句法+禁用构造表、truth.md=主张溯源+置信分层+陈旧度规则。两 subagent：prose-reviewer 只读评审、doc-grounder 对码落盘校。）

### D1. writing-postmortems
- **一句话定位**：无责复盘写作法——事实出自证据、原因出自机制、教训出自两者、永不出人名。
- **核心机制**：时机门（事后或长事故事稳定点，不在事中写）；骨架固定（Summary→Impact 量化→Timeline 纯证据→Root cause+contributing→**Wrong turns during the response**→Action items→Sign-off）；「错误的第一次修复也是内容」；复盘一旦 Reviewed 即不可改，新发现=带日期的补遗（重写=伪造记录）；action item 无 owner 即违禁；near miss 用同骨架但 Impact 标记为反事实。
- **数据契约**：骨架字段照录（Incident date/Duration/Severity[按组织分类法，无则显式留空]/Status: Draft|Reviewed）；Sign-off 行格式 `- YYYY-MM-DD <reviewer>: approved <scope>`（append-only 审批日志，内容晚于最近签核=未过门）。
- **可移植**：①**Wrong turns 节直接接 EPC100 自复盘件（W9）**——现在自复盘只记成功路径，加上"哪个第一修复没生效、哪个误导信号耗了一小时"，红队/校准才有真实素材；②「复盘不可变+补遗制」接 RUN_LEDGER/工单的 append-only 纪律；③Sign-off 日志+「内容新于签核即 fail 门」可做成后置链出站闸的一环（终稿改动晚于终审=不得出站）。
- **质量**：真好——70 行写透一门手艺；prior-art 表逐条标注继承与分歧（MADR/Keep-a-Changelog/ASD-STE100/Zinsser/Wikipedia AI 写作征兆）；README 明言哪些是原创（claim 溯源置信分层/陈旧度规则/one fact one home 均声称公开无先例）。无自动化测试（仓级仅 repository.test.cjs），规则靠 agent 自律执行——这是全仓通病。

### D2. reviewing-technical-prose
- **一句话定位**：技术散文评审协议——严重度语法+发现格式+不许乱标记清单+交付检查表。
- **核心机制**：三级严重度 BLOCKER/WARNING/OBS（定义在使用它的报告内）；改写铁律「内容零增减——加了事实和丢了事实同罪」+三个控制问题（哪句还像模型写的/增删了什么事实/是否换修辞复现了刚删的模式）；**findings to leave alone** 反误伤清单（每个禁用模式在好的人类写作里也出现，多项征兆同段共现才可标）；评审报告格式（首行 verdict、按严重度排序、每条=一句话缺陷+位置 file:line+修法+置信度、**具名空态 "FINDINGS: none"**、复评只列剩余、须表扬好的）；交付检查表 16 项。
- **数据契约**：检查表关键项照录：无 em/en dash、无 changelog 节/last updated 字段、结论先行三级（文档/章/段）、**每个带数字的主张溯源到文内具名来源**、引用实地跟随核验（章号/相对链接/文件名真实存在）、术语一概念一名、remove-the-name test（删产品名陌生人仍知所云）、改写零增减。
- **可移植**：①**本组对 W1 报告样式门的最佳单件**——16 项交付检查表 + 三级严重度语法可直接改造为 EPC100 终稿出站门（对 docx 排版前的 md 终稿跑一遍：数字断言溯源核验+引用链接存在性+术语一致性），与现有排版逐字节回归互补；②「具名空态 FINDINGS: none」接完备门——渠道静默缺席必须显式记"缺席"而非留空；③反误伤清单思想接 Jev 判断层：单一征兆不判死刑，多项共现才触发。
- **质量**：真好——truth.md 的三态置信（Measured/Sourced/Estimated）+「written/shipped/externally verified 三态区分」+「[source wanted: …] 占位而不编造引用」是全文凭据纪律的范本；`第三方行为易腐：任何 vendor/API 断言带观察日期与 commit` 直接可用。缺陷：规则密度极高（style.md 禁用表 20+ 条），无 linter 落地（自己承认"可机检的才自动化"但仓里没做），全靠模型自觉——移植时应挑可机检项先落 grep。

---

## 跨技能共性模式（≥3）

1. **双车道信任分级（trusted/candidate 显式分离）**：rigorpilot 全家（可信复现默认、候选探索须显式授权、候选成果禁冒充可信成果、explore 与 baseline 状态隔离）↔ competitor-profiling（quick/deep 两档）↔ attribution（方向性非真理）。模式要点=①授权门②车道隔离③跨 lane 断言禁令。对 EPC100：W2 分级工作流 + 弹药池"有效性判断通过才计数"可借此把「调研深度档位」与「证据信任档位」两个正交维度一次定义清楚。
2. **raw-first 按日期快照落盘，成品引用快照**：competitor-profiles/raw/<slug>/<date>/（只建不覆写，支持 diff）↔ rigorpilot repro_outputs/_runtime/<run_id>/（重试新 run 不覆盖）↔ rigorpilot ANNOTATED_README（原字节保留+插入块可剥离还原，round-trip 校验）。对 EPC100：弹药池快照件（W9）与"只增不删"红线已有三个现成目录范式可抄，字节级 round-trip 思想还能给 md→docx 排版回归加一道"剥插入还原"校验。
3. **状态机+枚举+具名空态的机器可读结果契约**：rigorpilot status 枚举四态/evidence_level 三态/result_match 三态/stage_results 区分 success|blocked|notRequested（"规划了≠执行了"）↔ riekelt 「FINDINGS: none 具名空态」+ Severity 三级自定义于报告内 ↔ marketingskills confidence 三级带判据。对 EPC100：conductor 渠道账本与完备门可统一到这套语义——尤其 notRequested/not_run 与"静默缺席显式过账"完全同构。
4. **多源数字冲突的调和协议**：attribution 五步（定唯一真源→永不分平台求和→读方向→自报仲裁→预算化 gap）↔ customer-research（矛盾即标记：说的和做的冲突要显式记录）↔ rigorpilot（README 与论文冲突→记录冲突不静默择一）。对 EPC100：多渠道行业数字打架时现成仲裁 SOP，且与 GRADE 联动（冲突未决=降级）。
5. **探针失明≠事实不存在（工具盲区显式声明）**：seo-audit（web_fetch 看不见 JS schema，假阴性警告）↔ rigorpilot（"缺常规目录不证明缺资产"）↔ hunter pitfalls（空结果不是错误）。对 EPC100：渠道探活与 Manus probe 的通用纪律，可写进 conductor 探针条款。
6. **诚实披露文化作为质量信号**：rigorpilot README 自曝 502 未验收、riekelt 自称无先例部分仅是检索结论、ai-seo 给 OKF"当下无用"的冷静定级——三个高质量仓共享「先说做不到什么」。反面：composio 五件只说能做什么。选型时可把"自曝缺陷"当准入 heuristic。

## W1-W9 空白覆盖一行表

| 空白 | 覆盖 | 最佳来源 |
|---|---|---|
| W1 报告样式门 | **强** | riekelt reviewing-technical-prose 16 项交付检查表+三级严重度（次：copy-editing 七遍扫、ai-seo 可抽取性十项） |
| W2 light/medium/heavy 分级 | **强** | rigorpilot trusted/candidate 双车道+quick/deep 档+run-train 四模式 |
| W3 出版级图表 | 无 | 本组无图表技能（空白依旧，他组补） |
| W4 PDF/文献结构化解析 | 弱 | rigorpilot lookup=源解析非文档解析（arxiv/doi/github 记录级 schema 可用，PDF 解析无） |
| W5 多 worker 编排契约 | **强** | rigorpilot plan fingerprint fail-closed + agent-job 交接 + runtime run_id 状态机 |
| W6 交付物可用性验收门 | **强** | rigorpilot result_match 三态（matched 需期望+容差；过程成功≠验收）+ riekelt 签核晚于内容即 fail |
| W7 学术检索聚合 | 中 | rigorpilot lookup providers 可插拔+evidence_class 四级优先（但源偏 DL 领域，cnki/中文源须自接） |
| W8 选题简报 schema | **强** | ai-research-explore campaign 七字段+想法硬门/软排名/provenance |
| W9 三新件（校准/快照/红队）未实施 | **强** | 快照=competitor-profiling raw 日期目录+ANNOTATED_README round-trip；红队=Wrong turns 节+ACH 冻结基线；校准=continuous-learning lessons_store+Sign-off append-only 日志 |

## 诚实纪律清单（负面/保留点名）

1. **content-research-writer（C1）：平庸**——无脚本无门无 schema，示例自标 [needs source]，纯对话模板。
2. **lead-research-assistant（C7）：平庸**——同上，被 marketingskills/prospecting 全面碾压。
3. **composio 五件（C2-C6）：保留**——绑死 rube.app 商业中间层+付费 API，违反免费优先红线，整体不可采用；仅 Known Pitfalls 知识可摘。
4. **marketingskills 全仓：零脚本**——文档工程一流但纯知识型，"技能"实为提示词包；付费工具依赖（Firecrawl/DataForSEO/Apollo）需换自有免费渠道重实现。
5. **rigorpilot：过重**——~2500 行编排器×2+shared 框架，全盘引入=引入一个框架；且 standalone model runner 无成功 live 验收（作者自曝三连 502），探索车道的想法排名部分未经端到端验证。
6. **riekelt：无自动化落地**——规则全靠模型自觉，仓内仅 1 个测试文件；style.md 禁用表 20+ 条无一 grep 化（作者明知可机检而未做）。
7. **seo-audit/content-strategy/sales-enablement：对本战场低相关**——专业知识真实但可移植点稀薄（各取一招）。
8. **ai-research-explore 想法硬门阈值**（single_variable_fit≥0.6 等七个魔法数）：文档未给出阈值出处/校准方法，照搬有伪精确风险。
