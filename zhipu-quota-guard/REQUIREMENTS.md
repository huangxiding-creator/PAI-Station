# REQUIREMENTS — ZhipuQuotaGuard（Phase 4；用户已批提案+5默认假设，此为提案的工程化展开）

## 功能需求（FR）
- **FR1 额度监控**：系统应轮询真身站 quota/limit 端点（套餐 Key Bearer），归一化为 QuotaSnapshot；自适应频率（闲 10min/高消耗 2min）；双 provider（z.ai/bigmodel）可配置启用。
- **FR2 卡库存**：系统应查询重置卡库存与有效期（customer-package-reset/list 或控制台兜底），计算卡预算=可用−reserve_cards。
- **FR3 烧穿预测**：系统应聚合 ~/.claude/projects JSONL 近 30min 消耗，折算积分当量速率（含高峰 0.5/1x 系数），预测烧穿时刻；与 nextResetTime 比对。
- **FR4 自动重置**：当预测烧穿时刻早于自然刷新且提前量≥30min 且卡预算>0 时，系统应自动执行重置（API 优先，DrissionPage UIA 兜底），先斩后奏，1 分钟内企微通报结果。
- **FR5 卡治理**：系统应按有效期 FIFO 选卡（快过期先花）；周卡仅在周额度也将烧穿时才用；账本记录 would_expire_wasted 规避。
- **FR6 通知**：企微推送事件：重置执行/结果、低水位预警（≥85%）、登录态失效、卡库存不足、契约漂移、心跳超时。
- **FR7 守护**：计划任务开机自启+崩溃自拉起；心跳写账本；浏览器会话最短化（重置瞬间唤起，完毕即清，Chrome 进程守门对齐）。
- **FR8 观测**：run-ledger JSONL 账本（唯一事实源）；本地单文件状态面板（当前水位/预测线/卡库存/最近动作）；每日汇总推送。
- **FR9 安全**：密钥/账密全部外置 secrets/（gitignored）；日志全量脱敏；dry-run 模式（决策+账本跑、不执行）；防风控随机延迟（重置动作前后 3-8s 抖动）。

## 非功能需求（NFR）
- NFR1 MTTR：额度耗尽→恢复中位 ≤0.5h（目标 5min），run-ledger 实测验收
- NFR2 零误重置：自然刷新可覆盖时花卡次数=0
- NFR3 零密钥泄露：仓内扫描 0 命中；日志脱敏 100%
- NFR4 静默失败=0：所有异常→账本+企微（fail loud）
- NFR5 资源：常驻内存 <150MB；闲时 CPU≈0（纯轮询）

## EARS 验收判据（核心）
1. When 真身站额度水位 ≥ threshold_pct 且预测烧穿早于自然刷新， the system shall 在 ≤2 个轮询周期内产出 reset 决策并执行，且重置结果（成功/失败）写入账本并企微通报。
2. When 卡预算 = 0， the system shall 不执行重置，推送「卡不足+建议」并降级 notify_only。
3. When quota/limit 响应结构与契约快照不符， the system shall 记 drift 账本+企微告警，并降级浏览器读数，不崩溃。
4. When 登录态失效， the system shall 尝试自动续期一次；仍失败则企微唤人，期间监控链路（纯 API）不受影响。
5. When mode=dry_run， the system shall 全链路跑通但 reset 动作替换为账本记录 simulated_reset。
6. When 守护进程异常退出， the system shall 由计划任务 ≤60s 内自拉起，且心跳账本可证明。

## 范围外（v1）
多账号轮换/自动购卡/模型自动降级切换（仅建议推送）/非 Windows 平台。
