# ⚠️ 已作废（2026-10-14）：本文件为 zbops-agent 自研路线遗留，与现行 revenue-engine
# REQUIREMENTS.md 的 REQ 编号撞号不同义；现行 WBS 将在 P6 由 ss-planner 重新生成。
# 历史内容保留于 git，仅作追溯，禁止按本文件排任务。

# WBS: revenue-engine（P6 ss-planner 生成，2026-10-14）

> 真源：E:/AI-Station/.super-skill/tasks.json（只经 ss 引擎增改，勿手编）。
> 需求基线：REQUIREMENTS.md v2.1（25 REQ：MUST 21 + SHOULD 4，全部被覆盖，无孤儿任务）。
> 作废清理：旧 WBS 遗留任务 T-023..T-039 已 drop（撞号不同义；可 ss.py task reopen 恢复）。
> 图谱健康：task validate ok=true；wave 1-6；全部 pending 任务 est 复杂度 ≤5。
> 全局纪律：胶水 ≤300 行门（REQ-024，快照与复跑：py -I revenue-engine/probes/check_glue_audit.py；
> 台账 .super-skill/glue_audit.md）；层级②依赖代码引入即 fail；docker 镜像锁 digest。

## 任务总览（按 Wave 分组；同 Wave 可并行）

### Wave 1（Phase 0 四硬门启动 + B 栈地基，8 任务并行）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-041 Phase0-存活门：2小号x14天在线/封号/进群自动采集+判据报告 | REQ-001(.AC1/.AC2) | - | py -I revenue-engine/probes/check_artifact.py survival |
| T-042 Phase0-商户号门：营业执照/企业商户号确认→ADR-005收款模式落定 | REQ-003(.AC1) | - | py -I revenue-engine/probes/check_artifact.py merchant_adr |
| T-044 Phase0-协同策略定稿：双栈问答分工/内容去重互通/风控信号互通 | REQ-004(.AC1) | - | py -I revenue-engine/probes/check_artifact.py collab_doc |
| T-045 EspoCRM docker部署(digest锁)+中文界面+Lead评分字段与原生列表排序 | REQ-014.AC2, REQ-006.AC1 | - | py -I revenue-engine/probes/espocrm_probe.py |
| T-046 商机评分公式+完整阈值表scoring.md(告警70/推荐50唯一来源) | REQ-014(.AC1) | - | py -I revenue-engine/probes/check_artifact.py scoring_doc |
| T-048 发送审计总线：全路径落盘+90天保留+周报自动汇总 | REQ-019(.AC1) | - | py -I -m pytest 私域运营/zbops/tests/test_audit_log.py -q |
| T-049 群资产归属全量审计（SHOULD） | REQ-025(.AC1) | - | py -I revenue-engine/probes/check_artifact.py group_assets |
| T-075 8440服务入口：FastAPI POST /enqueue路由+API Key(401)+军团自启 | REQ-005.AC2 | - | py -I -m pytest 私域运营/zbops/tests/test_api_8440_auth.py -q |
| T-040 ✅(done) P6自查：胶水行数门快照+许可证审计清单 | REQ-024(.AC1) | - | py -I revenue-engine/probes/check_glue_audit.py |

### Wave 2（信号→Lead 主线 + A 栈拓扑位 + 收款实测）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-050 Lead transformer主体：信号JSON→EspoCRM <60s（≤200行预算） | REQ-006(.AC1/.AC2) | T-045,T-046 | py -I -m pytest 私域运营/zbops/tests/test_lead_transformer.py -q |
| T-076 8440入队约束：过日3/全局20/冷却/熔断，超限429 | REQ-005.AC1 | T-075 | py -I -m pytest 私域运营/zbops/tests/test_api_8440_safety.py -q |
| T-081 走单实测腿：人工下单498研报+自动发货送达确认（人务+系统双段） | REQ-002.AC1 | T-042 | py -I revenue-engine/probes/check_artifact.py order_paid |
| T-059 99元会员方案ADR-002（SHOULD） | REQ-016 | T-042 | py -I revenue-engine/probes/check_artifact.py membership_adr |
| T-062 A栈部署：LangBot+WeChatPadPro双docker+fixwin 86400s/3（墙钟上等T-041的14天存活门） | REQ-009(.AC1/.AC2) | T-041,T-044 | py -I revenue-engine/probes/langbot_probe.py |
| T-073 23:59运营日报：五轴指标当值（SHOULD） | REQ-023(.AC1) | T-048 | py -I revenue-engine/probes/check_artifact.py daily_report |

### Wave 3（去重/流转/预算裁决 + A 栈插件）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-056 跨群归一化去重键定稿+同人合并单Lead（来源群追加） | REQ-007(.AC1/.AC2) | T-050 | py -I -m pytest 私域运营/zbops/tests/test_lead_dedup.py -q |
| T-058 EspoCRM Lead四级流转配置 | REQ-013.AC1 | T-045,T-050 | py -I revenue-engine/probes/espocrm_pipeline_probe.py |
| T-054 8440预算裁决：全局日20耗尽→问答>推荐>推送+顺延次日 | REQ-005.AC3 | T-076 | py -I -m pytest 私域运营/zbops/tests/test_budget_arbitration.py -q |
| T-078 走单留痕腿：全流程留痕报告+失败降级ADR | REQ-002.AC2 | T-081 | py -I revenue-engine/probes/check_artifact.py order_gate |
| T-060 静默群：退订/安静关键词→静默7天（SHOULD） | REQ-020(.AC1) | T-076,T-048 | py -I -m pytest 私域运营/zbops/tests/test_group_mute.py -q |
| T-061 值守问答试运行+出处率周抽检（n≥20,≥80%；人务+系统双段） | REQ-011(.AC1/.AC2) | T-044,T-076 | py -I revenue-engine/probes/check_artifact.py qa_sampling |
| T-063 A栈全局日20插件(~50行)：全路径计数+持久化+不双计 | REQ-010(.AC1/.AC2) | T-062 | py -I -m pytest 私域运营/zbops/tests/test_global_cap_plugin.py -q |
| T-065 双栈同群10分钟窗零重复：3天日志核验 | REQ-004.AC2 | T-044,T-048,T-062 | py -I revenue-engine/probes/dedup_crosscheck.py |
| T-071 账号异常分级预案+一次演练 | REQ-021(.AC1/.AC2) | T-041,T-048,T-062 | py -I revenue-engine/probes/check_artifact.py incident_drill |

### Wave 4（告警/推荐/提醒/推送核验 + 降级ADR + 限频审查）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-057 高分告警腿：评分≥70→企微webhook 5分钟内五要素 | REQ-008(.AC1/.AC2) | T-056 | py -I -m pytest 私域运营/zbops/tests/test_alert_webhook.py -q |
| T-066 群内推荐触发腿：评分≥50+当日未发→B栈队列带出处推荐(3天≥3例) | REQ-013.AC2 | T-076,T-056,T-058 | py -I -m pytest 私域运营/zbops/tests/test_group_recommend.py -q |
| T-067 48小时未跟进→企微提醒 | REQ-013.AC3 | T-058 | py -I -m pytest 私域运营/zbops/tests/test_followup_48h.py -q |
| T-068 文章推送9-10点窗核验：标签命中+md5零重复+预算顺延(3天) | REQ-012(.AC1/.AC2) | T-048,T-054 | py -I revenue-engine/probes/push_3day_probe.py |
| T-064 插件挂载点降级ADR+一次实测 | REQ-010.AC3 | T-063 | py -I revenue-engine/probes/check_artifact.py plugin_fallback |
| T-070 限频矩阵全覆盖审查（CowAgent唯一豁免）+熔断双栈同停口径 | REQ-018(.AC1/.AC2) | T-076,T-048,T-063 | py -I revenue-engine/probes/check_artifact.py rl_matrix |

### Wave 5（归因 + 72h 试运行执行）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-069 归因回调：acg-faka订单webhook→EspoCRM源Lead更新 | REQ-015(.AC1) | T-078,T-057 | py -I -m pytest 私域运营/zbops/tests/test_attribution.py -q |
| T-079 72h试运行执行腿：零人工介入核验 | REQ-022.AC1 | T-057,T-066,T-068,T-070,T-071 | py -I revenue-engine/probes/check_artifact.py soak_zero |

### Wave 6（收官：回溯报告 + 停机计量）
| 任务 | 覆盖 REQ | 依赖 | 验证 |
|---|---|---|---|
| T-072 收入归因回溯报告：前10单全量+漏斗周报（≥3单首报） | REQ-017(.AC1/.AC2) | T-061,T-066,T-069 | py -I revenue-engine/probes/check_artifact.py attribution_report |
| T-080 停机计量腿：停机时长进周报+soak报告 | REQ-022.AC2 | T-079 | py -I revenue-engine/probes/check_artifact.py soak_downtime |

## 排程与纪律说明

1. **tracer-bullet 顺序**：信号→Lead→告警最小闭环（T-045→T-050→T-056→T-057）最先打通；
   A 栈（T-062..）与收款腿（T-081/T-069）后置，与 PROPOSAL Phase 1-3 节奏一致。
2. **墙钟 vs 拓扑**：Wave 是拓扑序。T-062/T-065/T-071 拓扑上在 Wave 2/3，墙钟上等 T-041
   的 14 天存活门；B 栈主线不受其阻塞。T-041 FAIL（任一小号封号）→ A 栈任务转 dropped，
   C 族按 REQ-001.AC1 转 B 栈单栈降级并补 ADR。
3. **人务参与任务**（verify 为人工步骤+系统核验双段）：T-041（进群/日常巡检）、
   T-081（人工扫码付款）、T-061（人工抽检出处率）。
4. **胶水预算**：写码任务仅 T-050/T-056/T-057/T-066/T-069（transformer 族 ≤200 行）、
   T-075/T-076（8440 ~50 行）、T-063（插件 ~50 行）；其余任务复用既有件。每个写码任务
   done 时必须复跑 check_glue_audit.py；超 300 行全线停加码（REQ-017 降 SHOULD 留 ADR）。
5. **报告判据标记**：各 check_artifact.py 键定义了报告必含标记（VERDICT/ORDER_RESULT/
   OUTCOME/DEDUP3D/HUMAN_INTERVENTIONS 等），worker 出报告时对齐 SPEC。
