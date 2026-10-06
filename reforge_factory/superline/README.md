# superline — 超级生产线任务板 (P0 ✅ 12/12 · P1 在建)

报告名→顶级研报超级生产线框架 v1 (用户 2026-10-06 全批 P0-P2, 38 增量件).
总装文档 `_proposals/report-methodology-1006/SUPER_PIPELINE_FRAMEWORK_V1.md`,
批准回执 `APPROVAL.md`. 本目录 = 增量件落位处 (Python311 全栈).

## 边界 (随批继承, 件件适用)

- 硬层不动: 五层调度 / 弹药门 v3 / 饱和引擎 / RQS 21 门零改动
- 判定源一律取 tier_report / manifest / 池账本数字, 不信模型自评
- 免费模型优先; 付费敞口仅 Jev 原语位 (XC-6 档位表前置)
- 共性库回写走批准制 (waivers 同构); 账号安全四件套照旧

## P0 地基 (已落)

- [x] `contracts.py` 共享契约层: 常量唯一事实源 + charter/framework 纯函数
      校验器 + 指纹 + 兜底三段框架 + 门参数动态同源 (gate_defaults 读
      ammo_pool) — 测试 `tests/test_superline_contracts.py`

## P0 12 件 (主链: 判级 → 契约 → 分母可信 → 对账锁定)

| # | 件 | 落位 | 验收判据 (机检锚) | 态 |
|---|---|---|---|---|
| S0-1 | 门卫判级器 (泛化 epc50_start_gate → s0_gatekeeper) | superline/s0_gatekeeper.py | 10 历史战役回放判级一致率 ≥8/10; 每 RETREAT 缺口清单非空; 判级全程零付费渠道 | ✅ 1006 收官: 真盘回放 10/10 一致 (EPC50 PASS + EPC49/旧8 RETREAT), EPC49 缺口 T1缺1,252,551/T12缺6,704,907 字与冻结真值逐字吻合, 旧8战役 corpus-fallback 扫描复现冻结测量; 证据 superline/replay_out/{replay_summary,各战役}/; 单测 14 项全绿 (tests/test_s0_gatekeeper.py, 含 ast 零付费机检+replay 零通知探针) |
| S0-2 | 词表生成器 (entity expansion 六槽展开) | superline/tier_expander.py | 3 已完成战役回放 T1 召回 ≥90%; 六槽非空或显式「查无」; 全程免费渠道 <30min | ✅ 1006 收官: 真盘回放 3/3 全 100% (EPC50 4/4 · EPC49 4/4 · 中冶长天 3/3, rc=0), 单战役 ≤10s; EPC49 真坑根治=机构邻接缩略词 (SEDC公司形) 频次门放宽到 1 (论文标题单次即强组织信号), 泛词 PPT/OCR 仍须 ≥2; 证据 superline/replay_out_tier/{replay_summary,各战役}/; 单测 15 项全绿 (tests/test_tier_expander.py, 含 ast 零付费机检+草稿绝不写 tiers.json) |
| S0-3 | Charter 呈批门 + 两级输入协议 | superline/charter_gate.py | 一次试产全链时间戳留痕 (呈批/回执/批准进战役目录); 改批往返 ≤2 轮; 呈批件含机器可读 JSON | ✅ 1006 收官: 单测 8/8 + 真工件冒烟全链 (S0-1 PASS 判级+S0-2 80词草稿被真消费→charter contracts 零错→呈批→批准进战役目录→S1 准入开闸, ledger 事件链 built→submitted→receipt→accepted 全 ISO 时戳单调); EDIT 往返 ≤2 轮硬顶 (第3次自动 escalate 详单回呈绝不静默拉锯); 坏件禁呈批 (validate 零错才出门); 企微可注入零真发; 证据 superline/replay_out_charter/EPC50-SNEI/ |
| S0-4 | 解析腿标准件三件 (复述纪律/反例问题/英文意图词剥离) | superline/prompts/ | Charter 草案含复述栏 + 战役 04 指令含反例问题文件 + 英文词表带扇出 ≥3 变体 — 三项逐条 grep 可验 | ✅ 1006 收官: prompt_kit.py+prompts/parser_leg.md (SYSTEM 焊死三条) + verify_grep 一键验收; 真工件冒烟 EPC50 (SNEI 扇出 4 变体/反例 3 条/复述栏在) 三项全 True; 单测 4 项; 实测坑=测试须隔离 TE.POOL_ROOT (真池 EPC50 T2 竞对 SEI 渗进夹具, 行为本身正确) |
| S1-1 | 框架生成器 v1 (framework.json 契约+四框架族+双参数+模型分档) | superline/framework_gen.py | schema 校验过; 同输入重跑 3 次章数波动 ≤1; 路由字段齐备率 100% | ✅ 1006 收官: 纯规则确定性 (重跑3次指纹同/波动0); 四框架族双轨 (enterprise=EPC十维度域模板, industry/topic/policy=通用骨架族); 目标章数补齐(尾部案例/失败/路线图)裁剪(保头尾等步抽)双路实测; 密度纪律=无侦察据只准 low (contracts 契约同源); S0-3 门真接线 (只吃 charter_accepted, 未批准 PermissionError); 坏输入硬拒不兜底 (回炉在 S1-3); 真链冒烟 EPC50 15章路由齐备 15/15; 单测 5 项 |
| S1-2 | 规划前免费侦察注入腿 (zh-search-pro + anysearch) | superline/scout_inject.py | 每章密度预估可追溯 ≥1 侦察命中或显式 LOW; anysearch 渠道账本首笔产量 | ✅ 1006 收官: 真链冒烟 EPC50 双腿齐供 (zh-search-pro 报告名+15章词全量, anysearch 报告名一查限额纪律) 16 键 65 命中去重; 回灌真链修通=framework_gen --scout 归一 scout_v1 包形→15 章密度全可追溯 (11 章 high 带 scout_hits + 4 章零命中显式 low); anysearch 首笔产量在案 (ledger n_hits=5, 长标题0命中→企业名+EPC 简化回退恰两查); 证据 superline/replay_out_charter/EPC50-SNEI/ (scout.json+scout_relative_results.md) + scout_ledger.jsonl; 单测 6 项 (假腿注入零真触网+ast 零网络根模块) |
| S1-3 | 兜底默认框架 + 硬拒回炉 | contracts.default_framework + framework_gen 回炉环 | 坏 JSON 注入: 回炉与降级路径各实测触发 ≥1 次 (地基件已含兜底框架本体) | ✅ 1006 收官: 回炉环=确定性修梯 ≤2 修复轮 (r0 原样/r1 清洗或编码转真/r2 替换重读) 全死降级三段默认框架; 真工件冒烟 EPC50 双路触发 (尾逗号坏件 reworked rounds=1 指纹与好件逐位同=零数据丢失; 字节垃圾 degraded rounds=2 兜底件校验零错不悬空), rework_ledger.jsonl 全事件留痕 (变更零静默); CLI --check-framework 旗标; 单测 7 项 (五路: 回炉×2/降级/clean/absent); 证据 superline/replay_out_s13/ |
| S2-1 | snippet 不入池硬门 | ResearchFactory-Eng tier_router 闸 | 全量检索 snippet-only 入池记录 =0 (grep gate 日志可证) | ✅ 1006 收官: 双面闸=池侧 ammo_pool.ingest 硬门 (三规则: engine 自标/SERP 面形 ≥3编号行∧≥3URL/检索 JSON 落盘; 拦截落 snippet_gate.jsonl grep 可证) + 路由侧 select_channels 滤清单面渠道 (61 渠道恰滤 zh_search_pro 1 个纯清单面, 混面零误伤); 真池全量审计 1,312,608 行 snippet 形 0 行 (EPC49 122.6万/EPC50 2.8万/AUX 1.9万/demo 5, rc=0); CLI snippet-audit 子命令+保守规则宁漏不错杀 (judge 层兜底); 单测池侧 3 项+路由侧 19 项 (含新 S2-1 过滤测试); 证据 superline/replay_out_s21/{audit_real_pool,router_snippet_channels}.log |
| S2-2 | tier_router 预算分档三档 (outline_wide/section_narrow/gap) | ResearchFactory-Eng tier_router 派单参数 | 框架期/章级/补弹消耗分桶可查 (tier_report 分列); 总量不超弹药门预算 | ✅ 1006 收官: 三档映射 T1=outline_wide/T2=section_narrow/T3=gap (与 S1-1 BAND_BY_ROLE 同词表); 派单件带档+provenance 记档; 预算帽=plan-only 让渡真归零+超缺口截尾绝不静默; 池侧 ingest --band 入行 (非法归""=存量桶)+tier_report by_band 分列 (只计 valid); bands CLI=planned×ingested×budget_remaining 三桶一表 (cap_ok=新三档计划≤当期余量, 存量 2.36亿另列不进帽); 真链 EPC49 dry-run 2 件带档 501,020/3,881,962 字均在缺口内; 单测路由侧 22 项+池侧 2 项; 证据 superline/replay_out_s22/bands_evidence.log |
| S3-1 | 章节×证据双向对账器 (四权+权威度列+三态) | superline/chapter_matrix.py | 抽样 10 格对回 manifest 明细零漂移; 三态与人工复盘一致; 补扫单真实出队 1 条留痕 | ✅ 1006 收官: 行=章×列=T1/T2/T3 字数当量+四权 (同 epc-deep-research 阶段5 在役阈值纯函数重实现)+权威度分布+独立源; 判定源=manifest valid×dedup (与 tier_report 同语义); 三态门限 ≥75饱和/<40或零证据缺口; 处置=饱和锁定(S3-2锚)/贫血扩写/合并(Jaccard>0.5)/降级(仅T3)/缺口补扫; 真链 EPC50 15章×28,218行 三态13/2/0 与人工复盘一致 (组织人才5.7万/案例4.1万薄=真贫血, 公司面278万厚=真饱和), 权威度全未分级=pre-FT5行诚实降档; 抽样10格零漂移+漂移注入可检出; 补扫单真实出队=ch03/T3 media_group 真命令入队 (CONDUCTOR_STATE 测试态闸隔离) + ch04 最弱层 T1 零可派腿 plan-only 诚实留痕, rescan_ledger 双笔在案; 单测 4 项; 证据 superline/replay_out_s31/evidence_s31.md |
| S3-2 | 大纲锁定合同化 (outline-as-contract + 章级 4 态状态机) | superline/outline_contract.py | 章态与 manifest/完备门三方一致; 变更零静默 (每次变更 diff 在案, 指纹锚) | ✅ 1006 收官: 4态=gap_scan→collecting→locked(禁改章大纲)→writing(弹药门∧完备门双过交撰写), 只进不退/退=显式unlock钉住(refresh不自动回升否则假降态, 回升须relock+矩阵回饱和); 变更正门唯一=retitle/retier/remove/add 全走apply_edit(变更后框架自过validate硬拒坏变更, 每次尝试含拒落outline_changes.jsonl带指纹before/after); 绕合同手改framework.json→reconcile指纹失配当场检出; 真链EPC50沙盒15章establish 13锁/2采集+三方对账✅(章态↔矩阵↔真完备门)+变更7笔全留痕; promote真拦截实证=ammo门过但当日61渠道完备门裸缺席28→❌拒writing(双门纪律非摆设); 单测6项(建立/零静默/手改检出/只进不退+钉relock/章态失配/双门promote); 证据 superline/replay_out_s32/evidence_s32.md |
| XC-1 | 完备门键名归一器 (治 7/13 假缺席) | ResearchFactory-Eng conductor/v2 | 复查 13 裸缺席全部为真缺席 (零错位); 完备门四态分布与池账分毫不差; G-005 范式前后快照在案 | ✅ 1006 收官: 13=8 假缺席(池证到场, 池账逐键零漂移)+5 真缺席(工单 XC-1-R1..R5); 四态 33/10/2/13→42/9/7/0, passed False→True; 前后快照 completeness_v2.{before,after}_xc1.{json,md} 在案; 单测 10/10 |

## 试产战役候选 (1006 已盘, 用户令暂缓)

候选盘面 (全 52 战役 × 双池账本 × 05 粗加工存量 × 双门实读): ① EPC50 中石化
南京 = T1 47.6M/2148 件唯一过弹药门 + P0 链工件全在其身 + r50 定稿金标准,
缺 05 粗加工/完备门 28 裸缺席; ② 中冶长天 = 05 4243MB/280 件最厚档半成品,
池从零 (S0-2 词表回放 3/3); ③ EPC49 四川电力 = 05 4055MB + 唯一过完备门
(XC-1 后 42/9/7/0), T1 薄 1.7M 需补弹. 同型半成品备选 11 家 (中国海诚
4582MB 最大). 恢复试产时呈用户选.

## P1 15 件 (执行层; 用户 1006 暂缓试产后开工)

执行序 = Wave1 收尾件 → Wave2 S4 执行层 → Wave3 S2 采集面 (最重件殿后).

| # | 件 | 落位 | 验收判据 (机检锚) | 态 |
|---|---|---|---|---|
| P1-1 | S1 出口呈审门 (framework 呈批三态复用 S0 通道) | superline/framework_gate.py | framework.json 渲染 md 呈审+机器可读 JSON; 批/改批/豁免三态留痕; 积分制/账号面渠道首次出队前存在 approved framework 记录 (查账函数在位) | ✅ 1006 收官: 通道复用 S0-3 范式 (企微注入零真发/EDIT ≤2 轮第 3 次 escalate); 呈审件=机器可读 digest+人读章节路由表 (每章 T1/T2/T3 词数/分档/密度/渠道); 三态=APPROVED (指纹锚)/EXEMPT (waivers 同构: 无 reason 硬拒 exempt_blocked 入账, 带 reason WARN 态放行留痕)/EDIT; 坏框架 validate 错禁出门+submit_blocked 入账; s2_gate 出队闸真拦截实证=EPC50 replay 积分制渠道未批 ❌禁出队→APPROVED 后 ✅放行→免费面直行 (止损在成本拐点); 真链 15 章/87 词指纹 e00c29c668d84e05 与 S3-2 establish 逐位同 (跨件锚一致); ledger 5 事件 ISO 单调; 单测 5 项; 证据 superline/replay_out_p11/evidence_p11.md |
| P1-2 | S3 贫血章处置协议 (85/15 补扫预算+结构转向梯子) | superline/anemia_protocol.py | 补扫预算执行率可查 (分桶账); ≥2 轮零新增→pivot 记录 + ≥4 轮→升用户裁决各演练一条留痕; 超期告警在案 | ⬜ |
| P1-3 | S3 先图后文产前门 (图表清单=合同附件) | superline/charts_gate.py | 框架合同附图表清单 (图号/口径/数据源章) 每图口径有源; 至少拦截一次口径不可比退回记录在案 | ⬜ |
| P1-4 | S4 写作腿双槽提示词三件套 | superline/prompts/writer_prompts.py | SYSTEM 槽=产物合同+Data Integrity 五条; NEXT_STEP 槽=任务卡+计划全景 ✓/→/!; 计数条款「N out of M 章引用已核」三条款逐条 grep 在位 | ⬜ |
| P1-5 | XC-6 角色→LLM 档位一张表 (含 VL 位) | superline/roles_llm_map.json+checker | 表在役后付费腿调用 100% 有档位依据 (机检: 无表外付费调用); Jev 只占免费做不到的原语位标注 | ⬜ |
| P1-6 | XC-3 Task Ledger 三段账本 (认知级) | superline/task_ledger.py | 每战役 ledger.json{facts/open/speculation} append-only; 终稿引用句 100% 溯源自 facts 段; 引 speculation 句可判 FAIL (可证伪钩子在位) | ⬜ |
| P1-7 | S4 章级缺口检测器 gap_extractor | superline/gap_extractor.py | 初稿三触发位 ([待证]/估算推断段/引用源数=1)→补弹任务 JSON 入队; 单源论断 100% 命中 (对照底账); 抽 10 条 query 可派率 ≥80% | ⬜ |
| P1-8 | S4 反损耗编译门 | superline/compile_gate.py | 合成只准顺序 append 不准改写; 终稿字数 ≥ Σ分章稿 (wc 机检); 压缩性改写可检出 | ⬜ |
| P1-9 | S4 stuck 双层检测 | superline/stuck_detector.py | 写作腿同文重复 ≥2 判卡死 + 池侧同渠道同词表 2 轮零有效新增 warn; 注入式测试各触发一次且留痕入账本 | ⬜ |
| P1-10 | S4 写作-采集并发编排 (写 N 采 N+1) | superline/overlap_pipeline.py | gap 任务入池即被下一 tick 领走 (零新组件); 写作空转窗 ≤1 tick; 写作+补弹并行时间窗证据在案 | ⬜ |
| P1-11 | S2 SearchItem/ToolResult 渠道出口统一+logged 工厂 (XC-5 并入) | superline/channel_tools.py | 包 5 高频免费检索渠道 (zh-search-pro/anysearch/opencli 免费面…); 出口类型统一; _run 级 IO 日志落盘抽 10 次可回放入参出参耗时 | ⬜ |
| P1-12 | S2 查询内多引擎同步降级层 | superline/search_fallback.py | 免费检索注册表+首选/fallback 链; 模拟首引擎故障同 tick 切换成功 ≥1; 全败 5-10s 只重试 1 轮转 DEFER 无整轮空烧 | ⬜ |
| P1-13 | S2 星型并行上下文隔离 | superline/star_batch.py | 每子任务全新上下文 ≤8 项分批; API/文件腿并行浏览器腿互斥; 尾项证据 URL 去重后新增占比不衰减 | ⬜ |
| P1-14 | XC-2 渠道水位周报常态化腿 | tools/ 周度 schtask (OS 级) | 四桶账固化周度产出连续两周零人工; probe 面 3→14; 真缺口清单滚动可对账 | ⬜ |
| P1-15 | S2 12 真缺口接线+auto_dispatch 扩面 | ResearchFactory-Eng conductor (逐渠道开) | 完备门假缺席清零 (aliases 全量化); 12 渠道逐个 manifest 过账; C 桶 (在册不出粮) 下降可审计; auto_dispatch 逐渠道开不一把梭 | ⬜ |

P2 (11) 见总装文档呈审门分期表.
