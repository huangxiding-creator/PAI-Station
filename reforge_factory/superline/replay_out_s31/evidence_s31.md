# S3-1 章节×证据双向对账器 — 真工件证据 (1006 收官)

件: `superline/chapter_matrix.py` | 单测: `tests/test_chapter_matrix.py` 4/4

## 真链冒烟 (EPC50-SNEI: replay framework × 真池 manifest)

- 账本 28,218 行 (manifest valid × dedup, 与 tier_report 同语义)
- 15 章矩阵: 三态 13饱和/2贫血/0缺口; 贫血处置 ch04/ch12 扩写 (四权 74/74.6)
- 矩阵+审计落 `superline/replay_out_charter/EPC50-SNEI/00 研究报告需求/
  chapter_matrix.{json,md}` (framework=clean 回炉环零触发)
- **抽样 10 格对回 manifest 明细零漂移** (dedup_key 锚逐格 chars/items 重算相等;
  漂移注入实验: 单行 chars+7 → drift=1 可检出, 见单测)
- 权威度列全 "未分级" = 真池 28,218 行均 pre-FT-5 无 authority_grade 键 —
  诚实降档显示, 绝不臆造 A/B/C

## 四权口径 (同 epc-deep-research 阶段5 在役阈值, 纯函数重实现)

数量30% (≥10件30/≥5件20/≥3件12/余×4) + 深度30% (均字≥3000/1500/500)
+ 多样性20% (引擎≥3/2) + 时效20% (当年20/近一年15/更早8/无ts中位15)

## 三态/处置判定 (v1 门限: ≥75饱和 / <40或零证据缺口 / 中间贫血)

饱和→锁定 (S3-2 锚) | 贫血→扩写 (独占证据+有T1/T2) / 合并 (章间证据
Jaccard>0.5) / 降级 (仅T3词章) | 缺口→补扫

## 补扫单真实出队 1 条留痕

- ch04 自动最弱层 T1 → **plan-only 诚实留痕** (真注册表当期 T1/T2 零可机器
  派腿, 腿面诊断: T1=[] T2=[] T3=[media_group cmd✓])
- ch03 显式 T3 补弹档 → **真实入队**: conductor_state_sandbox.json
  J1267388878_media_group (P3/heavy, media_group_collector.py 真命令,
  CONDUCTOR_STATE 测试态闸隔离 — 生产队列零污染)
- 出队账: rescan_ledger_view.jsonl 2 笔 (1 queued + 1 plan-only),
  原始账本在 `replay_out_charter/EPC50-SNEI/_pipeline/rescan_ledger.jsonl`
- 单测另证真实 add_job 通路 (fixture 渠道 queued=True + conductor 态+ledger
  双留痕断言; 显式层 T1→P0/非heavy 档位透传 + 无词表层硬拒)

## 判定源纪律

行=manifest valid×dedup (dedup_key/url_norm/source_path 三级键), 不信模型
自评; 匹配面=标题级下界 (与 tier_report 同判据) — 对账两账本零漂移的根基.
