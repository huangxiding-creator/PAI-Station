# ARCHITECTURE — Demand Engine 2.0

## 组件图
```
tools/demand_ledger.py          # F1 台账核心：append(path, signal, idempotent) + read + dedupe(F7) + top
tools/dl_collect_wechat.py      # F2/F3 面A：rion p2p timeline + sns-feed 翻页 → JTBD 抽取（关键词触发+引句）
tools/dl_collect_comments.py    # F4 面B1：API 回执链（material→publish→comment/list，48001号skip如实）
tools/dl_collect_channels.py    # F5 面B3：CDP 9337 channels 后台评论爬取（DrissionPage 附加）
tools/dl_collect_internal.py    # F6 面C：引擎 MySQL feedback + ask 全史 + funnel pay → 台账
tools/demand_ledger_report.py   # F8 热力周报（跨面聚合+JTBD精选+top选题建议）
tools/demand_engine_night.cmd   # F10 调度入口（串联全部采集器+报告）
data/demand_ledger/signals.jsonl # 台账（唯一真源，append-only）
data/demand_ledger/run_log.jsonl # 每轮运行账
```

## 关键设计
- 台账行 schema = topic-signals 超集：{signal_id, ts, source_face, source_ref, demand_quote, jtbd{...}, frequency, urgency, score, expert_panel?}
- JTBD 抽取（面A）：关键词命中句 → job_statement 模板（当{trigger}时，{谁}想{动作}，这样{outcome}）；面B/C 直接从评论/问题/反馈原文
- 去重键：source_face+source_ref+quote hash 前置；语义归并（F7）在报告层非写入层（台账保留原始）
- CDP 通道：复用 9337 sph_profile 登录态；DrissionPage attach 而非新建实例
