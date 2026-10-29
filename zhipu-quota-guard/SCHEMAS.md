# SCHEMAS — 数据契约（Phase 3）

## 1. 外部 API（见 KNOWLEDGE_BASE/rules-and-endpoints.md 端点节）
quota/limit 响应（TOKENS_LIMIT 5h 窗）→ 内部归一化：

## 2. 内部数据模型
```python
QuotaSnapshot:  # 每次轮询产出
  ts: int                 # epoch
  provider: "zai"|"bigmodel"
  window_pct: float       # 5h窗已用%
  remaining: float
  next_reset_at: int      # epoch，调度权威字段
  raw: dict               # 原始响应（契约漂移检测用）

CardInventory:            # 重置卡库存
  five_hour: list[Card]   # {count, expire_at} 聚合后
  weekly: list[Card]
  fetched_at: int

BurnRate:                 # 本地遥测（ccusage 式聚合，最近30min窗口为主）
  tokens_per_min: float   # 加权积分当量/分钟（高峰系数折算后）
  peak_now: bool          # 是否处于高峰时段

Decision:                 # 决策引擎产出
  action: "reset"|"wait"|"notify_only"
  reason: str             # 人读理由（企微推送原文）
  predicted_exhaust_at: int | None
  card_to_use: "five_hour"|"weekly"|None  # FIFO+预留后选择

RunLedgerEntry(JSONL, 账本唯一事实源 C10):
  {ts, kind, payload}     # kind: poll|decision|reset_exec|reset_result|notify|heartbeat|login|drift|error
```

## 3. 配置（config.yaml，密钥除外）
```yaml
providers: {zai: {enabled, base_url, plan_key_ref}, bigmodel: {...}}
poll: {idle_min: 10, busy_min: 2, threshold_pct: 90}
policy: {reserve_cards: 1, lead_time_min: 30, fifo_by_expiry: true, mode: "auto"|"dry_run"|"notify_only"}
notify: {wecom: true}
daemon: {heartbeat_min: 15}
```
密钥引用 `plan_key_ref` → secrets/zhipu_secrets.json（gitignored）实际值。

## 4. 账本文件
- `ledger/run-YYYYMMDD.jsonl`（run-ledger）· `ledger/cards.json`（卡库存缓存）· `state/`（登录态 cookie、last_snapshot）
