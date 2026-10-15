# REQ-036 订阅更新流 SKU 骨架 + ?ref= 转介绍追踪（T-022）

数据件：`report_platform/subscription_sku.json`（纯数据骨架，只增不改；本件与
`funnel_events.jsonl` 为本任务仅有的两个落盘变更，既有文件零改动）。

## 权益口径（年度研究订阅 SUB-ANNUAL-1999，¥1,999/年）

- **全年新报告**：订阅期内 `content/report.json` 新上架付费报告自动入权益，无需另购。
- **修订流**：所含全部报告的修订版（v1.x → v2）免费更新，随上架链推送。
- **会员答疑**：企微会员群 + 报告页留言优先回复，工作日 48h 响应口径。

锚定：单本蓝皮书 ¥10,000（BLUEBOOK-2027）；订阅 ¥1,999/年 ≈ 1/5 本价得全年产线。

## 上架步骤（三行）

1. `subscription_sku.json` 的 skus[0] 同层加 `"status": "live"`，server 读骨架渲染订阅落地页。
2. 支付接线：`/api/pay/order` 支持 SUB-ANNUAL-1999，fen=1999×100，回调 `mark_paid` 后 orders 落账。
3. 权益生效：pay 级事件入 `funnel_events.jsonl`，订阅期 365 天自支付日起算，期内新报告 sku 自动入权益。

## 转介绍 ?ref= 追踪

- 链路：落地页 URL `?ref=<转介绍码>` → 前端 track 放进 extra →
  `funnel_query.record(sku, channel, level, ref=...)` 落库（ref 字段为 T-018 交付，本任务做部署验证）。
- 校验：ref 限 ASCII `[A-Za-z0-9_\-.,@;]` 0-64 位，非法直接 ValueError（不静默丢弃）。
- 查询：`py report_platform/funnel_query.py --sku SUB-ANNUAL-1999`；事件面 ref 经 `collect()` 可查（见下）。

## 部署验证（2026-10-15 实测；ref=v3-selftest，channel=selftest，明确标注 selftest 非真实流量）

```console
# 1) 用 record() 实写 1 条带 ref 的 selftest 访问事件到 funnel_events.jsonl
$ py report_platform/funnel_query.py --record SUB-ANNUAL-1999 selftest visit --ref v3-selftest
{"sku": "SUB-ANNUAL-1999", "channel": "selftest", "level": "visit", "ts": "2026-10-15T12:00:15+08:00", "ref": "v3-selftest"}

# 2) --sku 查询：事件已计入漏斗与渠道明细
$ py report_platform/funnel_query.py --sku SUB-ANNUAL-1999
SKU SUB-ANNUAL-1999 四级漏斗 (visit → sample_read → click_buy → pay)
  visit             1   上级转化率 —
  ...
  渠道明细: selftest: visit=1
  数据源: funnel_events.jsonl=1 条 + db events=0 条 + db 已支付订单=0 单 (库不存在则计 0)

# 3) ref 维度可见（查询器 collect() 事件面）
$ py -c "... [e for e in funnel_query.collect(sku='SUB-ANNUAL-1999')['events'] if e['ref']] ..."
[{"sku": "SUB-ANNUAL-1999", "channel": "selftest", "level": "visit", "ts": "2026-10-15T12:00:15+08:00", "ref": "v3-selftest", "source": "jsonl"}]
```

结论：REQ-036.AC1 满足——订阅 SKU 骨架在案 + ≥1 条带 ref 的访问记录（selftest 标注）
已落 `funnel_events.jsonl` 且查询可见。单测门禁：`tests/test_ref_tracking.py` 三口径
（带 ref 可查 / 不带 ref 落空串 / 坏 ref 格式拒绝零写入）。
