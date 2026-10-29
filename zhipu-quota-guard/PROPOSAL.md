# PROPOSAL: 智谱额度护盾 ZhipuQuotaGuard

> 让 CC 编程开发在 GLM Coding Plan 额度制下**永不断线**的 24h 无人值守守护——API 直连监控 + 预测型决策 + 重置卡资产治理 + 自动执行重置。

## The 10× claim (falsifiable)
- **Best differentiation axis**: latency（额度耗尽→恢复开发的 MTTR）
- **Multiplier**: **43.75×**（ours ≈0.08h 自动检测+重置+验证 vs 基线 ≈3.5h 人工发现+手动恢复，含夜间/无人值守空转；TenX index = 1.641）
- **Evidence**: docs.bigmodel.cn/cn/coding-plan/overview.md（动态刷新/积分制实证）+ zai-usage·opencode-glm-quota 源码（quota/limit 端点含 nextResetTime）+ 用户一手痛点亲述（24h 产线无人值守中断）
- **可证伪**: 上线后以 run-ledger 实测每次「额度耗尽→恢复」时延中位数，若 >0.5h 判本声明失败回炉

## Problem & persona
- **Persona**: AI-Station 工作站运营者本人——GLM Coding Plan 驱动 CC 24h 开发（自媒永动机+研报产线+多项目并行）
- **Pain**: 5h 动态刷新额度耗尽 → CC 立即中断，夜间/无人值守时段无人救场（evidenced by 用户语音亲述 + 07 任务/智谱额度监控及重置 转写）
- **Frequency**: 每窗口可发生（高峰 1x/非高峰 0.5x 积分制下，重任务日 1-3 次）；现有恢复全靠人肉

## Existing landscape (from research)
| Solution | Maturity | Stars | Gap it leaves |
|---|---|---|---|
| zcode-switch (MIT) | 84.5/100 | 410 | 只展示额度+定时领活动，无预测、无自动重置决策 |
| lichong-a/zhipu-codeing-plan-monitor (MIT) | ~40/100 | 2 | 仅查询（MIT 端点契约源），无动作闭环 |
| opencode-glm-quota (MIT, 2026-10 活跃) | ~45/100 | 32 | quota/limit 取数参考，单次查询非守护 |
| zcode-proxy (无许可证) | — | 22 | reset 端点族 pattern（仅参考，不可抄代码） |
| ccusage (MIT) | 95/100 | 19138 | 本地 JSONL 用量聚合，只管「我们烧多快」不管「额度/重置」 |

Landscape: median 51.2, mature 1, derived feasibility 0.691。**结论：查询有零件，重置无成品，预测+治理+守护闭环市面空白——adapt ≈85%，自建仅重置 glue + 决策引擎 + 编排。**

## Why this wins（vs 你的原始想法，100 倍升维点）
| # | 你的原始想法 | 本提案 | 为什么 |
|---|---|---|---|
| 1 | 浏览器逆向查额度比例 | **纯 API 直连**：`GET {api.z.ai\|open.bigmodel.cn}/api/monitor/usage/quota/limit`（套餐 Key Bearer）拿 percentage/remaining/**nextResetTime** | 官方无文档但社区三项目在役验证；零浏览器=零风控面，正合你「开放接口就更好」 |
| 2 | 到 98% 就重置 | **预测型决策引擎**：本地消耗速率（ccusage 解析 ~/.claude JSONL）× 高峰 0.5/1x 建模 × nextResetTime → 算「会不会在自然刷新前烧穿」，只在真会烧穿时花卡 | 阈值法两头亏：早重置浪费卡，晚重置照样断线；卡是稀缺资产，一张都不该浪费 |
| 3 | 每日 3 次、留 1 给永动机 | **重置卡资产治理**：API 查真实库存（`customer-package-reset/list`：5h卡/周卡各自数量+有效期）→ 预留配额(永动机-1) + **有效期 FIFO**（先花快过期的卡） | 「每日3次」是误解：卡按持有量计；快过期卡不花=白白作废 |
| 4 | 监控 bigmodel.cn 后台 | **双站 provider 抽象 + W0 真身锁定**：本机 CC 实走 api.z.ai，你给的登录页是 bigmodel.cn——两站账号分离，先实证哪站承载本 Key 消耗（可能两站都要护） | 监控错站=全部白做；provider 抽象后未来加账号零改造 |
| 5 | DrissionPage 全程逆向 | **DrissionPage+REA 只打一场仗**：登录态抓包「使用重置卡」按钮的 XHR（唯一无公开端点的环节）→ 抓到后降级纯 API；登录态 cookie 持久化保活，浏览器最小出场（铁律：不必要不开） | 重置动作端点全网无公开实现，这才是逆向主战场；抓包是 REA capture_browser_scenario 的标准活 |
| 6 | 断了再说 | **企微全链通知**：重置执行/额度告警/登录失效/卡库存不足，每步可观测 | 你在手机上就能看见护盾在干活 |
| 7 | 一次性工具 | **生产级守护**：Windows 计划任务常驻 + 审计账本(JSONL run-ledger) + dry-run 演练模式 + 契约漂移检测 + 防风控随机延迟 | 24h 无人值守必须有账本和熔断，否则静默失败比不自动化更糟 |

## Blue-ocean / red-ocean judgment
内部基础设施蓝海。查询类工具红海（5+ 个），但「预测决策 + 重置卡治理 + 自动执行 + 双站」闭环全球零成品（zcode-proxy 无许可证仅有协议面）。

## MVP scope (what CC builds first)
- **W0 真身锁定**（半天）: 用 settings 现有 Key 直打 api.z.ai quota/limit 实证归属；登录 15838272889 双站核对套餐/卡库存；V2/V3 套餐判别（3x 还是 0.5/1x）
- **W1 监控核心**（1 天）: provider 抽象 + quota/limit 轮询（自适应频率：闲时 10min / 高消耗 2min）+ 卡库存查询 + 状态落盘
- **W2 重置链路**（1 天）: DrissionPage@独立profile 登录 bigmodel.cn（或 z.ai）→ REA 抓包「使用」按钮 XHR → 复刻纯 API 调用 + 登录态失效自动续期（cookie 保活，失效才唤浏览器，验证码才唤你）
- **W3 决策引擎**（1 天）: ccusage 速率解析 + 烧穿预测（提前量≥30min）+ 卡预算（预留 N-1、有效期 FIFO）+ 高峰感知 + dry-run
- **W4 守护部署**（半天）: 计划任务开机常驻 + 崩溃自拉起 + Chrome 进程守门对齐
- **W5 观测**（半天）: 企微通知（tools/notify 复用）+ 本地状态面板（单文件 HTML）+ run-ledger
- **W6 试运行**（24-48h）: dry-run 1 天 → 实弹 1 天 → Ralph 瓶颈优化
- Out of scope (v1): 多账号轮换、自动购买套餐/卡、模型自动降级切换（只做建议推送）

## Monetization (see BUSINESS_MODEL.md)
内部生产力设施，不售卖。按内部 ROI 记账：每次避免的中断 × 挽回产线小时 × 产线小时价值 + 重置卡零作废收益。

## Scorecard
| Dim | Score |
|---|---|
| feasibility | 0.691 |
| user value | 0.95 |
| monetization | 0.70（内部ROI代理） |
| tenx | 0.99 |
| **weighted** | **0.845 — proceed** |

## Assumptions to confirm at gate（批准时请一并确认）
1. 重置卡实际库存以 W0 API 实查为准（若 0 张：工具自动降级为「监控+预测+企微预警」，重置腿待你补卡后即插即用）
2. 15838272889 的套餐真身站（bigmodel.cn / z.ai / 两站皆有）由 W0 实证；若 z.ai 需另套登录凭证，卡验证码才找你
3. 卡预留规则默认：**可用库存 −1 张留给自媒永动机**（取代原「每日最多2次」假设；可改）
4. 重置执行模式默认：**先斩后奏**（执行后企微通报）；若你要「先企微请示再执行」请说明
5. 密钥落位：`zhipu-quota-guard/secrets/`（gitignored），账号密码/套餐 Key 全部外置，永不进仓

## Risk register (top 3)
1. 重置 XHR 抓不到（按钮走加密/风控）→ 常驻 DrissionPage UIA 点按兜底（牺牲浏览器纪律最低限度，仅重置瞬间唤起）
2. 未文档端点改版（quota/limit 字段漂移）→ 契约测试每版本快照 + 漂移即企微告警 + 降级浏览器读数
3. 卡库存为 0 / 全部过期 → 降级监控+预警模式，推送「建议购卡/调峰」建议（联动 token-peak-hour-rule）
