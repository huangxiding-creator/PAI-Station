# WBS — zongbao-ai-v0917（0.9.18 迭代：分享全量启用 + 咨询记录删除）

> 任务图由 ss-planner 生成（T-009..T-020）；T-001..008 为 v0913 已完成史（不重复
> 执行）。版本基线：**线上=0.9.17（1012 17:00 发布），本轮交付 0.9.18，审核位空**。

## 任务表

| ID | 任务 | covers | after | verify | 自由度 |
|---|---|---|---|---|---|
| T-009 | 引擎-软删原语 delete_answer + 四可见性门（history/history_all/get_answer/get_answer_visible）+ deleted 列四点同步（两 CREATE+_ANSWER_UPGRADES+mysql_schema.sql） | REQ-004.AC3 REQ-005.AC1 REQ-007.AC1 | – | 引擎 pytest 全绿（含新 tests/test_delete_answer.py） | 中 |
| T-010 | 引擎-DELETE /api/answers/{aid} 端点（401/404/200 幂等；账务零副作用） | REQ-004.AC1 REQ-004.AC2 REQ-005.AC1 | T-009 | pytest 端点用例全绿 | 中 |
| T-011 | 客户端-onShareAppMessage 六页补齐（ask/home/my/pot/invoice/legal）+ BOOT-SIM 逐页锚+品牌标题闭集锚 | REQ-001.AC1 REQ-001.AC2 REQ-001.AC3 | – | BOOT-SIM 全绿 | 中 |
| T-013 | 客户端-onShareTimeline 十页成对（query 政策：内容页携最小参数）+ 诱导词扫荡锚（仅分享 handler 文案域） | REQ-002.AC1 REQ-002.AC2 REQ-002.AC3 | T-011 | BOOT-SIM 全绿 | 中 |
| T-014 | 引擎-四点列同步静态锚测试（pytest 源结构断言） | REQ-007.AC1 | T-009 | pytest 该用例绿 | 低 |
| T-015 | 客户端-my 页删除交互（hist-item 右侧删除钮+qw-pop「删除后不可恢复」+乐观移除+回滚+遥测 record_delete_tap/ok）+ api.js answerDelete | REQ-006.AC1 REQ-006.AC2 REQ-006.AC3 | T-010 | BOOT-SIM 全绿 | 中 |
| T-016 | e2e-零异常冷启（report?sku=CNNC-EPC / answer?id=自建）+ 真点删除全链 | REQ-003.AC1 REQ-003.AC2 REQ-006.AC1 | T-013 T-015 | node e2e 0 fail（引擎 8870+devtools 9420 就绪后跑） | 中 |
| T-017 | 部署-TCB 引擎上云（qw_tcb_prep→mn_client）+ 生产冒烟（health/history/poster 不回归） | REQ-007.AC2 | T-014 T-016 | 三板斧 normal+HasTraffic+health ok | 低 |
| T-020 | 交付-0.9.18 robot 上传+六段提审（不加急只一次；提审前复核线上=0.9.17 审核位空） | REQ-008.AC1 REQ-008.AC2 REQ-008.AC3 | T-016 T-017 | getcodepage 0.9.18 行=审核中+截图在档 | 低 |
| ~~T-012/T-018/T-019~~ | planner 自纠重加的弃件（dropped） | – | – | – | – |

## 波次（引擎先行 → 客户端并行 → e2e → 部署 → 交付）

- **wave 1**：T-009（引擎软删）∥ T-011（客户端分享六页）——互不依赖，可并行
- **wave 2**：T-010（端点）∥ T-013（朋友圈十页）∥ T-014（静态锚测试）
- **wave 3**：T-015（my 页删除交互）∥ T-017 前置件
- **wave 4**：T-016（e2e 全链；须引擎 8870 + devtools 9420 通道就绪）
- **wave 5**：T-017（TCB 上云+冒烟）→ **T-020**（上传+提审收官）

## 风险承接（RISK_REGISTER → 任务）

R1→T-016；R2→T-011/T-013 扫荡锚；R3/R8→T-010 越权用例；R4→T-010 副作用用例；
R5→T-009 四门过滤用例；R6→T-017 三板斧；R7→T-020 提审前置复核。

## 交付判据（P8 出口）

三线全绿（pytest ≥126 预期 / BOOT-SIM ≥577 预期 / e2e 新腿 0 fail）+ TCB 部署
normal+HasTraffic + 0.9.18 审核中 + 台账过账。
