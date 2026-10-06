# P1-2 S3 贫血章处置协议 — 真工件证据 (1006 收官)

件: `superline/anemia_protocol.py` | 单测: `tests/test_anemia_protocol.py` 7/7

## 定位

对账器 (S3-1) 处置建议上加两层闸, 防两种死法:
**临门一文不产** (补扫预算无界 → 85/15 帽: 基数=弹药门 t12 需求
3000万动态同源, 15%=450万封顶给补扫, 超帽即转 pivot 绝不再扫) 与
**无限补扫** (结构转向梯子: 零有效新增 ≥2 轮→pivot 合并/降级/换维,
≥4 轮→升用户裁决 waivers 通道挂起+企微呈报)。三态终止 =
CONTINUE/PIVOT/ESCALATE; 超期告警 = 滞留 >3 天 overdue_warn 入账
(单测注入时钟演练, 至多一条不刷屏)。

## 真链演练 (EPC50-SNEI replay, manifest 冻结=零增长是真实数据)

- 真贫血章 ch04/ch12 (与 S3-1 三态 13 饱和/2 贫血一致), 5 观察轮:
  streak 0(基线)→1→**2=PIVOT×2 真事件**→3→**4=ESCALATE×2 真事件**
  (企微注入零真发); pivot 建议=换维 (扩写章当前层已榨干)
- ledger 16 事件全链可重放: round×10 → pivot×2 → escalate×2 →
  rescan_blocked×2
- **补扫闸真拦截**: escalate 后 `may_rescan(ch04/ch12)` →
  `已升用户裁决 (escalate 在案) — resolve 前禁补扫` (RC=1)

## 85/15 分桶账 (真实 rescan_ledger, 执行率可查)

基数 30,000,000 (contracts.gate_defaults 同源) | 补扫帽 4,500,000 |
已出队 200,000 (S3-1 ch03 真单) / plan-only 200,000 (ch04 无可派腿) /
**执行率 4.44%** | gap 桶到账 0 / 生产桶分列另计 | 未耗尽

## 单测锚 (7 项)

梯子纯函数 (预算短路/梯子最高) / 观察轮 (基线-连击-增长复位) /
pivot 不重复 / 4 轮升裁决+挂起禁扫+continue 新窗口 / 分桶账耗尽态+
饱和章拒扫+章不存在 KeyError / exempt 无 note 硬拒+lock 终局停记轮 /
超期告警注入时钟 / ast 零网络根模块。

## 工件位

- `replay_out_p12/{evidence_p12.md, ledger_view.jsonl}`
- 原件 `replay_out_charter/EPC50-SNEI/_pipeline/anemia_ledger.jsonl`
- rescan 前置闸接线位: `chapter_matrix.dispatch_rescan` 调用前过
  `may_rescan` (P1-10 并发编排时焊死)
