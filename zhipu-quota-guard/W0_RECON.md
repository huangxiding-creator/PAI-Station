# W0 真身侦察报告（2026-10-23，API 腿实测）

## 实测结论（scripts/w0_recon.py 输出）
| 项 | 结果 |
|---|---|
| Key 归属 | 套餐 Key（***8dzV）在 api.z.ai 与 open.bigmodel.cn **双域同源**：同一 customerId=26081768204143049，同一数据 → 双站互为故障转移（修正「账号分离」假设） |
| 套餐 | **GLM Coding Max**（年付 ¥1920 实付，2027-01-26→2028-01-26，status VALID，level=max，autoRenew=0） |
| 5h 窗 | TOKENS_LIMIT 已用 **25%**，nextResetTime=1792739680173（今日）；⚠️响应无 usage/remaining 字段，仅 percentage——语义（已用%）以 W2 控制台进度条交叉确认 |
| MCP 工具月度 | TIME_LIMIT **100% 用尽**（search-prime 3392 + web-reader 608 / 4000），nextReset 2026-10-26——佐证今日 WebSearch 降级 |
| 重置卡 | **3 张 5h 卡**（recordId 6/7/8，GLOBAL，全部 available，expire 2026-12-22 23:59:59，从未使用）；周卡 0 张 |
| 卡预算 | 3 − 1（自媒永动机预留）= **2 张可动用**（用户批准的默认规则） |
| 登录态 | 监控链路+卡库存链路**零登录态**（套餐 Key Bearer 全通）——登录态仅在重置动作（若需）时引入 |

## 待 W2 解决
- 重置动作端点：**禁止盲探 POST**（误触=烧卡）。路径：①只读 GET 探 history/status/opportunity 端点族 ②读 zcode-proxy 源码端点名（授权账户互操作情报）③控制台抓包实证。

## 对架构的影响（ADR 修订）
- ADR2 修订：双站=同账户双域，provider 抽象保留（故障转移价值），去除「跨账号」复杂度
- ADR7：Max 档 V3 积分制（28,000/5h；高峰1x/非高峰0.5x）——无 V2 老套餐迹象，按 V3 建模
- 卡有效期统一 12-22：FIFO 退化为「预算约束下按需」，would_expire_wasted 逻辑保留（12月临近过期前应优先提示消耗）
