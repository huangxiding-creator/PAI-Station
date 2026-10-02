# 技能深读提取报告：nature-skills (12) + academic-research-skills (4)

- 提取员：t1-nat-acad（技能深读提取员）
- 日期：2026-09-26
- 清单来源：`research/t1_assignments.txt` 的 `== nature-skills ==`（12 个）与 `== academic-research-skills ==`（4 个，deep-research 重点深读）
- 方法：两仓根 README 通读 → 每技能 SKILL.md 全文 → 关键 agents/references/templates/scripts 抽读（脚本读头部判工程质量）→ 文档与脚本互证
- 仓库根：`research/vendor/skillsweep/nature-skills/`（Yuan1z0825，Apache-2.0，19 技能）；`research/vendor/skillsweep/academic-research-skills/`（Imbad0202，CC BY-NC 4.0，v3.22.2，4 技能 + 425 个 Python 脚本 + 229 个测试文件）

---

## A. academic-research-skills 仓（ARS，4 技能，重点组）

### A1. deep-research（重点深读）—— 13-agent 通用学术调研管线

- **一句话定位**：域无关的 13-agent 学术调研团队，8 种模式（full/quick/review/lit-review/three-way-scan/fact-check/socratic/systematic-review），从 RQ 立题到 APA 7.0 报告全程带门。
- **核心机制**：6 阶段（SCOPING→INVESTIGATION→ANALYSIS→COMPOSITION→REVIEW→REVISION），13 agent 分工（RQ/architect/bibliography/source-verification/synthesis/report-compiler/editor-in-chief/devils-advocate/ethics/socratic-mentor/risk-of-bias/meta-analysis/monitoring）。三道 DA 强制 checkpoint（RQ 后/综合后/终稿后），Critical 级阻断；修订环上限 2 轮，余留问题降级为 Acknowledged Limitations。Phase 1 后用户确认是硬门。反模式表 7 条（含"难以验证≠可接受：灰区=FAIL"铁律）。Socratic 模式 5 层对话（澄清→假设→证据→视角→含义），非生成模式铁律 + 显式退出标记 `[SOCRATIC-NON-GENERATION-EXIT: explicit_user_request]`。失败路径表 8 条（RQ 不收敛/<5 源/方法论错配/DA CRITICAL/伦理 BLOCKED/Socratic >10 轮/用户弃跑/纯中文文献切中文库）。
- **数据契约**（最高价值）：
  - **引用验证五态枚举**：`S2_VERIFIED`（Semantic Scholar API 命中，Levenshtein≥0.70 + 年份±1）→ `VERIFIED`（DOI 解析+元数据匹配）→ `PLAUSIBLE`（无 DOI 但 WebSearch 证实）→ `UNVERIFIABLE`（任何方法都无法确认→人工审）→ `FABRICATED`（全层失败→CRITICAL 必须移除）。Tier 0 S2 全覆盖（100%）/ Tier 1 DOI 全覆盖 / Tier 2 WebSearch 抽查 50%（低层源优先抽样）；`DOI_MISMATCH` 单列为已知幻觉模式；API 挂掉优雅降级记 `[S2-API-UNAVAILABLE]`。
  - **证据分级 I-VII**（系统综述> RCT> 对照> 队列/病例对照> 描述性综述> 单个描述性研究> 专家意见）+ 时效性四档（快速领域 2-3 年/中等 5-7/慢 10-15/奠基不限）+ COI 四型（Financial/Institutional/Intellectual/Personal, 各带 High/Moderate 严重度）。
  - **DA 让步阈值协议**：反驳打分 1-5；5=显式让步，4=带缺口让步，3=Hold 重述原攻击，2=Counter-attack 指出偷换，1=Escalate 加强攻击；决策日志 `[DA-DECISION: Score X/5 | ACTION: ... | REASON: ...]`；反谄媚三规则（用户推回≠证据、禁止连续让步、让步率>50% 自检后门槛升到 5/5）+ frame-lock 检测（每 checkpoint 后自问"有没有没质疑过的前提"）。
  - **Literature Matrix 模板**：Source×Theme 交叉表（✓Supports/✗Contradicts/—），Convergence Summary（每主题 Sources For/Against/Net/Strength/Confidence，Strong/Moderate/Weak/Contested/Gap 五档判读），Gap 表（Gap×Type{Empirical/Methodological/Temporal/Geographic/Theoretical}×Priority）。
  - **three-way-scan 模式**：每论文 WHY(问题)/HOW(路线)/WHAT(发现) 三段式 + 跨论文共性 WHY/分歧 HOW/最强 WHAT/未解全局缺口——轻量候选清单扫描，可升级到 lit-review/systematic-review。
  - Socratic 意图检测层：exploratory vs goal-oriented 每 5 轮重估；Dialogue Health Indicator 每 5 轮静默自评（持续一致/回避冲突/过早收敛三维，对用户不可见防博弈）。
- **可移植**（对照基线与 W 空白）：
  1. **五态引用验证枚举直接接到弹药池 GRADE 分级**：EPC100 每条入库证据带 `S2_VERIFIED…FABRICATED` 字段，FABRICATED/UNVERIFIABLE 不入池——"灰区=FAIL"铁律正是我们饱和引擎缺的入库闸（W6 交付物验收门的证据侧）。
  2. **DA 让步阈值协议接到 ACH 假设对抗腿**：现在我们的 ACH 是一次性的；把 1-5 反驳评分+让步率追踪+frame-lock 检测焊进红队腿（W9 三新件的红队件），可治"红队一推就软"的谄媚病。
  3. **three-way-scan 模式接 conductor 的轻量档**（W2）：每渠道首跑先 WHY/HOW/WHAT 扫一遍再决定是否 deep，正是 light/medium/heavy 分级的现成判据。
  4. Literature Matrix 的 Convergence Summary（主题级 For/Against/Net/Confidence）可做研报"争议点"小节的生成器 schema（W8 延伸）。
- **质量评价**：真好的证据——agent 文件齐整（14 个 agent .md 全在），semantic_scholar_api_protocol 给到精确 API base/限速/env 变量/匹配阈值，failure_paths 全场景覆盖；仓级 229 测试文件。缺陷——SKILL.md 里伦理审查段塞满 `#666 replay-validated resolved-context gate`、`#689 artifact`、`#681 LLM-ADVVISORY` 之类 issue 编号考古，新 agent 读到这段几乎无法执行（可维护性债）；大量机制是"prompt 声明+脚本测试"，端到端效果未测（仓 README 自己承认"corpus-scale evaluation of ARS itself remains future work"——诚实加分）。无独立测试针对 deep-research 各 agent 输出。

### A2. academic-paper —— 12-agent 论文写作管线

- **一句话定位**：12-agent（intake/literature-strategist/structure-architect/argument-builder/draft-writer/citation-compliance/abstract-bilingual/peer-reviewer/formatter/socratic-mentor/visualization/revision-coach）论文成稿管线，11 种模式。
- **核心机制**：8 阶段（CONFIG→RESEARCH→ARCHITECTURE→ARGUMENTATION→DRAFTING→CITATIONS+ABSTRACT 并行→PEER REVIEW→FORMAT），5 个用户确认门。v3.6.6 生成者-评估者契约：Phase 4/6 各拆 paper-blind 预承诺（4a/6a，输出 `[PRE-COMMITMENT-ACKNOWLEDGED]`）与 paper-visible 执行（4b/6b）两次独立调用——"写稿人先不见稿复述验收标准、评审先不见稿定评分计划"，物理隔离摧毁"读完稿再倒推标准"的漂移路径；每步输出有 lint 检查数（3/4/5 项结构检查），两次 lint 失败→`[GENERATOR-PHASE-ABORTED]` 转人工。
- **数据契约**：Paper Configuration Record（Phase 0 产物）；Argument Blueprint / Evidence Map（Phase 2/3）；Sprint Contract schema 13.1（`shared/sprint_contract.schema.json`，writer/evaluator 两套 frozen contract JSON：acceptance dimensions D1-D7、failure conditions F0-F6、`dimension_id/what_to_look_for/what_triggers_block/what_triggers_warn` 四字段评分计划）；Style Profile（从旧作学声音，软约束）；修订模式产 patch 文档 + 确定性 apply。
- **可移植**：
  1. **paper-blind 预承诺对焊到 EPC100 后置链的验收门**（W6）：排版/宣传件生成前，先让验收 agent 只看验收标准复述标准（不看稿），再放行生成——治"生成完再找理由通过"。
  2. `what_triggers_block/what_triggers_warn` 四字段评分计划是 W1 报告样式门的现成 schema：每条样式规则预注册 block/warn 触发条件，formatter 硬门（REFUSE 规则）执行。
  3. revision-coach 模式（把非结构化审稿意见解析成 immutable Roadmap + author sidecar `will_address/wont_address/not_on_point` 三态逐条过账）——与 conductor 完备门的"渠道逐条过账"同构，可借其三态枚举。
- **质量评价**：真好——生成者-评估者物理隔离是全组最有原创性的防漂移机制，且文档明说局限（v3.6.6 abort-only 无优雅降级、四调用轮跨会话即丢）。缺陷——双语摘要默认 zh-TW+EN 暴露繁中学术场景出身；LaTeX/APA 生态对工程研报过重。

### A3. academic-pipeline —— 10 阶段总编排器

- **一句话定位**：轻量编排器（自己不做实质工作，只检测阶段/荐模式/派发/管转移/记状态），把三个子技能串成 research→write→integrity→review→revise→re-review→re-revise→final-integrity→finalize→process-summary 十阶段流水线。
- **核心机制**：状态机含半阶段门（**Stage 2.5 / 4.5 INTEGRITY 为 MANDATORY 且不可静默绕过**，FAIL 修复环上限 3 轮，耗尽后须用户记录理由）；中途进入不许跳过 2.5（带现成论文先过完整性门再评审）；checkpoint 三型 FULL/SLIM/MANDATORY 自适应（连续 2 次"继续"降 SLIM，连续 4 次强制回 FULL 防走神；完整性与评审决策门永不降级）；预算透明（开工前报 token 估算 + 交互轮次预算，含 DELEGATE-52"长程文档损坏随往返次数复合"依据）；7 模式 AI 研究失败清单（实现 bug/幻觉结果/捷径依赖/bug 当洞见/方法伪造/frame-lock/引用幻觉）任一 SUSPECTED 或 1/3/5/6 号 INSUFFICIENT EVIDENCE 即阻断；每阶段转移注入核心原则强化块（抗 context rot）；修订早期停止判据 = 无 P0 残留+无决策级回归+无作者待办，明说"不计算分数差"。
- **数据契约**（照录）：
  - **Material Passport（Schema 9）**：`Origin Skill / Origin Mode / Origin Date / Verification Status / Version Label / Integrity Pass Date / Content Hash / Upstream Dependencies[]`；可选扩展 `reset_boundary[]`（append-only：`kind: boundary|resume`，boundary 含 `hash/stage/next/generated_at/session_marker/version_label/mode` 与可选 `pending_decision{question,options[]{value,next_stage,next_mode}}`，resume 含 `consumes_hash`）——`resume_from_passport=<hash>` 跨会话断点续跑，hash 不匹配硬报错。
  - `experiment_provenance[]`（外部实验声明：`experiment_id/repro_lock/planned_vs_executed[]/negative_results[]/known_limitations[]`）+ fail-closed `experiment_intake_declaration`（`experiments_declared|no_experiments_declared`，不声明即全链阻断）。
  - `literature_corpus[]` 输入口（CSL-JSON，Zotero/Obsidian/Notion 适配器）+ Run Ledger（#887：逐 checkpoint 记用户原话+步收据+文件哈希，`scripts/run_ledger.py report` 对账摘要 vs 实际）。
  - R&R Traceability Matrix（Schema 11）：每条评审意见→作者修订主张→复审是否验证。
- **可移植**：
  1. **Material Passport 是 W5 多 worker 调研编排契约的最佳蓝本**：EPC100 双车道/Manus 军团下发-回收时，每工件带 Content Hash + Upstream Dependencies + Verification Status，跨会话/跨 worker 用 hash 断点续跑——比我们现在 taskcard 的状态记录多一层密码学锚。
  2. **checkpoint FULL/SLIM/MANDATORY 自适应 + 唤醒守卫**直接映射 W2 分级工作流的"人工介入度"轴：无人值守跑 SLIM，关键门（成品放行/完整性）永不降级。
  3. **Run Ledger（用户原话+文件哈希逐 checkpoint 记账+对账脚本）就是 W9 快照件**的现成实现路径：我们的校准账本/快照可以照此做"摘要 vs 实际"对账。
  4. 7 模式 AI 研究失败清单可改写成"EPC100 研报失败模式清单"（编造引用/数据幻觉/框架锁死/把错误当洞见）挂到饱和引擎准入。
- **质量评价**：真好——编排器自律（"orchestrator 不做实质工作"写成反模式 #2）、fail-closed 设计（不跑实验也要显式声明 no_experiments_declared）、预算透明引用文献（DELEGATE-52）；README/change log 对"未测量的部分"逐条自曝。缺陷——配置面爆炸：几十个 env 开关（ARS_CLAIM_AUDIT/ARS_PASSPORT_RESET/ARS_INQUIRY_LEDGER/ARS_CROSS_MODEL/ARS_MODEL_TIERING/ARS_RE_REVIEW_LEGACY…）与互相依赖的 #660/#672/#673/#684/#743 侧车，实际使用者心智负担极高；多数开关的效果标注"unmeasured"。人审 checkpoint 密度与我们 7×24 无人产线根本冲突，移植须砍掉大半交互门。

### A4. academic-paper-reviewer —— 7-agent 模拟评审团

- **一句话定位**：5 席评审团（field-analyst 动态配置 4 张 Reviewer Configuration Card + 固定第五席 DA）+ 编辑综合器，产出 5 份独立报告 + Editorial Decision Letter + 不可排序 Revision Roadmap。
- **核心机制**：Phase 0 读全稿定领域/范式/方法型/期刊档，动态生成 4 个评审人身份卡（用户可调）；Phase 1 五席**并行互盲**（铁律 #2：commit 报告前不得交叉引用同伴输出；如实记录"persona 分离≠独立性"）；Phase 2 综合器不得编造意见（铁律 #3）；DA CRITICAL 必须在决定书中可见裁决（铁律 #4，验证/未解决都会阻止静默 Accept）；**只读约束**（铁律 #6：评审绝不改稿，一切产出独立成文）；Phase 2.5 修订教练用 Socratic 对话，作者逐条三态 `will_address/wont_address/not_on_point`。calibration 模式：对用户金标准集测自身 FNR/FPR（25 元组合成金集，FNR<0.15 + FPR<0.10 验收阈值）——但 README 自认"shipped test 用 stub judge 驱动，只验工具不验活模型；live calibration 未记录，现行评审全部标 NOT_CALIBRATED"。
- **数据契约**：Reviewer Configuration Card（身份/专长/关注点）；Schema 6 决定包；Schema 11 R&R Traceability；criterion-bound 判词（每条命名判据给证据锚定的范畴判断，`NOT_COMPARABLE` 显式值，禁隐式分数）。
- **可移植**：
  1. **动态评审身份卡 + 互盲 commit** 接 EPC100 自复盘/审校环节：按行业报告的失败模式动态配置审校人设（如"数据严谨审校/客户视角审校/合规审校"），互盲出报告再综合——比固定单一 reviewer 少锚定。
  2. calibration 模式的"金集测 FNR/FPR + 阈值验收"是 W9 校准账本的直接模板（且其 stub-vs-live 的诚实区分值得照抄）。
  3. `will_address/wont_address/not_on_point` 三态过账表可接到 conductor 完备门的渠道账本。
- **质量评价**：真好——"persona 分离≠独立性"的 typed provenance 记录、NOT_CALIBRATED 全量自标，诚实度全组最高。缺陷——评审质量本身未校准（他们自己反复承认），6 模式+3 套协议（sprint contract/三段 gate/checker）复杂度对移植成本高；评审对象是学术论文，工程研报需要重新定义评审维度。

---

## B. nature-skills 仓（12 技能）

> 仓级架构：router-style SKILL.md（55-160 行）+ `manifest.yaml`（声明 always_load / axes{axis: values→file} / references.on_demand 条件表）+ `static/core|fragments` + `references/` 深参考 + 部分带 scripts/tests。统一设计五原则：一手来源优先/显式胜过隐式/感知章节上下文/输出优先（可直接用产物）/自包含可扩展。README 与 README_EN 中英镜像强制（validate-readmes.py 校验）。`nature-shared/` 共享包（Terminology Ledger、journal formats、consistency-sweep 等）。

### B1. nature-academic-search —— 多源文献检索路由（本组最高分）

- **一句话定位**：manifest 轴路由的多源文献检索/引用核验/严格他引审计技能，MCP server + 无 MCP 降级双形态。
- **核心机制**：读 manifest→检测 workflow（六值之一或多个）→只加载对应 workflow 片段→执行。六个 workflow：multi-source-search / citation-verification / mesh-strategy / citation-file-mgmt / reference-mgmt / **strict-other-citation-impact-audit**（严格他引数+高影响力引用者画像：院士/Fellow/领域大牛识别+引用语境抽取）。源可靠性三层 T1（API 结构化：PubMed/CrossRef/arXiv）→T2（API 受限：Semantic Scholar/bioRxiv/medRxiv）→T3（抓取不稳：Google Scholar/WoS/Scopus/CNKI，永远先警告用户"结果可能不全或过时"），T1 失败→换 T1→再 T2→最后 T3。脚本失败两次→用 MCP 元数据手工生成兜底。
- **数据契约**：manifest.yaml 的 workflow 轴六值映射；T1/T2/T3 分层表（含各源限速：CrossRef 50req/s 免 key、arXiv 1req/3s、S2 1req/s）；`scripts/academic_search.py`（无 MCP 兜底，纯 stdlib 打 OpenAlex 免费无 key API，支持 topic/author/affiliation 约束消歧/ORCID/author-id/--list-authors 同名聚类，429 超时记 stderr 且独立退出码）；`scripts/preflight.py`（批量操作前 API 端点可达性预检）；format-converter.py（.nbib/.ris/.bib 互转）；MCP server（search_papers/get_paper_by_id/get_citation/lookup_mesh + opt-in Scopus/ScienceDirect 全家，本机凭据不进仓）。
- **可移植**：
  1. **这是 W7 学术检索聚合空白的即插即用答案**：T1/T2/T3 三层源可靠性分级 + 降级路由规则，直接对接 conductor 出队闸（domain_blocklist 同层），把我们"仅 cnki 单点"补成 PubMed/CrossRef/arXiv/OpenAlex/S2 多点，且 OpenAlex 兜底路径零 key 零依赖——完全符合免费资源优先铁律。
  2. manifest 的 `always_load / axes / on_demand` 三段式是技能上下文经济（progressive disclosure）的成熟实现，可作为我们自己技能库的规范模板。
  3. strict-other-citation-impact-audit 的"引用者画像"（谁引了你+他多牛+怎么引的）可改造为 EPC100 研报影响力跟踪（谁转引了我们的报告）。
- **质量评价**：真好——脚本头部文档完整（用法示例/礼貌池 --mailto/失败语义），MCP server 带 tests（test_mcp_tools/test_sources/test_elsevier_live）；Scopus 是 opt-in 商业源但默认链路全免费。缺陷——wf6 他引审计的"院士/Fellow 识别"依赖人工名单，自动化程度存疑（未读 wf6 全文验证名单来源）。

### B2. nature-paper-card —— 单篇精读 16 节证据卡

- **一句话定位**：把一篇论文变成有来源约束的 16 节 Paper Card（基本信息→一句话总结→RQ→背景脉络→痛点→核心思想→方法总览→模块拆解→公式→实验证据链→结论正确解读→作者自认局限→批判分析→学到的知识→知识连接→研究想法）。
- **核心机制**：绑定脚本强制（`prepare_paper.py` 产 source_bundle.json，禁止现场写临时抽取脚本——脚本红线 6 条）；**定位状态机三态**：`page-grounded`（PDF 页索引可靠→页级引用）/`structure-grounded`（页抽取不可靠但节/图/表/公式结构可靠→禁止页码引用）/`source-limited`（只有摘要/元数据→禁止页码+禁推断未见证据）；草稿前先建证据清单（每主图表带论证角色）+ claim-evidence 矩阵；外部检索只准用于 04/15 节/书目核验/显式查新，且记录 `paper-only|targeted external check|externally verified` 三态；交付前跑 `audit_paper_card.py` groundedness 审计（error=阻断）。
- **数据契约**：16 节固定 schema（05 节自带四列表：痛点/表现/作者解释/论文证据——"不得把作者解释当确立根因"）；source_bundle.json（pages[] 有正页定位 / unlocated_blocks[] 显式状态）；`[Paper: ...]` 指针语法；17/18 节不存在也写进审计（FORBIDDEN_SECTION_RE 正则防多写）。
- **可移植**：
  1. **三态定位状态机直接接到 W4 PDF/文献结构化解析**：我们解析行业研报/招股书 PDF 时，逐文档记 page-grounded/structure-grounded/source-limited，source-limited 文档禁止页级引用——把"解析不可靠"从静默降级变成显式契约。
  2. 16 节卡 schema 砍到 8-10 节可做 EPC100 的"单源精读卡"标准产物（进弹药池前的深加工件），05 节四列表对行业痛点提取尤其合身。
  3. "审计脚本阻断 + 脚本红线（禁止现场造替代脚本）"模式可用于我们的后置链 QA。
- **质量评价**：真好——prepare/audit 双脚本实现在（prepare 385 行+，audit 带正则契约），六 paper_type 片段齐（clinical/discovery/materials/methods/resource/review）；"Sections 17 and 18 do not exist"这种反向审计是见过最细的输出边界控制。未见明显缺陷。

### B3. nature-proposal-writer（researchwrite）—— proposal-first 写作状态机

- **一句话定位**：科研方案/开题报告的"证据先于文字"写作状态机，九原则（证据先于文字/论证先于章节/契约先于段落/范围先于完备/动态专家非固定池/内容先于语言/不自动升级事实/may indicate→proves 禁改/删除胜于解释/该停就停）。
- **核心机制**：三模式 compose/revise/hybrid；foundation 五文件先行（00_scope→01_research_canon 硬事实→02_evidence_table claim→evidence 映射→03_argument_map→04_section_contracts 每节 purpose/allowed claims/forbidden claims/inputs/validation→05_style_guide）；**QA 四门**（Gate2 professor 内容层专家→Gate1 anti-AI-writing detect-only→Gate3 auto-validation 格式/每 claim 有 citation/方法可复现/编号连续→Gate4 评分阈值定向回退≤3 轮）；情境挡位 `paper 7.0 / proposal 7.0 / internal 5.0 / quick 无`；**stopping rules**：max 3 轮/连续两轮提升<0.5/关键 claim 缺证据/专家冲突无法诚实解决/达标即停，停时四件套汇报（当前分/余留问题/停因/下一步建议）。
- **数据契约**（照录）：项目目录 `<outputs>/researchwrite/<project-slug>/`；`state.json` 最小字段 `{project, mode: compose|revise|hybrid, text_type, language: zh|en|mixed, target_reader, current_round, scores[], technical_debts[], status: intake|foundation|drafting|revision|export}`；8 维评分（研究问题清晰度/科学张力/证据匹配/逻辑链/方法可行性/创新性/风险边界/语言质量）×4 锚点；professor dispatch 契约七字段（task_context/current_mode/text_type/research_domain/current_failure_mode/needed_review_depth/canon-evidence-draft summary）。
- **可移植**：
  1. **section_contracts（每节 purpose/allowed claims/forbidden claims/validation）是 W8 选题简报 schema 的写作侧镜像**：EPC100 终稿每章预注册 allowed/forbidden claims，写手 agent 只能在契约内发挥——"不自动升级事实"原则接到弹药池 GRADE（低级证据禁升格为论断）。
  2. **stopping rules + 挡位制直接接 W2 分级工作流与饱和引擎**：`internal 5.0` 挡就是我们的 light 档验收线；"连续两轮提升<0.5 即停"是饱和门（字数门∧饱和门）之外的第三条便宜停止判据。
  3. state.json 的 `scores[]` 历史数组 + `technical_debts[]` 是轻量版校准账本（W9）：每轮分数留痕，债显式登记不掩盖。
  4. 降承诺提案模式（证据不足时降承诺强度而非硬写）对研报结论措辞分级有直接借鉴。
- **质量评价**：真好——参考文件自洽（professor-dispatch 内联定义不依赖外部技能）、有完整 worked-example；中文场景原生。缺陷——scripts/ 仅 build_proposal_docx.py 一个，评分/校验全靠 prompt 自觉，无自动 validation 脚本支撑 Gate 3（Gate 3 名为 auto-validation 实为 agent 手查）；文档承认借用的 autonovel/professor 是外部思想来源，若单装此技能需通读 19 个 references 才能拼出全流程，上手坡陡。

### B4. nature-paper2ppt —— 论文→中文汇报 PPTX

- **一句话定位**：从论文/阅读笔记产中文文献汇报 deck 的 router 技能，六 paper_type 叙事弧 + 9 步工作流 + 程序化 PPTX 质检。
- **核心机制**：paper_type 六值（discovery 问题→证据弧/methods 问题→方案弧/resource 工作流→验证弧/clinical 设计→推断弧/materials 性能→机理弧/review 证据地图弧）定叙事；Terminology Ledger 全程保术语一致；产出真 .pptx 而非大纲；交付前跑 `audit_pptx_quality.py`（纯 stdlib 检 PPTX XML 常见交付缺陷），高严重度=阻断，修复后复审并记 `output/qa_report.md`。
- **数据契约**：Terminology Ledger（跨幻灯片+演讲备注术语一致）；qa_report.md；audit 脚本以 EMU/PT 常数做几何检查。
- **可移植**：`audit_pptx_quality.py` 的"纯 stdlib + XML 级交付缺陷检查 + 严重度分级阻断"模式可接 EPC100 宣传三件（W1 样式门的 PPTX 腿）；六叙事弧分类对"行业研报→汇报 deck"的叙事选择有直接参考（工程行业报告多属 materials/design→performance 弧）。
- **质量评价**：平庸偏上——技能结构规范、审计脚本真实（EMU 常数+zipfile+ElementTree，工程干净），但场景是学术组会汇报，六弧与商业研报叙事不完全重合；无 tests 目录（对比 nature-citation 有 1 个测试文件）；视觉审查仍靠人（"rendered-preview policy"）。

### B5. nature-statistics —— 统计报告审查

- **一句话定位**：审/改/起草稿件统计报告的审查技能（非重算），围绕实验单位/n 定义/p 值/多重比较/效应量/图注统计/跨章节数值一致。
- **核心机制**：9 步工作流（任务分类→设计抽取→**定义 n 与重复**（独立实验单位 vs 生物重复 vs 技术重复 vs 细胞/视野/重复测量，默认独立单位为 n，禁止把细胞数当样本量）→claim 映射到分析→常见失败模式→报告完整性→图注统计对齐→保守起草→终审 QA）；缺信息一律 `AUTHOR_INPUT_NEEDED` 不编造；红线 6 条（不发明 p/n/自由度/CI/软件版本/校正法；不把 significant 当 important/causal 用）。
- **数据契约**：输出模板两版（审查版：`Statistics review scope / Major statistical issues[P0/P1/P2] / Ready-to-paste revision / AUTHOR_INPUT_NEEDED / Reviewer-risk note`；起草版：`Draft + Reporting notes[n/tests/corrections/software/unresolved]`）；源层级五级（用户材料>Nature 官方标准>Nature Methods 指南>CONSORT-STROBE-PRISMA-ARRIVE>保守惯例）。
- **可移植**：`AUTHOR_INPUT_NEEDED` 令牌 + P0/P1/P2 严重度标签是 W6 验收门"诚实缺口申报"的现成语法：EPC100 数据缺口径时显式列出待作者/上游补充项而非硬写；跨章节数值一致性检查（consistency-sweep：同一指标两处精度不一致、SD/Std 缩写漂移、CI/PI 混用）可直接做终稿数值一致性门。
- **质量评价**：真好——生物学统计的严谨度行业顶级（实验单位层级、图注-正文统计对齐），红线具体可执行。保留——一半失败模式（ARRIVE/盲法/生物重复）绑死生物医学，工程行业研报可移植的主要是数值一致性与措辞纪律部分；纯 prompt 技能无脚本无测试（技能性质使然，不算脱节）。

### B6. nature-citation —— CNS 系列支撑文献检索

- **一句话定位**：严格限定 Nature/CNS 系期刊范围内，按稿件分段找支撑文献并导出 ENW/RIS/Zotero RDF 的 router 技能。
- **核心机制**：七步工作流（分段→解析→检索→保守评估支撑度→校验完整作者元数据→导出一个引用管理器文件→评审工件）；scope 参数四档（Nature 系列/CNS/CNS 及子刊/仅正刊）；超 10 段切批处理策略；"绝不因标题相关就当支撑、绝不引用只看元数据不看摘要的候选、绝不发明缺失书目字段"；DOI 元数据缺 given name 时按 PMID 重取。
- **数据契约**：scope 枚举四档；`scripts/nature_citation.py`（2356 行单文件，CrossRef 为主）；RIS/EndNote/Zotero RDF 导出格式规范；evals.json。
- **可移植**：保守支撑评估（分段→claim→源的映射，宁缺勿滥）思路可加到弹药池证据-主张匹配；作者元数据完整性校验（surname-only AU 字段拒绝导出）是引用质量门细节。但期刊范围限定 CNS 使场景极窄。
- **质量评价**：**保留/负面**——2356 行单文件脚本 vs 仅 1 个测试文件（173 行，只测作者导出），测试覆盖与脚本规模严重失衡；CNS 范围硬编码使技能近乎只为投稿 Nature 系服务；对 EPC100 战场可移植密度低（我们不做 CNS 投稿）。若引用需求应优先 nature-academic-search（同仓更通用）。

### B7. nature-paper-to-patent —— 论文→中国发明专利草稿

- **一句话定位**：从论文/技术报告生成证据约束的中国发明专利草稿（权利要求书/说明书/摘要附图）与技术交底书，带阶段门与结构化校验。
- **核心机制**：三轴（source_format/task_mode 六值含 paper-patent 审计/invention_type）；**源锚定**：稳定源 ID 四前缀（`P001` 论文文本块/`E001` 公式/`F001` 图/`C001` 代码补充证据），权利要求每个技术特征必须映射源 ID；**支撑状态四态**：`explicit / inherent / needs-confirmation / unsupported`——unsupported 特征禁止进正式权利要求；事实缺失用 `[TO CONFIRM: ...]` 且置于正式权利要求之外；阶段门顺序（source map→术语账→清单→证据账→发明构思各过门才准写权利要求）；交付前 `validate_patent_draft.py draft.json`（ERROR 全清 WARNING 逐条对源复核）+ `build_patent_package.py`。
- **数据契约**：draft.json 结构化草稿（references/draft-schema.md）；源 ID 四前缀；支撑四态枚举；技术交底书=时间戳 Markdown+DOCX+Mermaid 渲染。
- **可移植**：
  1. **"特征→源 ID→支撑状态四态"是全组最锋落的证据约束语法**：接到 EPC100 研报生成侧即"每个关键论断必须挂弹药池证据 ID，支撑状态 explicit/unsupported 分明，unsupported 论断降级为推测措辞或删除"——正是 W6 验收门的内容侧执行器。
  2. 阶段门顺序（证据账先于成文）与我们"弹药池 1000 万字门槛先于生产"同构，其门粒度可参考。
- **质量评价**：真好——validate/build 双脚本真实、四态枚举设计精妙、明确自限"是起草辅助非专利性意见"。保留——中国专利场景（CNIPA 公告检索需 playwright chromium 重依赖）离主战场远；可移植的是语法而非流程。

### B8. nature-polishing —— Nature 风格润色路由

- **一句话定位**：在保事实/术语/证据边界前提下润色/翻译/精简学术文本，四轴路由（paper_type×section×language×journal）。
- **核心机制**：四轴检测→只加载命中片段；润色优先级固定（paper type→section job→paragraph logic→claim/evidence/boundary→sentence polish）；排版请求单独分流（latex-layout.md：render→contact-sheet→读 log 工作流，"永远编译并目检渲染页，绝不只看 .tex 判断排版"）；main-text-discipline（每加一段必触发删除/替换检查——篇幅纪律）；声称漂移扫描（consistency-sweep）。
- **数据契约**：axes 四值域（journal 轴四档 nature/nat-comms/nat-mach-intell/generic，正刊规则不得套子刊）。
- **可移植**："每新增一段触发受影响段落删除/替换检查"的零增长纪律接后置链篇幅控制；consistency-sweep（术语/数值/声称跨章节漂移审计）做终稿一致性门（W1）。
- **质量评价**：真好——碎片化加载设计干净，"排版≠润色"的显式分流少见地清醒。局限——Nature 语料导向（NMI 蒸馏的默认值自己声明"非官方政策"），工程研报需换风格语料。

### B9. nature-writing —— Nature 风格章节起草路由

- **一句话定位**：从作者证据起草/重构稿件章节与首次投稿材料的 router 技能，五轴（task×paper_type×section×language×journal）。
- **核心机制**：intake 先浮出缺失的 claim/evidence/boundary 再动笔；缺证据写占位符并列入 `Assumptions or missing inputs:` 而非编造；submission-package 任务走交付矩阵+就绪审计而非论文段落架构；submission 边界三分工（writing=首投/response=返修/reviewer=模拟评审）。
- **数据契约**：五轴值域（section 八值含 related-work/experiments）；submission-package 交付矩阵。
- **可移植**："缺证据→占位符+缺失清单"而非硬写，与 AUTHOR_INPUT_NEEDED 同族，可统一为 EPC100 终稿缺口申报语法；交付矩阵+就绪审计思路接 W6。
- **质量评价**：好——同仓润色技能的姊妹件，结构一致；对工程研报直接可用的主要是占位符纪律与交付矩阵概念。

### B10. nature-data —— Data Availability 声明与 FAIR 审计

- **一句话定位**：起草/审查稿件数据可用性声明、数据仓储方案与 FAIR 元数据检查的 router 技能（无内容轴）。
- **核心机制**：八步工作流（定期刊→盘点全部支撑数据集→**每数据集归入七条访问路径之一**（public repository/controlled access/within paper/reused public/third-party restricted/justified request/not applicable）→先定仓储与标识符策略再起草→显式数据集→位置映射→正式数据集引用→FAIR 审计→可粘贴文本+未解决字段）；不发明 DOI/登录号/仓库名/许可/禁运期；"available upon request" 默认标弱除非有具体限制理由。
- **数据契约**：七访问路径枚举；FAIR checklist；dataset→location 映射表。
- **可移植**：**负面/保留——对 EPC100 战场几乎无可移植物**：学术数据仓储声明场景与我们工程研报产线不重叠；唯一可借的是"先盘点归途再动笔"的次序原则与"不发明标识符"红线（后者我们已有等价纪律）。本组明确的低价值技能。
- **质量评价**：技能本身做得规范（源层级/边界清晰），但与主战场错位——列为不推荐引入。

### B11. nature-image2ppt —— 图片重建可编辑 PPT 的多 worker 运行时

- **一句话定位**：把幻灯片截图/扫描 PDF/图片型 PPTX 重建为对象级可编辑 PowerPoint 的 CLI 驱动运行时，带完整多 worker 生命周期与渲染 QA 硬门。
- **核心机制**：单一 CLI 入口 `cli/image2ppt/cli.py`；`doctor` 预检（失败即停，只装报告缺的依赖）；`prepare` 建 run 目录；`run next/dispatch/record/reset/hints/finalize` 生命周期——`run next` 给下一页、`dispatch` 把页派给 worker（带 agent-id + worker-prompt 文件）、单页可 `--local` 自认领、多页并行至 page_jobs.json 容量；每页硬门链 `page build → run_image2ppt_qa.py（首轮产 visual-review-evidence.template.json 保持 pending，人/AI 完成 evidence 后带 --visual-review-status reviewed 复跑）→ contact-sheet`，全过才 `run record`；公式渲染是硬门（引擎缺/编译失败即页失败，除非用户显式批准例外并记 `user_approved_exception: true + approval_note`）；finalize 从页清单重建整包、保演讲备注、原子发布（同目录临时文件成功后才替换）；视觉策略：能量测的原生对象（圆/卡片/直线/箭头 AutoShape）保持原生，复杂局部才有界位图；箭头原子性（薄箭头=单 connector、实心箭头=单 AutoShape，禁止线+三角拼接、禁止整张知识图谱压成一张图）。
- **数据契约**（照录）：`page_jobs.json`=唯一页状态源；`pages/page_NNN/manifest.json`=唯一页内容源（`schema_version: 2`，`visual_inventory[]` 带 `kind/representation`，每必需质检一条具体 `quality_evidence` 观察，`image2ppt_region_decomposition` 存语义区域证据）；`deck_manifest.json`=最终装配源；`imagegen-jobs.json` 记实际图片生产者与降级理由；`final/image2ppt_qa.json`；每页写入边界锁死（禁 `..`/symlink/绝对路径逃逸页目录，越界拒绝=硬失败）。
- **可移植**：
  1. **这是 W5（多 worker 调研编排契约）最完整的单仓实现**：`run next→dispatch(worker prompt 文件化)→record` 的页级认领-交付-记账循环、容量上限、慢 worker 不许 reset、"QA 只许报告不许改生命周期状态"——把 EPC100 双车道/NB 军团的 taskcard 升级成这套带证据文件的合同并不难，且我们已有 schtask/断点续跑传统。
  2. `visual-review-evidence.template.json → 填证据 → 带 status 复跑` 的"证据文件门"模式接 W6：验收不是打勾，是提交逐项具体观察的证据 JSON。
  3. 写入边界锁死（页目录沙箱）对多 worker 并行写盘的隔离有直接参考。
- **质量评价**：工程上是全 nature 仓最重的实现（真 CLI/真生命周期/真 QA 脚本）。**保留**——图片后端绑外部服务（Paddle OCR token 是百度 AI Studio、图片生成走 GPT Image via Codex OAuth 或 OpenAI 兼容 API），与免费资源优先红线相抵，默认 builtin-ink OCR "量文字几何但不认字"是弱降级；对主战场而言重建 PPT 的场景窄，值得搬的是合同不是功能。

### B12. nature-reader —— 图文中英对照全文阅读器

- **一句话定位**：产出来源锚定、图文对应、公式渲染的中英对照全文 Markdown reader 的 router 技能。
- **核心机制**：先分流（全文 reader / 节选翻译 / 带源引用的问答——问答复用既有 source_map ID 不重新生成全文）；source_format 五值（pdf-text/scanned-pdf/html/doi-arxiv/pasted-text）各配抽取片段；source-map-first 六步；Terminology Ledger 边译边建（成 paper.md 术语表 + source_map.json 术语表）；约束不足也要产草稿 reader 并在 `translation_notes.md` 标缺失页/低置信裁剪，**绝不降级为摘要模式**。
- **数据契约**：`paper.md` / `source_map.json`（块 ID 稳定锚点，供 nature-paper-card 复用）/ `translation_notes.md`；output-spec 定义精确字段。
- **可移植**：source_map.json 稳定块 ID 是 W4 的另一半——解析一次、精读卡/问答/引用三方复用同一锚点；"绝不降级为摘要"红线对长文档处理的诚实性有价值；五源格式分流（含 DOI/arXiv 先解析）可并入 W7 检索聚合的取回腿。
- **质量评价**：好——与 paper-card 构成"解析→精读"接力（reader 产 source map，paper-card 优先复用），是仓内技能互操作的范本；无自带脚本测试（抽取依赖环境 PDF/OCR 能力，技能有言在先）。

---

## C. 跨技能共性模式（≥3 条）

1. **诚实降级阶梯（explicit degradation ladder）是两仓共同的脊柱**。ARS 引用验证五态（S2_VERIFIED→FABRICATED，灰区=FAIL）、nature-paper-card 定位三态（page-grounded→source-limited，降级即禁页码引用）、nature-paper-to-patent 支撑四态（explicit→unsupported，unsupported 禁入正式权利要求）、nature-statistics 的 AUTHOR_INPUT_NEEDED、nature-academic-search 的 T1→T2→T3（T3 永远先警告）、nature-reader 的 translation_notes（约束不足不许变摘要）。模式级结论：**与其判断"好坏"，不如把"可靠到什么程度"做成封闭枚举并绑定每种状态的许可动作**——这比我们现有 GRADE 分级多了"状态→禁令"的联动层，可直接补进弹药池与 W6 验收门。
2. **反谄媚/让步阈值协议治"红队一推就软"**。ARS DA 的 1-5 反驳评分 + 禁止连续让步 + 让步率>50% 自检 + frame-lock 检测（"有没有整个讨论都没质疑过的前提"），加上 reviewer 侧的 Attack Intensity Preservation（同 1-5 尺度不同动作标签）。这是对我们 W9 红队件（设计了未实施）最直接的成品件：ACH 假设对抗腿按此协议跑，可量化"对抗强度保持度"。
3. **预承诺物理隔离（paper-blind pre-commitment）防标准漂移**。ARS v3.6.6 生成者-评估者契约：评审先不见稿定评分计划（`what_triggers_block/what_triggers_warn`），写手先不见稿复述验收标准，两次独立调用 + 结构 lint + abort 标签。EPC100 的验收门若照此改造（验收 agent 先注册验收标准再看成稿），可堵"生成完再找理由通过"的通病；W1 样式门可用其四字段评分计划做 schema。
4. **manifest 轴路由 = 上下文经济的成熟范式**。nature 仓的 `manifest.yaml`（always_load + axes 值→文件映射 + on_demand 条件表）让 60 行 router 驾驭 19 个参考文件，"声明检测值让用户便宜纠错"是廉价对齐机制；ARS 走相反路（SKILL.md 500-800 行塞满 issue 编号考古），可读性反差是我们自建技能库时选型的直接证据。
5. **带哈希的工件护照 + append-only 断点账本支撑跨会话/跨 worker 续跑**。Material Passport（Content Hash+Upstream Dependencies+reset_boundary boundary/resume 两类条目+resume_from_passport hash 匹配）与 image2ppt 的 page_jobs.json 单一状态源 + record 才入账，同构于我们 taskcard 但多了密码学锚与"resume 消费 boundary"的配对校验——W5 契约的抄作业对象。
6. **停止规则内建于循环**。researchwrite 五条停止条件（含"连续两轮提升<0.5"）、ARS 修订早期停止判据（无 P0+无回归+无待办，明禁分数差收敛）、image2ppt"慢 worker 不许 reset"，共同点是把"何时停"写成契约而非靠 agent 自觉——与我们饱和引擎（字数门∧饱和门）互补，便宜且可测。

## D. 对 W1-W9 空白覆盖一行表

| 空白 | 覆盖度 | 最佳来源（技能→部件） |
|---|---|---|
| W1 报告样式门 | 中 | ARS formatter 硬门+四字段评分计划（A2）；nature-polishing consistency-sweep（B8）；nature-paper2ppt audit_pptx_quality.py（B4） |
| W2 分级工作流 | **强** | ARS 模式谱系 fidelity/balanced/originality + FULL/SLIM/MANDATORY 自适应 checkpoint + 模型分层 economy/quality-boost（A1/A3）；researchwrite 挡位制 paper7.0/internal5.0（B3）；three-way-scan 作轻量档判据（A1） |
| W3 出版级图表 | 中 | ARS visualization_agent + statistical_visualization_standards（A2）；nature-image2ppt 原生对象重建策略（B11；注：nature-figure 主力在别组清单） |
| W4 PDF/文献结构化解析 | **强** | nature-paper-card 定位三态+source_bundle.json+审计脚本（B2）；nature-reader source_map.json 稳定块 ID 五源分流（B12） |
| W5 多 worker 编排契约 | **强** | nature-image2ppt run next/dispatch/record+页清单+证据文件门（B11）；ARS Material Passport+reset_boundary+Mode A/B 写域守卫（A3） |
| W6 交付物可用性验收门 | **强** | ARS Stage 4.5 终局完整性门（fresh 重跑+FAIL 环上限+记录用户决定）（A3）；paper-blind 预承诺（A2）；visual-review-evidence 证据文件门（B11）；P0/P1/P2+AUTHOR_INPUT_NEEDED 语法（B5） |
| W7 学术检索聚合 | **强** | nature-academic-search T1/T2/T3+OpenAlex 免费兜底+preflight（B1）；ARS 五个 API protocol 参考（S2/CrossRef/OpenAlex/arXiv/中文文献）（A1） |
| W8 选题简报 schema | 中强 | deep-research RQ Brief（FINER 评分+范围边界+子问题）+research_brief 模板+three-way-scan（A1）；researchwrite 00-05 foundation 文件+section contracts（B3） |
| W9 三新件（校准账本/快照/红队） | **强** | 校准：reviewer calibration 模式 FNR/FPR 金集验收（A4）+state.json scores[]（B3）；快照：Run Ledger 原话+哈希逐 checkpoint 记账+对账脚本（A3）；红队：DA 让步阈值协议+frame-lock 检测（A1/A4） |

## E. 引入优先级建议（供融合提案）

1. **第一梯队（语法/协议级，改动小收益大）**：诚实降级阶梯枚举（五态引用验证+四态支撑+三态定位）→弹药池与验收门；DA 让步阈值协议→ACH/红队腿；停止规则三件→饱和引擎。
2. **第二梯队（部件级）**：nature-academic-search 的 T1/T2/T3 检索分层+OpenAlex 兜底→conductor 新渠道（W7 即插即用）；Material Passport+resume hash→taskcard 升级（W5）；visual-review-evidence 证据文件门→后置链 QA（W6）。
3. **第三梯队（整技能引入需改造）**：deep-research 管线本体（砍人审门、去 PRISMA/IRB、换期刊域）作为 heavy 档调研引擎候选；researchwrite foundation 文件法作为重点选题的深加工线。
4. **不推荐引入**：nature-data（场景错位）、nature-citation（CNS 窄域+测试失衡）、nature-image2ppt 功能本体（外部付费服务绑定，仅搬合同）。

## F. 诚实纪律声明

本报告 16 技能中明确给出负面/保留判断 6 项（B4 平庸偏上、B5 半绑生医、B6 负面-测试失衡+CNS 窄域、B10 负面-场景错位不推荐、B11 保留-付费服务绑定、A3 缺陷-配置面爆炸+人审密度冲突、A4 缺陷-评审未校准），占比 37.5%>20%。纸面设计检查：未发现"文档有脚本缺"的硬脱节（所有 SKILL.md 声称的脚本均已验证存在且头部质量良好）；软脱节点名 2 处——researchwrite 的 Gate 3 名为 auto-validation 实为 agent 手查（B3）、ARS 多数 prompt 级机制效果自认 unmeasured（A1/A3，属其自曝而非我方发现）。两仓均存在商业服务绑定：ARS 需 ANTHROPIC_API_KEY、nature-image2ppt 绑百度 OCR/GPT Image、nature-academic-search 的 Scopus 系为 opt-in 商业源（默认链路免费，合规）。
