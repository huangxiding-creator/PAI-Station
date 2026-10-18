# REQUIREMENTS — Demand Engine 2.0（批准版）

## 功能需求
F1 Demand Ledger 台账：data/demand_ledger/signals.jsonl，统一 JTBD schema（沿用 topic-signals 字段）+ source_face(ext: group/p2p/moments/gzh_comment/sph_comment/mp_feedback/ask_log/purchase) + 频率/紧急度/时间戳；幂等（signal_id 去重）
F2 面A采集器A2私聊：rion timeline p2p 会话轮询→JTBD信号→台账
F3 面A采集器A3朋友圈：rion sns-feed --offset 翻页全量→JTBD信号→台账
F4 面B采集器B1公众号评论API：material/news→publish回执链→comment/list（总包说已通）→台账
F5 面B采集器B3视频号评论：channels 后台 CDP 9337 评论列表→台账
F6 面C接入器：feedback MySQL / ask 全史 / 购买日志→台账
F7 跨面去重：语义聚类（关键词n-gram Jaccard>0.6 归并，保留最高频）
F8 热力周报：tools/demand_ledger_report.py 输出 Markdown 热力榜+JTBD精选
F9 选题直通：ledger Top→radar_topics（复用 topic_signals_to_radar 桥逻辑扩展多面）
F10 调度：schtasks PAIStation-DemandEngine 每日 06:37（采集三面+周报）

## 非功能
N1 rion 只读红线；CDP 仅自家后台口；凭证外置；限流礼貌间隔
N2 台账只增不删（append-only jsonl）；失败 fail-soft 记录不中断
N3 全链零 AI 表述（需求侧同样适用）
