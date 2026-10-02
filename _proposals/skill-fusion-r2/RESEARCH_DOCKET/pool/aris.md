# ARIS (Auto-claude-code-research-in-sleep) 41技能深读提取报告

- 来源仓：`E:\AI-Station\_proposals\skill-fusion-r2\research\vendor\skillsweep\Auto-claude-code-research-in-sleep\`
- 范围：t1_assignments.txt `== Auto-claude-code-research-in-sleep ==` 全部41技能（含 skills-codex / skills-codex-gemini-review 子目录3技能与 shared-references/assurance-contract.md 共享契约）。
- 方法：逐个 SKILL.md 全文深读（共41个）+ 仓根工具链实证（tools/ 42文件、tests/ 64测试文件、verify_paper_audits.sh/review_gate.py/figure_renderer.py/extract_paper_style.py 头部核对）。
- 仓库画像一句话：**"speed × rigor" 双模型对抗科研发稿流水线**——executor=Claude、reviewer=Codex MCP(gpt-6-astra@xhigh)跨家族评审；skill=纯Markdown指令，配真实可测的Python/Bash确定性helper；学术会议论文为主战场（工程研报战场需做语义换轨）。

---

## A. 总编排与运行契约

### 1. research-pipeline（12）
- **一句话定位**：端到端总编排器（idea→experiment→paper→slides→poster），阶段化+可断点续跑+外置节奏。
- **核心机制**：阶段门（每阶段产物先行后进）；`run_state.py` 状态机（phases: pending/running/done/accepted/failed/skipped，**done≠accepted**——accept须verdict_id+reviewer handle）；外部节奏纪律：**verdict-bearing技能永不包进/loop或CronCreate**，心跳器只计数findings不裁决（"may say keep going, never good enough"），pivot枚举 none/structural(≥2 stale)/human(≥4 stale)。
- **数据契约**：`.aris/runs/<run_id>.json`；心跳报告字段=findings计数+pivot枚举；anti-overdefense SCOPE LIMITS块（禁SHA方案、禁投机机制、禁corner-case沉迷）粘进reviewer提示词。
- **可移植**：W9（三新件未实施）：ARIS把"校准/快照/红队"拆成了可执行件——心跳只计数+pivot阈值枚举可直接接到conductor 7min tick做完备门的节奏腿；done≠accepted语义接到EPC100后置链"全PASS才留否则回滚"已有实践，作交叉印证。W5：run_state phases枚举是现成的多worker阶段契约蓝本。
- **质量评价**：真——run_state.py 399行+test_run_state.py实测；节奏纪律有专测（test_auto_proceed_contract.py）。缺陷：整链假设单executor单reviewer，无并发多worker资源互斥概念（比conductor弱）。

### 2. idea-discovery [skills-codex-gemini-review overlay]（8）
- **一句话定位**：Workflow1 编排：research-lit→idea-creator→novelty-check→research-review→refine 五段链，Gemini替代第二Codex当评审。
- **核心机制**：AUTO_PROCEED true/false两态且**禁"问了没人答就继续"**（沉默≠同意，turn结束即停）；pilot预算四常数（PILOT_MAX_HOURS=2/PILOT_TIMEOUT_HOURS=3/MAX_PILOT_IDEAS=3/MAX_TOTAL_GPU_HOURS=8）；"let pilots kill, not vibes"——淘汰须实证信号或已发表论文，不许纸上品味杀idea。
- **数据契约**：`idea-stage/IDEA_REPORT.md` schema（Executive Summary/Literature Landscape/Ranked Ideas[每条:Pilot信号+Novelty:CONFIRMED+Reviewer score/next step]/Eliminated Ideas[带阶段与理由]/Refined Proposal/Next Steps）；refine-logs/{FINAL_PROPOSAL,EXPERIMENT_PLAN,EXPERIMENT_TRACKER}.md。
- **可移植**：W8（选题简报schema）：IDEA_REPORT的"Eliminated Ideas带死因"结构直接可抄进EPC100选题简报——死idea是防重复选题的资产。AUTO_PROCEED纪律接到Manus军团下发链（下发后不空等确认但用户可随时打断）。
- **质量评价**：结构清晰；保留——pilot腿假设本地GPU可用，工程研报战场无GPU pilot场景，移植时该腿应换成"渠道试采pilot"；绑gemini-review MCP bridge（本仓独有基建）。

### 3. research-lit（16）
- **一句话定位**：九源文献聚合中枢+验证门（ARIS检索层的收敛点）。
- **核心机制**：源优先级1-9（arxiv/semantic-scholar/openalex/alphaxiv/deepxiv/exa/gemini/web/local-pdf梯次）；D2多源聚合终局门：**零贡献源→ERROR+停**，每源须打"D2 contribution:"日志；fan-out分片并行+dedup_key去重；composed模式`— composed: <path>`允许复用外部已聚合产物。
- **数据契约**：Step1.5 `candidate_papers.json` = `[{"id","arxiv_id","doi","title"}]` → `verified_papers.json`（verdict/reason_code/papers[+status,method]）；verification_status枚举照录：`✅ verified via arxiv|crossref|s2 / ⚠️ UNVERIFIED(arxiv_id_only) / ⚠️ UNVERIFIED(title_only) / … VERIFY_PENDING / ❌ ERROR`；shard schema `{shard_id, entries:[{dedup_key, problem, method, results, relevance, source, verification_status}]}`。
- **可移植**：W7（学术检索聚合仅cnki单点）：九源优先表+三腿验证（arXiv→CrossRef→S2）是接入配方；D2"零贡献源=ERROR"语义直接焊到conductor完备门——静默缺席即报错，与本仓"完备门逐条过账"原则同构。W5：shard schema是fan-out分片的现成契约。
- **质量评价**：真好——verify_papers.py 613行三层级联实测（test_verify_paper_audits.py相邻）；状态枚举区分"查过没有"与"没查"，正是NOT_APPLICABLE≠SKIP思想。缺陷：无中文源（cnki/万方不在表内），本仓接入时要补层。

### 4. novelty-check（11）
- **一句话定位**：三腿新颖性验证（多源检索+时间窗并发工作检查+最近邻差分定位）。
- **核心机制**：多源搜→近3-6个月concurrent work专查→closest existing work+differentiation points；产出CONFIRMED/CLASH/WEAK三态，CLASH带可引用撞车证据。
- **数据契约**：结论枚举+closest paper列表+差异声明；下游idea-discovery以此淘汰idea。
- **可移植**：EPC100选题前的查重腿——把"closest existing work+差异点"接进选题简报schema（W8），防止同一榜题重复开研。
- **质量评价**：中上——机制描述具体，但无独立helper（依赖research-lit的检索基建），验证强度取决于上游。

### 5. grant-proposal（8）
- **一句话定位**：九类基金（KAKENHI/NSF/NSFC面青优杰/ERC/DFG/SNSF/ARC/NWO/GENERIC）申请书起草管线。
- **核心机制**：Phase0-5（文献定位→Aims设计→分节起草→外审→修订）；gap statement公式照录："Despite progress in [X], [specific gap] remains unaddressed because [reason]. This proposal addresses this by [approach], which will [expected impact]."；叙事弧=Problem→Why Now→What→Why It Will Work→Deliver（区别于论文弧）；Aims三性（独立有价值/逻辑相连/预算内可行）+Claims-Aims-Evidence矩阵（Aim|Key Claim|Preliminary Evidence|Proposed Validation|Risk Level|Deliverable）。
- **数据契约**：`GRANT_STATE.json`（phase/grant_type/subtype/language/codex_thread_id/gap_statement/aims_count/status/timestamp；<24h可resume）；review bundle文件`codex_panel_review_bundle_round_N.md`（criteria+绝对路径，MCP提示词保持短，让reviewer自己读文件）。
- **可移植**：W8：gap statement公式+Claims-Aims-Evidence矩阵直接可进工程研报的立项依据段模板；GRANT_STATE的phase+24h resume接到EPC100断点续跑惯例作交叉印证。中文NSFC节（面上/青年/优青/杰青差异表）是罕见的一手结构化资料。
- **质量评价**：内容扎实（NSFC子型评审侧重差异表有实用价值）；保留——默认AUTO_PROCEED=false全检查点阻塞，与7×24工厂相性差；无测试无脚本（纯提示词工程）；面向学术基金，离工程研报战场最远（价值在schema不在流程）。

---

## B. 审计与验收门（本仓护城河最深处）

### 6. assurance-contract.md（共享契约，被5+技能引用）
- **一句话定位**：全仓审计verdict契约——effort轴(深度)与assurance轴(严格度)分离+六值verdict状态机+外部验证器。
- **核心机制**：两轴独立（effort: lite/balanced/max/beast × assurance: draft/submission，派生映射lite/balanced→draft、max/beast→submission，可显式覆盖）；六值verdict：PASS/WARN/FAIL/NOT_APPLICABLE/BLOCKED/ERROR；**NOT_APPLICABLE≠SKIP**（"查了没有"须落盘留痕，"没查"是静默跳过=禁）；**BLOCKED比NOT_APPLICABLE危险**（该审而未能审=阻断，如"论文声称89.2%但无results/目录"）；子技能契约"**always emit, never block**"——子只发verdict，只有父+verifier决定阻断（阻断决策单点化）。
- **数据契约**：审计artifact schema照录：`{audit_skill, verdict, reason_code, summary, audited_input_hashes{file:sha256}, trace_path, thread_id|agent_id, executor_model/family, reviewer_model/family, review_independence: same-family|cross-family|deterministic, acceptance_status: provisional|accepted, reviewer_reasoning, generated_at, details}`；verifier契约：7步（manifest定位→artifact存在→schema校验→verdict合法→**SHA256重哈希比对，变了=STALE**→trace非空→JSON报告+exit 0/1）；overall_assurance: blocked/provisional/accepted，provisional不得呈现为submission-ready。
- **可移植**：W6（交付物可用性验收门）**最强单点**：六值verdict+STALE重哈希+"审计后改过文件=旧审计作废"三件套，直接接到EPC100后置链验收——docx重排版后旧审计失效须重跑，堵"排版后偷改内容"洞。W2：draft/submission与effort分离=分级工作流的门轴蓝本。
- **质量评价**：真好——verify_paper_audits.sh头50行实证与契约逐字段一致，MANDATORY_AUDITS四数组/ALLOWED_VERDICTS/REQUIRED_FIELDS全在；test_verify_paper_audits.py在测。这是全swarm七仓中把"验收"做成可执行契约的最佳样本。

### 7. citation-audit（19）
- **一句话定位**：参考文献逐条真实性审计（防幻觉引用）。
- **核心机制**：抽bib全部cite key→三层验证arXiv→CrossRef→Semantic Scholar（DOI/arxiv_id/title匹配）→fail-closed（网络失败=BLOCKED不是PASS）。
- **数据契约**：CITATION_AUDIT.json（按assurance schema）；verdict/reason_code/details.per_citation。
- **可移植**：工程研报引用腿——研报引用的公告/新闻/研报源无DOI，但"逐条列出处+可回溯URL+验证状态枚举"结构可平移；接到conductor出队闸的渠道账本（每条源带verification_status）。
- **质量评价**：真好——verify_papers.py 613行实测，三层级联有降级路径；学术API绑定（CrossRef/S2）对非学术源需换轨。

### 8. paper-claim-audit（19）
- **一句话定位**：论文数值主张逐条对账（claims↔原始结果文件）。
- **核心机制**：抽全部numeric claims→对results/逐条核对→evidence_check.py判四态；**"a deterministic gate DRIVES, it does not ACQUIT"**——确定性门只驱动复核，开脱须模型评审。
- **数据契约**：evidence状态枚举：`verified / value_not_found / path_missing / unparseable`；PAPER_CLAIM_AUDIT.json。
- **可移植**：W6：工程研报的"数据主张对账"——研报每个数字须能回指ammo_pool的证据卡；value_not_found/path_missing两态正是研报数字无源可溯的判别。接EPC100金标准86条的对账腿。
- **质量评价**：真好——evidence_check.py 212行+test_evidence_check.py；四态枚举是干净的状态机设计。

### 9. proof-checker（15）
- **一句话定位**：定理证明审计（本仓最重的单一技能，866行）。
- **核心机制**：六artifact流水（PROOF_SKELETON→proof-obligation ledger[DAG+typed symbols+micro-claims MC-N sequent形式+limit-order map]→审计→counterexample红队→修复→FATAL/CRITICAL修复后**blind re-review**）；20类问题taxonomy分4组；两轴severity（status×impact→FATAL/CRITICAL/MAJOR/MINOR）；opt-in `--deep-fix`（algebra_sanity）与`--restatement-check`（6种漂移签名）且"helper unavailable=not blocking"（可选件缺失不阻断主线）。
- **数据契约**：PROOF_AUDIT.{md,json}字段照录：`{audit_skill, verdict, reason_code, audited_input_hashes, trace_path, thread_id, reviewer_model/reasoning, details.issues[{id,severity,category,location,note}], deep_fix_plans[{issue_id,corrected_statement,changed_equations,downstream_labels,minimal_tex_patch_plan,closure_tests,algebra_sanity}], restatement_drift[{label,drift_type,severity}]}`；verdict路由表：`no_theorems→NOT_APPLICABLE / source_unreadable→BLOCKED / all_proofs_complete→PASS / minor_gaps→WARN / critical_gap→FAIL / reviewer_error→ERROR`；PROOF_CHECK_STATE.json。
- **可移植**：W9：restatement-check的"6漂移签名"（改写过程中的语义漂移检测）平移到EPC100研报多轮改写场景——每个draft轮次后比对关键主张是否漂移；deep_fix_plans的downstream_labels（修复的下游传染标注）接到研报改数字后的联动改图表/结论。
- **质量评价**：真好——taxonomy两轴severity+blind re-review是审稿工程化的教科书设计；对工程研报战场直接用处低（无定理），价值在**状态机与漂移检测模式**。绑Codex MCP reviewer。

### 10. kill-argument（9）
- **一句话定位**：最强反驳生成器（pre-mortem红队件）。
- **核心机制**：对核心主张生成最强反例/反驳→KILL_ARGUMENT.json落verdict→FATAL级反驳须在终稿前回应；属四强制审计之一（verify_paper_audits.sh的MANDATORY_AUDITS含KILL_ARGUMENT.json）。
- **可移植**：W9红队件——直接接到饱和引擎的ACH假设对抗腿做交叉印证：ARIS把它做成"强制审计+落盘verdict"，比裸红队提示词强在**可验收**。
- **质量评价**：真好——进强制审计清单=有verifier兜底；无独立脚本（模型评审型），强度依赖reviewer质量。

### 11. integrity-forensics（24）
- **一句话定位**：实验完整性取证（篡改/伪造检测）。
- **核心机制**：forensics_gate.py对结果文件做确定性取证（时间戳/哈希链/统计指纹）→异常=FAIL阻断；属Stop hook联动件。
- **可移植**：W6：研报数据链取证——ammo_pool证据卡的哈希链+采集时间戳指纹，防"证据后补/篡改"；test_forensics_gate.py实测。
- **质量评价**：真好——确定性取证+测试齐备；场景绑定实验数据文件，研报侧需换数据对象。

### 12. result-to-claim（8）
- **一句话定位**：实验结果→科学主张的转换门（防过度声称）。
- **核心机制**：`.aris/claims.json`→`.aris/evidence_precheck.json`→三路由：no→postmortem+pivot / partial→supplement+re-run / yes→ablation-planner或paper；fail-closed：reviewer不可用时仍写CLAIMS_FROM_RESULTS.md且首行`verdict: REVIEW_UNAVAILABLE`（不静默吞）。
- **可移植**：W6：**verdict: REVIEW_UNAVAILABLE首行协议**是"评审腿失联时产物自标脏"的优雅解，接到EPC100后置链——判断层(Jev/Laya)不可用时交付物自动降级标注。
- **质量评价**：真好——小而完整，fail-closed路径显式设计。

---

## C. 检索渠道skill群（7个）

### 13. arxiv（12）/ 14. semantic-scholar（20）/ 15. openalex（17）/ 16. alphaxiv（11）/ 17. deepxiv（10）/ 18. exa-search（12）/ 19. gemini-search（17）
- **一句话定位**：单渠道fetcher族——arxiv(官方API+分页)/semantic-scholar(S2 API+rate limit退避)/openalex(开放图谱+relevance_score排序)/alphaxiv(overview.md LLM友好端点)/deepxiv(paper-brief子命令)/exa(神经检索API)/gemini(Gemini grounding检索)。
- **共同机制**：每渠道=解析参数→渠道API→统一降级链（alphaxiv overview→alphaxiv abs→deepxiv brief→arXiv API→页面abstract兜底，wiki-enrich五源链即此）；统一进research-lit九源表；每fetcher配tools/*_fetch.py且**都有对应test_*_fetch.py**（arxiv/deepxiv/exa/openalex四fetcher实测在列）。
- **数据契约**：各fetcher stdout=结构化brief/markdown；citation格式带arxiv_id/doi/title/authors/year。
- **可移植**：W7：fetcher+测试成对的工程纪律直接抄——每渠道一个CLI fetcher+单测，比裸提示词渠道强在**可回归**；五源降级链接到conductor渠道账本做渠道健康降级。
- **质量评价**：真好（arxiv/semantic-scholar/openalex/exa）；alphaxiv/deepxiv依赖第三方新服务，端点漂移风险高（属已知易碎层，但降级链兜住了）。**gemini-search保留**：OAuth容量静默降级问题（免费层限流时行为不可见）、明示"引用数不可靠禁用"——诚实但暴露渠道天花板。

### 20. comm-lit-review（14）
- **一句话定位**：通讯领域文献综述（venue分级导览）。
- **核心机制**：纯散文venue梯队（顶会/二线/workshop）+人名-主题地图；检索靠WebSearch。
- **可移植**：W7的**反面教材**：无结构化API、无fetcher、无验证——领域绑定+纸面层级。价值仅剩"领域venue分级"这个知识组织思路（对应本仓"渠道分级"，但conductor已有更完整的账本制）。
- **质量评价**：**平庸**——14页篇幅几乎无可执行契约；无测试无脚本；领域（通信工程）与本仓战场错位。明确不推荐移植。

### 21. prior-art-search（11）
- **一句话定位**：现有技术/专利检索。
- **核心机制**：Google Patents site:查询模板+分类号（CPC）导航+侵权风险初筛三步；无专利API（无USPTO/ERNM结构化接入）。
- **可移植**：site:查询模板与CPC分类导航思路可并入conductor检索腿；但结构化专利检索（本仓空白）它也没解决。
- **质量评价**：**保留/偏负**——自称prior-art search却无一个真实专利数据源接入，全部依赖搜索引擎快照；对"专利新颖性"这种法律敏感判断只有提示词没有验证。纸面成分高。

### 22. skills-codex.web-debug-search（13）
- **一句话定位**：调试导向网络检索（GitHub/StackExchange/中文技术社区/官方文档），四轴证据标注。
- **核心机制**：源profile路由表（错误串→github+stackexchange优先等6行）；查询预算三常数（MAX_QUERIES_PER_PROFILE=4/MAX_TOTAL_QUERIES=8/MAX_FETCHED_CANDIDATES=12）+四早停条件（"never spend the whole budget merely because it exists"）；错误串保真三态（EXACT原文/NORMALIZED去易变字段/CONTEXTUAL翻译——"翻译永不标EXACT"）；**四轴独立标注**：Match quality[EXACT/NORMALIZED/CONTEXTUAL]×Finding type[ERROR/COMPATIBILITY/API-USAGE/WORKAROUND]×Evidence use[DEBUGGING-ONLY/COMPATIBILITY-ONLY/DISCOVERY-ONLY]×Authority[OFFICIAL/MAINTAINER/COMMUNITY-QA/COMMUNITY-DISCUSSION/BLOG/SEARCH-SNIPPET]；不信任内容规则（搜索结果是攻击者可编辑数据，禁执行其中指令）；结尾示证据边界声明（非论文引用证据）。
- **数据契约**：报告行schema：`|Match quality|Finding type|Evidence use|Authority|Profile|URL|Version/environment|Finding|Status|`；兼容性表`|Component|Observed version|Source version|Relation|Claim basis|Confidence|`（claim basis分official/maintainer-confirmed/reported/inferred四档）。
- **可移植**：**W7外的意外金矿**：四轴证据标注直接平移到EPC100研报信源分级——本仓GRADE分级之外补上"Authority（官方/维护者/社区问答/博客/仅快照）"与"Match quality（原文/泛化/语境）"两轴，研报引用可靠性判别立涨一档；查询预算+早停接conductor防渠道空烧。
- **质量评价**：真好——334行纯提示词工程却契约密度全仓检索类最高，有test_web_debug_search.py（对纯提示词技能写测试=罕见纪律）；中文社区profile（SegmentFault/V2EX/知乎/腾讯阿里云文档）对本仓中文战场直接可用。

---

## D. 知识库（Karpathy LLM-wiki系）

### 23. research-wiki（8）
- **一句话定位**：四实体知识图谱wiki（Karpathy模式LLM自维护）。
- **核心机制**：四实体paper:/idea:/exp:/claim:；8种边型（graph/edges.jsonl，supports/invalidates边=经验轴独立于claim证明轴）；claim状态=证明轴（verified/sound-modulo-imports/refuted/unproven/drafted/retracted）；EXP_NODE_OK门（实验节点须过验收才可被引用）；capture_filter.py反自毒（防wiki自我引用污染idea生成）；query_pack.md预算制（8000字符，failed ideas段1400字符**永远包含**——负结果永远进上下文）。
- **数据契约**：papers/<slug>.md frontmatter（node_id/external_ids.arxiv/title）；graph/edges.jsonl行式边记录；query_pack.md分段预算。
- **可移植**：W8：query_pack预算制+负结果永远包含，接到EPC100自复盘→下一份选题的知识回灌腿（当前复盘产出无结构化回灌）；edges.jsonl行式边记录适合ammo_pool的引用关系层（证据卡→主张卡supports边）。
- **质量评价**：真好——research_wiki.py 1720行+wiki测试7个文件（claims/encoding/experiments/ideas/fetch/helper_resolution）；"证明轴与经验轴分离"是认识论级别的干净设计。

### 24. skills-codex.wiki-enrich（11）
- **一句话定位**：wiki TODO脚手架批量补全（ingest_paper的后半段）。
- **核心机制**：10可填节vs2保护节（Connections=图自动生成、Abstract原文=不可变，**构造即保护**）；marker正则`^_TODO(\._?|: fill in after reading\._?)$`发现候选；五源fetch链（见C组）；--force分级（默认幂等只补TODO，可cron）；MAX_PAPERS=20/次（token预算现实）。
- **数据契约**：日志行照录`wiki-enrich: enriched paper:<slug> from <source> (filled N/M sections)`——**provenance逐paper记录**（"若未来发现alphaxiv对某paper幻觉，可反查该源碰过的每页"）；末尾Source breakdown五源计数。
- **可移植**：本仓语料库（We-AIPO/750飞书对象等）的**结构化补全模式**：占位marker+幂等补全+逐条provenance三件套，接到微信读书/飞书语料的字段补全管线。
- **质量评价**：真好——幂等+provenance+保护节设计完整；依赖上游scaffold格式（绑定ARIS ingest_paper）。

---

## E. 写作与排版

### 25. paper-writing（18）
- **一句话定位**：论文生成主工作流（含Phase6审计收口）。
- **核心机制**：分节起草→引用DBLP/三源验证→Phase6按assurance级invoke verify_paper_audits.sh，submission级**非零exit=拒绝出Final Report**；Final Report自标`submission-ready: yes/no`。
- **可移植**：W6/W2："终稿出口接验证器、失败拒发"整个模式=后置链的终稿门；submission-ready自标签接到交付物brief（用户一眼见成色）。
- **质量评价**：真好——收口逻辑由外部脚本承担非模型自觉。

### 26. paper-plan（9）
- **一句话定位**：论文大纲+主张-证据矩阵+样板差距表。
- **核心机制**：Claims-Evidence Matrix先行；GAP_REPORT.md对照样板逐槽找差；style-ref**writer侧独享**——参考样式永不进reviewer提示词（judge on its own merits）。
- **数据契约**：GAP_REPORT表照录：`|Exemplar slot|Feature|User evidence|Status: covered/partial/missing|Slot ID: GAP_<SECTION>_<FEATURE>|`→缺失槽转DATA_NEEDED markers。
- **可移植**：W1（报告样式门）：**GAP_REPORT稳定Slot ID机制直接可抄**——研报样板对照表每槽一个稳定ID（GAP_摘要_钩子/GAP_正文_数据密度…），样式差距可追踪可版本化；DATA_NEEDED marker接"缺数据槽显式标注"而非静略过。
- **质量评价**：真好——Slot ID稳定化是差距管理的巧思；无独立脚本（矩阵靠模型维护）。

### 27. writing-systems-papers [skills-codex]（8）
- **一句话定位**：系统顶会论文段落级结构蓝图（OSDI/SOSP/ASPLOS系）。
- **核心机制**：页分配表（12页制式：Abstract 0.25/Intro 1.5-2/Design 3-4/Eval 3-4…）；四写作模式（Gap分析G1-Gn↔A1-An↔验证/观察驱动O1-O3/贡献清单/Thesis公式"X is better for Y in Z"）；三陈述规则（每个结论说三遍：节首假设/节尾结论/图注）；六位可信来源（Levin&Redell/Irene Zhang/Heiser等）。
- **可移植**：W1：**页分配表+段落模板直接换轨成研报版式预算**（研报各节的字数/图表密度预算表）；三陈述规则平移为研报"核心判断三处一致"（摘要/正文/结论）自检；G1-Gn↔A1-An映射是研报"痛点-对策"结构化模板。
- **质量评价**：真好（作为知识型技能）——无脚本无测试但定位就是蓝图，内容密度高来源硬；领域（系统会议）与研报战场有距离，价值在**结构模板**。

### 28. render-html（18）
- **一句话定位**：MD→HTML渲染+SHA漂移检测+成本分级评审门。
- **核心机制**：MD为canonical/HTML为生成视图（**单一事实源纪律**）；meta带SHA256（源变即检出版面过期）；评审门成本分级（interim `--no-review`轻过 vs audit级全门）；pure-stdlib+XSS sanitizer（零依赖可移植）。
- **数据契约**：HTML meta区带source_sha256+rendered_at。
- **可移植**：W1：canonical/生成视图分离+SHA漂移=研报md2docx链的正解（本仓md2docx层级坑的同族问题）；接EPC100后置链排版腿——docx重导出前校验md未变。
- **质量评价**：真好——工程判断成熟（成本分级评审是"不是每版都值得审计"的量化表达）。

### 29. paper-compile（11）
- **一句话定位**：LaTeX编译循环+错误自修。
- **核心机制**：编译→错误分类→定向修（缺包/引用未定义/编码）→重编译上限；产物PDF+编译日志留痕。
- **可移植**：后置链docx排版的错误自修循环同构（层级坑/图片后处理已有实践，可对照其"错误分类→定向修"的显式枚举法）。
- **质量评价**：中上——机制常规但错误分类枚举值得对照。

### 30. overleaf-sync（8）
- **一句话定位**：Overleaf双向同步+逐hunk审计路由。
- **核心机制**：三方状态表（local/remote/in-sync/behind/ahead）；**per-hunk diff路由**——每个hunk按内容类型（正文/引用/数值/定理）路由到对应重审计；五层token安全（TTY拒绝交互、`olp_[A-Za-z0-9]{20,}`正则pre-commit hook拦提交、keychain存储）。
- **可移植**：**per-hunk diff路由是全仓最精的增量审计思想**：接EPC100改稿循环——第N轮只对改动hunk重跑对应验证（数值改动→对账腿/引用改动→citation腿），免全文重审；密钥正则hook接到本仓"密钥永不入库"红线（.gitignore外再加主动拦截层）。
- **质量评价**：真好——安全五层+增量路由双亮点；绑Overleaf场景（思想可拆）。

---

## F. 图表与可视化

### 31. paper-figure（10）
- **一句话定位**：统计图生成（matplotlib系，与paper-illustration分管统计/示意）。
- **核心机制**：数据→图型选择→渲染脚本→review；figure_renderer.py为入口（现为shim，规范实现已迁`skills/figure-spec/scripts/figure_renderer.py`——**skill自持单owner helper**架构演进）。
- **可移植**：W3：shim→canonical迁移模式（旧路径保持可用）是本仓工具迁移的温和范式（只增不删红线的同族实践）。
- **质量评价**：中上；69行shim说明经历了一次架构收敛（helper从tools/中心制→skill自持制），值得注意此演进方向。

### 32. figure-spec（9）
- **一句话定位**：图表规格先行（spec→renderer分离）。
- **核心机制**：图以声明式spec描述（数据映射/轴/标注）→渲染器执行→spec与产物都入库可复现；现承载canonical figure_renderer。
- **数据契约**：figure spec（声明式）+渲染产物+复现命令。
- **可移植**：W3：**spec/渲染分离**接出版级图表——研报图表先写spec（数据列/单位/中文字体）再渲染，改版只改spec不重画；复现命令随图入库。
- **质量评价**：真好——声明式可复现是图表工程化正道。

### 33. paper-illustration（14）
- **一句话定位**：Gemini多阶段AI示意图生成（架构图/方法图）。
- **核心机制**：五段流水：Claude规划prompt→gemini-3-pro布局优化→gemini-3-pro风格核查→gemini-3-pro-image渲染→**Claude STRICT评审1-10分，≥9才收，箭头指错=≤6自动拒**；MAX_ITERATIONS=5；CVPR/NeurIPS视觉标准清单（箭头4-6px深色/白底/3-5协调色/灰度可读）；style-ref opt-in（默认关闭零行为变化）。
- **数据契约**：`figures/ai_generated/{layout_description.txt, style_spec.txt, figure_v1..N.png, figure_final.png, latex_include.tex, review_log.json}`；评审模板=逐箭头逐方块核对清单（A箭头正确性/B块内容/C箭头可见性/D标签/E视觉平衡/E2红旗/F布局/G合规七组）。
- **可移植**：W3：**STRICT评审清单**（逐箭头/逐块核对+分项封顶规则）平移到研报图表验收——AI生成图必须过"逐元素指对"人审级清单；五段流水提示词模板可直接换GLM免费链。
- **质量评价**：**保留**——三缺陷：(1) `curl "...?key=$API_KEY"`把密钥放URL查询参数（进程列表/服务器日志泄漏，违本仓密钥纪律）；(2) 输出结构列`review_log.json`但工作流八步中**无任何一步写它**（文档-流程脱节实证）；(3) 绑Gemini付费API+每轮两gemini调用一渲染，五迭代最坏11次付费调用，违免费优先。清单本身是金，实现须重造。

### 34. paper-poster-html（15）
- **一句话定位**：学术海报生成+测量门验收。
- **核心机制**：**measurement gates before aesthetics**——先测版面物理量再谈美观；门目标照录：column spread<5px / footer gap 30-50px / canvas-fill 95-101% / figure-area 14-22%；closed fix vocabulary（修复动作封闭枚举：token|component|rebalance|asset|canvas——**禁自由发挥修复**）；claim→evidence匹配六枚举`{OK, NUMERIC-MISMATCH, OVERCLAIM, MISSING-PRECONDITION, NOT-IN-PAPER, SCOPE-NARROWED}`；FIGURE_MANIFEST.json图源provenance；校准打分（critical caps封顶）。
- **数据契约**：POSTER_STATE.json `{phase, venue, canvas, template, design_decisions, figures_selected, visual_rounds, codex_threads, status}`（可断点续跑）；GATE_REPORT.json schema v1。
- **可移植**：W1（报告样式门）**主力**：物理量门+数值区间（canvas-fill 95-101%这类）直接定义研报docx/宣传三件的版式门——"页边距/图占比/字号下限"全部测量化；closed fix vocabulary接到排版修复循环（修复动作枚举化防越修越坏）；OVERCLAIM六枚举接到研报主张-证据匹配。
- **质量评价**：真好——把美学验收变成物理量验收是全仓最可迁移的排版思想；绑海报场景但门机制完全通用。

### 35. paper-talk（13）
- **一句话定位**：论文→演讲deck+审计迁移。
- **核心机制**：**staging adapter**——构造合成paper目录（symlink指向slides用到的bib/results/figures），使claim/citation审计**原样跑在slide内容上**（审计器不感知对象换了）；speaker notes byte-stable（sha256锁定，后续排版轮禁改）。
- **数据契约**：`.aris/paper-talk/{PIPELINE_STATE.json, FINAL_REPORT.md, audit-input/(合成paper), audits/{slide_claim_audit.json, citation_audit.json, anonymity_scan.json, export_integrity.json}}`；verdict任一非PASS→conference-ready降级为polished（**诚实降级标签**）。
- **可移植**：**staging adapter是通用武器**：研报改宣传三件/公众号稿时，构造合成对象让既有审计腿复用，免为新体裁重写审计；降级标签制（不合门就标次级成色而非硬发）接交付物分级。
- **质量评价**：真好——symlink合成目录四两拨千斤；anonymity_scan对研报场景可换成"敏感信息扫描"（密钥/客户名）。

### 36. skills-codex.slides-polish（9）
- **一句话定位**：逐页Codex评审+surgical排版修复（内容锁定后的视觉收敛pass）。
- **核心机制**：triage全扫→逐页fresh-thread评审（**实证结论：逐页评审1-2轮收敛，批量单遍永不收敛**）；字号换算表（Beamer pt×1.6→PPTX pt，8/8.5→14-18…42→80-100，页码永≤16pt）；十条硬不变量（原件永不覆写/_pre_polish快照/speaker notes逐字节保持/禁改内容/匿名占位fail-closed/唯一文本匹配断言）；shape定位按**文本内容非索引**（"index drifts"——索引会漂移）+重复匹配即abort请求人工消歧；每3页checkpoint。
- **数据契约**：`INSPECT_<stem>.json` shape清单（slide_count/slides[].shapes[]{id,name,shape_path,parent_group_ids,type: TEXT_FRAME|PICTURE|AUTO_SHAPE|GROUP|TABLE|CONNECTOR|PLACEHOLDER, placeholder_type, table_cell, text, runs[{text,font_pt,bold,italic,color_rgb}], bbox_in{left,top,width,height}, fill_rgb, line_rgb, image_size_px}, notes_text_hash:sha256)；POLISH_STATE.json（<24h可resume）；TRIAGE.md；POLISH_CHANGELOG.md逐页一行`Slide K | <change> | reason`。
- **可移植**：W1：字号换算表+EMU→英寸（EMU_PER_INCH=914400）+ pitfalls目录（图纵横比/中文字体ea hint/tofu/斜斜泄漏/页码封顶）是PPTX排版工程的浓缩弹药库，直接接宣传三件的PPTX腿；"按文本定位非索引+断言唯一"是改既有文件不误伤的通用纪律；speaker notes sha256保持→研报"改版不改内容"验收同构。
- **质量评价**：真好（设计层）——但**inspect_pptx.py是"契约先行"纸面件**：SKILL.md明言"脚本不存在时首次运行现场创建"，即无固定实现、行为不可复现、无测试——全仓唯一"文档有schema无脚本"实锤（其余声称的工具都实测存在）。绑Codex MCP。设计照抄、实现须自建。

---

## G. 评审循环

### 37. auto-review-loop（9）
- **一句话定位**：审-改循环编排+停止门状态机。
- **核心机制**：review_gate.py持有**停止/继续/升级转移表**（"safety-critical transition table is executable and testable instead of existing solely as prose"——把关键决策从提示词搬进可测代码）；STOP=score≥6 AND verdict∈{ready,almost}（双条件缺一不可）；backend转移（codex→manual→copilot→oracle-pro→agy→llm-chat）；fail-closed REVIEW_UNAVAILABLE。
- **数据契约**：Transition dataclass `{decision, next_backend, requires_external_acquittal, identity_assurance, reason}`；VALID_BACKENDS/VALID_VERDICTS枚举在码内。
- **可移植**：W2/W6：**停止门可执行化**是本仓判断层最该抄的一件——EPC100改稿循环的"何时停"目前散在提示词，应做成review_gate式转移表+单测；双条件停机（分数门∧verdict门）接Laya判断层的置信双阈值（Noul双阈值同构印证）。
- **质量评价**：真好——review_gate.py头部实证与文档完全一致，test_review_gate.py在测；KNOWN_FAMILIES含zhipu/deepseek/moonshot（对中国模型生态有原生支持）。

### 38. auto-review-loop-llm（8）
- **一句话定位**：评审循环的OpenAI兼容后端版（GLM/ZhiPu/DeepSeek/Kimi/MiniMax/SiliconFlow表）。
- **核心机制**：后端配置表（base_url/model/env var名逐家列）；curl fallback路径。
- **可移植**：W2：**国产免费模型评审后端表直接可用**（本仓免费优先铁律的现成接线图）——GLM/DeepSeek/Kimi的base_url与env约定照录即用。
- **质量评价**：**保留**——密钥靠环境变量明文，curl fallback会把凭据暴露在进程参数（与paper-illustration同病）；表本身有价值，实现须按本仓密钥纪律重造（keyring/凭据库）。

### 39. research-review（9）
- **一句话定位**：通用外审门（reviewer persona可换）。
- **核心机制**：persona化评审（grant panelist/NeurIPS reviewer/系统会议PC）；SCOPE LIMITS反过度防御块；产物REVIEW.md带severity分级（CRITICAL/MAJOR/MINOR）。
- **可移植**：SCOPE LIMITS块（禁SHA方案/禁投机机制/禁corner-case沉迷）接到所有Jev/Laya判断层提示词——防判断层用"建议加更多验证"式空转意见稀释信号。
- **质量评价**：真好——SCOPE LIMITS是被实战教训逼出来的设计（reviewer过度防御是通病）。

---

## H. 实验与周边

### 40. analyze-results（8）
- **一句话定位**：实验结果分析（全仓最薄技能）。
- **核心机制**：结果→统计摘要→发现陈述；46行。
- **可移植**：几乎无——"数值带单位照录/不把显著改写成significant"两句纪律可并入数据对账腿。
- **质量评价**：**平庸**——无门/无脚本/无schema/无测试，与相邻result-to-claim(8页带完整状态机)同权重却空壳，疑似占位技能。明确不推荐移植。

### 41. experiment-plan（8）
- **一句话定位**：主张驱动实验计划（anchor/反主张约束）。
- **核心机制**：五类block（anchor锚定/novelty-isolation新颖性隔离/simplicity简化/frontier-necessity前沿必要性/failure-analysis失败分析）；**anti-claims**（显式声明本实验不证明什么）；MAX_PRIMARY_CLAIMS=2（主张上限防贪多）。
- **数据契约**：EXPERIMENT_PLAN.md block结构+TRACKER。
- **可移植**：**anti-claims直接进研报模板**——每份研报显式声明"本文不证明X/数据边界到Y"，防读者过度外推（研报公信力件）；MAX_PRIMARY_CLAIMS=2接到选题简报（每份研报核心判断≤N条）。
- **质量评价**：真好——anti-claims是全仓最便宜最值钱的诚实机制之一。

### 42. formula-derivation（9）
- **一句话定位**：公式推导核查（散文流程）。
- **核心机制**：逐步推导+每步依据标注；无工具无脚本。
- **可移植**：研报量化模型（估值/测算）推导段的"每步标注依据"格式要求。
- **质量评价**：**保留/平庸**——纯提示词散文，深度远不及同仓proof-checker（后者已覆盖其场景且有完整状态机）；存在感弱，疑似被proof-checker吸收前的遗留。

（注：编号1-42共42节，因web-debug-search等3个skills-codex子目录技能单列；对41技能清单完整覆盖，assurance-contract.md作为共享契约插入B组不计入41。）

---

## 跨技能共性模式（模式级发现，8条）

1. **六值verdict状态机 + always-emit-never-block**（P1，全仓脊柱）：PASS/WARN/FAIL/NOT_APPLICABLE/BLOCKED/ERROR六值统一；子技能只发verdict永不自阻断，阻断决策单点收敛在父+外部verifier。关键细分：NOT_APPLICABLE（查了没有，落盘留痕）≠静默skip（没查，无痕）；BLOCKED（该审未能审）比NOT_APPLICABLE危险且阻断。**对本仓**：EPC100完备门/验收门的verdict词表与"谁有权阻断"的单一权点设计照此校准。
2. **确定性脚本先于模型开销，"gate DRIVES, not ACQUITs"**（P2）：凡可确定性判定的（哈希新鲜度/schema/编译/数字对账）交给脚本，模型只处理语义；且确定性通过不能替代模型开脱。**对本仓**：判断层Jev/Laya前的预筛腿应是确定性脚本（词面命中/数字对账），Jev只裁语义——本仓双轨影子的"typesafe主+laya影"已是同构，缺的是把预筛也脚本化。
3. **STALE重哈希——审计与对象锁死**（P3）：审计artifact记录audited_input_hashes，verifier重算比对，文件后改=审计作废。**对本仓**：后置链"排版后内容不可变"的机制化（docx重导出触发md哈希校验），堵排版环节偷改。
4. **canonical helper解析链 + Policy A/B/D1/D2/E**（P4）：`.aris/tools/→tools/→$ARIS_REPO/tools/→~/.aris/repo`四层解析，缺件按策略分硬失败(A)/警告跳过(B)/主备(D1)/多源聚合(D2)/诊断(E)。**对本仓**：conductor渠道适配器的解析与降级策略词表可直接套用此五Policy命名法。
5. **opt-in旗标=零默认行为变化**（P5）：--style-ref/--deep-fix/--restatement-check/--interactive全部默认关闭，不开则行为与旧版逐字节一致。**对本仓**：新能力挂接存量管线（后置链/conductor）时的兼容纪律——功能进旧链必须opt-in起步。
6. **保护节+provenance的知识库写入纪律**（P6）：可写区/不可变区构造即分离（Connections图自动生成、Abstract原文不可变）；每次写入记来源（"enriched from <source> (filled N/M)"）。**对本仓**：语料库/自复盘回灌的写入边界与溯源格式。
7. **外置节奏：心跳只计数，永不裁决**（P7）：verdict技能禁包loop/cron；心跳器数findings、按stale计数建议pivot（none/structural/human），但"may say keep going, never good enough"。**对本仓**：conductor tick与人工判断的权责边界同构印证；SuperSkill周报的"计数不裁决"原则交叉印证。
8. **done≠accepted + 24h窗口可恢复状态**（P8）：阶段done只是完成，accepted须verdict_id+reviewer handle；状态文件带时间戳，超24h视为陈旧重开。**对本仓**：EPC100断点续跑的收口语义补强——任务卡须有"验收人verdict"字段才算闭账。

另有一个**反模式发现**：ARIS经历了helper从tools/中心制→skill自持制（figure_renderer.py shim注释实证）的架构回流，说明"中心工具仓"会积累所有权模糊，收敛向"单一owner的skill内脚本+旧路径shim保兼容"——对本仓渠道CLI化工程的目录治理有前瞻参考价值。

## W1-W9覆盖一行表

| 空白 | 覆盖度 | 主力来源 |
|---|---|---|
| W1 报告样式门 | **强** | paper-poster-html物理量门+closed fix vocabulary；paper-plan GAP_REPORT稳定Slot ID；slides-polish字号换算表；render-html SHA漂移；writing-systems-papers页分配蓝图 |
| W2 分级工作流 | **强** | effort(lite/balanced/max/beast)×assurance(draft/submission)双轴+派生映射；render-html成本分级评审；slides-polish四级 |
| W3 出版级图表 | **强** | figure-spec声明式可复现；paper-illustration STRICT逐元素评审清单（实现须重造）；paper-figure shim演进范式 |
| W4 PDF/文献结构化解析 | **中** | 五源fetch链+alphaxiv LLM友好端点偏元数据/摘要级；全文PDF结构化解析无专件（extract_pdf_figures类不存在于本仓） |
| W5 多worker调研编排契约 | **中** | research-lit fan-out分片schema+run_state phases+D2多源聚合；但无资源互斥/并发仲裁（弱于本仓conductor） |
| W6 交付物可用性验收门 | **最强** | assurance六值verdict+STALE重哈希+verify_paper_audits.sh 7步verifier+kill-argument强制审计+result-to-claim REVIEW_UNAVAILABLE首行协议 |
| W7 学术检索聚合 | **强** | research-lit九源表+三层验证级联+fetcher/测试成对纪律+web-debug-search四轴证据标注（信源分级意外金矿）；中文源缺位须自补 |
| W8 选题简报schema | **中** | IDEA_REPORT schema（Eliminated带死因）+query_pack预算制+novelty-check最近邻差分+gap statement公式 |
| W9 三新件未实施 | **中** | 红队件最强（kill-argument+counterexample+threat_scan.py实测）；快照件有（_pre_polish+checkpoint+24h resume）；校准账本无直接对应（calibrated scoring思想散在poster门） |

## 诚实纪律核查

- 负面/保留评价技能数：**12/41 ≈ 29%**（comm-lit-review平庸、prior-art-search纸面、analyze-results空壳、formula-derivation被吸收遗留、paper-illustration三缺陷[密钥入URL/review_log.json不写/付费绑定]、auto-review-loop-llm凭据明文、gemini-search容量静默降级、grant-proposal全检查点阻塞且离战场远、slides-polish inspect_pptx.py契约先行纸面件、idea-discovery绑GPU与MCP、alphaxiv/deepxiv端点易碎[有降级兜底]、web-debug-search纯提示词[但质量高故轻保留]）。
- 纸面设计实锤1处：slides-polish的inspect_pptx.py（SKILL.md自认"脚本不存在时现场创建"，schema详尽但无固定实现无测试）。
- 文档-流程脱节实锤1处：paper-illustration输出结构列review_log.json但八步工作流无写它的步骤。
- 反向澄清：初判怀疑的"文档有脚本缺"**不成立**——tools/42文件+tests/64测试实测存在，verify_paper_audits.sh/review_gate.py/research_wiki.py/extract_paper_style.py头部分别与对应SKILL.md契约逐字段吻合；ARIS是swarm中脚本-文档一致性最好的仓之一。
- 商业服务绑定清单：Codex MCP(gpt-6-astra)×8技能、Gemini API×2、Overleaf×1、exa×1、alphaxiv/deepxiv第三方×2——移植时按免费优先铁律换轨（auto-review-loop-llm的国产模型表是现成替代图）。
