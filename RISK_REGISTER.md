# RISK_REGISTER — zongbao-ai-v0917

| ID | 风险 | 概率 | 影响 | 缓解 | 检测 |
|---|---|---|---|---|---|
| R1 | 朋友圈分享（onShareTimeline）首次启用：单页模式冷启动不自洽（query 携参页白屏/报错） | 中 | 中 | tab 页不带 query；详情页仅带最小参数（sku/id），与既有深链降级路径同构；e2e 复现冷启动直达 | e2e：compile_condition 直达每个携参页面 + 控制台零错误 |
| R2 | 分享文案触发运营规范 3.2.1（诱导分享） | 低 | 高（拒审） | 全部静态定案文案复用过审形态（「总包AI顾问-」品牌前缀/报告标题），零利益承诺词；BOOT-SIM 加诱导词红线扫荡锚（全页面 js 扫「分享.*赠\|得\|送」） | BOOT-SIM 锚 + 提审表单人工核对 |
| R3 | 删除接口越权（删他人记录） | 低 | 高 | owner 门：DELETE 端点校验 openid=行主，否则 404；pytest 越权用例（用户B删用户A→404） | pytest: test_delete_forbidden_other_owner |
| R4 | 软删后账实不符（已购导出的记录被删，退款/发票口径乱） | 低 | 中 | 软删只影响展示与可见性门；pay_log/rewards 物理不动；发票累计口径取 pay_log（不受影响） | pytest: 删除后 pay_log 计数零变化断言 |
| R5 | history_all 未过滤 deleted → 已删记录仍计入批量导出弹窗金额 | 中 | 中 | history/history_all/get_answer/get_answer_visible 四处统一 `deleted` 过滤；pytest 已删记录从 unpaid 计数消失 | pytest: test_deleted_excluded_from_history_all |
| R6 | MySQL 生产列迁移失败（ALTER 被拒/锁表） | 低 | 中 | `_ANSWER_UPGRADES` 既有机制（INT DEFAULT 0 秒级 ALTER，InnoDB online DDL）；duplicate column 吞掉幂等可重跑 | 部署后三板斧 + 生产冒烟（history 带 deleted 过滤的回数） |
| R7 | 0.9.16 审核中与 0.9.17 提审冲突（平台限制并发提审） | 低 | 中 | 平台允许同号仅一个在审版本：**若 0.9.16 仍在审，0.9.17 提交前需确认 0.9.16 已出结果**（过审→发布后再提 0.9.17；或撤审重提——红线禁撤）。提审前先跑住哨读行确认 | 提审前置检查：getcodepage 版本行状态 |
| R8 | 锅圈 curator 行被误删（理论） | 极低 | 低 | curator 行 openid=pot-curator ≠ 任何用户 token 的 openid，owner 门天然不可达 | pytest: pot 行对普通用户删除=404 |
| R9 | 删除后 my 页统计数字不一致（提问数/额度票根） | 低 | 低 | 统计口径统一走服务端（history 返回后的 items 派生=已过滤）；删除后本地乐观移除+静默重拉 | e2e: 删除后列表长度与空态切换断言 |

## 风险总量：9（高影响 2 项均有既定缓解）；残余可接受。
