# CONTEXT — 统一语言表（ubiquitous language，context_lint 依据）

| 术语 | 定义 | 禁用同义词 |
|---|---|---|
| 套餐 Key | Coding Plan 专用 API Key（≠标准 Key，2026-10-16 分家） | "API密钥"泛称 |
| 5h 窗 | 动态刷新额度窗：消耗后 5h 归还，以 nextResetTime 为准 | "每5小时重置"（易误解为钟点窗） |
| nextResetTime | quota/limit 返回的下次自然刷新时刻，调度权威字段 | — |
| 积分 | V3 额度单位（input×6.9+cache×1.7+output×24)/1e4 | "Token数"（V2 概念） |
| 高峰 | 周一至五 14:00-18:00 UTC+8，1x；非高峰 0.5x | "3倍时段"（V2 老概念） |
| 重置卡 | 官方「额度重置卡」，5h卡/周卡，各自有效期，活动发放 | "重置次数"（无固定日次） |
| 卡预算 | 可用卡 − reserve_cards（默认留 1 给自媒永动机） | — |
| 烧穿 | nextResetTime 前额度耗尽的事件 | "超额" |
| MTTR | 额度耗尽→恢复开发的时延，核心验收指标 | — |
| 先斩后奏 | 自动执行重置后企微通报（用户已批默认） | — |
| dry-run | 决策与账本全跑、不真执行重置 | "测试模式" |
| 真身站 | 本机套餐 Key 额度实际承载的站（z.ai/bigmodel） | — |
| run-ledger | ledger/*.jsonl 账本，唯一事实源 | "日志"泛称 |
