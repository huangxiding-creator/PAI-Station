# S3-2 大纲锁定合同化 — 真工件证据 (1006 收官)

件: `superline/outline_contract.py` | 单测: `tests/test_outline_contract.py` 6/6

## 章级 4 态状态机 (只进不退; 退=显式 unlock 钉住)

gap_scan (缺口补扫) → collecting (贫血扩写) → locked (饱和锁定, 禁改章大纲)
→ writing (弹药门∧完备门双全过交撰写)

钉住语义 (真坑根治): unlock 后 refresh 不自动回升 — 否则降态被秒回=假降态;
回升须显式 relock 且矩阵回饱和, 全程留痕.

## 真链冒烟 (EPC50-SNEI 沙盒 battle_copy × 真池 28,218 行 × 真完备门)

- establish: 15 章入合同, 态分布 13 locked / 2 collecting / 0 gap_scan,
  指纹锚 e00c29c668d84e05
- **reconcile 三方一致 ✅**: 章态 ↔ 章节矩阵 (manifest 派生) ↔ 战役门
  (ammo tier_report × completeness_v2.json 真读), 指纹✓ 章态失配 0 门漂移 0
- 变更零静默全路径 (outline_changes.jsonl 7 笔):
  - 锁章 ch01 retitle → ❌ 拒+留痕 (须先 unlock)
  - 开放章 ch04 retitle → ✅ 应用, framework.json 落盘, 指纹
    e00c29c6→1fd856c1 变更在案
  - ch05 unlock→refresh 钉住不回升→relock 解钉回升 (三笔连环留痕)
  - **promote ch01 → ❌ 战役门未全过**: ammo gate_ok=True 但真完备门
    passed=False (当日 11:55 生产重渲: 61 渠道分母 present 2/exempt 16/
    带豁免 12/**裸缺席 28** — EPC50 战役后新注册渠道无其账), 双门纪律
    真拦截非摆设; writing 态仅单测 (门 monkeypatch 全过) 实证
- 绕合同手改 framework.json → reconcile 指纹失配当场检出 (单测
  test_03: 手改→fingerprint_ok False→还原→ok)

## 变更正门唯一性

一切结构性变更 (retitle/retier/remove/add) 只走 apply_edit: 变更后框架须
自过 contracts.validate_framework (坏变更硬拒), 每次尝试 (含拒) 落
outline_changes.jsonl 带 fingerprint_before/after; 合同指纹 = 章序+题目+
分层词表+分档 规范串 sha1[:16].

## 工件位

- `battle_copy/00 研究报告需求/outline_contract.json` (合同态)
- `battle_copy/00 研究报告需求/outline_changes.jsonl` (变更账 7 笔)
- `battle_copy/00 研究报告需求/framework.json` (retitle 后真框架)
