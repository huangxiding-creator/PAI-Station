# 世界顶级调研能力终极提案（ULTIMATE_PROPOSAL）

> 铸模法：双波调研成果（波1方法论164项 + 波2情报方法论80项 = 244项，stars 全部 gh api 实测 2026-10-28）× 现役资产盘点（1028实测）× 1026 四大差距诊断 → 分级可落地提案。
> 铁律在役：免费宪法（纯付费方案不出现在执行计划，仅在附录 H 标注「需用户付费决定」）/ 可落地（每项有具体命令与文件路径）/ 数字零造假（所有数字注明实测来源，目标值明确标注）。

---

## 一、执行摘要

1026 诊断的四大差距中，③规范化数仓与④语义判层已有地基但未收口（数仓 4 表 3,602 行、无图谱、无日更；判层复验仅 1/16 战役且实证翻案率 41.8%），①一手价格与②人类专家网络是结构性缺口；本提案从 244 项调研中铸出 18 项分级提案——6 项 P0（本周零预算收口：判层全战役复验+常开、akshare 免费面数仓扩容、GDELT 免费监测腿、MarkItDown 入池格式化、免费盯梢三件套、三技能收编）、6 项 P1（1-2 周改造：LightRAG 图谱层、FacTool 式 claim 级核查链、TradingAgents 牛熊对抗辩论、微信访谈腿即专家网络免费平替、数仓日更活水、公众号监测总线）、6 项 P2（方法论长跑：S&P 记分卡、麦肯锡七步立题门、STORM 多视角问询、graphiti 双时间轴、OSINT 尽调 SOP、校准账本复利），全部零预算（GLM-4-flash 免费档 / akshare / GDELT / 开源 MIT-Apache 件），按投入产出比排序，每项验收标准可证伪。

---

## 二、现役资产盘点基线（1028 实测，差距矩阵的分母）

| 资产 | 实测值 | 来源 |
|---|---|---|
| 渠道注册表 | MASTER_REGISTRY.json 620 条（A=195/B=234/C=185/D=6） | channels_survey_2026/B级接入总账.md（脚本逐项复算，断言通过） |
| B级 234 分桶 | free_key 64 + dataset 21 + free_register 124 + paid_only 25 → 免费可接入面 209/234 = **89.3%**（任务输入另载「付费库平替 95.7%」，本仓台账未见落字，双列如实） | btier_plan.json + B级接入总账.md |
| B级点亮 | lit_total=70（免费钥波 7 引擎 + 免费注册波 63 条）；钥申领执行轮 lit=3（FIRMS/GNews/Tavily）+ pending=3 + wall=8 + paid-skip=1 | btier_freekey_ledger.md §⑤（零硬闯零验证码突破） |
| HTTP 引擎 | HTTP_ENGINES **146 条**（AST 实测 1028；台账轨迹 134→+8→+4） | legs/api_replica_bridge.py + 集成台账.md |
| 腿 | 目录 `*_leg.py` **150 件**（1028 ls 实测）；台账编内 134（在役 15 + 批量建造 119，编译门 119/119 绿） | channels_survey_2026/腿建造台账.md |
| ETL 数仓 | data/warehouse/price_finance.db（630,784 B；4 表；行数 8+1,469+1,775+350=**3,602**；源=akshare 1.19.3 全免费；混凝土日线缺口如实留白） | data/warehouse/etl.py + etl_log.jsonl（1026） |
| 语义判层 | semantic_judge.py L2（GLM-4-flash 免费档，SEMANTIC_JUDGE 环境变量默认关）；复验 1 次：EPC-JIAGE 候选 592 → 跑 292（cap）→ **翻案 122（41.8%）**/维持 163/误 7，耗时 1,173.7s，双钥轮换 292 次 | _tmp_semantic_replay_report2.json（2026-10-26） |
| 弹药池战役 | E:/AI-Station/ammo_pool/ 下 **16 个战役目录** | ls 实测 |
| 方法论宪法 | METHODOLOGY.md v2（S1-S7 + Tetlock 校准/Bellingcat 快照/RAND 红队）+ consulting_forge_doctrine.md v6（主张身份分级/叙事弧线/方法路由） | reforge_factory/ |
| 质量门族 | density_gate.py（v3 长度分层标尺）/ rqs_v3 V3-CITE 与 V3-QUANT / report_gate_check.py / grade_rules.py / blindspot_sensor.py / entity_coverage.py / entity_timeline.py / ach_arena.py / redteam_run.py / calibration_ledger.jsonl + brier_score.py | reforge_factory/ |
| 调研弹药 | 波1 164 项（可直接采用 45/需改造 13/方法论参考 91/纯论文 15）+ 波2 80 项（直接采用 23/开源可改造 30/方法论参考 17/需付费 10）→ **免费可用 234 项** | survey_methodology.json + survey_intelligence.json |

---

## 三、差距矩阵（每差距 × 现役资产 × 世界级方案 × gap 量化 × 承接提案）

| # | 差距 | 现役资产（实测） | 调研发现的世界级方案 | gap 量化 | 承接提案 |
|---|---|---|---|---|---|
| ① | 一手价格（结构限制=免费宪法） | ETL 4 表：8 公司×3 财务指标×5 年 + 3 商品序列（螺纹钢/沥青/水泥 proxy）+ 4 宏观指标；混凝土日线缺口留白；招投标价格序列 0；海外价格锚 0 | OpenBB（74,797★ AGPL）/ a-stock-data（87 端点 34 源）/ GDELT DOC 2.0（免费已注册，中文全文检索）/ ACLED（学术免费）/ B级 dataset 21 条（OpenSanctions 等） | 表品类 4 vs 目标 ≥7；商品品类 3；海外事件源 0；数仓 1026 后冻结无日更 | P0-2 / P0-3 / P1-5 / P1-6 |
| ② | 人类专家网络 | 0 专家通话 / 0 访谈纪要；现役人类信号=微信洞察（被动 JTBD 信号） | GLG/AlphaSights/Guidepoint/Third Bridge/ProSapient（全付费→附录H）；**免费平替路径**=Inex One 免费目录（行业模式拆解）+ Third Bridge「访谈前调研包」模式 + AlphaSights 合规防火墙机制 → 微信访谈腿 | 池内一手人类信息占比 0%（全部为公开资料）；顶级咨询每项目 5-20 通专家电话 | P1-4（免费面）/ 附录 H（付费面） |
| ③ | 规范化数仓（ETL 已建但浅） | price_finance.db 单层关系表，无图谱层（实体关系 0），无日更（1026 冻结），无双时间轴（仅 etl_log 时间戳） | LightRAG（40,369★ MIT 双层检索+增量更新）/ graphiti（32,283★ MIT bi-temporal 双时间轴）/ RAPTOR（1,775★ 层级摘要）/ papermill（6,496★ 参数化批跑） | 表→图谱 0 层；时效=冻结快照；「事件时间 vs 摄取时间」可答性 0 | P0-2 / P1-1 / P1-5 / P2-4 |
| ④ | 语义判层（已建但覆盖率待验） | L1 启发式 + L2 GLM 语义复核已接线 ammo_pool.judge（791 行位），但默认关；复验 1/16 战役且 cap 截断（292/592=49.3%）；实证翻案率 122/292=41.8%（外文材料系统性误杀存在且量大） | FacTool（935★ Apache-2.0 claim 抽取→双路核查）/ FActScore（460★ 原子事实分解）/ RefChecker（434★ triplet 比对）/ ALCE（528★ citation recall/precision 机器判层标准）/ DeepEval（19,145★） | 复验覆盖 1/16 战役；L2 常开率 0；判层粒度=材料级（claim 级 0） | P0-1（收口）/ P1-2（升维到 claim 级） |

---

## 四、P0 分级提案（立即可落地 · 零预算 · 对接现有基建）

### P0-1 语义判层全战役复验 + L2 常开【优先序 1】

- **名称**：判层收口——16 战役全量 replay，翻案回写，SEMANTIC_JUDGE 默认常开
- **来源**：内部件收口（semantic_judge.py + _tmp_semantic_replay2.py 已实测可跑）；世界级判层标准锚=ALCE citation recall/precision（波1 LANE6，方法论参考）
- **对接现有资产**：`E:/AI-Station/reforge_factory/semantic_judge.py`（L2）+ `E:/AI-Station/reforge_factory/ammo_pool.py` judge 主循环（791 行 P1-1 接线位）+ `E:/AI-Station/ammo_pool/` 16 战役 + `E:/AI-Station/reforge_factory/completeness/`（复验产物落盘位）
- **实施步骤（≤5）**：
  1. 把 `_tmp_semantic_replay2.py` 固化为 `reforge_factory/semantic_replay.py`（cap 参数化 + 断点续跑 + 逐战役产物落 `ammo_pool/<战役>/completeness/semantic_replay.json`）；
  2. 逐战役跑全量（EPC-JIAGE 补跑剩余 300 候选；其余 15 战役首跑），GLM-4-flash 免费档双钥轮换沿用；
  3. 翻案回写：flips（L1 判废→L2 valid）批量改判 `pool_state.json` 账本与 manifest，回写动作落 `decision_ledger.jsonl`；
  4. `SEMANTIC_JUDGE=1` 写入调度环境（run_sched_legs_r1.cmd），L2 由「保守关」转「常开」，judge 主循环其余逻辑不动；
  5. 汇总 16 战役复验报告落 `reforge_factory/completeness/semantic_coverage.json`（每战役 flips/holds/errs/翻案率）。
- **验收标准（可证伪）**：16/16 战役 replay 完成，覆盖=全部「L1 判废 ∧ 外文信号」候选（cap 解除）；连续 7 天新入池材料的 L2 触发记录 ≥1 条/天（semantic_coverage.json 含 daily 字段）；回写后 pool_state.json 有效字数账本变化与 flips 逐条对账可重放。
- **预期提升（量化）**：复验覆盖 1/16→16/16 战役；按已实证单战役翻案率 41.8% 口径，16 战役预期恢复有效弹药数百件级（**以逐战役实测为准，不预填**）；外文材料系统性误杀从结构性问题降为可审计事件。

### P0-2 ETL 数仓第二期扩容（akshare 免费面盘点入仓）【优先序 2】

- **名称**：price_finance.db 从 4 表到多表层——招投标/人工/机械/海外面
- **来源**：w2-069 a-stock-data（15 层 87 端点 34 源，开源可改造）作覆盖面参照；数据源沿用现役 akshare 1.19.3（全免费）
- **对接现有资产**：`E:/AI-Station/data/warehouse/etl.py`（4 表 schema 已立）+ `E:/AI-Station/data/warehouse/price_finance.db` + `E:/AI-Station/reforge_factory/legs/warehouse_leg.py`（查询路由 METRIC_KEYS/COMMODITY_KEYS/MACRO_KEYS）
- **实施步骤（≤5）**：
  1. 盘点 akshare 免费面中建筑/造价/海外工程相关接口（脚本逐个试拉，**可拉才入清单，缺口如实记录**——沿用混凝土缺口先例）；
  2. etl.py 新增 jobs（候选方向：招投标/中标价、人工成本、机械台班、海外宏观——以盘点实测为准），schema v2 增表，每行 source 字段全落；
  3. warehouse_leg.py 查询路由按新表扩键；
  4. `py data/warehouse/etl.py run all` 全量重跑 + `counts`/`verify` 双命令出实测行数；
  5. 缺口清单（免费面无序列者）落 `data/warehouse/gaps.md`，不伪造。
- **验收标准（可证伪）**：`py data/warehouse/etl.py counts` 新表行数 >0 且 verify 3 查询通过；任抽 20 行 value 可回溯 source 接口（复拉一致）；gaps.md 每条缺口有接口名与实测响应为证。
- **预期提升（量化）**：表 4→≥7（目标值，以落库实测为准）；行数 3,602→≥10,000（目标值，验收以 counts 实测为准）；商品/成本品类 3→≥8；差距③从「已建但浅」到「覆盖面可举证」。

### P0-3 GDELT 双 API 监测腿（免费已注册）【优先序 3】

- **名称**：全球事件+全文检索免费流接入 146 引擎池
- **来源**：w2-022 GDELT Project（免费公开，probe=200，已注册）+ w2-023 GDELT DOC 2.0 API（全文检索+情绪+实体+时间线，支持中文查询）+ w2-024 gdeltPyR（GPL-3.0 Python 客户端，内部使用合规）
- **对接现有资产**：`E:/AI-Station/reforge_factory/legs/api_replica_bridge.py` HTTP_ENGINES（146 条，只增不删 + .bak 先行）+ 新薄腿照 7 件样板（ecb_sdw/nasa_images 等）+ `E:/AI-Station/reforge_factory/superline/demand_radar.py`（radar_signals.jsonl 三快源之一 policy_pulse）
- **实施步骤（≤5）**：
  1. HTTP_ENGINES 增 `gdelt_doc` 条目（免费无 key，查询模板+代理位注明）；
  2. 新建 `reforge_factory/legs/gdelt_doc_leg.py` 薄腿（--campaign/--queries 参数对齐 warehouse_leg 风格），AST 编译门绿；
  3. EPC-OVERSEAS 冒烟：中文查询实测入池 ≥1 件（channel_invocations.jsonl 落行）；
  4. demand_radar 挂 GDELT 定时流（15 分钟级，调度避峰窗口）；
  5. 台账落 `channels_survey_2026/集成台账.md` 增行（只增不删）。
- **验收标准（可证伪）**：冒烟 HTTP 200 且命中 ≥1 件入池（台账行为证）；连续 3 天定时任务在 radar_signals.jsonl 留痕 ≥3 条/天。
- **预期提升（量化）**：全球事件监测源 0→1；免费中文全文检索 API +1；HTTP_ENGINES 146→147；差距①海外一手信号面首破。

### P0-4 MarkItDown 入池统一格式化【优先序 4】

- **名称**：调研原始件（PDF/DOCX/PPTX/XLSX）进证据池前的免费统一格式化
- **来源**：microsoft/MarkItDown（192,569★ MIT，w2-056 直接采用）
- **对接现有资产**：`E:/AI-Station/reforge_factory/harvest_localfiles.py`（本地件腿）+ ammo_pool ingest 前置位
- **实施步骤（≤5）**：
  1. `E:/AI-Station/.venv` 安装 markitdown（按官方 README）；
  2. harvest_localfiles 入池前批转 md（转换失败件如实留 pending，不静默丢）；
  3. 抽 100 件人工对照转换保真（正文/表格/数字三查）；
  4. 保真结论与坑回写 `reforge_factory/factory_gotchas.md`（只增不删）。
- **验收标准（可证伪）**：100 件抽检保真 ≥95%（数字零漂移为硬门，一个数字漂移即 FAIL 打回）；失败件 pending 率落账。
- **预期提升（量化）**：可判材料格式 3 类（md/html/txt）→7 类（+pdf/docx/pptx/xlsx）；judge 覆盖面从纯文本扩到公文/标书/PDF 报告主流格式（提升幅度以入池格式分布实测为准）。

### P0-5 免费盯梢三件套（FTP + Google Alerts + Talkwalker）【优先序 5】

- **名称**：关键页 7×24 变更监测的零运维兜底腿
- **来源**：w2-029 Follow That Page（免费档 5 页/日检，probe=200）+ w2-042 Google Alerts（免费）+ w2-043 Talkwalker Alerts（免费邮件，probe=200）
- **对接现有资产**：`E:/AI-Station/reforge_factory/superline/demand_radar.py`（信号源位）+ `E:/AI-Station/reforge_factory/harvest_intake.py` + qqmail-cli（51817@qq.com 只读轮询能力已在役）
- **实施步骤（≤5）**：
  1. 选盯梢清单：招标公告页/政策发布页/竞品定价页/付费库竞品公开页（≤5 页入 FTP，长尾专有名词入双 Alerts）；
  2. 三件免费盯梢注册落位（清单文件落 `reforge_factory/config/`）；
  3. 告警邮件 → qqmail-cli 轮询 → harvest_intake 入池（grade=C 待升标注）；
  4. demand_radar 挂告警为快源之一；
  5. 盯梢台账只增不删。
- **验收标准（可证伪）**：5 页 + ≥10 关键词全登记在册；首月捕获变更 ≥10 条且 ≥1 条进雷达信号账（radar_signals.jsonl 可查）。
- **预期提升（量化）**：7×24 盯梢页面 0→5 + 关键词告警 2 路（Google/Talkwalker 双轨互备）；页面变更发现时效从「下次人工巡检」到「邮件分钟级」（以首月实测捕获数为证）。

### P0-6 三技能收编（券商深研 / 12 阶段深挖 / 记者核查）【优先序 6】

- **名称**：即装即用 skill 蒸馏收编——只取真增量
- **来源**：hoolulu/deep-research（605★ 券商级深研 skill）+ Socialpranker/deepdive（368★ 12 阶段研究管线 + claims 台账）+ jamditis/claude-skills-journalism（436★ 记者级核查工作流）（均波1 LANE1/3，可直接采用）
- **对接现有资产**：`E:/AI-Station/reforge_factory/crossdisc/method_cards.py`（方法卡库）+ manus-report-replica skill（既有七层工作流）+ rqs_v3 V3-CITE（既有引用门，对照防同构重复吸收）
- **实施步骤（≤5）**：
  1. 三仓 clone 到参考位（只读吸收，不装不改产线）；
  2. 逐件蒸馏差异表（对方件 vs 我方 S1-S7+V3-CITE 逐条对照，同构件弃用）；
  3. 真增量并入 method_cards.py（候选：deepdive 的 claims 台账纪律、journalism 的核验流程、券商 skill 的深研编排）；
  4. 下一战役冒烟引用 ≥2 张新卡。
- **验收标准（可证伪）**：差异表落盘 `reforge_factory/crossdisc/`（含「同构弃用」判定行）；新方法卡 ≥2 张且在下战役产物中被引用（引用记录可查）。
- **预期提升（量化）**：方法卡库 +≥2 张真增量（差异表为证）；零自研成本（clone+蒸馏即可）。

---

## 五、P1 分级提案（需改造 · 1-2 周）

### P1-1 LightRAG 图谱层首建（弹药池→实体关系图）【优先序 9】

- **来源**：HKUDS/LightRAG（40,369★ MIT，双层检索=低层实体+高层主题，增量更新，落地成本低于微软版；备选 gusye1234/nano-graphrag 4,006★ 极简可 hack）
- **对接**：`E:/AI-Station/ammo_pool/<战役>` valid 弹药 + `E:/AI-Station/reforge_factory/entity_coverage.py`（既有实体覆盖账本，对账口径）+ `E:/AI-Station/reforge_factory/legs/warehouse_leg.py`
- **步骤**：① .venv 按 LightRAG 官方 README 安装；② 单战役（EPC-JIAGE）valid 弹供建索引；③ 实体抽取落 SQLite，与 entity_coverage 口径对账；④ 5 个多跳问题冒烟（每个答案带弹药源回链）；⑤ 性能/成本报告落 completeness/。
- **验收**：实体数 ≥500（首战役，实测落账）；与 entity_coverage 对账偏差 ≤5%；5/5 多跳问题给出带源回答（无源=FAIL）。
- **提升**：差距③数仓从单层表→「表+图」双层；实体级关联检索 0→1。

### P1-2 claim 级核查链（FacTool 移植）【优先序 7】

- **来源**：GAIR-NLP/factool（935★ Apache-2.0，claim 抽取→检索+代码执行双路核查）+ Factcheck-GPT（117★，FactCheck-Bench 官方数据集宿主）+ FActScore（460★，原子事实分解→逐条核验→百分比）
- **对接**：`E:/AI-Station/reforge_factory/report_gate_check.py`（成稿门）+ rqs_v3 V3-CITE（引用门）+ `E:/AI-Station/reforge_factory/ai_reviewer.py`
- **步骤**：① 成稿抽取原子 claim（按句/按数字）；② 本地弹药池优先检索核验（池内无据→免费引擎补查）；③ 支持/反驳/无据三态判定；④ 无据 claim 清单回写章节修订项；⑤ 与人工抽检 20 条对齐率报告。
- **验收**：20 条人工抽检一致率 ≥80%（低于即打回调 prompt）；每份成稿无据 claim 数落账可跨报告比较。
- **提升**：核查粒度从章级/材料级→断言级（差距④升维）；「每句话有出处」从人工纪律变机检指标（ALCE citation recall/precision 口径）。

### P1-3 牛熊对抗辩论轮（TradingAgents 移植）【优先序 8】

- **来源**：TauricResearch/TradingAgents（117,312★，analyst 团队→research 团队牛熊对抗辩论→trader→risk manager 可否决）
- **对接**：`E:/AI-Station/reforge_factory/ach_arena.py`（CIA ACH 对抗场）+ `E:/AI-Station/reforge_factory/redteam_run.py`（RAND 红队，premortem+KAC 已规划）+ METHODOLOGY.md 验收判据 3
- **步骤**：① 红队轮升级为牛方/熊方双角色（各 ≥3 论点，每论点强制挂树证据）；② 独立军团会话裁决轮（contextTransfer 上下文隔离，防自查放水）；③ 无证据论点判无效；④ 裁决结论回写章节修订项；⑤ 第 11 份报告全链试行。
- **验收**：premortem 失败路径中 ≥1 条导致成稿实质修改的比例 ≥50%（宪法判据，可证伪）；辩论轮产物落 decision_ledger.jsonl。
- **提升**：对抗校验从单轮红队→结构化辩论+可否决位；关键判断的反驳覆盖率可量化（每判断 ≥1 反方论点为门）。

### P1-4 微信访谈腿（专家网络免费平替）【优先序 11】

- **来源**：w2-019 Inex One 专家网络目录（免费公开，逐家运作模式/定价横向拆解）+ Third Bridge「访谈前调研包」模式（w2-016）+ AlphaSights 合规防火墙机制（w2-015）——付费件本身只进附录 H
- **对接**：wechat-intelligence-hub skill（微信群 JTBD 信号）+ wechat-claw 审批通道（一切互动+审批走微信桥）+ ammo_pool（访谈纪要=grade B 一手证据入池挂树）
- **步骤**：① 访谈 SOP 文档落 `reforge_factory/expert_call_sop.md`（招募→合规过滤→匹配→1 小时通话→纪要转录→入池，五段对齐 GLG 模式）；② 提问卡模板（Third Bridge prep pack 式：对象背景/已搜到什么/缺口 3 问）；③ 合规门（不碰内幕/竞业/在审项目，触发即停）；④ 微信群行业人试点 3 人；⑤ 纪要结构化入池（grade=B/一手 标注）。
- **验收**：3 次试点完成，每次纪要 ≥1 条一手判断入池且挂树 EEI；合规门零触发或触发即停记录在案。
- **提升**：一手人类信号 0→≥3 条/战役（差距②免费面首破）；专家访谈成本 ¥0（付费网络对照：GLG 类按通话计费——见附录 H）。

### P1-5 数仓日更活水（papermill/计划任务）【优先序 10】

- **来源**：nteract/papermill（6,496★ BSD-3，参数化批量执行，生产化调度友好）
- **对接**：`E:/AI-Station/data/warehouse/etl.py` + Windows 计划任务（mission-engine Startup 守护在役）+ 企微告警通道（tools/notify_approval_wecom.py 复用）
- **步骤**：① etl 作业包装为可参数化批跑（cmd/notebook 双形态其一）；② 计划任务挂日更（非高峰窗口，token 峰值令在宪）；③ etl_log.jsonl 增量断言（行数单调性校验）；④ 失败企微告警；⑤ 7 日试运行出稳定性报告。
- **验收**：连续 7 天日更成功，行数增量全落 log；失败 ≤1 次且告警 5 分钟内到企微。
- **提升**：数仓时效从「1026 冻结快照」→「日级滚动」（差距③）；序列新鲜度可答（最新数据日期 ≤48h）。

### P1-6 公众号监测总线（we-mp-rss + RSSHub + FreshRSS）【优先序 12】

- **来源**：rachelos/we-mp-rss（5,049★ 公众号转 RSS/Markdown，开源可改造）+ RSSHub（46,687★，**已装在役**）+ FreshRSS（16,428★ AGPL 自托管聚合落库；AGPL 内部使用无碍）
- **对接**：RSSHub（在役中枢）+ harvest legs + `E:/AI-Station/reforge_factory/superline/demand_radar.py` + 既有 ima 收割/搜狗微信（去重对账面）
- **步骤**：① 自托管部署 we-mp-rss（免费）；② 行业公众号 20 个转 RSS 订阅流；③ FreshRSS 聚合落库；④ 增量文→harvest_intake 入池；⑤ 与既有公众号腿（ima/搜狗微信）URL 归一去重对账。
- **验收**：20 公众号 7 天连续 feed 无断流；新文入池 ≥50 件且去重账通过（重复率如实落账）。
- **提升**：公众号监测从「收割式快照」→「订阅式实时流」（差距①中文一手源时效升级）；监测总线三件成型。

---

## 六、P2 分级提案（方法论升级 · 长期）

### P2-1 S&P 评级标准 → 报告质量记分卡【随下一份成稿启用】

- **来源**：S&P Global Ratings Criteria 全量公开披露（w2-010，监管强制透明=免费的世界级方法论文库：基本面因素/分析原则/方法论/关键假设四层）
- **对接**：`E:/AI-Station/reforge_factory/grade_rules.py` + `E:/AI-Station/reforge_factory/SCORECARD.json` + `E:/AI-Station/reforge_factory/report_gate_check.py`
- **做法**：拆 S&P 四层标准 → 我方报告评分卡的「关键假设披露制」：每份报告关键假设+敏感性+打分卡写法对齐评级机构口径。
- **验收**：连续 3 份报告带「关键假设与敏感性」节且机检通过（report_gate_check 增对应检查项）。

### P2-2 麦肯锡七步 + SCQA + MECE → 立题门升级【随下一战役立题启用】

- **来源**：w2-001 麦肯锡七步问题解决法（官方公开页）+ w2-009 Minto 金字塔原理/SCQA + w2-004 MECE 原则
- **对接**：`E:/AI-Station/reforge_factory/question_tree.py`（S1 立题）+ `E:/AI-Station/reforge_factory/superline/charter_gate.py`
- **做法**：七步改写为立题 checklist 七栏；SCQA=导论章模板；MECE=章节矩阵/dupcheck 门的理论口径注脚。
- **验收**：下一战役立题卡含七步七栏 + SCQA 导论（charter_gate 检查项）；MECE 查重门文档引用理论口径。

### P2-3 STORM Perspectifier → 多视角问询生成

- **来源**：stanford-oval/storm（31,720★ MIT，多视角问询→多 agent 对话→大纲→带引用长文）
- **对接**：`E:/AI-Station/reforge_factory/question_tree.py`（EEI 生成）+ `E:/AI-Station/reforge_factory/completeness/blindspot_sensor.py`（盲区传感器对照）
- **做法**：立题后自动生成 N 视角问题集（业主/总包/分包/监管/供应商各出问题），扩 EEI 覆盖维度。
- **验收**：EEI 覆盖维度 +N 维（盲区传感器检出「未问之问」数对照提升，实测落账）。

### P2-4 graphiti 双时间轴 → 数仓时效设计 v2

- **来源**：getzep/graphiti（32,283★ MIT，bi-temporal=事件时间与摄取时间分离+增量更新）；post-graph-rag（12★，新事实替换旧事实的「CFO 换人」解法）
- **对接**：`E:/AI-Station/data/warehouse/etl.py` schema v2 + `E:/AI-Station/reforge_factory/snapshot_audit.py`（既有快照审计件）
- **做法**：event_time/ingest_time 双轴入 schema；新事实替换旧事实规则（旧值不删只标记失效，兼容只增不删铁律）。
- **验收**：任一序列可机答「该值何时发生/何时知道」两问；旧值零物理删除。

### P2-5 OSINT 结构化尽调 SOP（OpenCTI 方法论先行）

- **来源**：OpenCTI（10,211★，STIX2 知识图谱+调查关系图谱+时间线=顶级情报机构结构化调查方法论本体）+ SpiderFoot（23,906★ 200+模块）+ ogi（335★ Maltego 开源直替）——先方法论后工具（工具重，SOP 先行）
- **对接**：EPC-OVERSEAS 战役 + `E:/AI-Station/reforge_factory/entity_timeline.py` + legs（OSINT 长尾腿候选：awesome-osint 工具地图）
- **做法**：竞对/海外业主实体尽调 SOP：observable→indicator→sighting 证据链→时间线→报告节。
- **验收**：1 份海外业主尽调节产出，时间线 ≥10 事件且全带源（entity_timeline 落账）。

### P2-6 校准账本复利（Tetlock 长跑，既有件持续在役）

- **来源**：METHODOLOGY.md 既有设计（Tetlock/GJP）+ HN 发现 Deterministic-Judge（arXiv 2606.22737，评审去随机化——对账腿的未来升级件）
- **对接**：`E:/AI-Station/reforge_factory/calibration_ledger.jsonl` + `E:/AI-Station/reforge_factory/brier_score.py` + `E:/AI-Station/reforge_factory/decision_stats.py`
- **做法**：每战役 ≥5 条可验证预测入账；到期对账打 Brier 分；季度校准曲线；恶化判断类型进「判断陷阱清单」。
- **验收**：宪法判据 1——跑满 3 个月对账后平均 Brier score <0.20（优于瞎猜 0.25 且持续收敛）。

---

## 七、实施路线图（甘特式）

```
周次      1  2  3  4  5  6  7  8   月2      月2-3     持续
─────────────────────────────────────────────────────────────
P0-1 判层复验+常开   ██████
P0-2 数仓扩容          ████████
P0-3 GDELT腿       ███
P0-4 MarkItDown    ██
P0-5 免费盯梢          ████
P0-6 三技能收编            ████
P1-2 claim核查链             ████████
P1-3 牛熊对抗辩论           ████████
P1-1 LightRAG图谱              ████████
P1-5 数仓日更                 ██······················▶ (上线后每日自动)
P1-4 微信访谈腿                      ████████
P1-6 公众号监测总线                    ████████
P2-2 七步立题门                        █ (随下一战役立题)
P2-1 S&P记分卡                           █ (随下一份成稿)
P2-3 STORM多视角                              ████
P2-4 双时间轴v2                                  ████
P2-5 OSINT尽调SOP                                  ████
P2-6 校准账本     ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▶ (≥3个月对账)
─────────────────────────────────────────────────────────────
里程碑: W1末=16/16战役判层复验收官 | W2末=数仓≥7表+引擎146→147
        W4末=claim核查链+辩论轮在役 | W6末=图谱层+访谈腿+监测总线
        M3末=BS<0.20首验 | 全程零预算
```

依赖关系：P0-2→P1-5（先扩容再日更）；P0-1→P1-2（材料级判层收口后才做断言级）；P1-1 依赖单战役弹药冻结快照；P2-2/P2-1 挂战役节奏（不空等排期）；串行全链令在役——本路线图不与在飞报告链交错，P0 批次利用战役间隙窗口执行。

---

## 八、预算（全免费/零预算清单）

| 提案 | 凭据 | 成本 |
|---|---|---|
| P0-1 | GLM-4-flash 免费档双钥轮换（semantic_judge 现役链路，智谱双账号强制令在宪） | ¥0 |
| P0-2 | akshare 1.19.3 全免费（etl.py 铁律注记） | ¥0 |
| P0-3 | GDELT 公开 API 免费无 key（w2-022/023 probe=200） | ¥0 |
| P0-4 | MarkItDown MIT 开源自托管 | ¥0 |
| P0-5 | FTP 免费档 / Google Alerts / Talkwalker Alerts 免费邮件 | ¥0 |
| P0-6 | 三仓开源 clone | ¥0 |
| P1-1 | LightRAG MIT | ¥0 |
| P1-2 | FacTool Apache-2.0 + 检索走池内/免费引擎 | ¥0 |
| P1-3 | 开源方法论移植（军团会话=免费账号） | ¥0 |
| P1-4 | 微信访谈（自有微信生态） | ¥0 |
| P1-5 | papermill BSD + 本机计划任务 | ¥0 |
| P1-6 | we-mp-rss/RSSHub/FreshRSS 开源自托管 | ¥0 |
| P2 全部 | 公开方法论页（S&P 披露库/麦府公开页/Wikipedia CC-BY-SA）+ 开源仓 | ¥0 |

隐性成本如实披露：本机与 ECS 计算资源（既有）；GLM 免费档额度有限——P0-1 单战役实测 292 次调用 1,173.7s，16 战役全量为数千次调用级（**以逐战役实测为准**），超额风险由双账号轮换 + glm-4-air 降级链兜底（semantic_judge 既有设计）。

---

## 九、附录 H：需用户付费决定项（不在执行计划内，仅登记）

| 件 | 类型 | 免费宪法处置 |
|---|---|---|
| GLG / AlphaSights / Guidepoint / Third Bridge / ProSapient（w2-014~018） | 专家网络付费订阅+按通话计费 | 不采购；其 SOP 模式经免费路径 P1-4 吸收 |
| AlphaSense 含 Tegus 转录库（w2-021） | 专家通话转录库检索 | 不采购；转录沉淀模式由访谈腿自建库复刻 |
| Wood Mackenzie Lens（w2-011）/ Oxford Economics（w2-012） | 能源/宏观经济模型平台 | 不采购；「项目级评估」「情景+压力测试」结构由报告模板复刻 |
| NewsAPI 生产档（w2-027）/ Event Registry 付费档（w2-025）/ MetaGer key（€5 一次性，波2 §⑤） | API 付费档 | 不采购；免费档/免费替代（GDELT/FTP/Alerts）承接 |
| 一手价格付费库（Wind/Bloomberg 等，1026 诊断差距①的结构面） | 终端订阅 | 结构限制=免费宪法：免费面逼近（数仓+GDELT+B级 209 条免费路径），付费面永久留档不进计划 |

---

## 十、铁律合规声明

- **免费宪法**：执行计划 18 项全部零预算；付费件仅出现在附录 H 且逐条标注「需用户付费决定」。
- **可落地**：每项提案给出对接文件路径/仓库名与 ≤5 步实施步骤；命令沿用台账在役口径（如 `py data/warehouse/etl.py counts`）。
- **数字零造假**：资产基线全部注明实测来源（1028 AST/ls/ledger 复算）；调研 stars 为 gh api 2026-10-28 实测；目标值一律标注「目标（以实测为准）」；任务输入的 95.7% 因台账未见落字而与实测 89.3%（209/234）双列如实处理。
- **台账纪律**：新引擎/新腿/新卡全部走只增不删 + .bak 先行 + AST 编译门（119/119 先例）+ 台账增行。
- **密钥纪律**：GDELT 无 key；GLM 双钥走 secrets 既有位；凭据不进仓不进日志。
- **节奏纪律**：串行全链令在役，本提案各批次利用战役间隙执行，不与在飞报告链交错；涉及浏览器环节（P1-4/P1-6）遵守「浏览器不必要不开 + 用完即清 + 采集最小化」。

---

*铸模输入：survey_methodology.json（164 项）+ survey_intelligence.json（80 项）+ 现役资产 1028 实测盘点 + 1026 四大差距诊断 | 生成：2026-10-28 | 本件为提案，待用户批准后按路线图执行*
