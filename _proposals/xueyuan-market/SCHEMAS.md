# SCHEMAS — 数据契约草案（Phase 3 产出，Phase 5 API_DESIGN 直接输入）

> 浓缩自：PROPOSAL.md（4.2-4.4/六）、FEASIBILITY_REPORT.md（1.1）、KNOWLEDGE_BASE/ 全部七件（virtual_pay/refund_criticism/viral_poster/content_pipeline/engine_conventions/mp_review_compliance）
> 实读补充：WeAppForge/projects/zongbao/content/catalog.json、chapters.json（试点实样）
> 约定：SQLite DDL 草稿；金额一律**分**（INTEGER）；时间 ISO-8601 文本（UTC+8）；布尔 0/1；主键统一 `id TEXT`（短ID/ULID）或自增。每表标注归属期 **[P0]/[P1]/[P2]**（P0=可卖闭环，P1=可传闭环，P2=可增闭环，PROPOSAL 六）。
> 纪律：本文件是草案——Phase 5 允许加列/加索引，**不允许改语义**（字段含义以 KNOWLEDGE_BASE 对应文件为准）。

## 0. 分期总览

| 期 | 表/契约 | 支撑能力 |
|---|---|---|
| P0 | users, reports, chapters, entitlements, orders | 可卖闭环：上架/试读/支付解锁/下载 |
| P1 | criticisms, refunds, vouchers, gift_grants(增补), poster_code, share_event, invite_relation | 可传闭环：批评退款/点赞赠/海报归因/邀请组队 |
| P2 | subscriptions(备忘) | 订阅推送/会员（远期，DAU 门槛后才评估） |

---

## 1. users — 用户 [P0]

uid 短 ID 化（openid 28 字符不进 scene，KNOWLEDGE_BASE/viral_poster.md §4）。

```sql
CREATE TABLE users (
  id            TEXT PRIMARY KEY,            -- 短ID（Base62/自增映射），如 uXk29f
  openid        TEXT NOT NULL UNIQUE,        -- 微信 openid（引擎侧换 appid 隔离）
  nickname      TEXT DEFAULT '',
  created_at    TEXT NOT NULL,
  last_seen_at  TEXT,
  is_blacklisted INTEGER NOT NULL DEFAULT 0, -- 批评退款黑名单（历史退款率>30% 转人工，R-04）
  refund_count_month INTEGER NOT NULL DEFAULT 0,  -- 当月退款次数（资格闸：≤2，PROPOSAL 假设4）
  flags         TEXT DEFAULT '{}'            -- json：运营标记（如首席批评官/勋章，P1 扩展）
);
```

## 2. reports — 报告 [P0]

catalog.json 的库内镜像 + 运营字段（KNOWLEDGE_BASE/content_pipeline.md §5）。

```sql
CREATE TABLE reports (
  id            TEXT PRIMARY KEY,            -- 报告短ID，如 js-shuiwang-2026
  title         TEXT NOT NULL,
  summary       TEXT DEFAULT '',
  price_fen     INTEGER NOT NULL DEFAULT 49800,  -- 统一定价 49800 分（PROPOSAL 假设2）
  chapter_count INTEGER NOT NULL,
  trial_chapters INTEGER NOT NULL DEFAULT 2, -- 试读章数（content_pipeline --trial）
  source        TEXT DEFAULT '总包创研院',
  published_at  TEXT,
  province      TEXT DEFAULT '',             -- 省份地图入口（PROPOSAL 4.1）
  owner_type    TEXT DEFAULT '',             -- 业主类型筛选
  industry      TEXT DEFAULT '',             -- 行业筛选
  tags          TEXT DEFAULT '[]',           -- json array：热词联想/三维关联推荐
  pdf_trial_path TEXT DEFAULT '',
  pdf_full_path TEXT DEFAULT '',             -- full.pdf 压缩后路径（待办，content_pipeline §4）
  status        TEXT NOT NULL DEFAULT 'on'   -- on/off（下架进改进队列，R-05 兜底）
);
```

## 3. chapters — 章节 [P0]

chapters.json 的库内镜像；**付费正文不入包、库内只存试读章正文**（防泄漏双设计，KNOWLEDGE_BASE/content_pipeline.md §3）。

```sql
CREATE TABLE chapters (
  id            TEXT PRIMARY KEY,            -- ch01..chNN（content_pipeline 编号）
  report_id     TEXT NOT NULL REFERENCES reports(id),
  idx           INTEGER NOT NULL,            -- 章序（从 1 起）
  title         TEXT NOT NULL,
  is_trial      INTEGER NOT NULL DEFAULT 0,  -- 1=试读章（带正文）；0=付费章
  html          TEXT DEFAULT '',             -- 试读章=正文 html；付费章=''（空壳，服务端按权益下发）
  char_count    INTEGER DEFAULT 0,           -- 去标签字符数（噪声过滤阈值 400 参照）
  UNIQUE(report_id, id)
);
CREATE INDEX idx_chapters_report ON chapters(report_id, idx);
```

## 4. entitlements — 阅读权益 [P0]

服务端按权益下发的判据表（AI_NATIVE_OPTIONS #5）。

```sql
CREATE TABLE entitlements (
  id            TEXT PRIMARY KEY,
  user_id       TEXT NOT NULL REFERENCES users(id),
  report_id     TEXT NOT NULL REFERENCES reports(id),
  source        TEXT NOT NULL DEFAULT 'purchase',  -- purchase(购买)/gift(点赞赠)/voucher(书券换)/invite(组队)/compensate(iOS退款补偿)
  order_id      TEXT DEFAULT '',             -- source=purchase 时关联 orders.out_trade_no
  granted_at    TEXT NOT NULL,
  expires_at    TEXT DEFAULT '',             -- 空=永久；组队/赠品可设期
  UNIQUE(user_id, report_id, source)         -- 同源同报告唯一；跨源并存允许
);
CREATE INDEX idx_ent_user ON entitlements(user_id);
```

## 5. orders — 订单（pay_log 对账） [P0]

pay_log 对账表（biaoxun 同款已建成惯例，KNOWLEDGE_BASE/engine_conventions.md §2）；outTradeNo 为幂等键。

```sql
CREATE TABLE orders (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  out_trade_no  TEXT NOT NULL UNIQUE,        -- 幂等键：{reportId}_{ts}（utils/pay.ts 实样）
  user_id       TEXT NOT NULL REFERENCES users(id),
  report_id     TEXT NOT NULL REFERENCES reports(id),
  offer_id      TEXT DEFAULT '',             -- 虚拟支付发售单元 ID（WIZARD 回传值）
  product_id    TEXT DEFAULT 'xy_report_unlock',  -- 道具 ID（通用道具，WIZARD）
  price_fen     INTEGER NOT NULL,            -- 49800
  platform      TEXT NOT NULL DEFAULT 'android',  -- android/ios（iOS=Apple 通道 12%）
  env           INTEGER NOT NULL DEFAULT 0,  -- 0=正式，1=沙箱（统一语言表）
  mode          TEXT NOT NULL DEFAULT 'short_series_goods',
  status        TEXT NOT NULL DEFAULT 'pending',  -- pending/paid/delivered/refunded/refund_partial/failed
  wx_order_sn   TEXT DEFAULT '',             -- 官方回执单号（回调核对）
  pay_sig       TEXT DEFAULT '',             -- pay_sign 双签名快照（对账取证）
  paid_at       TEXT DEFAULT '',
  refund_state  TEXT DEFAULT '',             -- none/partial/full（对 refunds 汇总）
  created_at    TEXT NOT NULL,
  raw_notify    TEXT DEFAULT '{}'            -- json：回调原文快照（xpay_refund_notify 等，对账兜底）
);
CREATE INDEX idx_orders_user ON orders(user_id, created_at);
```

对账纪律：每笔支付/退款回调落 raw_notify，与 pay_log 逐单核对（R-12）；重复回调按 out_trade_no 幂等 200（harness D 场景）。

## 6. criticisms — 批评评分（四层闸数据化） [P1]

四层制度主表（KNOWLEDGE_BASE/refund_criticism.md §4）；评分证据先行——确定性预筛字段+LLM 判断层分离。

```sql
CREATE TABLE criticisms (
  id            TEXT PRIMARY KEY,
  user_id       TEXT NOT NULL REFERENCES users(id),
  report_id     TEXT NOT NULL REFERENCES reports(id),
  order_id      TEXT NOT NULL REFERENCES orders(out_trade_no),  -- 须为已支付订单
  content       TEXT NOT NULL,               -- 批评原文
  char_count    INTEGER NOT NULL,            -- 资格：50-300（冗长偏差校正）
  read_verified INTEGER NOT NULL DEFAULT 0,  -- 层①资格闸：真实阅读行为已核验（未读者不可发起）
  -- 确定性预筛（代码层，先于 LLM）
  anchor_score  REAL NOT NULL DEFAULT 0,     -- 语义锚定分：引用具体章节/数据点（embedding+实体命中正文）；模板化话术=0 → 直接不给退
  similarity_score REAL NOT NULL DEFAULT 0,  -- 与历史批评查重最高相似度（n-gram+语义）；过高→人工复审
  dup_flag      INTEGER NOT NULL DEFAULT 0,  -- 跨账号/同账号相似度告警位
  -- 判断层（免费模型优先，输出评分依据）
  llm_scores    TEXT DEFAULT '{}',           -- json：{sincerity:0-100 真诚度, authenticity:0-100 真实度, constructiveness:0-100 建设性, rationale:'批评哪句↔报告哪节'}
  final_score   REAL DEFAULT 0,              -- 合成分（映射输入）
  refund_tier   TEXT NOT NULL DEFAULT 'none',-- none(<50 不退+感谢券)/tier50/tier100…（按分线性：50分→50%，100分→100%）；tier100+黑名单特征→人工
  manual_review INTEGER NOT NULL DEFAULT 0,  -- 1=转人工（黑名单/查重告警/100%档，AI_NATIVE_OPTIONS #8）
  reviewer_note TEXT DEFAULT '',
  status        TEXT NOT NULL DEFAULT 'scored',  -- scored/approved/rejected/manual_pending/closed
  created_at    TEXT NOT NULL,
  UNIQUE(user_id, report_id)                 -- 层①：每报告每用户 1 次
);
```

## 7. refunds — 退款单 [P1]

Android 自动退（refund_order API）+iOS 书券补偿双轨（KNOWLEDGE_BASE/virtual_pay.md §8）。

```sql
CREATE TABLE refunds (
  id            TEXT PRIMARY KEY,
  order_id      TEXT NOT NULL REFERENCES orders(out_trade_no),
  criticism_id  TEXT DEFAULT '' REFERENCES criticisms(id),  -- 空客诉退款（非评分路径）可无
  user_id       TEXT NOT NULL REFERENCES users(id),
  platform      TEXT NOT NULL,               -- android: refund_order 自动原路退；ios: 书券补偿+引导苹果通道
  tier          TEXT NOT NULL,               -- 继承 criticism.refund_tier
  amount_fen    INTEGER NOT NULL,            -- 按分线性退金额（部分退款语义须实测，实测不通→全额退+差额书券）
  method        TEXT NOT NULL DEFAULT 'auto',-- auto(≤50%档)/manual(100%档或黑名单)/voucher(iOS 补偿)
  status        TEXT NOT NULL DEFAULT 'initiated',  -- initiated/notify_received(180天内退手续费校验)/settled/failed
  voucher_granted TEXT DEFAULT '',           -- iOS 等额书券发放单号（compensate 来源）
  wx_refund_sn  TEXT DEFAULT '',             -- refund_order 回执
  created_at    TEXT NOT NULL,
  settled_at    TEXT DEFAULT ''
);
CREATE INDEX idx_refunds_order ON refunds(order_id);
```

## 8. vouchers — 书券 [P1]

非现金内循环：邀请/批评感谢券/iOS 补偿都发书券（PROPOSAL 4.4）。

```sql
CREATE TABLE vouchers (
  id            TEXT PRIMARY KEY,
  user_id       TEXT NOT NULL REFERENCES users(id),
  amount_fen    INTEGER NOT NULL,            -- 面值（如邀请解锁 50 元=5000 分）
  source        TEXT NOT NULL,               -- invite(邀请解锁)/criticism_thanks(<50分感谢券)/ios_refund(iOS等额补偿)/campaign
  source_ref    TEXT DEFAULT '',             -- 来源单号（invite_relation.id/criticisms.id/refunds.id）
  status        TEXT NOT NULL DEFAULT 'active',  -- active/used/expired
  used_order_id TEXT DEFAULT '',             -- 核销订单（书券换报告→entitlements.source='voucher'）
  expires_at    TEXT DEFAULT '',
  created_at    TEXT NOT NULL
);
CREATE INDEX idx_vouchers_user ON vouchers(user_id, status);
```

## 9. gift_grants — 点赞赠报告（增补表） [P1]

附条件赠送：站内点赞→必得一份随机报告（未购清单随机指定），每日限 1 份（KNOWLEDGE_BASE/refund_criticism.md §8）。

```sql
CREATE TABLE gift_grants (
  id            TEXT PRIMARY KEY,
  user_id       TEXT NOT NULL REFERENCES users(id),
  liked_report_id TEXT NOT NULL REFERENCES reports(id),  -- 被点赞报告
  granted_report_id TEXT NOT NULL REFERENCES reports(id),-- 获赠报告（未购清单随机指定，随机性仅在指定哪份）
  grant_date    TEXT NOT NULL,               -- 每日限1份判据（DATE）
  created_at    TEXT NOT NULL,
  UNIQUE(user_id, grant_date)                -- 每日 1 份
);
```

## 10. poster_code — 海报码映射（短码兜底+码池） [P1]

scene 32 字符契约与短码映射（KNOWLEDGE_BASE/viral_poster.md §3/§4）。

```sql
CREATE TABLE poster_code (
  scene_code    TEXT PRIMARY KEY,            -- scene 直存 'r=Ab3xK9&i=U8mQ2z'（≈18字符）或短码 's=Xk29fA'
  report_id     TEXT NOT NULL REFERENCES reports(id),   -- r=
  inviter_uid   TEXT DEFAULT '',             -- i=（空=无邀请人降级）
  channel       TEXT DEFAULT 'poster',       -- 海报/会话/朋友圈
  poster_version TEXT DEFAULT 'v1',          -- 模板版本（模板改不发版）
  pregenerated  INTEGER NOT NULL DEFAULT 1,  -- 预生成码池（官方建议，避 5000 次/分）
  created_at    TEXT NOT NULL
);
```

## 11. share_event — 分享事件 [P1]

```sql
CREATE TABLE share_event (
  id            TEXT PRIMARY KEY,            -- share_id
  user_id       TEXT NOT NULL REFERENCES users(id),
  report_id     TEXT NOT NULL REFERENCES reports(id),
  channel       TEXT NOT NULL,               -- poster/session(会话)/moments(朋友圈)
  poster_version TEXT DEFAULT 'v1',
  ts            TEXT NOT NULL
);
CREATE INDEX idx_share_user ON share_event(user_id, ts);
```

## 12. invite_relation — 邀请关系（首触归因主表） [P1]

**首触归因（first-touch）**：一个被邀请人只记第一个有效邀请人；K 因子=人均邀请数×邀请转化率由此表聚合（KNOWLEDGE_BASE/viral_poster.md §5）。

```sql
CREATE TABLE invite_relation (
  id            TEXT PRIMARY KEY,
  inviter_uid   TEXT NOT NULL REFERENCES users(id),
  invitee_uid   TEXT NOT NULL REFERENCES users(id),
  report_id     TEXT NOT NULL REFERENCES reports(id),
  scene_code    TEXT NOT NULL REFERENCES poster_code(scene_code),
  status        TEXT NOT NULL DEFAULT 'scanned',  -- scanned/registered/unlocked/paid（漏斗推进）
  unlocked_at   TEXT DEFAULT '',             -- 邀请解锁达成时刻（邀2位新用户→完整免费部分+50元书券）
  ts            TEXT NOT NULL,
  UNIQUE(invitee_uid, report_id)             -- 首触：被邀请人+报告 唯一，先到先记
);
CREATE INDEX idx_invite_inviter ON invite_relation(inviter_uid, status);
```

## 13. scan_visit — 扫码访问（漏斗第一环） [P1]

```sql
CREATE TABLE scan_visit (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  scene_code    TEXT NOT NULL REFERENCES poster_code(scene_code),
  user_id       TEXT DEFAULT '',             -- 未登录先空（0.5 分钟读到正文，无登录墙）
  entry_page    TEXT NOT NULL,
  ts            TEXT NOT NULL
);
```

## 14. subscriptions — 订阅（备忘，远期） [P2]

会员订阅准入=DAU≥1万+上线 90 天（deep_pay Q3），P2 后再评估；先立占位不实现。

```sql
-- P2 备忘（不建表）：订阅消息推送（关注省份/主题上新通知）走微信订阅消息官方能力，
-- 订阅关系可先用 users.flags json 承载；年度会员/B端全库授权待 PROPOSAL P2 评审后另立表。
```

---

## 15. 文件契约：catalog.json / chapters.json（小程序包内静态数据）

与 §2/§3 表字段对齐映射（KNOWLEDGE_BASE/content_pipeline.md §7）；包内文件为构建产物，真源=SQLite。

### catalog.json

位置 `projects/<app>/content/catalog.json`；结构 `{"reports": [...]}`，合并更新（同 id 覆盖）。

| 字段 | 类型 | 对应表列 | 说明 |
|---|---|---|---|
| id | string | reports.id | 报告短 ID |
| title | string | reports.title | 标题 |
| summary | string | reports.summary | 摘要 |
| price | int | reports.price_fen | 价格（分）；试点期曾存 990，正式口径 49800 |
| chapterCount | int | reports.chapter_count | 实质章数 |
| source | string | reports.source | 出品方 |
| publishedAt | string | reports.published_at | ISO 日期 |

示例一行（zongbao 试点实样）：
`{"id":"js-shuiwang-2026","title":"江苏省水网工程商机研究","summary":"江苏省水网工程商机研究——总包创研院出品。","price":990,"chapterCount":19,"source":"总包创研院","publishedAt":"2026-09-27"}`

### chapters.json

位置 `projects/<app>/content/reports/<report_id>/chapters.json`；结构 `[{id, title, html}]` 数组。

| 字段 | 类型 | 对应表列 | 说明 |
|---|---|---|---|
| id | string | chapters.id | ch01..chNN |
| title | string | chapters.title | 章标题 |
| html | string | chapters.html | 试读章=正文 html；**付费章=""（空壳，防包内泄漏）** |

示例一行（试读章实样截断）：
`{"id":"ch01","title":"第一章  研究概述与方法论","html":"<h1>第一章  研究概述与方法论</h1><h2>1.1  研究背景与目标</h2><p>江苏省滨江临海…</p>"}`

付费空壳示例一行：`{"id":"ch03","title":"第三章  江苏水利建设宏观战略背景","html":""}`

---

## 16. 术语与外键纪律

- 全部术语以 CONTEXT.md 统一语言表为准（env 0 正式/1 沙箱、道具/offer_id/product_id、空壳章等）。
- 外键跨表引用统一用短 ID（users.id/reports.id/chapters.id/scene_code/out_trade_no），**openid 永不进 scene/日志**。
- orders.env 与支付请求 env 严格同源；沙箱单（env=1）不进营收对账（FEASIBILITY 2.2 口径）。
- refunds/criticisms 一对一弱关联（criticism_id 可空）——客诉退款与评分退款并存。
- P1 表全部为 P0 表的下游：无 P0 订单链先跑通，不建 P1 表（分期纪律，PROPOSAL 六）。
