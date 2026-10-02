# -*- coding: utf-8 -*-
"""总包学园存储——SQLite：DDL 26 表+单写锁+每操作短连接（qianwen store 惯例）。

表结构=SCHEMAS.md §1-13（13 表）+ARCHITECTURE §六增补 4 表+P1 熔断状态表
+P2 增值簇 3 表（transfers/subscriptions/subscribe_sends，末尾追加）
+v1.2 情报官停留账 invite_dwell（末尾追加）；业务读写随域实装。
"""
from __future__ import annotations

import hashlib
import json
import re
import sqlite3
import threading
from contextlib import contextmanager
from datetime import datetime, timedelta, timezone
from pathlib import Path

from . import config

_LOCK = threading.Lock()
_init_done = False

_TZ8 = timezone(timedelta(hours=8))


def now() -> str:
    """ISO-8601（UTC+8 秒级）全库时间口径。"""
    return datetime.now(_TZ8).isoformat(timespec="seconds")

TABLES = [  # 26 表清单（测试与运维对账用；与下方 DDL 一一对应）
    # SCHEMAS.md §1-13
    "users", "reports", "chapters", "entitlements", "orders",
    "criticisms", "refunds", "vouchers", "gift_grants", "poster_code",
    "share_event", "invite_relation", "scan_visit",
    # ARCHITECTURE §六 增补表
    "favorites", "read_log", "teams", "team_members",
    # Phase 8 P1 社交经济簇增补表（voucher 部分核销账 / team 到期事件账）
    "voucher_burns", "team_events",
    # Phase 8 P1 批评退款簇增补：L4 熔断状态（refund.py 域内 CRUD）
    "fuse_state",
    # Phase 8 P2 增值簇增补：转赠账（FR-P2-04）/ 订阅关系+发送去重账（FR-P2-02）
    "transfers", "subscriptions", "subscribe_sends",
    # Phase 8 P2 增补（v1.2 情报官体系）：停留累计账（有效带新判据②）
    "invite_dwell",
    "card_code",
    # 3c 榜单域增补：周快照（leaderboard ISO 周冻结口径）
    "rank_week",
]


@contextmanager
def _db():
    config.DATA_DIR.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(config.DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        yield conn
        conn.commit()
    finally:
        conn.close()


def init() -> None:
    """建库（幂等）：26 表 + 索引。全部 CREATE IF NOT EXISTS，重跑不炸。"""
    global _init_done
    with _LOCK:
        if _init_done:
            return
        with _db() as c:
            c.executescript(
                """
                -- §1 users [P0]（openid 永不进 scene/日志，uid 短 ID 化）
                CREATE TABLE IF NOT EXISTS users (
                    id            TEXT PRIMARY KEY,            -- 短ID（Base62/自增映射），如 uXk29f
                    openid        TEXT NOT NULL UNIQUE,        -- 微信 openid（引擎侧换 appid 隔离）
                    nickname      TEXT DEFAULT '',
                    created_at    TEXT NOT NULL,
                    last_seen_at  TEXT,
                    is_blacklisted INTEGER NOT NULL DEFAULT 0, -- 批评退款黑名单（历史退款率>30% 转人工，R-04）
                    refund_count_month INTEGER NOT NULL DEFAULT 0,  -- 当月退款次数（资格闸：≤2）
                    flags         TEXT DEFAULT '{}',          -- json：运营标记（首席批评官/勋章，P1 扩展）
                    session_key   TEXT DEFAULT ''             -- 增列（§五-5 服务端留存，绝不下发；qianwen mp_session 同职责并入）
                );

                -- §2 reports [P0]
                CREATE TABLE IF NOT EXISTS reports (
                    id            TEXT PRIMARY KEY,            -- 报告短ID，如 js-shuiwang-2026
                    title         TEXT NOT NULL,
                    summary       TEXT DEFAULT '',
                    price_fen     INTEGER NOT NULL DEFAULT 49800,  -- 统一定价 49800 分
                    chapter_count INTEGER NOT NULL,
                    trial_chapters INTEGER NOT NULL DEFAULT 2, -- 试读章数（content_pipeline --trial）
                    source        TEXT DEFAULT '总包创研院',
                    published_at  TEXT,
                    province      TEXT DEFAULT '',             -- 省份地图入口
                    owner_type    TEXT DEFAULT '',             -- 业主类型筛选
                    industry      TEXT DEFAULT '',             -- 行业筛选
                    tags          TEXT DEFAULT '[]',           -- json array：热词联想/三维关联推荐
                    pdf_trial_path TEXT DEFAULT '',
                    pdf_full_path TEXT DEFAULT '',             -- full.pdf 压缩后路径
                    status        TEXT NOT NULL DEFAULT 'on'   -- on/off（下架进改进队列）
                );

                -- §3 chapters [P0]（付费正文不入包、库内只存试读章正文）
                CREATE TABLE IF NOT EXISTS chapters (
                    id            TEXT PRIMARY KEY,            -- ch01..chNN（content_pipeline 编号）
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    idx           INTEGER NOT NULL,            -- 章序（从 1 起）
                    title         TEXT NOT NULL,
                    is_trial      INTEGER NOT NULL DEFAULT 0,  -- 1=试读章（带正文）；0=付费章
                    html          TEXT DEFAULT '',             -- 试读章=正文 html；付费章=''（空壳）
                    char_count    INTEGER DEFAULT 0,           -- 去标签字符数（噪声过滤阈值 400 参照）
                    UNIQUE(report_id, id)
                );
                CREATE INDEX IF NOT EXISTS idx_chapters_report ON chapters(report_id, idx);

                -- §4 entitlements [P0]（按权益下发判据表）
                CREATE TABLE IF NOT EXISTS entitlements (
                    id            TEXT PRIMARY KEY,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    source        TEXT NOT NULL DEFAULT 'purchase',  -- purchase/gift/voucher/invite/compensate
                    order_id      TEXT DEFAULT '',             -- source=purchase 时关联 orders.out_trade_no
                    granted_at    TEXT NOT NULL,
                    expires_at    TEXT DEFAULT '',             -- 空=永久；组队/赠品可设期
                    UNIQUE(user_id, report_id, source)         -- 同源同报告唯一；跨源并存允许
                );
                CREATE INDEX IF NOT EXISTS idx_ent_user ON entitlements(user_id);

                -- §5 orders [P0]（pay_log 对账表；outTradeNo 幂等键）
                CREATE TABLE IF NOT EXISTS orders (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    out_trade_no  TEXT NOT NULL UNIQUE,        -- 幂等键：{reportId}_{ts}
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    offer_id      TEXT DEFAULT '',             -- 虚拟支付发售单元 ID（后台回传）
                    product_id    TEXT DEFAULT 'xy_report_unlock',  -- 道具 ID（通用道具）
                    price_fen     INTEGER NOT NULL,            -- 49800
                    platform      TEXT NOT NULL DEFAULT 'android',  -- android/ios（iOS=Apple 通道 12%）
                    env           INTEGER NOT NULL DEFAULT 0,  -- 0=正式，1=沙箱
                    mode          TEXT NOT NULL DEFAULT 'short_series_goods',
                    status        TEXT NOT NULL DEFAULT 'pending',  -- pending/paid/delivered/refunded/refund_partial/failed
                    wx_order_sn   TEXT DEFAULT '',             -- 官方回执单号（回调核对）
                    pay_sig       TEXT DEFAULT '',             -- pay_sign 双签名快照（对账取证）
                    paid_at       TEXT DEFAULT '',
                    refund_state  TEXT DEFAULT '',             -- none/partial/full（对 refunds 汇总）
                    created_at    TEXT NOT NULL,
                    raw_notify    TEXT DEFAULT '{}'            -- json：回调原文快照（对账兜底）
                );
                CREATE INDEX IF NOT EXISTS idx_orders_user ON orders(user_id, created_at);

                -- §6 criticisms [P1]（四层闸数据化：确定性预筛与 LLM 判断层分离）
                CREATE TABLE IF NOT EXISTS criticisms (
                    id            TEXT PRIMARY KEY,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    order_id      TEXT NOT NULL REFERENCES orders(out_trade_no),  -- 须为已支付订单
                    content       TEXT NOT NULL,               -- 批评原文
                    char_count    INTEGER NOT NULL,            -- 资格：50-300
                    read_verified INTEGER NOT NULL DEFAULT 0,  -- 层①资格闸：真实阅读行为已核验
                    anchor_score  REAL NOT NULL DEFAULT 0,     -- 语义锚定分（模板化话术=0 → 直接不给退）
                    similarity_score REAL NOT NULL DEFAULT 0,  -- 与历史批评查重最高相似度
                    dup_flag      INTEGER NOT NULL DEFAULT 0,  -- 跨账号/同账号相似度告警位
                    llm_scores    TEXT DEFAULT '{}',           -- json：{sincerity,authenticity,constructiveness,rationale}
                    final_score   REAL DEFAULT 0,              -- 合成分（映射输入）
                    refund_tier   TEXT NOT NULL DEFAULT 'none',-- none/tier50/tier100…（50分→50%，100分→100%）
                    manual_review INTEGER NOT NULL DEFAULT 0,  -- 1=转人工（黑名单/查重告警/100%档）
                    reviewer_note TEXT DEFAULT '',
                    status        TEXT NOT NULL DEFAULT 'scored',  -- scored/approved/rejected/manual_pending/closed
                    created_at    TEXT NOT NULL,
                    UNIQUE(user_id, report_id)                 -- 层①：每报告每用户 1 次
                );

                -- §7 refunds [P1]（Android 自动退 + iOS 书券补偿双轨）
                CREATE TABLE IF NOT EXISTS refunds (
                    id            TEXT PRIMARY KEY,
                    order_id      TEXT NOT NULL REFERENCES orders(out_trade_no),
                    criticism_id  TEXT DEFAULT '' REFERENCES criticisms(id),  -- 空客诉退款可无
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    platform      TEXT NOT NULL,               -- android/ios
                    tier          TEXT NOT NULL,               -- 继承 criticism.refund_tier
                    amount_fen    INTEGER NOT NULL,            -- 按分线性退金额
                    method        TEXT NOT NULL DEFAULT 'auto',-- auto(≤50%档)/manual/voucher(iOS 补偿)
                    status        TEXT NOT NULL DEFAULT 'initiated',  -- initiated/notify_received/settled/failed
                    voucher_granted TEXT DEFAULT '',           -- iOS 等额书券发放单号
                    wx_refund_sn  TEXT DEFAULT '',             -- refund_order 回执
                    created_at    TEXT NOT NULL,
                    settled_at    TEXT DEFAULT ''
                );
                CREATE INDEX IF NOT EXISTS idx_refunds_order ON refunds(order_id);

                -- §8 vouchers [P1]（非现金内循环）
                CREATE TABLE IF NOT EXISTS vouchers (
                    id            TEXT PRIMARY KEY,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    amount_fen    INTEGER NOT NULL,            -- 面值
                    source        TEXT NOT NULL,               -- invite/criticism_thanks/ios_refund/campaign
                    source_ref    TEXT DEFAULT '',             -- 来源单号
                    status        TEXT NOT NULL DEFAULT 'active',  -- active/used/expired
                    used_order_id TEXT DEFAULT '',             -- 核销订单
                    expires_at    TEXT DEFAULT '',
                    created_at    TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_vouchers_user ON vouchers(user_id, status);

                -- §9 gift_grants [P1]（点赞→附条件赠送，每日限 1 份）
                CREATE TABLE IF NOT EXISTS gift_grants (
                    id            TEXT PRIMARY KEY,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    liked_report_id TEXT NOT NULL REFERENCES reports(id),  -- 被点赞报告
                    granted_report_id TEXT NOT NULL REFERENCES reports(id),-- 获赠报告（未购清单随机指定）
                    grant_date    TEXT NOT NULL,               -- 每日限1份判据（DATE）
                    created_at    TEXT NOT NULL,
                    UNIQUE(user_id, grant_date)                -- 每日 1 份
                );

                -- §10 poster_code [P1]（scene 32 字符契约与短码映射）
                CREATE TABLE IF NOT EXISTS poster_code (
                    scene_code    TEXT PRIMARY KEY,            -- 'r=Ab3xK9&i=U8mQ2z'（≈18字符）或短码 's=Xk29fA'
                    report_id     TEXT NOT NULL REFERENCES reports(id),   -- r=
                    inviter_uid   TEXT DEFAULT '',             -- i=（空=无邀请人降级）
                    channel       TEXT DEFAULT 'poster',       -- 海报/会话/朋友圈
                    poster_version TEXT DEFAULT 'v1',          -- 模板版本
                    pregenerated  INTEGER NOT NULL DEFAULT 1,  -- 预生成码池（避 5000 次/分限频）
                    created_at    TEXT NOT NULL
                );

                -- §11 share_event [P1]
                CREATE TABLE IF NOT EXISTS share_event (
                    id            TEXT PRIMARY KEY,            -- share_id
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    channel       TEXT NOT NULL,               -- poster/session/moments
                    poster_version TEXT DEFAULT 'v1',
                    ts            TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_share_user ON share_event(user_id, ts);

                -- §12 invite_relation [P1]（首触归因主表）
                CREATE TABLE IF NOT EXISTS invite_relation (
                    id            TEXT PRIMARY KEY,
                    inviter_uid   TEXT NOT NULL REFERENCES users(id),
                    invitee_uid   TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    scene_code    TEXT NOT NULL REFERENCES poster_code(scene_code),
                    status        TEXT NOT NULL DEFAULT 'scanned',  -- scanned/registered/unlocked/paid
                    unlocked_at   TEXT DEFAULT '',             -- 邀请解锁达成时刻
                    ts            TEXT NOT NULL,
                    UNIQUE(invitee_uid, report_id)             -- 首触：先到先记
                );
                CREATE INDEX IF NOT EXISTS idx_invite_inviter ON invite_relation(inviter_uid, status);

                -- §13 scan_visit [P1]（漏斗第一环，未登录先空）
                CREATE TABLE IF NOT EXISTS scan_visit (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    scene_code    TEXT NOT NULL REFERENCES poster_code(scene_code),
                    user_id       TEXT DEFAULT '',             -- 未登录先空（0.5 分钟读到正文，无登录墙）
                    entry_page    TEXT NOT NULL,
                    ts            TEXT NOT NULL
                );

                -- ARCHITECTURE §六 增补：favorites [P0]（收藏以服务端状态为真源，FR-P0-09）
                CREATE TABLE IF NOT EXISTS favorites (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    created_at    TEXT NOT NULL,
                    UNIQUE(user_id, report_id)
                );

                -- ARCHITECTURE §六 增补：read_log [P1]（层①资格闸「真实阅读行为」判据）
                CREATE TABLE IF NOT EXISTS read_log (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    chapter_id    TEXT NOT NULL REFERENCES chapters(id),
                    ts            TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_read_log_user ON read_log(user_id, report_id, ts);

                -- ARCHITECTURE §六 增补：teams / team_members [P1]（组队 3 人 ¥998 满员发放，FR-P1-10）
                CREATE TABLE IF NOT EXISTS teams (
                    id            TEXT PRIMARY KEY,            -- 队伍短ID
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    leader_uid    TEXT NOT NULL REFERENCES users(id),
                    status        TEXT NOT NULL DEFAULT 'open',-- open（招募）/full（满员发放）
                    created_at    TEXT NOT NULL
                );
                CREATE TABLE IF NOT EXISTS team_members (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    team_id       TEXT NOT NULL REFERENCES teams(id),
                    uid           TEXT NOT NULL REFERENCES users(id),
                    out_trade_no  TEXT DEFAULT '',             -- 各自支付单（满员核销判据）
                    joined_at     TEXT NOT NULL,
                    UNIQUE(team_id, uid)                       -- 同队不重复加入
                );

                -- Phase 8 P1 增补：voucher_burns（书券部分核销账，追加式只增不删）
                -- vouchers 行不 mutate 面值：部分核销记 burns 流水，余额=Σ发放-Σ核销；
                -- 全额烧完的 voucher 才置 status='used'+used_order_id（幂等核销判据）
                CREATE TABLE IF NOT EXISTS voucher_burns (
                    id            TEXT PRIMARY KEY,
                    voucher_id    TEXT NOT NULL REFERENCES vouchers(id),
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    amount_fen    INTEGER NOT NULL,            -- 本次核销分额（≤该券剩余）
                    redeem_ref    TEXT NOT NULL,               -- 兑换单号（一次兑换的多笔同 ref）
                    created_at    TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_voucher_burns_user ON voucher_burns(user_id, created_at);
                CREATE INDEX IF NOT EXISTS idx_voucher_burns_voucher ON voucher_burns(voucher_id);

                -- Phase 8 P1 增补：team_events（组队状态机事件账，追加式）
                -- 到期事件=72h 未满员解散的落库凭据，供 E2 refund 域消费（引擎只记不退）
                CREATE TABLE IF NOT EXISTS team_events (
                    id            TEXT PRIMARY KEY,
                    team_id       TEXT NOT NULL REFERENCES teams(id),
                    kind          TEXT NOT NULL,               -- expired（到期解散）/full（满员）
                    payload       TEXT NOT NULL DEFAULT '{}',  -- json：事件快照（退款执行所需字段）
                    ts            TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_team_events_team ON team_events(team_id, kind);

                -- Phase 8 P1 增补：fuse_state（L4 熔断状态落库+原子翻转载体；CRUD 在 refund.py）
                CREATE TABLE IF NOT EXISTS fuse_state (
                    key           TEXT PRIMARY KEY,            -- 'report:{rid}' 单报告线 / 'global' 全站周线
                    opened        INTEGER NOT NULL DEFAULT 0,  -- 1=熔断打开（停新发起，已受理义务继续履行）
                    reason        TEXT DEFAULT '',             -- 内部判据（不外泄；对外文案只写「平台保留权」）
                    opened_at     TEXT DEFAULT '',
                    updated_at    TEXT NOT NULL DEFAULT ''
                );

                -- Phase 8 P2 增补（末尾追加块）：transfers（FR-P2-04 水印版转赠事件账）
                -- 语义：转出即失权益（entitlements 当场删）、受赠方得 source='transfer' 权益；
                -- UNIQUE(report_id, from_user)=「每报告终身限转 1 次」判据（写入碰撞→409）
                CREATE TABLE IF NOT EXISTS transfers (
                    id            TEXT PRIMARY KEY,            -- 转赠单号 tXk29f
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    from_user     TEXT NOT NULL REFERENCES users(id),
                    to_user       TEXT NOT NULL REFERENCES users(id),
                    from_source   TEXT DEFAULT '',              -- 转出方被转走权益的来源（审计快照）
                    created_at    TEXT NOT NULL,
                    UNIQUE(report_id, from_user)
                );
                CREATE INDEX IF NOT EXISTS idx_transfers_to ON transfers(to_user, created_at);

                -- Phase 8 P2 增补：subscriptions（FR-P2-02 关注省份/主题订阅关系）
                CREATE TABLE IF NOT EXISTS subscriptions (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    kind          TEXT NOT NULL,                -- province / topic
                    value         TEXT NOT NULL,                -- 省份名或主题词
                    status        TEXT NOT NULL DEFAULT 'active',  -- active（退订=删行，不留灰态）
                    created_at    TEXT NOT NULL,
                    UNIQUE(user_id, kind, value)
                );
                CREATE INDEX IF NOT EXISTS idx_subscriptions_value ON subscriptions(kind, value);

                -- Phase 8 P2 增补：subscribe_sends（订阅消息一次性发送去重账）
                -- 「收到一次」判据：UNIQUE(user_id, tmpl_key, report_id)——同报告同模板不重发
                CREATE TABLE IF NOT EXISTS subscribe_sends (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    user_id       TEXT NOT NULL REFERENCES users(id),
                    tmpl_key      TEXT NOT NULL,                -- XY_SUBSCRIBE_TEMPLATES 键名
                    report_id     TEXT NOT NULL,
                    result        TEXT DEFAULT '',              -- 发送结果摘要（不落 openid/token）
                    created_at    TEXT NOT NULL,
                    UNIQUE(user_id, tmpl_key, report_id)
                );

                -- Phase 8 P2 增补（v1.2 情报官体系，末尾追加块）：invite_dwell 停留累计账
                -- 有效带新判据②（累计满 3 分钟）：追加式流水（每笔=一次上报计入秒，
                -- 已 clamp/cap）；(invitee,report) SUM=累计，达标由 invite 域把
                -- invite_relation.status 置 'effective'（状态机扩展，一次性幂等）
                CREATE TABLE IF NOT EXISTS invite_dwell (
                    id            INTEGER PRIMARY KEY AUTOINCREMENT,
                    invitee_uid   TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    seconds       INTEGER NOT NULL,             -- 本次计入秒数（clamp 后、截到累计上限）
                    created_at    TEXT NOT NULL
                );
                CREATE INDEX IF NOT EXISTS idx_invite_dwell ON invite_dwell(invitee_uid, report_id);

                -- 末尾追加块（卡维短码，2026-09-28）：card_code 卡场景短码池
                -- 根因=官方 scene ≤32 可见字符，真实卡 id（<rid>-cNNN≈20-24 字符）
                -- 使 c=<card_id>&i=<uid> 全量超限（3104/3104）——与报告码 poster_code
                -- 溢出通道对称：直拼合法走 c=，超限落本表 s=<8hex>；UNIQUE(card_id,
                -- inviter_uid) 幂等（同卡同人恒同码，QR/归因/码池三处复用一致）
                CREATE TABLE IF NOT EXISTS card_code (
                    short_code    TEXT PRIMARY KEY,               -- 's=' 后 8 hex
                    card_id       TEXT NOT NULL,
                    inviter_uid   TEXT NOT NULL REFERENCES users(id),
                    report_id     TEXT NOT NULL REFERENCES reports(id),
                    created_at    TEXT NOT NULL,
                    UNIQUE(card_id, inviter_uid)
                );
                CREATE INDEX IF NOT EXISTS idx_card_code_card ON card_code(card_id);
                -- 3c 榜单周快照（leaderboard 域；ISO 周一行的冻结口径，跨周自动翻新）
                CREATE TABLE IF NOT EXISTS rank_week (
                    week          TEXT PRIMARY KEY,               -- ISO 周键，如 2026-W40
                    payload_json  TEXT NOT NULL,                  -- 三榜+故事整包快照
                    generated_at  TEXT NOT NULL
                );
                """
            )
        _init_done = True


# ── users（登录域：openid→uid 映射入库；session_key 仅服务端留存）──
def get_or_create_user(openid: str, session_key: str = "", nickname: str = "") -> dict:
    """openid→uid 映射入库（幂等）；返回用户行 dict。"""
    init()
    uid = _uid_for(openid)
    with _LOCK, _db() as c:
        c.execute(
            "INSERT OR IGNORE INTO users(id,openid,nickname,created_at,session_key)"
            " VALUES(?,?,?,?,?)",
            (uid, openid, nickname, now(), session_key),
        )
        row = c.execute("SELECT * FROM users WHERE openid=?", (openid,)).fetchone()
    return dict(row) if row else {"id": uid, "openid": openid}


def _uid_for(openid: str) -> str:
    """确定性短 ID：sha256(openid)[:10]（映射幂等，免查表插入）。"""
    return "u" + hashlib.sha256(openid.encode()).hexdigest()[:10]


def get_user(uid: str) -> dict | None:
    init()
    with _db() as c:
        row = c.execute("SELECT * FROM users WHERE id=?", (uid,)).fetchone()
    return dict(row) if row else None


# ── 进库钩子（T-P0-01）：catalog.json+chapters.json → reports/chapters 表 ──
# 幂等 upsert；slug 主键（"{reportId}/{chNN}" 防撞号）；价格原样搬运（治理归 A 线）。
_REPORT_UPSERT = """INSERT INTO reports(id,title,summary,price_fen,chapter_count,
trial_chapters,source,published_at,province,owner_type,industry,tags)
VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ON CONFLICT(id) DO UPDATE SET
  title=excluded.title, summary=excluded.summary, price_fen=excluded.price_fen,
  chapter_count=excluded.chapter_count, trial_chapters=excluded.trial_chapters,
  source=excluded.source, published_at=excluded.published_at,
  province=COALESCE(NULLIF(excluded.province,''),reports.province),
  owner_type=COALESCE(NULLIF(excluded.owner_type,''),reports.owner_type),
  industry=COALESCE(NULLIF(excluded.industry,''),reports.industry),
  tags=COALESCE(NULLIF(excluded.tags,'[]'),reports.tags)"""


def sync_from_catalog(content_dir: Path, full_content_dir: Path | None = None) -> dict:
    """读 content_dir/catalog.json + reports/*/chapters.json → upsert 库；幂等可重跑。"""
    init()
    content_dir = Path(content_dir)
    catalog_file = content_dir / "catalog.json"
    if not catalog_file.exists():
        return {"reports": 0, "chapters": 0, "skipped": "catalog.json 不存在（内容区未就位）"}
    entries = json.loads(catalog_file.read_text(encoding="utf-8")).get("reports", [])
    n_reports = n_chapters = 0
    for entry in entries:
        rid = str(entry.get("id") or "").strip()
        if not rid:
            continue
        trial = int(entry.get("trialChapters") or entry.get("trialChapterCount") or config.TRIAL_CHAPTER_COUNT)
        with _LOCK, _db() as c:
            c.execute(_REPORT_UPSERT, (
                rid, str(entry.get("title") or ""), str(entry.get("summary") or ""),
                int(entry.get("price") or 0), int(entry.get("chapterCount") or 0), trial,
                str(entry.get("source") or "总包创研院"), str(entry.get("publishedAt") or ""),
                str(entry.get("province") or ""), str(entry.get("ownerType") or ""),
                str(entry.get("industry") or ""),
                json.dumps(entry.get("tags") or [], ensure_ascii=False),
            ))
        n_reports += 1
        n_chapters += _sync_chapters(content_dir, full_content_dir, rid, trial)
    try:  # FTS 维护钩子（T-P0-19 切片②）：进库后重建检索索引；失败不阻塞进库（检索自愈降级 LIKE）
        from . import fts as _fts  # 局部导入防环（fts→store）
        _fts.rebuild_reports([str(e.get("id") or "") for e in entries])
    except Exception:
        pass
    return {"reports": n_reports, "chapters": n_chapters}


def _sync_chapters(content_dir: Path, full_dir: Path | None, rid: str, trial: int) -> int:
    """单报告章节 upsert（试读判定=章 isTrial 标记或序号≤trial；付费正文取全集覆盖）。"""
    chap_file = content_dir / "reports" / rid / "chapters.json"
    if not chap_file.exists():
        return 0
    chaps = json.loads(chap_file.read_text(encoding="utf-8"))
    full_map: dict = {}
    full_file = (Path(full_dir) / "reports" / rid / "chapters_full.json") if full_dir else None
    if full_file and full_file.exists():
        for ch in json.loads(full_file.read_text(encoding="utf-8")):
            full_map[str(ch.get("id") or "")] = ch.get("html") or ""
    slugs, n = [], 0
    with _LOCK, _db() as c:
        for idx, ch in enumerate(chaps, 1):
            cid = str(ch.get("id") or f"ch{idx:02d}")
            slug = f"{rid}/{cid}"
            is_trial = 1 if (ch.get("isTrial") in (1, True) or idx <= trial) else 0
            html = str(ch.get("html") or "")
            if full_map.get(cid):  # 引擎侧全集为真源（试读/付费章皆覆盖）
                html = full_map[cid]
            char_count = len(re.sub(r"<[^>]+>", "", html))
            c.execute(
                "INSERT INTO chapters(id,report_id,idx,title,is_trial,html,char_count)"
                " VALUES(?,?,?,?,?,?,?) ON CONFLICT(id) DO UPDATE SET idx=excluded.idx,"
                " title=excluded.title, is_trial=excluded.is_trial, html=excluded.html,"
                " char_count=excluded.char_count",
                (slug, rid, idx, str(ch.get("title") or ""), is_trial, html, char_count),
            )
            slugs.append(slug)
            n += 1
        if slugs:  # 清理 A 线重切章后的残留行（幂等镜像）
            marks = ",".join("?" * len(slugs))
            c.execute(
                f"DELETE FROM chapters WHERE report_id=? AND id NOT IN ({marks})",
                (rid, *slugs),
            )
    return n
