# RESEARCH_DIGEST — laya × 项目判断层全景调研（2026-09-23）

## A. laya 本体（一手：仓库全读 + 本机隔离评测）

| 维度 | 事实 | 来源 |
|---|---|---|
| 版本 | 0.3.6，commit c7527708（09-22 release，最新） | GitHub API |
| 架构 | 非自回归 System 1：单前向 typed decisions；三原语 choice/score/noul | README/common.py |
| 模块 | agent(385L)/router(336L)/common(280L)/shortlist(272L)/lang(292L)/presets(187L)/email(104L) | 仓库树 |
| **应答同构** | `system_one(state,questions)→{answers:{qid:{type,choice,noul,score,probabilities,confidence}}}` 与 typesafe API **逐字段同构** | agent.py L337-366 vs client.py |
| 微调 | 官方 notebook（2×T4 DDP）：`proper_reward` 损失+梯度检查点+micro-batch 8+4 epochs+**事后 LBFGS 温度拟合** | notebooks/ |
| 高基数 | shortlist.py：embed_fn 余弦粗排 top-k 再判（issue #102 方案） | shortlist.py |
| 语言路由 | lang.py 脚本检测 0.5ms；`preload=True` 保热（用户坑二：不预热每次重建 CPU 7.4s/T4 10.3s→32.8ms） | lang.py/用户资料 |
| 开放 issues | #185 头输出未归一化(~300× 编码器尺度，AMP 慎用)；#186 温度在 train slice 拟合有过拟合风险→held-out 拟合 | GitHub issues |
| 本机实测 | 冷加载 23.4s；批 6.5ms/问；VRAM 1603MB；dept 77.8%(zh 72.2/en 83.3)；score 33.3%(均值化)；churn 69.4%；refund 80.6%；模糊置信 0.097 vs 正常 0.702；乱码高置信穿透门控 | `_quarantine/laya-eval/REPORT.md` |

## B. 项目 Jev 接线全景（替换靶子，全部实读）

**中央阀门**：`E:\AI-Station\src\paistation\judgment\client.py`（265L）——ask/ask_noul/ask_choice + fail-soft + 熔断(3败/300s冷却/半开) + 三层开关(PAI_JEV env > jev.ini > key) + traj 审计(hash-only)。当前态：**enabled=1，key 在位，生产在用**。

| # | 接线位 | 原语 | 作用 | Jev 实测基线 |
|---|---|---|---|---|
| 1 | paistation/main.py + resident/entry.py | noul | 常驻助手任务指派判定 | E2: 召回1.00/误报0.00 |
| 2 | intent/l2_slow.py | choice | 意图快路径（免 LLM 直判） | E1: p50 1.3s, conf(对)0.92/错0.70 |
| 3 | cx/jev_screen.py | noul | 检索命中复核（四态 confirmed/hollow/lexical_only） | E3: 具体 0.94/0.08 |
| 4 | cx/source_filter.py | noul | J1 信源筛 | 双百倍 P0 已接线 |
| 5 | RF jev_adjudicator.py | choice+noul | 孤簇合并裁决+核名 | 滚雪球增量腿 |
| 6 | RF jev_method_review.py | ask | 方法论复核 | — |
| 7 | RF snowball_round.py | (经5) | 考卷泄漏根治腿 | 词面88/confirmed12 |
| 8 | super-skill assets/jev_ask.py | noul+choice | 随身 CLI | S2 正0.62-0.91/负0.03-0.12; S3 正0.80-0.95/负0.02-0.24 |

**关键结论：8 位全部经 `ask(state,questions)->answers|None` 可调用件汇入 JudgmentClient——引擎置换=改一处，业务零改动。**

## C. 中文微调弹药（项目自有标注资产）

| 资产 | 量 | 形态 |
|---|---|---|
| tmp/jev_exp1_intent.jsonl | 159 | choice 带 expect 标签 |
| tmp/jev_exp2_taskreq.jsonl | 24 | noul 带 label |
| tmp/jev_exp3_verify.jsonl | 100 | noul 带 q/a/lexical/jev_noul |
| SELF_PROFILE 金标准100题 | 100 | golden_100_v1.jsonl |
| 双百倍 golden_baseline.json | — | 词面/Jev 分离基线 |
| laya-eval fixtures | 36+24 | 构造式标注（本窗口产出） |
| S2/S3 周管线 | 每周累积 | manifest 核验+材料预筛结果 |
| 研究工厂 run ledger | 持续 | 判断结果与后续验证回流 |

存量 ~400+ 高质量中文标注决策对；周管线持续增产；免费模型（GLM flash）可半自动扩标至 2-5k。

## D. 外部水位

- metaso 佐证：laya=「用 System 1 思维重塑决策」开源项目（TypeSafe AI 相关文章），社区覆盖薄→**年轻项目，锁版本+vendor 源码必要**
- WebSearch 配额 09-26 复位（缺口记录于 GAP_REPORT）
- 用户资料坑三条全部纳入设计：USE_TF=0 / preload=True / 语言路由 0.5ms（高棉语 0.000 坑靠路由绕过）
