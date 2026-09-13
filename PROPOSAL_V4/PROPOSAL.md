# PROPOSAL_V4 — 个人认知主权 OS（总提案·已批准）

- 批准记录：2026-09-13 用户批准（「批准」），按 A→B→C→D→E 顺序动工
- 调研依据：`RESEARCH_DOCKET/v4-vision-upgrade/`（239 条净新增 + 四份收敛文档）
  - 愿景全文：`RESEARCH_DOCKET/v4-vision-upgrade/VISION_V4.md`（五支柱/双北极星/判据）
  - 实现路线：`RESEARCH_DOCKET/v4-vision-upgrade/PROPOSAL_V4.md`（五阶段+尸检对照）

## 本目录文档

| 文件 | 作用 |
|------|------|
| WBS.md | 五阶段 WBS；Phase A 细化到任务级（TDD 先行） |
| RUN_LEDGER.md | 运行台账（C10：台账胜过文档） |
| ARCHITECTURE.md | sovereign 包架构（Phase A 动工时补） |

## 五阶段（依赖序）

| 阶段 | 支柱 | 一句话 | 状态 |
|------|------|--------|------|
| A 主权层 MVP | P0 | 资产法定化：vault+决策记忆+export/import/audit/forget+遗产模式+三向适配器 | ✅ 收官（76fe08d/28c2e83，938 passed，三验收判据达成） |
| B 验证资产复利 | P4/M3 | 出口闸 done token+任务级进化+金标准 40→500+ | ✅ 收官（1d225af，977 passed） |
| C 机器控制面 | P1 | 本机 API 网关+风控信任+审批密码学+7 天无人值守 | ✅ 收官（32d3b91，1001 passed，第三方复用判据达成） |
| D 网络节点 | P3/E | x402 客户端+git-native 市场+跨标准适配器+IM 侧挂 | ✅ 收官（bc1077b，1026 passed；真钱闭环待配置支付处理器） |
| E 商业治理 | B | 章程三律+小时数定价+open-core 2.0 | ✅ 收官（CHARTER.md 发布+audit 一致；1036 passed） |

判伪条款：10× 判据 12 个月内达成 <3 条 → V4 判伪回滚（详见 VISION_V4 第五节）。
