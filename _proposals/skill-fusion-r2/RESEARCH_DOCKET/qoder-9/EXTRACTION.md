# qoder.com.cn 市场技能深读提取（9 技能源码包全量通读）

- 来源：`E:\AI-Station\_proposals\skill-fusion-r2\research\qoder\unpack\` 9 目录 + 同级 `*.detail.json` 元数据
- 读法：每技能全量读 SKILL.md / references / scripts / tests / examples / templates
- 装机量（market 元数据）：科研绘图 92 > 论文检索 74 > 论文审查 27 > 深度研究 26 > 科学技能查找 23 > 科学数据处理 19 > 科学假设生成 11 > 学术写作 2 ≈ 世界线程入口 2
- 作者归属：除「学术写作」「world-threads-entry」外，7 个技能同出作者「集思谱/Giiisp」（skill 内自述 "jointly built with Giiisp"），是一个**厂商技能生态包**，互相有交接合同
- 对照基准（本项目已有）：全渠道调度器+完备门、弹药池 1000 万字门槛、饱和引擎（字数门∧饱和门+ACH）、Manus 军团、Jev 判断层、七步方法论循环。下文「可移植」一律以"我们缺什么"为准

---

## 1. thesis-audit-reviewer（论文审查，装机 27）

### 1.1 定位与触发
把学位论文审阅从"读完后写意见"改成"证据驱动、覆盖可追踪、结论可复核"的**审计操作系统**（原文：This skill is an audit operating system, not a one-shot prompt）。触发词写法是"任务动作+交付物特征+技术手段"三段式：review/audit/proofread + formal evaluation report + checklist-based, line-by-line, evidence-grounded comments, PDF page locations, MinerU/VLM parsing。description 里直接把可识别的技术特征写进去，让宿主模型可精确路由。

### 1.2 流程机制
12 步工作流：确认范围 → 建工作区 → 解析（MinerU VLM 优先/本地 pymupdf4llm→fitz 双降级，保密材料禁上传切本地）→ **建审计分母**（先枚举页/节/图表/公式/文献/数据事实/强结论/政策建议，再判断问题）→ 方法画像+可验证声明账本 → 审阅矩阵（状态禁留空）→ 高风险区优先审 → 事实核验与复算 → 问题库（只收证据齐的）→ 出报告 → 完成门 → 留档。
判停/质量门：completion_gate.md 定义 10 个硬门（Source/Parsing/Coverage/Method&Fact/Evidence/Factcheck/Report/Validation/Documentation/单篇优先于批量）+ 8 个软门。核心纪律是"报告只是工作产物的衍生物，审计本体是账本和矩阵"。
完成声明的固定话术（防夸大）：「已完成并通过报告结构验证。」「已完成审阅报告，但仍有 X 项因原文/数据缺失标记为需作者补充材料。」「未能完成交付门禁，因为……」。
批量原则：每篇独立 paper_id/工作区/问题库，可并发解析与初筛，**最终汇总必须单线程生成**；「批量模式只增加调度层，不削弱单篇完成门禁」。

### 1.3 数据契约（全套 12 件工作产物，最强资产）
`00_source_manifest.md`（含 SHA256/页数/解析方式）→ `01_page_index` → `02_structure_map` → `03_method_profile.md`（方法画像表：role=背景/辅助/核心证据/核心结论来源，premises，supports_main_claim，required_actions）→ `04_object_ledger.csv`（审计分母，object_type 枚举 13 种，含 extraction_confidence/needs_visual_check）→ `05_verifiable_claims.csv`（claim_type 枚举 + verification_action 六值 + status 十值）→ `06_review_matrix.csv`（每条检查规则×对象，status 禁空）→ `07_issue_database.md`（七要素固定格式）→ `08_external_factcheck.md`（verified/partly_verified/contradicted/unsupported/needs_author_source 五态）→ `09_reference_audit.csv`（含 function 列：theory/method/fact/data/background/decoration——给文献定功能角色）→ `10_coverage_report.md` → `11_final_review_report.md`。
**四类可验证对象**分类学：外部事实 / 内部一致性事实 / 方法前提 / 作者自算结果——每类对应不同验证义务。
**复算四级阶梯**：L0 表内一致性 → L1 公式代入 → L2 公开数据最小复算 → L3 完整复现(需作者源)。
- **可追溯编号体系**：全部工作产物用稳定 ID 前缀互联——`ISSUE-*`(问题)/`MATRIX-*`(矩阵行)/`OBJ-*`(对象)/`FACT-*`(外部事实)/`REF-*`(文献)/`CLAIM-*`(声明)/`METHOD-*`(方法画像)；铁律「最终报告每条 finding 必须含至少一个产物 ID，否则删掉该条或先补工作记录」+「若某条意见只有聊天中的阅读印象，不得作为正式批注交付」

**方法触发义务表**（method_and_fact_audit.md，识别到什么方法就触发什么审计，原文照录可改写成研报版）：

| 论文方法 | 普适审计义务 |
|---|---|
| 事件研究、时间序列、政策冲击 | 检查事件日期、窗口、估计期、有效交易日、基准模型、核心结果是否可复算 |
| 回归、DID、面板模型 | 检查样本期、处理/对照组、变量定义、数据来源、系数/显著性与表格一致 |
| DEA、Malmquist、效率评价 | 检查 DMU 与指标数量关系、投入产出指标口径、分解解释、效率结果可复核 |
| PCA、因子分析、综合评价 | 检查原始指标矩阵、标准化、KMO/方差贡献率/载荷、权重计算逻辑 |
| 问卷、量表、实验 | 检查样本量、回收率、有效样本、信效度、实验组/对照组、测量时间点 |
| 访谈、扎根理论、案例研究 | 检查访谈人数、材料条数、编码过程、阶段划分依据、审计轨迹和饱和度 |
| 文献计量、知识图谱 | 检查数据库、检索式、检索日期、去重规则、时间范围、软件参数 |

### 1.4 提示词精华（原文摘录）
- SKILL.md：「If a conclusion lacks location, excerpt, and basis, keep it in the work notes as a lead; do not put it in the formal report.」（无定位/原文/依据的结论只能是线索，不进正式报告）
- method_and_fact_audit.md：「不能把所有可复核问题直接标为 `needs_author_source`。只有在 Level 0-2 均不可行时，才进入 Level 3。」——反"偷懒甩锅给作者"
- evidence_rules.md：「`pass` 不是空白，必须说明检查了哪些页、章节或对象」+「不要直接用『需作者提供材料』跳过前 1-3 步」
- evidence_rules.md 规则化边界两栏表：「适合规则化：编号一致性/数字一致性/来源覆盖年份……不应完全规则化：研究问题是否凝练/实证解释是否过度/创新点是否成立」——确定性工具与 AI 判断的分工白纸黑字
- comment_language.md 九类标准批注句式，例（结论过度）：「该处把样本内结果解释为普遍结论，存在外推过度。建议改为『在本文样本和模型设定下显示……』，避免使用『证明、验证、最优、领先、彻底』等绝对化表述。」
- 强词黑名单：「证明、验证、印证 / 最优、领先、第一、彻底 / 弯道超车、可落地、普遍适用 / 显著提高但没有统计检验」

### 1.5 脚本件（9 个，无第三方重依赖）
- `scan_verifiable_claims.py`：正则候选生成器（百分比/金额/日期/样本量/交叉引用→自动指派 verification_action），自述"a candidate generator, not a final fact checker. AI must clean"——脚本生候选、AI 清洗的分工明确
- `validate_audit_report.py`：**交付物正则验收器**——校验报告必备章节/每条批注八字段/禁语（我觉得/感觉/大概）/strict 模式强制追溯编号存在，`--strict` 不过 exit 1
- `docx_integrity_scan.py`：OOXML 直查公式/脚注/批注/修订/域代码数量，防"paragraph.text 假装读了全文"
- `doctor.py`：技能自检（文件齐全+依赖探测）；`init_audit_workspace.py`：一键脚手架+防覆盖；`mineru_vlm_extract.py`/`pdf_local_fallback_extract.py`/`split_mineru_vlm_pages.py`：解析三级链；`render_md_report_pdf.py`：交付渲染

### 1.6 测试写法
**无 tests/ 目录（本技能唯一明显缺口）**；补偿机制是 validate_audit_report.py 当"可执行验收"用 + ACCEPTANCE 式完成门清单。

### 1.7 对工程研报战场的可移植做法
这是我们**输出侧质检**的完整蓝本（现有体系全在输入侧：完备门管渠道过账、饱和引擎管调研够不够，缺"成稿对不对"的审计腿）：
1. **研报审计分母**：成稿后先枚举全部可审对象（每个数字/每个企业事实/每个预测/每个因果断言/每条引用），生成 object_ledger——直接补齐"研报里多少主张、多少已核、多少悬空"的账
2. **复算四级阶梯**接到 EPC100 研报上："某企业 2025 营收 X 亿、CAGR Y%"→L0 全文数字互查（同一对象多处出现是否一致）→L2 用已落盘渠道数据最小复算——Jev 管语义，复算管算术，互补
3. **覆盖矩阵状态机**（pass/issue/needs_*/blocked 禁留空）替换现在"检查过没有"的模糊说法；pass 必须绑定完成的验证动作
4. **validate_report.py 正则验收器**：给研报定结构契约（必备章节/每条引用带渠道 ID/禁"预计将大幅提升"类无支撑强词），exit code 进管线门
5. 批注七要素（定位/摘录/意见/依据/修改要求/优先级/确定性）用作人工复核单格式

### 1.8 诚实质量评价
**真好，九个里第一**。好在内聚：它把"审计"抽象成 分母→账本→矩阵→问题库→门禁 的通用工作系统，且明确标注"不能迁移的是单规则自动判定，应迁移的是工作系统"（audit_operating_protocol 末节）。references 间零重复、每个文件单一职责。缺陷：默认审查依据绑定用户两份私有 docx（通用性受损）；无 tests；validate 脚本自身无回归。

---

## 2. sci-employee-deep-research（深度研究，装机 26）

### 2.1 定位与触发
调外部 Deep Research SSE 服务产出"有结构、有引用、有证据边界"的研究报告；description 强调"mark the evidence boundaries of the conclusion"（标记结论的证据边界）——卖点不是长文而是可核验。

### 2.2 流程机制
写研究 brief（3-5 子问题）→ 先吃 paper-search 交接的候选包（不裸问宽问题）→ 调接口消费 SSE（阶段枚举：KeywordPlanning/PrivateSearch/ResearchPlanning/WebResearch/answer/KeepAlive）→ 整理关键词/来源/候选/引用 → 输出报告+复核清单。失败分支 8 条各有处理：健康检查失败不伪造报告/SSE 断流保留已收事件/无引用只能标初稿/answer 超时标 incomplete 不丢弃/`searchArticlesByQuery1` 返回 400 记录 endpoint+关键词不重试刷接口改短词或 arXiv/OpenAlex 回退/answer 只返回澄清问题→当需求澄清不当调研结论/**references 很多但混杂→退回 paper-search 过滤而不是让 answer 硬写**。
硬规则（原文）：「如果 `references` 为空或 `private_search_summary.totalResults=0`，不能把结果标为『研究报告』。只能标为『问题澄清』『检索失败记录』或『无证据初稿』。」

### 2.3 数据契约
**上游交接合同**（paper-search→deep-research）：`{research_question, candidate_papers, exclude, questions_to_answer}`；
**输出补回合同**：`{references_count, answer_status: complete/incomplete/clarification/no-evidence, evidence_used, claims_need_fulltext_check, retrieval_limits}`——技能间用结构化 JSON 交接而非自由文本。
**answer_status 五态机**：complete(有ref+done) / incomplete(有ref+片段无done) / references_only / clarification_or_no_evidence(有answer无ref) / no_evidence(total=0)，每态绑定固定 user_action 文案。
**报告结构固定十段**（研究问题→边界→关键词→证据来源→主要结论→分论点→引用与证据→争议或不足→可实操路线→**还需要核验**）；**最小实测记录格式**九栏（健康检查/请求主题/请求字段/观察到的 SSE 阶段/关键词/检索命中数/失败 endpoint/references 数量/answer 类型/下一步）——每次调用留可比对的结构化实测记录。

### 2.4 提示词精华
- 「Deep Research 的价值不是长文本，而是把『检索、证据、报告、待核验问题』串起来」
- 「宽泛问题会带来混杂 references……标题强相关和摘要弱相关要分开看」——检索相关度分层意识
- SKILL.md 内嵌"已实测状态"章节：三次真实调用的命中数/45 秒超时/空结果如实记录——把实测失败史写进技能文档，罕见的诚实

### 2.5 脚本件
`stream_deep_research.py`（368 行）：SSE→JSONL 进度转发器，每事件带 ts+elapsed_ms；health 预检失败合成 interface_unavailable 事件；`--from-log` 可回放日志（测试关键）；`--max-events N` 优雅截断做探针。`parse_deep_research_sse.py`：SSE 文本日志→证据摘要（phases/keywords/totalResults/failures/references_count/answer_status）。纯标准库。

### 2.6 测试写法
test_stream_deep_research.py 4 例，全部**子进程跑真脚本+构造 SSE 日志回放**，断言事件序列、answer_status、user_action 文案、退出码——测的是"技能行为契约"不是函数。无网络依赖（--from-log），可离线 CI。

### 2.7 对工程研报战场的可移植做法
1. **answer_status 五态机**直接套给 Manus 军团回收腿：任务回收时不只收文本，强制补 `{evidence_used, claims_need_fulltext_check, retrieval_limits}`——"哪些引用已核验哪些仍需人工看全文"现在是军团产出的盲区
2. **技能间交接合同**：Manus 任务下发用 `{research_question, candidate_docs, exclude, questions_to_answer}` 固定 schema，杜绝自由 prompt 漂移；与 laya 意图层的 typesafe 合同思路同源，可对齐
3. **混杂结果退回上游过滤**分支：渠道返回大而不准时先过滤再写，不硬写
4. `--from-log` 回放式测试模式可抄给调度器的渠道适配层测试

### 2.8 诚实质量评价
真的好：状态机完备、失败路径全覆盖、测试写法示范级。缺陷：**硬编码第三方私网服务 `http://123.56.218.60:18000`**（他人服务器，随时失联，也不合规疑虑）；本质是单 API 包装+过程工程，研究方法本身薄（无假设分解/对抗）。

---

## 3. giiisp-paper-search-apis（论文检索，装机 74）

### 3.1 定位与触发
多入口论文 POST 检索路由（OA 标题摘要/arXiv 摘要/编号/多字段/题名五接口），任务→接口路由表开头即给。价值在**检索卫生学**：怎么诚实处理一个会 401/403/429/回 HTML 的商业接口。

### 3.2 流程机制
先判断任务→路由表选接口→检查鉴权（无 token 只构造请求不真调，附认证 URL）→调用→失败分类处理→字段归一化→输出短表或引用审计表。dry-run 是默认安全模式。

### 3.3 数据契约
- **字段归一化映射表**：归一化字段(title/authors/year/venue/abstract/doi/arxiv_id/url/pdf_url/source_api/match_reason/verification_status) ← 各源字段候选列表；缺值填 null「不要用推测值补齐」
- **失败响应矩阵**：401/403→标接口受限不重试刷接口改开放源回退；429→降频不并发补打；Content-Type text/html→不解析为论文摘录页头 120 字；业务 code 无结果数组→保留原始错误字段
- **引用审计输出模板**：`原文主张|引用占位符|检索词|候选论文|证据字段|链接|状态|处理意见` 一行一主张，处理意见五值为：保留/替换/补充引用/删除主张/改写——**连处置动作都枚举**，不是只标状态。四态收束定义：已核验（题名+作者年份+DOI/arXiv/来源页互相能对上且摘要支持主张）/待核验（元数据匹配但缺 DOI 或关键字段）/不支持（候选与主张不一致，**或只能支持更弱的说法**）/接口受限（附开放源回退建议）
- 开放源回退（arXiv/OpenAlex/Semantic Scholar/Crossref/PubMed）结果强制标「非 Giiisp 结果」

### 3.4 提示词精华
- 「不要编造引用量、期刊分区、全文内容或不存在的 DOI」
- 「每次检索输出一张短表……摘要依据：只摘核心命中点」+ 每行带 match_reason（一句话说明为什么纳入候选）——**入库理由字段化**
- 「如果接口需要登录态或鉴权，但当前没有凭据，只构造请求体和 curl 示例，不真实调用」——dry-run 优先

### 3.5 脚本件
`progressive_paper_search.py`：JSONL 进度事件器（search_started/auth_status/request_prepared/response_received/search_complete），Authorization 头自动 redact，401/403/HTML 自动附 auth_url+user_action。`dry_run_paper_search.py`：只打请求体。examples/ 四个 JSON 是**请求矩阵+归一化样例+失败样例+端到端样例**——格式契约文件化。

### 3.6 测试写法
test_progressive_paper_search.py 3 例：dry-run 事件序列、真实调用 mock、失败路径；test_dry_run 用 request_matrix.json 驱动（数据驱动测试，接口契约以 fixture 固化）。TEST_BUNDLE_README 记录打包前 pytest 结果+真实探针耗时（15.8s）——发版前实测留痕。

### 3.7 对工程研报战场的可移植做法
1. **渠道字段归一化契约**：17+ 渠道现在各有原生格式，抄这张"归一化字段←来源字段候选"表做成全渠道统一 schema，match_reason 字段直通完备门过账
2. **失败响应分类矩阵**：401/403/429/HTML/超时→各自动作，进 conductor 出队闸的自动处置规则（现在有黑名单闸，缺"限频降档"细粒度）
3. **引用审计表**：研报每条数据主张一行（主张|来源渠道|证据字段|核验状态|处理意见），"不支持"态让"引用撑不起主张"显形——这是弹药池→成稿的质量桥
4. request_matrix.json 式**接口契约 fixture**给每个渠道适配层当回归基准

### 3.8 诚实质量评价
真好：归一化表+失败矩阵+引用审计三件是渠道工程的标准答案级写法，测试数据驱动。缺陷：深度绑定 giiisp.com 商业服务（回退设计缓解）；归一化脚本本身不含在包内（靠 SKILL.md 指导 AI 执行），确定性程度打折扣。

---

## 4. giiisp-scientific-image-generation（科研绘图，装机 92，市场第一）

### 4.1 定位与触发
论文段落/图题/实验流程→图像生成任务，主线是"生成+检查+修订"闭环。触发词用用户原话（"画一张科研图""按这张图继续改"）。

### 4.2 流程机制
作图简报(figure_spec)→生成→机器检查→VLM 语义审查→(Critic 建议→revised_description→**最多一轮**自动重生成)→代理复查摘要→manifest 重建→交付索引。判停：自动修订硬上限一轮，「第二版复查后停止，把后续选择权交给用户」——反无限迭代。

### 4.3 数据契约
- `figure_spec.json`：figure_kind/caption/communicative_intent/**required_labels/forbidden_labels**/layout_brief/style_brief/reference_role(preserve_structure|use_elements|refine_sketch|edit_image)/preserve_constraints/allowed_changes/disallowed_changes——单图结构化事实源，「避免多轮 prompt 追加后互相矛盾」
- **run 目录全系谱**：每轮独立 run 目录存 figure_spec/request(脱敏)/response/poll_history/图片/check/semantic_review/manual_review/blocker；edit run 必写 source_run.txt+父图 SHA256+lineage 字段组——「每张图都必须有可追溯 run，不只保存最终图片」
- `check.json`：machine_check（存在性/字节/类型/尺寸）+ quality_review_axes 五轴（content_accuracy/layout_quality/text_readability/aesthetic_quality/artifact_severity），**分数默认 null 不伪造模型判断**
- 图包三件：package_plan/package_checkpoint/figure_package（对应编排计划/断点/交付清单）
- `workflow_status.json`：标准入口的阶段状态记录（generation/semantic/auto_repair/agent_review/manifest 各阶段 completed/skipped/blocked+原因），编排器每步落盘可断点续查

### 4.4 提示词精华（semantic_review_dashscope.py 内嵌 Critic prompt，全文值得抄）
- 「你是顶级 AI 会议标准的科研图 Critic……如果发现问题，输出具体 critique，并给出合并修正后的 revised_description；如果不需要修改，critic_suggestions 和 revised_description 都写 No changes needed.」
- 审查六规则：Fidelity & Alignment（忠实方法论节，允许合理简化，不能幻觉新增）/ Text QA（错字、**伪英文**、无意义文字）/ Validation of Examples / Caption Exclusion / Clarity & Readability / Legend Management
- 「revised_description 必须主要基于原 Detailed Description 修改，不要无故从头重写」——修订不漂移
- 输出强制严格 JSON schema（quality_review_axes 带 PASS|FAIL|UNCERTAIN+score+rationale，observed_labels/missing_required_labels/forbidden_labels_seen/recommended_next_action/next_edit_prompt），temperature=0+response_format=json_object
- SKILL.md 提示词经验条：「主标签控制在 3-6 个短词」「长解释放到图注/排版层」「二次修改时只列允许变化的局部，避免重新生成整张图导致结构漂移」
- 中文进度样式范例（节选，用户可见播报的口径约束）：「[21:32 | 机器检查] 文件本身是有效图片，尺寸和格式没问题；但语义和标签还要复查，不能只看机器检查就交付。」「[21:34 | 复查结论] 主体结构基本成立，关键标签也在；但仍发现一处文字或语义问题，这版适合做草稿，正式版建议再改一轮。」——播报原则：每条绑定真实节点、含一个技术载荷、**不写成后台日志也不写成陪聊安慰**

### 4.5 脚本件
8 个：生成 smoke(615 行)/编排器 run_workflow(652 行)/机器检查/VLM 审查/manifest/package/**variant 选择器**/dry-run。select_figure_variant.py 是纯可审计字段打分器：completed+50/有图+20/机检过+15/人工轴分×3/VLM ready_to_ship±/缺必标签-8each——「不从图片外观臆测语义质量」。

### 4.6 测试写法
7 个测试文件全带（每个脚本一个），含 manifest 组装/打分边界/blocked 路径——九技能中测试最全。

### 4.7 对工程研报战场的可移植做法
研报配图腿直接可用：
1. **Critic→revised→一次自动修订**闭环移植到研报图表：图表生成后 VLM 审（必含数据点标签齐全/伪英文/图注不入图/布局五轴），不合格自动修一轮封顶
2. **run 系谱**移植成"研报版本 lineage"：每版成稿记录父版+保留约束+允许改动+禁止改动+diff 所依据的渠道证据 ID——改稿不再漂移
3. required_labels/forbidden_labels 二元组移植成"研报事实卡"：每章必现的关键数字/企业名 vs 禁用的绝对化词
4. variant 打分器模式给"多渠道同题产出择优"：只按可审计字段（来源权威度/新鲜度/命中理由）打分，不靠模型看外观
5. blocker.json 模式：渠道无凭据时留 blocker 不伪造——可并入渠道账本

### 4.8 诚实质量评价
真好且工程最重：双层检查+修订上限+全量测试+诚信默认值（无 token 只写 blocker）四件套是 AIGC 交付质量工程的样板。缺陷：绑定集思谱 Imagine 商业接口与 DashScope 双付费服务（VLM 审查腿可用本项目已接的免费视觉模型替换）；run_workflow 652 行偏胖；SKILL.md 380 行偏长。

---

## 5. scispark（科学假设生成，装机 11）

### 5.1 定位与触发
关键词→七阶段证据留痕研究想法（Tashan Scispark 工作流的 skill 化）。触发词含技能别名+任务词+产出词三类。

### 5.2 流程机制
Stage1 事实抽取→2 假设生成(H1-H5 稳定编号+**可证伪预测**)→3 初稿想法→4 技术优化+评审(S4-P1 问题编号)→5 MoA 机制优化+评审→6 人机协作整合+学术规范检查→7 可选 slides。快模式停在 Stage3 并声明跳过了哪些阶段。**证据量阈值门**：50+ 相关记录→深度分析 / 30+→标准流程 / 15+→带 limitation 继续 / <15→先扩检索，**禁止下强结论**。
进度透明采用"事件驱动+时间戳"模式：`[21:33 | 检索完成]`式短播报绑定阶段转换点（解析后/检索后/各阶段后/弱证据时/长等待 keepalive/完成时），每条带一个真实载荷（命中数/代表论文/证据水位），「不改脚本和阈值，只为透明加消息」。

### 5.3 数据契约
stage-contracts.md 逐阶段定输入输出文件名+必含字段；literature.csv 全程维护（id/title/.../stage/**usage**/verification_status），verification_status 三值：已核验（title/authors/year/arXivID/URL/abstract 全且相关）/待核验/**不支持**（论文不支持预期主张）；final_idea_template.md 含 Hypothesis-to-Design 映射表（假设|设计组件|验证方法|Issue IDs）。

### 5.4 提示词精华
- 「Do not turn a keyword directly into a polished proposal without stage evidence.」（无阶段证据不得把关键词直接变成 polished 提案——反跳步）
- 「For every strong claim in the final idea, point to a paper row, user-provided evidence, or an explicit limitation.」——强主张三出路：文献行/用户证据/显式局限
- 「Do not invent DOI, journal rank, impact factor, or full-text findings.」
- 假设评价矩阵：verifiability/novelty/feasibility/impact/priority 五维

### 5.5 脚本件
search_arxiv.py（100 行，arXiv API→归一化 literature 记录，与论文检索技能同 schema——生态内 schema 复用）；init_scispark_workspace.py 建目录。

### 5.6 测试写法
无 tests。

### 5.7 对工程研报战场的可移植做法
1. **证据量阈值分级→结论强度分级**：现有饱和引擎是字数门∧饱和门，可加"证据条数档位"：N 条独立源支持→可断言趋势；<阈值→只能写"初步迹象+limitation"——把证据量直接映射到允许的措辞强度
2. **稳定假设编号+falsifiable prediction**：研报的核心判断（J1 类）各配"什么证据会推翻它"，接 ACH 对抗腿
3. literature.csv 的 **usage 列**（每条证据用在哪一阶段/哪一节）可并入弹药池元数据，实现"证据→章节"反查
4. 跳过阶段显式声明（quick mode 停 Stage3 并说明）对应研报快版/全版双轨的诚实声明

### 5.8 诚实质量评价
中上：阶段契约+阈值门+编号纪律是真设计；但 MoA(机制作用)五维是生物医学科残留、对通用场景生硬；arxiv-integration.md 里泄漏开发者绝对路径 `C:\Users\16571\...`（打包卫生瑕疵）；无测试。

---

## 6. research-baseline-builder（科学数据处理，装机 19）

### 6.1 定位与触发
把科学问题翻译成"数据输入/输出/样本单位"契约+可跑基线。触发词是"帮助明确 what goes in / what comes out / how samples are defined"。

### 6.2 流程机制
重述问题→**输入输出合同**（8 要素：目标/输入/数据描述/期望输出/**样本单位**/标签/特征/分组字段）→问题→数据任务路由→最轻框架选择→工作区+可跑模板→SOP 六步（可视化→预处理→建模→训练→评估→解释）→**goal-check**（结果是否真回答原科学问题）。Guardrails 七禁：样本共享身份禁随机切分/禁 post-outcome 变量做特征/禁 ID 类做特征/不平衡禁只优化 accuracy/禁把相关说成效用/禁藏小样本/禁过度建模。

### 6.3 数据契约
问题→数据任务路由表（科学措辞→输入/输出/数据问题/第一基线/主指标 8 行，如 "Does X affect Y?"→因果效应→回归调整/匹配/DID→效应量+CI）；baseline ladder 四级（sanity→可解释→强经典→神经）；workspace 产物：problem_definition/data_schema.csv(UTF-8-BOM)/eda_plan/preprocess_plan/baseline_plan/train_eval_plan/baseline_report+routing_decision.json+workflow_status.json（区分 demo/user_csv 数据来源）。

### 6.4 提示词精华
- 「Do not start with models. First ask what goes in, what should come out, and what one sample means.」（先问进出和样本单位，再谈模型——需求翻译纪律）
- goal-check.md 常见错配表：「High prediction accuracy→does not prove causal effect」「Feature importance→not mechanism」「Good random-split score→not cross-site/future performance」——结果类型≠结论类型
- goal-check 定句式：「This baseline answers [part of goal] under [data/split/metric]. It does not yet support [unsupported claim]. The next check is [...].」——**结论边界三段式**
- 「If no data file is available, do not invent columns or write runnable training code.」

### 6.5 脚本件
init 脚本生成骨架+按关键词复制模板（image→efficientnet/tabular→xgb/时序→gru）；4 个可独立运行基线模板（RF/XGBoost+Optuna/GRU/EfficientNet，demo 数据可跑通、写 metrics.json）；run_workflow 薄编排。

### 6.6 测试写法
无 tests。

### 6.7 对工程研报战场的可移植做法
可移植的是**翻译层**不是 ML 代码：
1. **研报章节路由表**：仿"科学措辞→任务族"表做"章节类型→分析框架→最小证据要求→主指标"路由（市场空间→行业数据+政策源→市场规模/CAGR 竞争格局→竞对源矩阵→市占率/集中度 财务→年报数据→增速/毛利率 风险→政策+舆情→风险等级）——七步循环的"分析选型"步可固化成表
2. **结论边界三段式**接到 Jev 判断层输出：「本结论在[渠道集合/时间窗/口径]下成立，尚不支持[外推说法]，下一步需[某渠道补证]」
3. "错配表"（高accuracy≠因果）做成研报措辞审计规则：增速数据≠竞争力、订单额≠市占率、样本内拟合≠预测能力
4. 无数据不编造列——对应"无证据不写数字"红线

### 6.8 诚实质量评价
对本战场**直接价值低**（ML 基线脚手架与文字研报无关），但翻译三件套（路由表/错配表/边界句式）是真方法论；模板代码工程规范（CONFIG 区/demo 可跑/指标落 JSON）质量好。无测试；SKILL.md 开头用大段"形态说明"自我辩护（像是被质疑过空骨架）。

---

## 7. find-science-skills（科学技能查找，装机 23）

### 7.1 定位与触发
技能路由器：用户需求→"领域×研究阶段×功能分工"三维→静态目录确定性筛选→≤5 候选。description 只一句任务描述（最短）。

### 7.2 流程机制
硬/软边界设计：**领域和阶段是硬过滤，功能默认只做排序偏好**（`--strict-function` 才升级硬过滤）——理由原文「避免复合任务因功能判断偏差而漏掉正确技能」。语义复核规则：研究对象/数据类型匹配**与**动作/产物匹配**两类证据缺一不可**；「不要为某条查询或某个 skill ID 添加特殊规则」。

### 7.3 数据契约
science_skill_catalog.json：**1391 条技能**三维分类（领域树×研究阶段×功能），阶段枚举 5 值（发现获取/构思设计/执行采集/分析验证/表达发表）、功能枚举 17 值（检索获取/阅读提取/证据综合/问题构思/研究设计/流程规划/模拟建模/实验执行/数据采集/数据处理/分析推断/领域解释/验证评测/可视化/科研写作/引用管理/投稿评审），每条含 summary/task/classification_rationale/quality_score/readiness(trusted|provisional|restricted)/source_repository+source_path（来自 brycewang-stanford/Awesome-Journal-Skills 等仓库静态快照）。脚本输出内嵌 **DECISION_CONTRACT**：`{maximum_recommendations:5, direct_match_requires:[research_object_or_data, requested_action_or_output], no_direct_match:"return_gap_or_ask_clarification"}`——把推荐纪律做成机器可读字段。

### 7.4 提示词精华
- 「最多推荐 5 个；没有直接匹配时返回『目录未覆盖』或追问，**不得用高质量但无关的技能补位**」——反"总得推荐点什么"
- 「可信度和质量分只用于直接匹配候选之间的排序，不证明语义相关」——排序依据≠相关性证据
- 「研究阶段按主要产物判断，不按工具名称判断；agent、API、工具库和 workflow 只是实现形式」

### 7.5 脚本件
filter_science_skills.py（281 行纯标准库）：三维筛选+readiness 排序+`--list-dimensions`/`--list-functions` 自省入口（先看漏斗里实际有什么再选）。

### 7.6 测试写法
test 260 行：importlib 动态加载脚本+合成 fixture 目录，测 readiness 排序压过 quality_score（restricted 99 分不排前）、strict/prefer 两模式、非法维度报错——**测决策契约本身**。

### 7.7 对工程研报战场的可移植做法
本项目已有 100+ 技能资产（渠道 CLI 化/opencli 166 站桥接），缺统一路由：
1. 建**技能三维目录**（领域=行业/职能，阶段=研报七步循环的步，功能=检索/核验/写作/绘图/推送），把自有技能+市场技能编目，filter 脚本直接可抄（纯标准库）
2. **DECISION_CONTRACT 机器可读化**给 super-skill 调度用：≤N 候选/双证据匹配/无匹配报缺口不硬塞——与「已知空白转工单铁律」天然契合（目录未覆盖→登记工单）
3. "先列漏斗里有什么再选"两段式调用可减少技能误路由

### 7.8 诚实质量评价
设计真好（硬软边界+反补位纪律+契约测试）；数据弱：1391 条是第三方仓库静态快照、无更新机制、quality_score 来源不透明（classification_rationale 里有 manual_confirmed 标注算是留痕）。生态位特殊：它是给"技能很多的宿主"用的元技能。

---

## 8. 学术写作（装机 2）

### 8.1 定位与触发
学术文本"写—审—改—投"五模式（论文写作/同行评审/回稿修订/基金申请/投稿材料）。触发词全部是用户原话场景句。description 末尾**显式声明不管什么**（不负责文献检索、不负责引用合规）——负向边界写进触发条件。

### 8.2 流程机制
评审流水线三阶段：配置 5 个互不重叠审稿视角（主编/方法学/领域/跨学科/Devil's Advocate）→各视角独立走 7 维清单（初评→逐节→方法统计→可复现→图表→伦理→写作）→编辑综合（共识/分歧标注+仲裁理由）。写作模式纪律：一段一义/句间关系/逆向大纲自检/claim-evidence 硬约束。

### 8.3 数据契约
输出契约（改写章节时）：紧凑大纲 3-7 点+标注段落角色(opening/challenge/method/advantage/evidence/limitation)的改写段落+五维自审清单+`Claim: … | Evidence: … | Status: supported/needs evidence` 映射表。R→A→C 审稿回复模板带 R&R 可追溯矩阵（意见|是否已处理|回应摘要|正文位置|已核验?）。

### 8.4 提示词精华
- 「① 5 个视角**独立评审，不互相参照，避免『假多样性』**；② 综合者不得编造意见，每条须溯源到具体审稿报告；③ Devil's Advocate 判定 CRITICAL 时，决定不能是 Accept」——评审面板防塌缩三铁律
- 「每条批评须含『错在哪、在何处、怎么改』，禁泛泛套话与谄媚打分」
- 「保事实、保术语、保数字：写作/改写不得改动事实结论、专业术语与数值」
- 方法节要求「能被独立复现（材料、参数、软件版本、统计计划齐全）」

### 8.5 脚本件 / 8.6 测试
均无。纯 prompt+模板技能。模板件 6 个：peer_review_report / editorial_decision（编辑决定信+分优先级修订路线图）/ response_to_reviewers（R→A→C）/ nih_specific_aims（缺口→目标→中心假设→2-4 aims→payoff，附自查清单"每个 aim 独立不互为前提，一个失败不拖垮全部"）/ cover_letter / grant_agencies（NSF 双权重 Broader Impacts、NIH SIA 三评审轴、DOE cost sharing、DARPA 阶段里程碑+通用失败模式六条）。

### 8.7 对工程研报战场的可移植做法
1. **5 视角独立评审面板**是现成的成稿评审流水线：换成研报场景五视角（行业专家挑事实/财务专家挑数字/政策研究员挑合规/Devil's Advocate 挑核心判断/编辑综合），**独立评审不互看**+分歧仲裁留痕——比单轮 Jev 校验信息量大，成本是多轮
2. `Claim|Evidence|Status: supported/needs evidence` 映射表可做成研报逐段自检产物，直接喂审计腿
3. R→A→C 矩阵用于"用户/导师批注→修订→复核"闭环的留痕
4. 逆向大纲自检（写完倒推论点→主题句→证据点，映射不上的段落删改）接排版前质检

### 8.8 诚实质量评价
内容是通行最佳实践的 competent 汇编（IMRaD/CONSORT/NIH 套路正确但无新机制），纯 prompt 无工程件，装机 2 与其"大而全"定位不符（对 CLI 宿主过重）。缺陷：边界声明引用了生态里不存在的「引用合规技能」「实验设计技能」（悬空依赖）；模板是给学术论文的不是给研报的，需重写后才能用。

---

## 9. world-threads-entry（世界线程入口，装机 2）

### 9.1 定位与触发
TopicLab/他山世界论坛的 OpenClaw 实例运营入口：绑 key、心跳、回帖、涨积分。触发词全是平台专有名词。

### 9.2-9.6 机制/契约/提示词/脚本/测试
references/website-skill.md（631 行，从平台下载的完整协议）：每轮先 `topiclab notifications list` 优先续已有 thread；核心目标=提高 points_progress；身份=连续 instance 而非一次性代发工具；拿不准先 `topiclab help ask "<问题>"`（**问协议而不是猜 API**）；核心文件(AGENTS/TOOLS/HEARTBEAT/...)只写长期规则摘要、完整 skill 正文原样下载覆盖。无脚本无测试。

### 9.7 对工程研报战场的可移植做法
基本不可移植（社区运营与研报无关）。唯二可取：①「协议漂移→重新下载官方 skill 正文覆盖本地，本地只留摘要」与本项目渠道逆向的漂移应对同构，可作为"外部协议文档"管理规范；②「拿不准先 help ask」对应"读不到的在用数据→登记工单问上游"（已有铁律，互证）。

### 9.8 诚实质量评价
对本任务无价值，且有明显缺陷：references 里**入库了个人 bind key 和账号认领 claim 链接**（`key=tlos_2y8KvBg3sdS5`、`openclaw_claim=oc_claim_...`）——凭证随技能包分发是安全事故级失误；内容是"涨积分运营攻略"，学术含量低。装机 2 属实。

---

## 跨技能共性发现（模式级，≥5 条）

1. **「产物即证据」工作系统**（thesis-audit 表述最完整：「Treat the report as a product generated from work artifacts, not as the audit itself」）。全部高质量技能都把中间产物（账本/矩阵/run 目录/manifest/literature.csv/workflow_status.json）当一等公民，交付物只是从产物生成的视图。我们体系的产物概念集中在输入侧（弹药池），**输出侧没有对等的工作产物层**——这是最大缺口。

2. **诚实默认值工程化**，不是口号而是数据结构：image-gen 无 token 写 blocker.json 不伪造图片、quality_review_axes 分数默认 null、VLM 阻断写 blocked 状态；deep-research 无引用只能标"无证据初稿"；paper-search 缺字段填 null「不要用推测值补齐」；scispark 证据不足"stop before strong claims"。**每个质量判断字段都有"未判定"态且禁止伪造**——可全线并入渠道账本与 Jev 判断层的 schema。

3. **状态机完备化+禁留空**：pass/issue/needs_factcheck/needs_internal_crosscheck/needs_method_premise_check/needs_recalculation/needs_author_source/not_applicable/blocked（thesis-audit 九态）；answer_status 五态；verification_status 四态；reference 核验三态。共同纪律：**"看过"不等于 pass——pass 必须绑定已完成的验证动作**，状态留空即违规。我们完备门管"渠道来没来"，这套管"对象验没验"，正交互补。

4. **确定性脚本与 AI 判断的分界线显式化**：thesis-audit evidence_rules 专设两栏表（可规则化：编号/数字一致性/来源年份覆盖；必须 AI 附原文依据：问题凝练/过度解读/创新成立）；scan_verifiable_claims 自述"candidate generator, AI must clean"；find-science-skills "宿主负责理解需求，脚本执行确定性漏斗"。**脚本管枚举/一致性/统计，模型管语义/评价/措辞**，边界写在契约里而不是临场决定。

5. **验证成本分级阶梯**：复算 L0 表内一致性→L1 公式代入→L2 公开数据最小复算→L3 完整复现（且强制先走低级）；图检 机器检查→VLM 语义→人工；基线 sanity→可解释→强经典→神经。共同原则：**先便宜确定性检查，贵的检查按需升级，且"不能未经低级直接跳高级"写成硬规则**（"不要直接用需作者提供材料跳过前 1-3 步"）。Jev 积分付费资源的"必要性单查"纪律与此同构，可扩展成全链验证阶梯。

6. **技能间结构化交接合同**：paper-search→deep-research 的 `{research_question, candidate_papers, exclude, questions_to_answer}` 进 / `{references_count, answer_status, evidence_used, claims_need_fulltext_check}` 出；image-gen 的 figure_spec→check→semantic_review→manifest 文件链。**技能生态靠 JSON 契约串联而非自由文本**，且同一作者七技能共用归一化 schema（literature.csv 四技能同构）。Manus 军团下发/回收、laya 双轨影子都应合同化到此程度。

7. **进度事件协议统一**：JSONL 一行一事件（ts+elapsed_ms+event+payload），长任务节点化透明（search_started/request_prepared/response_received；stream_started/phase/references_ready/answer_delta）；SSE 必须实时透出「不能在后端等完整 done 后一次性返回」。对应我们的企微长任务通知与 EPC100 车道可见性，可统一成一套事件 schema。

8. **发版验收留痕文化**：TEST_BUNDLE_README 记录打包前 pytest 通过数+真实探针耗时；ACCEPTANCE.md 列"必须通过命令+预期"；deep-research 把三次真实调用失败史写进 SKILL.md。技能不是写完即发，是**测完+实测记录后才发**——对齐本项目干净房闸模式，可作为市场技能采购的验收标准模板。

9. **负面清单与市场表现的错位**：装机最高的两个（绘图 92/检索 74）赢在"高频刚需场景+免费可用层（dry-run/开放源回退）"，而方法学最深的 thesis-audit 只有 27——**市场选择弱依赖方法学深度，强依赖场景频率与低门槛入口**。对我们做"技能融合生产线"的启示：输出侧审计能力（最值得抄的部分）恰恰是市场稀缺位，也是我们的护城河方向（最难优先开发宪法的又一次验证）。

## 与本项目体系的一页差距对照

| 维度 | 本项目已有 | qoder 9 技能补位 |
|---|---|---|
| 输入侧完备性 | 17+渠道调度+完备门+弹药池字数门 | 证据条数阈值→结论强度分档（scispark）；失败响应分类矩阵（paper-search） |
| 调研深度 | 饱和引擎+ACH+Manus 军团 | 交接合同+answer_status 五态+claims_need_fulltext_check（deep-research） |
| 语义校验 | Jev 判断层 | 结论边界三段式（baseline-builder）；错配表（accuracy≠因果） |
| **输出侧审计** | **无** | **审计分母+覆盖矩阵+复算 L0-L2+报告正则验收器（thesis-audit）——最高优先可抄** |
| **成稿评审** | 无（Jev 是判断非评审） | 5 视角独立面板+分歧仲裁（学术写作） |
| 版本治理 | git | run 系谱+preserve/allowed/disallowed 三元组（image-gen） |
| 配图 | md2docx/排版链 | Critic→一次自动修订闭环+五轴质量（image-gen） |
| 技能治理 | super-skill/渠道 CLI 化 | 1391 条三维目录+DECISION_CONTRACT 路由器（find-science-skills） |

## 优先落地接线清单（按"我们缺什么"排序）

**P0 输出侧审计腿（抄 thesis-audit，单技能即可成腿）**
1. `audit_denominator.py`：成稿解析→枚举对象账本（每个数字/企业事实/预测/因果断言/引用一行，object_type+location+extraction_confidence）——可大量借鉴 scan_verifiable_claims.py 的正则模式组（percent/money/date/sample/cross_reference + 上下文窗口 ±90 字）
2. `verify_ledger.csv` + 状态机（九态禁留空，pass 必须绑定验证动作）：先跑 L0 全文数字互查（同一对象多处出现是否一致，纯脚本可做）→L2 用已落盘渠道数据最小复算（接入弹药池）
3. `validate_report.py`：研报结构契约正则验收（必备章节/每条数据主张带渠道 ID 与核验状态/强词黑名单"预计将大幅/龙头地位稳固/弯道超车"），exit code 接管线门——直接改 validate_audit_report.py 的章节表和禁语表即可
4. 覆盖与剩余风险章节写进研报模板：哪些主张已验/未验/blocked，禁止"未检查"被读成"没问题"

**P1 军团与判断层增强**
5. Manus 回收腿加输出合同：`{references_count, answer_status(五态), evidence_used, claims_need_fulltext_check, retrieval_limits}`；无引用产出降级为"无证据初稿"不入弹药池正账
6. Jev 输出接"结论边界三段式"：本结论在[渠道集合/时间窗/口径]下成立，尚不支持[外推]，下一步需[补证动作]；配"错配表"措辞审计规则（增速≠竞争力、订单≠市占率、样本内≠预测）
7. 证据条数阈值→措辞强度分档：N≥阈值才可写趋势断言，否则强制"初步迹象+limitation"措辞——与饱和引擎双门并联

**P2 生态与资产件**
8. 5 视角独立评审面板（审稿→仲裁→分歧留痕）作为 EPC100 高价值研报的终审腿；Devil's Advocate 判 CRITICAL 时一票否决"可交付"
9. 研报版本 lineage：每版记录父版+preserve_constraints/allowed_changes/disallowed_changes+依据证据 ID；配图腿接 Critic 一轮自动修订
10. 渠道统一归一化 schema（title/source/date/url/match_reason/verification_status ←各源字段候选表）+ request_matrix 式接口契约 fixture 做渠道适配层回归
11. 自有技能三维目录+DECISION_CONTRACT 路由器（filter_science_skills.py 纯标准库可直接移植），目录未覆盖→转工单（对齐已知空白转工单铁律）

**明令不抄**：world-threads 的凭证入库做法（安全反例）；giiisp 系的商业接口依赖本身（抄其回退/卫生模式，不抄其服务）；学术写作的论文场景模板（抄面板机制，重写场景）。
