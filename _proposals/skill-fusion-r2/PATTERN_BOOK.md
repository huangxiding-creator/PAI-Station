# PATTERN_BOOK — 跨源模式合成书（skill-fusion-r2 收官卷）

> 2026-09-26 ｜ research-orchestrator 终局产出 ｜ 输入 = 3 份原卷宗（qoder-9 / museai-hatch / genli）+ 8 组池报告（aris 41 / kdense 29 / mkt-rigor 27 / knowwork 20 / nat-acad 16 / deer-fire 15 / t2a 36 / t2b 36）
> 深读总量：**243 项技能**（原卷宗 23 + T1 148 + T2 72），净汲取 ≥232，满足用户「不少于 200 个」令。
> 判据：只收「≥2 个独立来源收敛」或「单源但机制可执行且红线合规」的模式；每条标注出处与本项目落点。

## 0. 一页总结论

十源合成的总图景与 GAP_REPORT §0 一致且更强：**输入侧我们世界级（conductor/弹药/饱和/军团/判断层，外部无一仓有等价物），输出侧（成稿→审计→验收→交付）是全部高质量外部仓的公共深处，我们整段空白。** 池组回收后新增两条硬判据：

1. **「生成与裁决分离」在 5 个互不相关的仓独立收敛**（ARIS/auto-paper/t2a 三仓/ARS paper-blind/Jev 同构）——这是全池最强的单信号，输出侧审计腿必须按此架构建。
2. **「六值 verdict 状态机 + STALE 重哈希 + 审计后改动即作废」在 ARIS 有可执行实现**（verify_paper_audits.sh 7 步 + 64 测试），W6 从「有参照」升为「有蓝本可抄」。

负面率纪律达标：八池组负面/保留占比 24%-47%（kdense 24% / knowwork 40% / nat-acad 37.5% / deer-fire 47% / mkt-rigor 30% / aris 29% / t2a 36% C 级 / t2b 31% C 级），全部 ≥20%。

---

## 1. 十四条横贯模式（融合主料）

### P1. 多值 verdict 状态机 + 禁留空 + 缺失不折算
- **内容**：一切检查对象的状态用封闭枚举表达；「看过没有」（NOT_APPLICABLE，落盘留痕）≠「没看」（静默 skip，禁）；「该审未能审」（BLOCKED）比「不适用」更危险且必须阻断；数值缺失不许编码为 0/空串/降级措辞。
- **出处（6 源收敛）**：ARIS assurance-contract 六值 PASS/WARN/FAIL/NOT_APPLICABLE/BLOCKED/ERROR（verify_paper_audits.sh 实测）；qoder thesis-audit 九态覆盖矩阵；kdense folklore 六态 `resolved|ambiguous|not-found|invalid|unsupported|unavailable`（「工具调用失败≠无证据」）+ scholar-evaluation 三态（missing 不编码 0）；rigorpilot result_match 三态（matched 须期望+容差，只有 observed 一律 not_evaluated）；mkt-rigor「FINDINGS: none 具名空态」；t2b experiment-audit PASS|WARN|FAIL。
- **本项目落点**：conductor 完备门渠道过账状态从「done/未 done」升级为六态词表；验收门 verdict 统一词表；「渠道查无数据」与「渠道不可用」分流（前者可结案后者须补采）——metaso 漂移教训的字段级固化。

### P2. 生成与裁决分离（防自我盖章）★全池最强信号
- **内容**：出具放行判决的一方不得看见执行方的修复摘要/上下文；评分腿与执行腿物理隔离（不同线程/不同调用/预承诺）。
- **出处（5 独立源）**：auto-paper Reviewer Independence（fresh thread，实证：带修复摘要评分 3/10 虚高至 8/10）；ARIS experiment-audit（executor 只收路径、外审读码判案）+ paper-talk（style-ref 永不进 reviewer）；ARS v3.6.6 paper-blind 预承诺（评审先不见稿定评分计划）；t2a 三仓收敛（skill-reviewer「assurance 不得高于证据」/ idea-creator「生成可同族、裁决不可同族」）；doc-coauthoring fresh 子代理读者测试。
- **本项目落点**：EPC100 审计腿建成时，审计 agent 只见验收标准与对象哈希、不见生成过程；自复盘盲评已是同构实践，扩展到终稿门。

### P3. 审计分母 → 双账本 → 行内绑定 → 复算阶梯（输出侧审计 OS）
- **内容**：成稿先枚举可审对象建分母账本；claim↔source 双 CSV 账本；行内 `[claim:C001][evidence:E001]` 绑定语法；复算 L0 表内一致性→L1 公式代入→L2 公开数据最小复算→L3 完整复现（禁跳级）。
- **出处（4 源）**：qoder thesis-audit（12 工作产物+复算四级+ID 前缀互联）；kdense market-research-reports（source_ledger 21 字段+claims_ledger 19 字段+audit_claim_citations.py，本池与 EPC100 最同构物）+ scientific-writing（E/C/N/M/O/R 六类 ID）；ARIS paper-claim-audit（四态 value_not_found/path_missing 正是研报数字无源判别）；t2a numerical_claim 检测器（新增数字不在被删行即拒）+ restatement 回归（摘要↔正文归一化比对六类漂移签名）。
- **本项目落点**：W10 主件。源稿带绑定标签发布版机械去标签；L0/L2 接弹药池已落盘数据；「聚合器与原始源不算独立佐证」「段尾引用不支持无关句子」写进审计规则。

### P4. 内容哈希绑定批准 + STALE 重哈希
- **内容**：「批准是内容指纹的函数不是时间戳的函数」；审计 artifact 记录 audited_input_hashes，verifier 重算比对，审计后改文件=审计作废。
- **出处（5 源）**：kdense pptx-posters（批准绑定 manifest 内容哈希）；ARIS assurance（STALE 重哈希，7 步 verifier 第 5 步）；museai magic-moment（指纹绑定审阅）；rigorpilot plan fingerprint fail-closed（命令集变了先失败不悄悄跑）；t2b data-analysis SHA256(内容) 缓存键。
- **本项目落点**：W6 核心。终稿 docx 排版前算内容哈希，验收记录绑定哈希；排版环节任何改动触发重审——堵「排版后偷改内容」洞。夜训/检查点热换类高危自动化加同款防篡改。

### P5. 模板代 vs 运行时代 + 「抄制度必须配执行器」
- **内容**：外部技能两代并存——模板代（大模板无门无降级）与运行时代（Rules 头/门/降级/负面清单）；纸面设计（文档有脚本缺/无脚本绕过测试门）是普遍病。
- **出处**：knowwork P1（Anthropic 知识工作插件两代实证）；kdense 仓规漏洞（7 个无测试技能全部恰好无 scripts）；museai 门脚本全缺失（纯文档态验收体系）；aris slides-polish inspect_pptx.py「契约先行、现场生成」纸面件 + paper-illustration review_log.json 列而不写；genli 零测试全靠 prompt。
- **本项目落点**：融合铁律——**凡引入外部制度，同步落地执行器**（CI 可跑脚本/gate_ckpt 形态），这是我们与原仓的最大差异点也是护城河位（GAP_REPORT §5 第 6 条的池组实证加厚）。

### P6. 一问定档 + 量化预算分级
- **内容**：深度档位=量化预算表（查询数×源数×页数×图表数×硬停点），不是形容词；档间升级路径显式。
- **出处（5 源）**：genli MODE_REGISTRY（light/medium/heavy 全参数+5 步传播协议）；ARIS effort(lite/balanced/max/beast)×assurance(draft/submission) 双轴+派生映射；firecrawl-deep-research（「跑多久」一问定三档带预算）；deer-flow claude-to-deerflow（三布尔组合四档）；rigorpilot trusted/candidate 双车道（授权门+车道隔离+跨 lane 断言禁令）。
- **本项目落点**：W2。EPC100 快报/标准/深度三档参数表落 MODE_REGISTRY 单一真相源；「调研深度档位」与「证据信任档位」两正交维一次定义。

### P7. worker 编排契约族（W5 全栈答案）
- **内容**：扇出=模板化 worker_prompt_template+output_schema+completion_format；步骤级 In/Out/Handoff/Gate 四元组；断点状态 JSON+24h staleness 门；verdict 类步骤禁定时器重入；done≠accepted。
- **出处（7 源拼成完整契约栈）**：museai wide-research（5 字段入/6 字段出契约+覆盖率强制入用户报告+失败只重试一次）；knowwork marketing-monday（四元组+「总数不得成为更窄口径分母」chain-seams 律，4.7x→194x 事故实证）；deer-flow SLR（并发决策表+静默丢弃警告+检索只准跑一次）；nat-acad image2ppt（run next→dispatch→record 页级认领+证据文件门+慢 worker 不许 reset）；rigorpilot（_runtime/<run_id>/ 重试不覆盖=只增不删样板）；aris（run_state phases+done≠accepted 须 verdict_id+「心跳只计数永不裁决」）；t2b 四仓收敛（断点 JSON+24h staleness+「判决类禁定时器重入」三拍）。
- **本项目落点**：Manus 军团任务卡 schema 升级（下发带指纹、回收带 answer_status 五态+evidence_used+claims_need_fulltext_check+retrieval_limits）；conductor 出队闸加「判决类任务一次性」判据；taskcards 加验收人 verdict 字段才闭账。

### P8. 验收门物理化（W6 蓝本件）
- **内容**：交付物验收=看用户将看到的形态（新鲜渲染），不是信任产出代码；机器门（非零退出挡）→新鲜眼读渲染产物→占位符扫描；三次熔断上报；failures/advisories 两级。
- **出处（6 源）**：museai artifacts/testing（三段式+「Never return a link while a gate fails」+三次熔断+后台沉默≠成功）；anthropics docx/xlsx（soffice 转 pdf→pdftoppm 逐页图+recalc JSON 门 status/total_errors，**errors_found 也 exit 0 陷阱拆穿**；Proprietary 只借做法不拷脚本）；ARIS verify_paper_audits.sh（7 步 verifier+exit 0/1）；rigorpilot result_match（过程成功≠验收成功）；nat-acad visual-review-evidence（验收=提交逐项具体观察的证据 JSON，不是打勾）；kdense pptx-posters（包安全检查清单，docx 同为 zip 同构）。
- **本项目落点**：md2docx 逐字节回归（已有）之后加「成品门」：docx→PDF→逐页图（视觉模型抽读+全文占位符扫描 TODO/lorem/xxx/待补充）；xlsx 交付走 recalc JSON 门；门不过不发企微交付通知。

### P9. 诚实降级阶梯（状态→禁令联动）
- **内容**：与其判「好坏」，不如把「可靠到什么程度」做成封闭枚举并绑定每种状态的许可动作；缺口可见化绝不填充。
- **出处（5 源）**：nat-acad（引用五态 S2_VERIFIED→FABRICATED 灰区=FAIL/专利支撑四态 unsupported 禁入正文/定位三态 source-limited 禁页级引用）；qoder answer_status 五态（无引用只能标「无证据初稿」）；kdense EDA 四层 fail-closed（Unsupported 先问格式再谈内容）；ARIS result-to-claim（REVIEW_UNAVAILABLE 首行协议——评审腿失联产物自标脏）；t2b（DATA_NEEDED grep 可检索注释+contact-research 稀疏数据降级输出不猜 persona）。
- **本项目落点**：弹药池证据卡加「验证状态枚举」字段并在入库闸生效（FABRICATED/UNVERIFIABLE 不入池）；判断层不可用时交付物自动降级标注；研报证据缺口用 DATA_NEEDED 类可检索标记而非硬写。

### P10. 免费学术检索栈（W7 即插即用组合）
- **内容**：多源路由+per-源 hazard 文件+先 count 后分页再对账+fetcher/测试成对+三层验证级联。
- **出处（5 源）**：nat-acad nature-academic-search（T1/T2/T3 分层+OpenAlex stdlib 免费零 key+preflight）；kdense paper-lookup（18 API 路由+「会在 200 里失败」hazard 纪律+paginate exit 4=走完但少记录）；aris research-lit（九源优先表+D2 零贡献源=ERROR+shard schema）；deer-flow SLR（arxiv_search.py MIT 免费 5 evals 可直装）；ARS（S2 API 协议精确到限速/env/Levenshtein≥0.70 匹配阈）。
- **本项目落点**：scholar_hub = cnki（已有）+ arxiv_search.py 收编 + OpenAlex 腿 + S2/CrossRef 验证级联；全免费零 key，合规红线。中文源仍需自补层（各仓均无中文库，验证我们的 cnki 资产稀缺性）。

### P11. 预注册判据 + 反谄媚红队协议（W9 红队腿成品件）
- **内容**：先预注册证实/证伪判据再调查；反驳打分 1-5+禁止连续让步+让步率>50% 自检+frame-lock 检测；每议题必坐异见者；分歧地图（冲突+底层权衡+什么证据能裁决）。
- **出处（4 源）**：ARS DA 让步阈值协议（决策日志 `[DA-DECISION: Score X/5|ACTION|REASON]`）+ reviewer Attack Intensity Preservation；deer-fire parallel-debugging（预注册 confirming/falsifying 两列判据+Verdict 四枚举+仲裁决策树）；t2b marketing-council（强制异见者「全同意的议会是镜子不是董事会」+分歧地图）；kdense hypothesis-generation（rival 九类矩阵+lint_causal_claims 因果动词词表 lint+防 HARKing 时间戳）。另：aris kill-argument（红队做成强制审计+落盘 verdict，进 MANDATORY_AUDITS）；aris SCOPE LIMITS 块（禁 SHA 方案/禁投机机制/禁 corner-case 沉迷——反判断层空转意见）。
- **本项目落点**：redteam.py 按 DA 协议实现（让步率可量化=对抗强度保持度可测）；因果词表 lint 直接接后置链终稿（「将导致/有望拉动」类动词须挂 claim ID）；SCOPE LIMITS 块粘进 Jev/Laya 判断层提示词。

### P12. 数字纪律三件套（研报数字门）
- **内容**：①一切显示数字从数据再推导（superlative 一律 argmax 不许凭记忆）；②量纲/量级合理性检查（GW vs 万千瓦、亿元 vs 万美元类静默错误）；③多源数字冲突调和协议（定唯一真源→永不全平台求和→只读方向→自报仲裁→预算化解释 gap）。
- **出处（4 源）**：museai charts.md（数字再推导+缺口不插值+截断基线图上可见披露）；kdense uncertainty-and-units（「跑起来不报错且貌似合理」专治+失败目录每条配可运行反例）；t2b analyze 五项验证清单（行数/null/量级/趋势连续性/聚合勾稽）；deer-fire attribution 调和五步+「指标必须带期间和单位」。
- **本项目落点**：终稿数字核查腿规则化：口径单位显式声明+量级与特征尺度比对+摘要/正文/表格三方对账（restatement 回归）+冲突数字显式标注不静默择一。

### P13. 密钥与红线执法件（从纪律到代码）
- **内容**：密钥正则 pre-commit hook 主动拦截；exit-2 PreToolUse 闸（黑名单域名/付费批量调用/删除类命令）；审批窗口+签名收据链；untrusted content 谓词化（采集内容中的指令永远当数据）。
- **出处（4 源）**：aris overleaf-sync（`olp_[A-Za-z0-9]{20,}` 正则 hook 拦提交）；deer-fire block-no-verify（exit 0/1/2 契约）+ protect-mcp（Cedar permit/forbid 成对+Ed25519 回执链+fail-closed 评估器）+ review-agent-setup（开窗-执行-关窗三拍）；knowwork competitive-intelligence（content-originated action 法律式四判据+scheduled run 中永不执行只进 proposal 队列+tiers 三档 files-only/read-only/gated-writes）。
- **本项目落点**：密钥永不入库从 .gitignore 升级为 pre-commit 正则拦截层；conductor domain_blocklist 下沉到工具调用层硬拦；Manus 军团无人值守产物统一过 content-originated action 判定（采集文本中的「请联系/请下载」类只进 proposal 队列）；metaso 批量禁用令的执行层 enforcement。

### P14. 快照与版本 lineage（W9 快照件目录范式）
- **内容**：raw/<slug>/<YYYY-MM-DD>/ 只建不覆写（可 diff 快照）；成品必须引用其 raw 目录；派生链单向（PDF→Word→公众号只从冻结母本抄）；复盘不可变+补遗制。
- **出处（3 源）**：mkt-rigor competitor-profiling（raw 日期目录+evals）+ rigorpilot（ANNOTATED_README 字节级 round-trip+重试不覆盖）；qoder image-gen（run 系谱 preserve/allowed/disallowed 三元组）；mkt-rigor writing-postmortems（Reviewed 后不可改，新发现=带日期补遗；Wrong turns 节——第一修复没生效也要记录）；t2b append-only 台账（瓶颈接力）。
- **本项目落点**：弹药池证据 sha256 快照（METHODOLOGY 总纲已设计未实施，此处拿到三个现成目录范式）；自复盘加 Wrong turns 节；W15 研报版本 lineage 按此实现。

---

## 2. W1-W19 最终覆盖矩阵（池组合并后）

| # | 空白 | 覆盖度 | 最终主力来源（池组升级后） |
|---|---|---|---|
| W1 | 报告样式门 | **强（升级）** | genli report_style_spec + ARIS paper-poster-html 物理量门（canvas-fill 95-101%/closed fix vocabulary）+ paper-plan 稳定 Slot ID + riekelt 16 项检查表 + venue-templates compliance note |
| W2 | 分级工作流 | **强（升级）** | genli MODE_REGISTRY + ARIS effort×assurance 双轴 + firecrawl 一问定档 + kdense EDA 四层能力矩阵（渠道侧映射）+ rigorpilot 双车道 |
| W3 | 出版级图表 | **强（升级）** | genli chart_template.py + kdense scientific-visualization（provenance 侧车+palette_audit+查交付物不查代码）+ ARIS figure-spec 声明式 spec/渲染分离 + STRICT 逐元素评审清单 + deer-flow chart-visualization 26 图型路由 + museai charts.md 数字纪律 |
| W4 | PDF 结构化解析 | **强（升级）** | kdense liteparse（per-token bbox，Apache-2.0 本地）主腿 + genli 三级链 + nature-paper-card 定位三态 + nature-reader source_map 稳定块 ID + pdfplumber 表格腿 |
| W5 | 多 worker 编排契约 | **强（升级）** | P7 契约族七源拼图：wide-research+四元组+并发决策表+指纹 fail-closed+断点 24h 门+done≠accepted+回包五件套 |
| W6 | 交付物验收门 | **最强（升级）** | P8 六源：三段式+STALE 重哈希+result_match+证据文件门+recalc JSON+三次熔断 |
| W7 | 学术检索聚合 | **强（升级）** | P10 五源免费组合：arxiv_search.py 直装+OpenAlex+T1/T2/T3+fetcher/测试成对+三层验证级联；中文源自补 |
| W8 | 选题简报 schema | **强（升级）** | deer-fire consulting-analysis 数据需求表六字段（直通 conductor 出队）+ rigorpilot campaign 七字段+想法硬门 + genli topic-brief event_date 落窗 + aris IDEA_REPORT Eliminated 带死因 + experiment-plan anti-claims |
| W9 | 三新件未实施 | **强（升级）** | 红队=P11 四源成品件；快照=P14 三范式；校准=kdense weight_sensitivity 排序不稳性 + ARS FNR/FPR 金集验收（NOT_CALIBRATED 自标）+ Sign-off append-only + Brier 对账 |
| W10-W19 | 见 GAP_REPORT §3 | 全部加固 | 双账本（kdense）/六值词表（ARIS）/断点 24h（t2b 四仓）/传播协议（genli）/三态正交（museai+kdense）/时态（museai）/阈值→措辞（qoder+statistical-power 敏感性曲线）/边界三段式（qoder）——池组各补 1-2 个实现件 |

**池组新增差距（登记进 GAP_REPORT §7）**：
- **W20 扩标数据集泄漏审计**：hypogenic audit_dataset 跨 split 精确重复=硬门（pinned 数据集实测抓 3 组泄漏）——laya v2/v3 扩标质检直接可用，防同类研报句子同进 train 与 held-out。
- **W21 per-hunk 增量审计路由**：aris overleaf-sync 每个 diff hunk 按内容类型（正文/引用/数值）路由到对应重审计——第 N 轮改稿只重审改动部分，免全文重审，审计成本随轮次不随篇幅涨。
- **W22 staging adapter 审计复用**：aris paper-talk 构造合成目录让既有审计腿原样跑在新体裁上——宣传三件/公众号稿复用研报审计，免为新体裁重写审计器；降级标签制（不合门标 polished 而非硬发）。

## 3. 多仓独立收敛清单（最强信号，融合优先级依据）

| 收敛模式 | 独立源数 | 源列表 |
|---|---|---|
| 生成与裁决分离 | 5 | aris / t2a(auto-paper+skill-reviewer+idea-creator) / nat-acad(ARS) / knowwork(doc-coauthoring) / （本项目 Jev 判断层同构印证） |
| 断点状态 JSON+24h staleness | 4 | aris 全家 / t2b marketing-plan / rigorpilot / nat-acad |
| 多值 verdict+具名空态 | 6 | aris / qoder / kdense / rigorpilot / mkt-rigor / t2b |
| raw 日期快照只建不覆写 | 3 | mkt-rigor / rigorpilot / qoder(run 系谱) |
| 探针失明≠事实不存在 | 3 | mkt-rigor(seo-audit) / rigorpilot / t2a(hypogenic)；另有 museai 死链=源失败、aris NOT_APPLICABLE≠SKIP 同族 |
| 负触发 evals/路由契约 | 2 | deer-flow SLR eval#4 / firecrawl 反触发声明段 |
| fetcher/测试成对 | 2 | aris 渠道族 / deer-flow arxiv_search 5 evals |
| 只读审计与修复执行分离 | 3 | t2a skill-reviewer / knowwork crm-hygiene / rigorpilot analyze-project |
| 诚实自曝=质量信号 | 3 | rigorpilot(502 未验收) / ARS(NOT_CALIBRATED) / mkt-rigor(OKF 无爬虫收益)——选型准入 heuristic |

## 4. 明令不抄汇总（合并负面清单，安全/质量红线）

1. **凭证与密钥**：qoder world-threads 凭证随包分发（安全反例永不安装）；aris paper-illustration 密钥入 URL 查询参数 + auto-review-loop-llm 凭据明文 curl fallback——实现须按本仓 keyning 纪律重造。
2. **商业/付费绑定**（只抄模式不抄服务）：giiisp 系接口本体；firecrawl 全系（FIRECRAWL_API_KEY）；composio 五件（rube.app 中间层）；Composio/apollo/DataForSEO/Ahrefs 系；aris 8 技能绑 Codex MCP+2 绑 Gemini（换轨图=auto-review-loop-llm 国产模型表）；bgpt-paper-search（$0.01/结果）；nature-image2ppt 后端（百度 OCR/GPT Image）；ARS 需 ANTHROPIC_API_KEY。
3. **Proprietary license**：anthropics docx/xlsx——只借鉴做法（渲染成图闭环/recalc JSON 门），永不拷贝脚本。
4. **纸面件**（制度好执行缺，须自建执行器）：museai artifacts 门脚本全缺；aris slides-polish inspect_pptx.py 现场生成无测试；kdense 7 个无 scripts 绕测试门技能；genli 零测试。
5. **平台与配置面**：genli macOS 栈（Songti/xelatex）移植须换 Windows 字体链实测；ARS 配置面爆炸（几十 env 开关）+人审 checkpoint 密度与 7×24 冲突——移植须砍九成交互门；rigorpilot ~2500 行×2 编排器过重——择机制不整体安装。
6. **魔法数与审美立法**：rigorpilot 想法门七阈值无校准出处（伪精确风险）；museai sentence case/slide furniture 产品口味非工程真理；自违反仓（travel-planning 343 行 vs 自家 trim aggressively）。
7. **冗余成对病**（同题必合并、评测与文档同改）：knowwork 三对半冗余实证；aris formula-derivation 被 proof-checker 吸收遗留。

## 5. 采购与移植分账

**可直装/收编（免费+红线合规，4 件）**：
| 件 | 来源 | 许可 | 用途 |
|---|---|---|---|
| arxiv_search.py | deer-flow | MIT | conductor 学术渠道（免费零 key，5 evals） |
| OpenAlex 腿（academic_search.py stdlib） | nature-skills | Apache-2.0 | W7 兜底检索（免费零 key） |
| liteparse | K-Dense 包装（Apache-2.0 工具） | Apache-2.0 | W4 PDF per-token bbox 主腿（本地离线） |
| GLM/DeepSeek/Kimi 评审后端表 | aris auto-review-loop-llm | 表值照录 | 免费评审腿接线图（实现重造） |

**模式移植自建（执行器我们写，制度抄上面 14 条）**：输出侧审计腿/交付门/样式门/分级工作流/scholar_hub/topic_card/三新件/军团契约/数字门/快照——全部按 P5 铁律「制度+执行器」成对交付，落 EPC100/conductor 既有形态（tick/gate_ckpt/postchain），不引入外部框架。

**安装纪律**：任何安装前过 SkillSpector（NVIDIA 71 漏洞模式扫描，装机重试在途）+ 凭证正则扫描（本池已扫，仅误报）；world-threads 型（凭证随包）永久拒装。

## 6. 数据回填

- 池目录 `research/pool_catalog.jsonl`：1842 unique skills（T1 160 / T2 档 3-7 分数百级 / T3 弱相关）；本卷完成后「已深读」标记 243 项。
- 八组报告原件：`RESEARCH_DOCKET/pool/{aris,kdense,knowwork,mkt-rigor,nat-acad,deer-fire,t2a,t2b}.md`（合计约 1900 行）。
- 三份原卷宗：`RESEARCH_DOCKET/{qoder-9,museai-hatch,genli-market-research}/EXTRACTION.md`。
