# superline — 超级生产线 P0 任务板

报告名→顶级研报超级生产线框架 v1 (用户 2026-10-06 全批 P0-P2, 38 增量件).
总装文档 `_proposals/report-methodology-1006/SUPER_PIPELINE_FRAMEWORK_V1.md`,
批准回执 `APPROVAL.md`. 本目录 = 增量件落位处 (Python311 全栈).

## 边界 (随批继承, 件件适用)

- 硬层不动: 五层调度 / 弹药门 v3 / 饱和引擎 / RQS 21 门零改动
- 判定源一律取 tier_report / manifest / 池账本数字, 不信模型自评
- 免费模型优先; 付费敞口仅 Jev 原语位 (XC-6 档位表前置)
- 共性库回写走批准制 (waivers 同构); 账号安全四件套照旧

## P0 地基 (已落)

- [x] `contracts.py` 共享契约层: 常量唯一事实源 + charter/framework 纯函数
      校验器 + 指纹 + 兜底三段框架 + 门参数动态同源 (gate_defaults 读
      ammo_pool) — 测试 `tests/test_superline_contracts.py`

## P0 12 件 (主链: 判级 → 契约 → 分母可信 → 对账锁定)

| # | 件 | 落位 | 验收判据 (机检锚) | 态 |
|---|---|---|---|---|
| S0-1 | 门卫判级器 (泛化 epc50_start_gate → s0_gatekeeper) | superline/s0_gatekeeper.py | 10 历史战役回放判级一致率 ≥8/10; 每 RETREAT 缺口清单非空; 判级全程零付费渠道 | ☐ |
| S0-2 | 词表生成器 (entity expansion 六槽展开) | superline/tier_expander.py | 3 已完成战役回放 T1 召回 ≥90%; 六槽非空或显式「查无」; 全程免费渠道 <30min | ☐ |
| S0-3 | Charter 呈批门 + 两级输入协议 | superline/charter_gate.py | 一次试产全链时间戳留痕 (呈批/回执/批准进战役目录); 改批往返 ≤2 轮; 呈批件含机器可读 JSON | ☐ |
| S0-4 | 解析腿标准件三件 (复述纪律/反例问题/英文意图词剥离) | superline/prompts/ | Charter 草案含复述栏 + 战役 04 指令含反例问题文件 + 英文词表带扇出 ≥3 变体 — 三项逐条 grep 可验 | ☐ |
| S1-1 | 框架生成器 v1 (framework.json 契约+四框架族+双参数+模型分档) | superline/framework_gen.py | schema 校验过; 同输入重跑 3 次章数波动 ≤1; 路由字段齐备率 100% | ☐ |
| S1-2 | 规划前免费侦察注入腿 (zh-search-pro + anysearch) | superline/scout_inject.py | 每章密度预估可追溯 ≥1 侦察命中或显式 LOW; anysearch 渠道账本首笔产量 | ☐ |
| S1-3 | 兜底默认框架 + 硬拒回炉 | contracts.default_framework + framework_gen 回炉环 | 坏 JSON 注入: 回炉与降级路径各实测触发 ≥1 次 (地基件已含兜底框架本体) | ☐ |
| S2-1 | snippet 不入池硬门 | ResearchFactory-Eng tier_router 闸 | 全量检索 snippet-only 入池记录 =0 (grep gate 日志可证) | ☐ |
| S2-2 | tier_router 预算分档三档 (outline_wide/section_narrow/gap) | ResearchFactory-Eng tier_router 派单参数 | 框架期/章级/补弹消耗分桶可查 (tier_report 分列); 总量不超弹药门预算 | ☐ |
| S3-1 | 章节×证据双向对账器 (四权+权威度列+三态) | superline/chapter_matrix.py | 抽样 10 格对回 manifest 明细零漂移; 三态与人工复盘一致; 补扫单真实出队 1 条留痕 | ☐ |
| S3-2 | 大纲锁定合同化 (outline-as-contract + 章级 4 态状态机) | superline/outline_contract.py | 章态与 manifest/完备门三方一致; 变更零静默 (每次变更 diff 在案, 指纹锚) | ☐ |
| XC-1 | 完备门键名归一器 (治 7/13 假缺席) | ResearchFactory-Eng conductor/v2 | 复查 13 裸缺席全部为真缺席 (零错位); 完备门四态分布与池账分毫不差; G-005 范式前后快照在案 | ✅ 1006 收官: 13=8 假缺席(池证到场, 池账逐键零漂移)+5 真缺席(工单 XC-1-R1..R5); 四态 33/10/2/13→42/9/7/0, passed False→True; 前后快照 completeness_v2.{before,after}_xc1.{json,md} 在案; 单测 10/10 |

P1 (15) / P2 (11) 见总装文档呈审门分期表; P0 收口后按「已有 05 根基对标
存量、T1 覆盖厚」原则提试产战役候选名单呈用户选 (批准事项 4 未决项).
