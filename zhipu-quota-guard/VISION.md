# VISION — ZhipuQuotaGuard（Phase 0, C1/C3：最难问题·世界级且落地）

## 终局画面
AI-Station 的每一段 Claude Code 开发（自媒永动机/研报产线/任意项目）在 GLM Coding Plan 额度制下**数学上不可能因额度中断**：护盾以纯 API 毫秒级感知额度水位，以本地遥测预测烧穿时刻，以重置卡资产治理决定「何时花哪张卡」，以 ≤5 分钟 MTTR 完成恢复——并且这一切有账本、有通知、可审计、可证伪。

## 三层野心（不预先缩水）
1. **个体户层（本案）**：单工作站单账号，24h 无人值守，MTTR ≤5min
2. **产线层**：护盾的高峰感知与水位数据反哺 station 排程宪法（token-peak-hour-rule 的 V3 化），研报产线大 Token 相位自动避开高危窗口
3. **舰队层（留接口）**：provider 抽象 + 多账号配置结构，未来 N 账号轮换（zcode-switch 模式）零改造接入

## 世界级判据（C12 金标准）
- MTTR 中位 ≤0.5h（目标 5min），run-ledger 实测
- 重置卡零作废（有效期 FIFO，账本可查 would_expire_wasted）
- 误重置率 = 0（自然刷新可覆盖时绝不花卡）
- 密钥泄露事件 = 0（外置+脱敏日志+gitignore 三重）
