# BUSINESS_MODEL — ZhipuQuotaGuard（内部生产力设施，非售卖品）

## 模式
不对外售卖。价值按**内部 ROI 账本**计量，run-ledger 自动记账：

```
月度ROI = Σ(避免的中断次数 × 平均挽回小时 × 产线小时价值) + 重置卡零作废收益 − 维护工时
```

## 收益来源（可测）
1. **中断挽回**：每次额度耗尽事件，MTTR 从 ~3.5h（人工）→ ~5min（自动）；夜间/无人值守时段全覆盖。账本字段：event_ts, detected_at, restored_at, cards_used
2. **重置卡零作废**：有效期 FIFO 调度，快过期卡优先花；账本字段：card_id, expiry, used_at, would_expire_wasted(bool)
3. **排程增益**：现行 V3 积分制（高峰1x/非高峰0.5x）实证后，station「token-peak-hour-rule」记忆同步修正（旧记忆为 V2 3x），研报产线大 Token 相位排程可更精准——护盾的高峰感知数据直接反哺产线排程
4. **决策节约**：预测引擎避免「不必要重置」（自然刷新能覆盖就不花卡），卡预算利用率最大化

## 成本
- 一次性开发 ≈2 人日（85% 复用：端点契约/licence 干净的取数逻辑/ccusage/DrissionPage 官方范式）
- 常驻成本 ≈0（计划任务 + 纯 HTTP 轮询，浏览器仅重置瞬间）

## 定价维度结论
N/A（无市场定价维度，scorecard monetization=0.70 为内部 ROI 代理分）。
