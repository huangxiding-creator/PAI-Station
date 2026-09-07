# 附录 B 数据库 DDL 全集、索引设计与迁移策略

## B.1 总则
四库分离（memory/outbox/skills/audit），单写多读；WAL 模式（读写并发）；每日 03:00 本地增量备份（保留 30 天）+ 用户手动导出。所有时间戳 Unix 秒。FTS5 用 jieba 预分词列（`summary_tokens`）而非默认 unicode61（中文分词质量）。

## B.2 memory.db 完整 DDL

```sql
PRAGMA journal_mode=WAL;
PRAGMA synchronous=NORMAL;

CREATE TABLE memory (
  id TEXT PRIMARY KEY,              -- uuid4
  ts INTEGER NOT NULL,              -- 事件发生时间（记忆主体时间）
  created_at INTEGER NOT NULL,      -- 入库时间
  type TEXT NOT NULL CHECK(type IN
    ('doc','screen','im_wechat','im_feishu','im_wecom','im_dingtalk',
     'commit','calendar','clipboard','browse')),
  source_path TEXT,                 -- 出处路径/消息会话标识
  source_hash TEXT,                 -- sha256(原文) 前 16 位，去重键
  summary TEXT NOT NULL,            -- ≤200 字事实摘要
  entities TEXT NOT NULL DEFAULT '[]',  -- JSON: [{"name":"张三","kind":"person"},...]
  tags TEXT NOT NULL DEFAULT '[]',
  weight REAL NOT NULL DEFAULT 1.0, -- Ebbinghaus 权重
  links TEXT NOT NULL DEFAULT '[]', -- Zettelkasten 互链 memory_id[]
  depth INTEGER NOT NULL DEFAULT 1, -- DIKW 层级 1-4
  content_ref TEXT                  -- L0 原文引用（仅高价值记忆保留，指向 viking://）
);
CREATE INDEX idx_mem_ts ON memory(ts);
CREATE INDEX idx_mem_hash ON memory(source_hash);
CREATE INDEX idx_mem_type_ts ON memory(type, ts);

CREATE VIRTUAL TABLE memory_fts USING fts5(
  summary_tokens, entities_text, tags_text,
  content=''                        -- external content 模式省一半存储
);
CREATE TRIGGER mem_ai AFTER INSERT ON memory BEGIN
  INSERT INTO memory_fts(rowid, summary_tokens, entities_text, tags_text)
  VALUES (new.rowid, jieba(new.summary), ents(new.entities), tags(new.tags));
END;

CREATE TABLE entity_map (           -- 实体倒排（召回第二路）
  entity TEXT NOT NULL,
  kind TEXT NOT NULL,               -- person/project/client/org/date/topic
  memory_id TEXT NOT NULL,
  PRIMARY KEY (entity, memory_id)
);
CREATE INDEX idx_ent ON entity_map(entity);

CREATE TABLE recall_log (           -- 召回质量回流（自学习输入）
  q TEXT, ts INTEGER, hit_ids TEXT, adopted INTEGER  -- 1=命中被采纳
);
```

## B.3 outbox.db / skills.db / audit.db 完整 DDL

```sql
-- outbox.db
CREATE TABLE outbox (
  id TEXT PRIMARY KEY, ts INTEGER NOT NULL,
  trigger TEXT NOT NULL,            -- cron/event/im/periodic
  skill_id TEXT, content_path TEXT NOT NULL,
  score REAL NOT NULL,              -- Fogg B 分
  quadrant INTEGER NOT NULL CHECK(quadrant IN (1,2,3,4)),
  action TEXT NOT NULL CHECK(action IN ('push_wecom','drawer','folded','drop')),
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK(status IN ('pending','adopted','edited','rejected','expired')),
  adopted_diff REAL,                -- 编辑距离比 0(完全采纳)-1(重写)
  expires_at INTEGER
);
CREATE INDEX idx_ob_status_ts ON outbox(status, ts);

-- skills.db
CREATE TABLE skills (
  id TEXT PRIMARY KEY, name TEXT UNIQUE NOT NULL,
  version TEXT NOT NULL, level INTEGER NOT NULL DEFAULT 3,
  origin TEXT NOT NULL CHECK(origin IN ('builtin','distilled','market')),
  sample_count INTEGER NOT NULL DEFAULT 0,
  adopt_rate REAL NOT NULL DEFAULT 0.5,   -- 滚动 30 样本
  state TEXT NOT NULL DEFAULT 'drafting'
    CHECK(state IN ('drafting','stable','degrading','relearning','published','banned')),
  triggers_json TEXT, privacy TEXT NOT NULL DEFAULT 'none',
  updated_at INTEGER NOT NULL
);
CREATE TABLE skill_samples (        -- 蒸馏样本留档（证据包）
  skill_id TEXT NOT NULL, ts INTEGER NOT NULL,
  draft_path TEXT, final_path TEXT, diff_stat TEXT,  -- 改动块统计
  PRIMARY KEY (skill_id, ts)
);

-- audit.db（只追加，永不 UPDATE/DELETE——审计铁律）
CREATE TABLE audit (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL, actor TEXT NOT NULL,   -- engine:xxx / skill:xxx / channel / user
  action TEXT NOT NULL,                       -- read_file/send_msg/push/run_skill/...
  target TEXT, detail TEXT,                   -- JSON 明细
  result TEXT NOT NULL                        -- ok/denied/error + 原因
);
CREATE INDEX idx_audit_ts ON audit(ts);
CREATE INDEX idx_audit_actor ON audit(actor, ts);
```

## B.4 迁移与版本策略
- `schema_version` 表记录版本；启动时比对，按迁移脚本顺序执行（`migrations/001_xxx.sql`）；
- 破坏性迁移必须先自动备份旧库（`memory.db.bak-v{n}`）；
- 用户数据主权：`avatar.pai` 导出包含全部四库 dump（SQL 或 JSON 双格式）+ skills 目录，保证任何未来版本可完整恢复。

## B.5 容量与性能测算
- 单用户年增记忆：文档 200 条/月 + 屏幕 1,440 条/月（10 分钟×12h×30d，摘要后仅高价值入 L1）+ IM 500 条/月 ≈ 2,000 条/月 → 年 2.4 万条，10 万条前不达升级阈值；
- 10 万条 FTS5+jieba 查询实测基准 <300ms（含实体图两跳扩展）；
- audit 年增 ~50 万行，纯插入无性能问题，按年分库（audit-2026.db）。

## B.6 V2.1 增补：智能复利引擎相关 DDL（对应第 15 章）

```sql
-- 1) 任务域奇点判据字段（skills.db，迁移 002_singularity.sql）
ALTER TABLE skills ADD COLUMN e2e_rate REAL DEFAULT 0.0;      -- 30天滚动：端到端完成率（≥0.95 过线）
ALTER TABLE skills ADD COLUMN adopt_rate REAL DEFAULT 0.0;    -- 30天滚动：轻改采纳率（≥0.60 过线）
ALTER TABLE skills ADD COLUMN incident_cnt INTEGER DEFAULT 0; -- 30天滚动：重大事故数（=0 过线）
ALTER TABLE skills ADD COLUMN autonomy_level TEXT DEFAULT 'L1' CHECK(autonomy_level IN ('L1','L2','L3'));

-- 2) 意图表（memory.db，迁移 003_intents.sql）
CREATE TABLE IF NOT EXISTS intents (
  intent_id INTEGER PRIMARY KEY AUTOINCREMENT,
  domain TEXT NOT NULL,                    -- 任务域，外键→skills.skill_name
  hypothesis TEXT NOT NULL,                -- 意图假设（如"送礼选品：预算内体面优先"）
  evidence_hash TEXT NOT NULL,             -- 证据摘要哈希（不存原文，隐私最小化）
  confidence REAL DEFAULT 0.5,
  status TEXT DEFAULT 'active' CHECK(status IN ('active','retired')),
  created_at INTEGER, retired_at INTEGER
);
CREATE INDEX IF NOT EXISTS idx_intents_domain ON intents(domain, status);

-- 3) 授权升降级审计（audit.db，迁移 004_autonomy.sql）
CREATE TABLE IF NOT EXISTS autonomy_events (
  event_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  domain TEXT NOT NULL,
  old_level TEXT, new_level TEXT NOT NULL,
  reason TEXT NOT NULL,                    -- 'singularity_passed' | 'incident_demotion' | 'user_override' | 'panic_switch'
  metrics_json TEXT,                       -- 触发时的三项判据快照
  prev_hash TEXT, hash TEXT NOT NULL       -- 哈希链：hash=sha256(prev_hash||ts||domain||new_level||reason)
);
```

迁移说明：①三个脚本遵循 B.4 顺序执行与备份策略；②`autonomy_events` 与既有审计哈希链同构，可合并校验；③`evidence_hash` 设计呼应零信任约束——意图库可导出但导出时 evidence_hash 保留、原文永不入库；④技能市场回流（15.8.3 防失速）只回流传销后的规则文本，`intents`/diff 原始数据永不离开本机。

## B.7 V3.1 技能铸造厂新增（第 19 章，迁移 005_foundry.sql）

```sql
-- 1) 信息源登记（core.db；INI 每源 6 字段，库表存运行态）
CREATE TABLE IF NOT EXISTS info_sources (
  source_id TEXT PRIMARY KEY,              -- '混沌学园'
  type TEXT NOT NULL CHECK(type IN ('web_course','feishu_wiki','ebook_dir','intranet')),
  url TEXT, path TEXT,
  auth_ref TEXT,                           -- SecretRef→DPAPI 保险箱，明文永不入库
  schedule TEXT NOT NULL,                  -- cron，如 'weekly MON 08:00'
  formats TEXT DEFAULT 'docx,md,pdf',
  enabled INTEGER DEFAULT 1,
  last_cursor TEXT,                        -- 增量游标（课程页码/知识库节点 token）
  fingerprint TEXT,                        -- 源级内容指纹
  health INTEGER DEFAULT 100               -- 源站改版健康度（低于阈值触发 heal 告警）
);
-- 2) 知识原料湖索引（raw.db；目录是缓存、库是索引）
CREATE TABLE IF NOT EXISTS raw_corpus (
  chunk_id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_id TEXT NOT NULL,
  coords TEXT NOT NULL,                    -- 来源坐标：'混沌学园/课程A/第3节'
  fingerprint TEXT NOT NULL,               -- 章节级指纹（增量再蒸馏定位，成本降 90%+）
  license TEXT NOT NULL CHECK(license IN ('self_only','market_ok','rewrite_ok')),
  created_at INTEGER, updated_at INTEGER
);
CREATE INDEX IF NOT EXISTS idx_raw_src ON raw_corpus(source_id, fingerprint);
-- 3) skills 表增列（幂等 ALTER）
--    price_tokens INTEGER DEFAULT 0       -- 自铸=0 永远免费自用；上架才定价（19.10）
--    origin TEXT CHECK(origin IN ('diff','ebook','course','wiki','intranet'))
--    parents TEXT                          -- 血缘 JSON：父技能/源 chunk_id/杂交配方（19.12）
--    license_flag INTEGER DEFAULT 0       -- 0 自用 / 1 可上架（19.11 分层自动执行）
```

迁移说明：①`license` 三态由采集器按源类型自动标注（混沌课程=rewrite_ok 且上市场拦截、企业内网=self_only 硬编码）；②血缘 `parents` 支撑血缘图与"源更新→技能可升级"反查（raw_corpus.fingerprint 变更即定位受影响技能）；③`info_sources.health` 是 R17（源站改版）的量化哨兵。

## B.8 V3.2 信任-上下文引擎新增（第 21 章，迁移 006_trust_context.sql）

```sql
-- 1) 信任账本（core.db；月度信任报告的数据源）
CREATE TABLE IF NOT EXISTS trust_ledger (
  event_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  kind TEXT NOT NULL CHECK(kind IN ('grant','revoke','upgrade','downgrade','incident','repair','report')),
  scope TEXT NOT NULL,                     -- 感知源/通道/任务域
  detail_json TEXT,                        -- 事件细节（含出境 payload 哈希引用）
  trust_delta REAL DEFAULT 0               -- 信任余额变动（incident 为负，repair 回补）
);
CREATE INDEX IF NOT EXISTS idx_trust_ts ON trust_ledger(ts);
-- 2) 上下文覆盖度矩阵（18 源×4 态；仪表盘的库化）
CREATE TABLE IF NOT EXISTS context_sources (
  source TEXT PRIMARY KEY,                 -- 'files'|'email'|'calendar'|'im_feishu'|...18 源
  layer TEXT NOT NULL CHECK(layer IN ('explicit','behavioral','environmental')),  -- L0/L1/L2
  status TEXT DEFAULT 'dormant' CHECK(status IN ('dormant','granted','active','deep')),
  ladder TEXT DEFAULT 'T0' CHECK(ladder IN ('T0','T1','T2','T3')),   -- 信任阶梯门槛
  last_event_at INTEGER, refresh_sec INTEGER,
  hit_count INTEGER DEFAULT 0              -- 该源贡献的需求命中次数（覆盖度仪表盘列）
);
-- 3) 意图库证据升级（兼容扩展，迁移内幂等）
--    intents.evidence_hash TEXT  →  intents.evidence_json TEXT
--    数组元素 {layer: L0|L1|L2, kind, hash, ts}；置信度 = 层间一致度函数（21.3.2 三角定位）
```

迁移说明：①`trust_ledger.trust_delta` 只做趋势展示不做访问控制判据（权限判定永远以用户明示授权为准——账本是透明工具不是隐形评分）；②`context_sources.hit_count` 由需求命中回写，构成"每格贡献了多少次命中"的覆盖度仪表盘；③`intents` 升级保留旧字段写入兼容（evidence_hash 继续维护，防降级丢数据）。

## B.9 V3.4 共同成长引擎新增（第 23 章，迁移 007_cogrowth.sql）

```sql
-- 1) 双成长账本（core.db；PGI/UGI 的数据源，6×2 成长矩阵的库化）
CREATE TABLE IF NOT EXISTS growth_ledger (
  event_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  subject TEXT NOT NULL CHECK(subject IN ('product','user')),   -- 哪条螺旋
  track TEXT NOT NULL CHECK(track IN ('knowledge','skill','capability','value')),
  event TEXT NOT NULL,                       -- 'skill_acquired'|'gap_filled'|'domain_singularity'|'practice_done'|...
  evidence_json TEXT,                        -- 证据引用（技能id/图谱节点/任务id）
  delta REAL DEFAULT 0                       -- PGI/UGI 分量增量
);
-- 2) 教学会话（core.db；教中学缺口的采集点）
CREATE TABLE IF NOT EXISTS teaching_sessions (
  session_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  domain TEXT NOT NULL,
  mode TEXT NOT NULL CHECK(mode IN ('teach','coach','delegate')),  -- L1/L2/L3 教学档位
  topic TEXT, socratic_rounds INTEGER DEFAULT 0,
  comprehension_score REAL,                  -- L1 追问理解分
  knowledge_gap_found INTEGER DEFAULT 0      -- 被问倒→23.2.1 知识缺口登记
);
-- 3) FSRS 练习队列（core.db；py-fsrs 调度，每日 3 张上限硬编码）
CREATE TABLE IF NOT EXISTS practice_items (
  item_id INTEGER PRIMARY KEY AUTOINCREMENT,
  front TEXT NOT NULL, back TEXT NOT NULL,
  source_skill TEXT, source_node TEXT,       -- 来自哪个技能/图谱节点
  due INTEGER NOT NULL, stability REAL, difficulty REAL,  -- FSRS 三参数
  reviews INTEGER DEFAULT 0, lapses INTEGER DEFAULT 0
);
-- 4) 价值归因（core.db；月度共同价值报告数据源）
CREATE TABLE IF NOT EXISTS value_attribution (
  task_id TEXT PRIMARY KEY, ts INTEGER NOT NULL,
  product_share REAL, user_share REAL,       -- 归因（缺省估算/用户 10 秒修正）
  basis_json TEXT                            -- 归因依据
);
```

迁移说明：①`growth_ledger` 与 `trust_ledger` 同构（事件流+增量），月报合并校验；②`practice_items` 的 due/stability/difficulty 直接由 py-fsrs 维护，不自研调度算法；③螺旋上升判定器（23.1.3）以 `growth_ledger` 双 subject 聚合为判据——连续两个宏循环全维停滞才触发诊断，防误报。

## B.10 V3.4 产品灵魂宪章新增（第 24 章，迁移 008_soul.sql）

```sql
-- 1) 注意力账本（core.db；注意力 ROI 判定与月度审计数据源）
CREATE TABLE IF NOT EXISTS attention_ledger (
  event_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  kind TEXT NOT NULL CHECK(kind IN ('flow','deliver','blocked')),  -- 流向/递进/挡掉
  source TEXT,                              -- 应用/信息源/推送候选
  duration_sec INTEGER, value_est REAL,     -- 注意力成本/预期价值
  roi REAL                                  -- value_est/(duration_sec+打扰成本系数)
);
-- 2) 疫苗库（core.db；错误免疫系统：纠正→抗体→复拦）
CREATE TABLE IF NOT EXISTS immune_rules (
  rule_id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_ts INTEGER NOT NULL,
  scene_sig TEXT NOT NULL,                  -- 场景签名（scanner 签名体系复用）
  error_pattern TEXT NOT NULL, correct_action TEXT NOT NULL,
  origin_event TEXT,                        -- 来源纠正事件（trust_ledger 引用）
  blocked_count INTEGER DEFAULT 0,          -- 复拦次数（免疫有效性）
  shared INTEGER DEFAULT 0                  -- 脱敏上架标志（只发模式不发数据）
);
-- 3) 传承授权（core.db；全 opt-in+可吊销+禁冒充三铁律的库化）
CREATE TABLE IF NOT EXISTS legacy_grants (
  grant_id INTEGER PRIMARY KEY AUTOINCREMENT,
  created_ts INTEGER NOT NULL,
  grantee TEXT NOT NULL,                    -- 被传授人（市场用户/团队成员）
  scope_json TEXT,                          -- 授权范围（技能集/画像维度；不含隐私原始数据）
  revoked INTEGER DEFAULT 0, revoked_ts INTEGER
);
-- 4) 年报索引（raw.db；Word 产物在文件系统，库存索引与素材引用）
CREATE TABLE IF NOT EXISTS annual_retrospectives (
  year INTEGER PRIMARY KEY,
  generated_ts INTEGER NOT NULL,
  narrative_path TEXT,                      -- Word 产物路径（纯本地）
  stats_json TEXT                           -- 六章数据快照
);
```

迁移说明：①`attention_ledger.roi` 是推送发出前的准入门（挡掉:递进 ≥10:1 验收的量化基础）；②`immune_rules.origin_event` 关联信任修复协议——同一纠正事件的两个产出（信任修复+能力抗体）；③`legacy_grants` 吊销采用标志位+时间戳（不物理删，审计可追溯）。

## B.11 V4.0 免费模型极限工程新增（第 26 章，迁移 009_free_extreme.sql）

```sql
-- 1) 语义缓存（core.db；兵器五：一切学过的永不重算）
CREATE TABLE IF NOT EXISTS semantic_cache (
  cache_key TEXT PRIMARY KEY,            -- sha256(任务签名+提示词签名)
  q_sig TEXT NOT NULL,                   -- SimHash 指纹（jieba 分词，本地零依赖）
  result_ref TEXT NOT NULL,              -- 结果引用（outbox/产物路径/技能id）
  hits INTEGER DEFAULT 0,
  created_ts INTEGER, last_hit_ts INTEGER
);
CREATE INDEX IF NOT EXISTS idx_sc_sig ON semantic_cache(q_sig);
-- 2) 挥霍流水（core.db；挥霍仪表盘与 ¥0 复利对账单数据源）
CREATE TABLE IF NOT EXISTS squander_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  purpose TEXT NOT NULL CHECK(purpose IN ('ensemble','verify','retry','decompose','cross_model','thinking')),
  calls INTEGER NOT NULL, tokens INTEGER NOT NULL,
  counterfactual_cost REAL NOT NULL      -- 等价付费成本（¥0 账单数据源）
);
-- 3) 价值反事实扩列（B.9 value_attribution 幂等 ALTER）
--    counterfactual_cost REAL           -- 若走付费旗舰的等价成本
--    saved_hours REAL                   -- 归还小时（价值公式 H·w 的 H）
```

迁移说明：①`q_sig` 用 SimHash 而非向量——本地、零依赖、零成本（诚实边界：不为优雅引入向量库，GPTCache 仅作参考实现）；②`squander_log` 按月分区归档（同 audit 年分库策略）；③`counterfactual_cost` 折算牌价表存 INI（改牌价只改配置不动库）；④第 25 章三感宪章**零新增表**——哇时刻用 outbox 状态+audit 回溯、奇点宣告复用 autonomy_events、对账单聚合 value_attribution（体验层全部站在既有引擎上）。
