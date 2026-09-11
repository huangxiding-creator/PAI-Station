# 08 成果 —— 器官宪法

> 液态架构 12 器官之一（PROPOSAL_V2.md 第 3 章）。本文件是器官的宪法：
> 使命、边界、IO 契约、质量门、自主更新触发器。引擎只是代谢层，可换；器官与数据不朽。

## 使命
产能仓库：答案/文稿/报告/方案/工具五层成果

## IO 契约
- **输入**：任务执行
- **输出**：成品、交接记录

## 质量门（出厂标准）
密度计 ≥60 或如实降级

## 自主更新触发器
任务完成时

## 目录结构
- `answers/`
- `drafts/`
- `reports/`
- `solutions/`
- `tools/`

## 液态状态
`_state.json`：水位（watermark）/ 条目计数（items）/ 新鲜度（freshness）/
健康度（health）/ 上次同步（last_sync）。由引擎经 `paistation.organ.state`
原子更新，水位只前进不后退。

## 流转凭证（红线 R14）
器官间一切交接落 `_credentials/chain.jsonl`（带 sha256 摘要，可审计）。
引擎禁止直写本器官之外的任何器官内部。
