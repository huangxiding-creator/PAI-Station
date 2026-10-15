# REQ-032 漏斗账本接线说明（funnel_events.jsonl）

四级漏斗 `visit → sample_read → click_buy → pay`，事件 schema：

```json
{"sku": "R50-SNEI", "channel": "gzh-zbzs", "level": "visit", "ts": "2026-10-15T11:30:00+08:00", "ref": "wx_vid_123"}
```

- `channel` 渠道名（唯一带渠道维度的源——server events 表无 channel 列，故立本账本）
- `ref` 转介绍/投放追踪参数（`?ref=`，呼应 REQ-036），可空
- 写入函数：`funnel_query.record(sku, channel, level, ref="")`（校验非法 level/sku/channel 直接抛 ValueError）

## 接线位（改既有服务时照此挂，本任务未动 server.py/pay.py 一行）

1. **visit / sample_read / click_buy 三级**：`server.py` `do_POST` 的 `/api/track` 分支，
   `INSERT INTO events` 成功之后追加一行：

   ```python
   import funnel_query as FQ
   lvl = {"visit": "visit", "read_sample": "sample_read", "click_buy": "click_buy"}.get(ev)
   if lvl:
       FQ.record(sku, extra 中的渠道标记或 "site", lvl, ref=extra)
   ```

   渠道标记建议：落地页 URL 带 `?ch=gzh-zbzs`（或 `?ref=`），前端 track 调用时放进 `extra`。
   （`scroll_*`/`show_qr` 为更细粒度，不入四级，无需转记。）

2. **pay 级（官方落点）**：`server.py` `/api/pay/notify/wx` 与 `/api/pay/notify/ali`
   的 `PAY.mark_paid(...)` 成功后：`FQ.record(sku, channel, "pay")`。
   不用 events 表的 `order_created` 冒充 pay——那是下单未必付。

3. **渠道命名规范**：`site`（站内自然流量）/ `gzh-<公众号号位>` / `wx-video` /
   `ref-<转介绍码>` / `zhihu` 等 `[\w-]{1,24}`。

## 查询

```
py report_platform/funnel_query.py --sku BID26-FULL     # 单 SKU 四级漏斗数
py report_platform/funnel_query.py --week 2026-W42      # 全站周汇总（per-SKU）
py report_platform/funnel_query.py --record R50-SNEI gzh-zbzs visit   # 手工写入
py report_platform/weekly_north_star.py --week 2026-W42  # 周报北极星 md
```

查询双源合并：本账本（带渠道）+ `report_platform.db` 只读实读
（events 表映射 visit/read_sample/click_buy；pay 级=orders 表到达过支付的订单）。
库不存在时该源计 0，如实呈现。
