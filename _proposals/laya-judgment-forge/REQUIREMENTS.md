# REQUIREMENTS — LayaForge（批准版 2026-09-23）

## 功能需求

| ID | 需求 | 验收 |
|----|------|------|
| F1 | laya-server 常驻服务：/v1/systemone 契约≡typesafe、/healthz、preload、USE_TF=0、无窗自启 | 合同测试+拔线冒烟 |
| F2 | JudgmentClient engine=laya\|typesafe（ini+env），熔断/开关/traj 语义原样 | 现有测试全绿+新合同测试 |
| F3 | 平价门：E1-E3 重放+金标准+fixtures 逐位对比 Jev 实测 | parity_report.json 落档 |
| F4 | 中文微调管线：数据工厂→单卡训练→held-out 温度→回归门 | zh≥85/score≥70/churn≥85 |
| F5 | 研究工厂八新位（E1-E8），全 fail-soft | 每位独立验收账本 |
| F6 | 周度复利：新数据→再训→回归→热换→周报 | 首轮全自动留档 |

## 非功能

- 延迟 p50 ≤60ms；VRAM 常驻 ≤2GB；断网可用
- 只增不删；问句措辞钉死；确定性检查归代码；凭据不入 git
- Windows 无弹窗；长训练晚间窗

## 红线（不可协商）

见 PROPOSAL §5；违反任何一条=整轮回滚。
