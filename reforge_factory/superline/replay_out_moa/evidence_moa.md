# 框架驱动调研接线 — 真工件证据 (1006 用户令收官)

件: `superline/manus_outline_adapter.py` | 单测: `tests/test_manus_outline_adapter.py` 5/5
提示词: `ResearchFactory-Eng/RefPrompts/生成报告目录框架提示词_v3_框架驱动调研版.md`
样例: `ResearchFactory-Eng/RefPrompts/Manus输出示例_中国海诚.md`

## 定位 (用户 1006 新范式)

旧流: 报告名 → 生成关键词 → 检索采集 (epc-deep-research 阶段2/S0-2 词表面)
新流: 报告名 → **Manus (v3 提示词) → 目录框架** → 本件摄取 framework_v1
      → 既有链 S1-2 scout → P1-1 呈审门 → S2 章级分档采集 (T1=outline_wide
      /T2=section_narrow/T3=gap) → S3 对账锁定。
词表职责不变 (S0-2 六槽仍产 T1 实体词), 框架供给**章级采集目标与验收标准**
(研究问题/检索词/信源方向/侦察 URL)。

## 映射规则 (与 framework_gen 同构, 不另立山头)

分档 = 显式 role 优先 + 标题关键词兜底 (首尾 outline_wide / benchmark→gap /
其余 section_narrow); 渠道 = EPC50 实测组合; T1 = tiers.json 轮转切片 ∪
[全称,简称]; T3 = 检索词中 EPC/总承包 行为词 [:3] 无则兜底; 密度纪律 =
high/medium 无侦察 URL 强制降 low (S1-2 同款) + moa_ledger.jsonl 入账绝不静默;
校验失败硬拒不兜底 (外部件降级会抹掉调研指令, 不走 S1-3)。

## 真链冒烟 (Manus输出示例_中国海诚.md → EPC51-HAISUM)

- 15 章 / 54 节 / 272,000 字当量 (30万目标 -9.3%, ±10% 内)
- validate_framework 零错, route_completeness 15/15, 指纹 cc05c6e4ed9c
- 章级路由抽查: ch01[outline_wide]/ch02-10[section_narrow]/
  **ch11[gap]** (显式 role=benchmark)/ch12-14[section_narrow]/
  ch15[outline_wide]; T3 行为词逐章落位 (如 ch02「年报 工程总承包 收入」)
- 落盘 `replay_out_moa/EPC51-HAISUM/00 研究报告需求/framework.json`
  + `_pipeline/moa_ledger.jsonl` ingest 事件

## 实坑入账 (1006 冒烟抓出)

「轻工赛道的拥挤与空隙：海诚vs兄弟设计院与跨界对手」——benchmark 章标题
不含「对标/竞争/格局」关键词, 标题猜角色误判 section_narrow。根治 =
契约加显式 `role` 字段 (值域 intro/core/benchmark/outro), **对标章必填
benchmark**, 标题关键词只作兜底; 单测双路 (role 显式/关键词) 各钉一条。

## 点火位 (待用户令, 全域暂停中)

1. 恢复收集域 (`yield_pause_all --resume` 按账) 后, 以 v3 提示词快速启动
   指令发单 Manus (试点 profile 10号, 日1单纪律) 产第 51 家真框架
2. `manus_outline_adapter --md <Manus输出> --campaign-id EPC51-xxx
   --tiers <S0-2 词表> --out <战役>/00 研究报告需求/framework.json`
3. 后接既有链: S1-2 scout → P1-1 呈审 → S2 章级分档采集 (采集按章验收)
