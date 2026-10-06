# P1-1 S1 出口呈审门 — 真工件证据 (1006 收官)

件: `superline/framework_gate.py` | 单测: `tests/test_framework_gate.py` 5/5

## 定位

S2 是重资源阶段 (渠道配额/账号面/班次腿) — HITL 关卡卡在成本拐点,
S1 是最后廉价止损点. 通道复用 S0-3 charter_gate 范式 (呈批/回执/ledger
时间戳链/企微注入零真发/EDIT ≤2 轮第 3 次 escalate), 指纹锚复用 S3-2
outline_contract.fingerprint.

## 真链冒烟 (EPC50-SNEI replay 战役 15 章真框架)

- build: 15 章 / 87 分层词, 校验零错, 指纹 `e00c29c668d84e05`
  — **与 S3-2 establish 时指纹逐位同** (同框架跨件锚一致)
- submit: 机器可读 framework_submitted.json + 人读 framework_review.md
  (章节路由表: 每章 T1/T2/T3 词数/分档/密度/渠道), 企微注入零真发
- **s2_gate 出队闸真拦截实证**: 积分制渠道 (credits=true) 未批时
  `framework_approved.json 缺失 — 禁出队` (RC=1); APPROVED 后放行
  (`approved@2026-10-06T15:23:29 round1 fp=e00c29c6…`); 免费面渠道
  (zh_search_pro) 直行 — 止损点在成本拐点, 零成本面不受闸
- ledger 5 事件 ts 全 ISO 单调: built → submitted → receipt →
  approved → push

## 三态回执 (单测实证)

- APPROVED → framework_approved.json (verdict/fingerprint/round 锚定)
- EXEMPT → 豁免留痕 waivers 同构: 无 reason 硬拒 (`exempt_blocked`
  入账), 带 reason → `{"verdict":"exempt","waiver":true,"reason":…}`
  WARN 态放行 (非 approved)
- EDIT → 改批 ≤2 轮, 第 3 次 escalate 详单回呈 (绝不静默拉锯)

## 坏件禁出门

framework.json 空 channels → validate 错 → submit ValueError 硬拒 +
`submit_blocked` 入 ledger (机检零错才许出门, 与 S0-3 同判).

## 工件位

- `replay_out_p11/{framework_review.md, framework_submitted.json,
  framework_approved.json, ledger_view.jsonl}`
- 原件在 `replay_out_charter/EPC50-SNEI/00 研究报告需求/`
