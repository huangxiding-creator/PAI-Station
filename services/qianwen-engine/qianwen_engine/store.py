# -*- coding: utf-8 -*-
"""总包千问存储——sqlite（用户配额 / 答案 / 点赞 / 批评 / 互动赠次 / 锅圈）。

v0.8.0 CloudBase 云托管迁移——双驱动存储：
- DB_KIND=sqlite（默认）：本地/ECS 行为与旧版逐位一致（连接-提交-关闭、同一套 DDL）；
- DB_KIND=mysql：PyMySQL + 小连接池（借出 ping 自愈容器空闲断连）+ DictCursor。
SQL 原文保持 sqlite 写法，方言差异（? 占位 / ON CONFLICT upsert /
datetime('now','localtime') / AUTOINCREMENT / INSERT OR IGNORE / PRAGMA）由
模块级适配器 _sql() 仅在 mysql 侧转换——两套语义 1:1，函数签名零改动。
"""
from __future__ import annotations

import json
import re
import secrets as pysecrets
import sqlite3
import threading
import time
from contextlib import contextmanager
from typing import Optional

from . import config

_LOCK = threading.Lock()
_init_done = False

_IS_MYSQL = config.DB_KIND == "mysql"   # 驱动在 import 时定型（config 读环境变量）


# ── MySQL 驱动（惰性装载：sqlite 部署无需安装 PyMySQL） ──────────
class _Row(dict):
    """dict + 整数下标——对齐 sqlite3.Row 访问面（row[0] / row["col"] / row.keys()）。"""

    def __getitem__(self, key):
        if isinstance(key, int):
            return tuple(self.values())[key]
        return super().__getitem__(key)


def _keep_text(value):
    """DATETIME/DATE/TIMESTAMP 解码保持文本原样（"YYYY-MM-DD HH:MM:SS"）——与 sqlite
    的字符串口径一致（锅圈排序按此格式 strptime，前端直接展示该字符串）。"""
    if isinstance(value, (bytes, bytearray)):
        return value.decode("utf-8", "ignore")
    return value if isinstance(value, str) else str(value)


_DRIVER: Optional[dict] = None


def _driver() -> dict:
    """装载 PyMySQL 驱动件（仅 mysql 模式首个连接时执行一次）。"""
    global _DRIVER
    if _DRIVER is None:
        import pymysql
        import pymysql.cursors
        from pymysql.converters import FIELD_TYPE, conversions as _base_conv

        conv = dict(_base_conv)              # 时间类型保持文本解码，其余解码不变
        for ft in (FIELD_TYPE.DATETIME, FIELD_TYPE.TIMESTAMP,
                   FIELD_TYPE.DATE, FIELD_TYPE.TIME):
            conv[ft] = _keep_text

        class _RowCursor(pymysql.cursors.DictCursor):
            dict_type = _Row

        _DRIVER = {
            "connect": pymysql.connect,
            "conv": conv,
            "cursorclass": _RowCursor,
            "IntegrityError": pymysql.err.IntegrityError,
            "OperationalError": pymysql.err.OperationalError,
            "ProgrammingError": pymysql.err.ProgrammingError,
        }
    return _DRIVER


def _sql(template: str) -> str:
    """方言适配器：sqlite 写法的 SQL 原文 → mysql 方言（sqlite 模式原样返回，零转换）。

    覆盖本模块全部方言点（新增查询要么可被本适配器转换，要么进 _SCHEMA 方言对）：
      ?                            → %s
      INSERT OR IGNORE             → INSERT IGNORE
      ON CONFLICT(k) DO UPDATE SET x=excluded.x → ON DUPLICATE KEY UPDATE x=VALUES(x)
      datetime('now','localtime')  → CURRENT_TIMESTAMP
      TEXT DEFAULT (datetime(…))   → DATETIME DEFAULT CURRENT_TIMESTAMP
      INTEGER PRIMARY KEY AUTOINCREMENT → INT PRIMARY KEY AUTO_INCREMENT
      PRAGMA …                     → 空串（mysql 跳过；当前无 PRAGMA，防御性收口）
    """
    if not _IS_MYSQL:
        return template
    if template.lstrip().upper().startswith("PRAGMA"):
        return ""
    out = template
    out = re.sub(r"INSERT\s+OR\s+IGNORE", "INSERT IGNORE", out, flags=re.I)
    out = re.sub(r"ON\s+CONFLICT\s*\([^)]*\)\s+DO\s+UPDATE\s+SET",
                 "ON DUPLICATE KEY UPDATE", out, flags=re.I)
    out = re.sub(r"(\w+)\s*=\s*excluded\.(\w+)", r"\1=VALUES(\2)", out, flags=re.I)
    out = re.sub(r"INTEGER\s+PRIMARY\s+KEY\s+AUTOINCREMENT",
                 "INT PRIMARY KEY AUTO_INCREMENT", out, flags=re.I)
    out = out.replace("TEXT DEFAULT (datetime('now','localtime'))",
                      "DATETIME DEFAULT CURRENT_TIMESTAMP")
    out = out.replace("datetime('now','localtime')", "CURRENT_TIMESTAMP")
    return out.replace("?", "%s")


class _MyConn:
    """PyMySQL 连接包装——提供 sqlite3.Connection 同款调用面
    （execute / executemany / commit / total_changes，execute 返回游标含 lastrowid）。

    异常翻译：pymysql IntegrityError/OperationalError/ProgrammingError → sqlite3
    同名/兼容异常，调用点既有 except 分支零改动。total_changes=本连接累计 DML 行数。
    """

    def __init__(self, conn) -> None:
        self._conn = conn
        self.total_changes = 0

    def execute(self, sql: str, params: tuple = ()):
        return self._run("execute", sql, params)

    def executemany(self, sql: str, seq: list):
        return self._run("executemany", sql, seq)

    def _run(self, method: str, sql: str, args):
        d = _driver()
        cur = self._conn.cursor()
        try:
            converted = _sql(sql)
            if converted:                          # PRAGMA 等 mysql 跳过项 → 空操作
                getattr(cur, method)(converted, args or None)
        except d["IntegrityError"] as exc:
            raise sqlite3.IntegrityError(str(exc)) from exc
        except (d["OperationalError"], d["ProgrammingError"]) as exc:
            raise sqlite3.OperationalError(str(exc)) from exc
        if cur.rowcount and cur.rowcount > 0:
            self.total_changes += cur.rowcount
        return cur

    def commit(self) -> None:
        self._conn.commit()

    def rollback(self) -> None:
        try:
            self._conn.rollback()
        except Exception:  # noqa: BLE001 — 回滚失败只剩弃置连接一条路（_my_borrow 兜底）
            pass


# ── mysql 连接池：小池 + 借出 ping 自愈（容器空闲断连常态） ──────────
_POOL_LOCK = threading.Lock()
_POOL: list = []
_POOL_MAX = 4            # 写路径另有 _LOCK 串行，引擎并发低，小池即够


def _my_connect():
    d = _driver()
    return d["connect"](
        host=config.MYSQL_HOST, port=config.MYSQL_PORT,
        user=config.MYSQL_USER, password=config.MYSQL_PASSWORD,
        database=config.MYSQL_DATABASE, charset="utf8mb4",
        autocommit=False, conv=d["conv"], cursorclass=d["cursorclass"],
        connect_timeout=5, read_timeout=60, write_timeout=60,
    )


@contextmanager
def _my_borrow():
    """借出/归还：用前 ping（断了重连）；异常路径的连接弃置不回池（异常原样外抛）。"""
    with _POOL_LOCK:
        conn = _POOL.pop() if _POOL else None
    if conn is None:
        conn = _my_connect()
    ok = False
    try:
        conn.ping(reconnect=True)
        yield _MyConn(conn)
        ok = True
    finally:
        _release(conn, ok)    # 注意不可在 finally 里 return——会吞掉在途异常


def _release(conn, ok: bool) -> None:
    """归还或弃置：ok=False（含异常在途）→ 直接关闭；池满 → 关闭多余连接。"""
    if ok:
        with _POOL_LOCK:
            if len(_POOL) < _POOL_MAX:
                _POOL.append(conn)
                return
    try:
        conn.close()
    except Exception:  # noqa: BLE001
        pass


@contextmanager
def _db():
    """连接上下文：sqlite=开-用-提交-关（既有行为）；mysql=池借-ping-提交-还。"""
    if _IS_MYSQL:
        with _my_borrow() as w:
            try:
                yield w
                w.commit()
            except Exception:
                w.rollback()
                raise
    else:
        config.DATA_DIR.mkdir(parents=True, exist_ok=True)
        conn = sqlite3.connect(config.DB_PATH)
        conn.row_factory = sqlite3.Row
        try:
            yield conn
            conn.commit()
        finally:
            conn.close()


# ── 模式定义（方言对，一处维护）：sqlite 语句与旧版逐字同义；mysql 变体并列 ──
# mysql 侧约定：
#   - 索引内嵌 KEY（MySQL 无 CREATE INDEX IF NOT EXISTS，故索引对的 mysql 侧为 None）
#   - answers.rowid = 真实自增列——对齐 sqlite 隐式 rowid 的插入序（history 排序两方言同义）
#   - TEXT/MEDIUMTEXT 不可带列默认（兼容 MySQL 5.7）→ 允许 NULL，读路径统一归一为 ''
#   - 演进列（error_text/views/shared/opt_*/env…）直接建全，ALTER 升级在 mysql 为幂等空转
_SCHEMA: tuple = (
    ("""CREATE TABLE IF NOT EXISTS users (
        openid TEXT PRIMARY KEY,
        unionid TEXT DEFAULT '',
        nickname TEXT DEFAULT '',
        free_used INTEGER DEFAULT 0,
        bonus_earned INTEGER DEFAULT 0,
        bonus_used INTEGER DEFAULT 0,
        quota_day TEXT DEFAULT '',
        like_day TEXT DEFAULT '',
        like_granted INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS users (
        openid VARCHAR(64) PRIMARY KEY,
        unionid VARCHAR(128) DEFAULT '',
        nickname VARCHAR(255) DEFAULT '',
        free_used INT DEFAULT 0,
        bonus_earned INT DEFAULT 0,
        bonus_used INT DEFAULT 0,
        quota_day VARCHAR(10) DEFAULT '',
        like_day VARCHAR(10) DEFAULT '',
        like_granted INT DEFAULT 0,
        opt_day VARCHAR(10) DEFAULT '',
        opt_used INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("""CREATE TABLE IF NOT EXISTS answers (
        id TEXT PRIMARY KEY,
        openid TEXT NOT NULL,
        question TEXT NOT NULL,
        answer_full TEXT DEFAULT '',
        citations TEXT DEFAULT '[]',
        via TEXT DEFAULT 'kb',
        status TEXT DEFAULT 'ready',
        unlocked INTEGER DEFAULT 0,
        liked INTEGER DEFAULT 0,
        criticized INTEGER DEFAULT 0,
        elapsed_sec REAL DEFAULT 0,
        views INTEGER DEFAULT 0,
        shares INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS answers (
        id VARCHAR(32) PRIMARY KEY,
        openid VARCHAR(64) NOT NULL,
        question TEXT NOT NULL,
        answer_full MEDIUMTEXT,
        citations MEDIUMTEXT,
        via VARCHAR(16) DEFAULT 'kb',
        status VARCHAR(16) DEFAULT 'ready',
        unlocked INT DEFAULT 0,
        liked INT DEFAULT 0,
        criticized INT DEFAULT 0,
        elapsed_sec DOUBLE DEFAULT 0,
        views INT DEFAULT 0,
        shares INT DEFAULT 0,
        error_text TEXT,
        out_trade_no VARCHAR(64) DEFAULT '',
        paid INT DEFAULT 0,
        tldr TEXT,
        related TEXT,
        shared INT DEFAULT 0,
        export_paid INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        rowid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        UNIQUE KEY uk_answers_rowid (rowid),
        KEY idx_answers_openid (openid, created_at DESC)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("CREATE INDEX IF NOT EXISTS idx_answers_openid ON answers(openid, created_at DESC)", None),
    ("""CREATE TABLE IF NOT EXISTS mp_session (
        openid TEXT PRIMARY KEY,
        session_key TEXT NOT NULL,
        updated_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS mp_session (
        openid VARCHAR(64) PRIMARY KEY,
        session_key VARCHAR(255) NOT NULL,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("""CREATE TABLE IF NOT EXISTS rewards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        openid TEXT NOT NULL,
        aid TEXT NOT NULL,
        action TEXT NOT NULL,
        created_at TEXT DEFAULT (datetime('now','localtime')),
        UNIQUE(openid, aid, action)
    )""",
     """CREATE TABLE IF NOT EXISTS rewards (
        id INT PRIMARY KEY AUTO_INCREMENT,
        openid VARCHAR(64) NOT NULL,
        aid VARCHAR(32) NOT NULL,
        action VARCHAR(16) NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY uk_rewards_openid_aid_action (openid, aid, action)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("""CREATE TABLE IF NOT EXISTS pot_items (
        aid TEXT PRIMARY KEY,
        sort INTEGER DEFAULT 0,
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS pot_items (
        aid VARCHAR(32) PRIMARY KEY,
        sort INT DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("""CREATE TABLE IF NOT EXISTS followups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        aid TEXT NOT NULL,
        openid TEXT NOT NULL,
        question TEXT NOT NULL,
        answer TEXT NOT NULL DEFAULT '',
        status TEXT NOT NULL DEFAULT 'pending',   -- pending|ready|error
        error_text TEXT DEFAULT '',
        created_at REAL
    )""",
     """CREATE TABLE IF NOT EXISTS followups (
        id INT PRIMARY KEY AUTO_INCREMENT,
        aid VARCHAR(32) NOT NULL,
        openid VARCHAR(64) NOT NULL,
        question TEXT NOT NULL,
        answer MEDIUMTEXT,
        status VARCHAR(16) NOT NULL DEFAULT 'pending',   -- pending|ready|error
        error_text MEDIUMTEXT,
        created_at DOUBLE,
        KEY idx_followups_aid_openid (aid, openid)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("CREATE INDEX IF NOT EXISTS idx_followups_aid_openid ON followups(aid, openid)", None),
    ("""CREATE TABLE IF NOT EXISTS posters (
        aid TEXT PRIMARY KEY,
        png BLOB,
        created_at REAL
    )""",
     """CREATE TABLE IF NOT EXISTS posters (
        aid VARCHAR(32) PRIMARY KEY,
        png LONGBLOB,
        created_at DOUBLE,
        env VARCHAR(16) DEFAULT ''
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    ("""CREATE TABLE IF NOT EXISTS pot_reports (
        aid TEXT NOT NULL,
        openid TEXT NOT NULL,
        reason TEXT NOT NULL,
        created_at TEXT DEFAULT (datetime('now','localtime')),
        PRIMARY KEY (aid, openid)
    )""",
     """CREATE TABLE IF NOT EXISTS pot_reports (
        aid VARCHAR(32) NOT NULL,
        openid VARCHAR(64) NOT NULL,
        reason TEXT NOT NULL,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (aid, openid)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.8.0 虚拟支付对账流水（导出收费：单条/批量一单一行；幂等插入由调用方保证）
    ("""CREATE TABLE IF NOT EXISTS pay_log (
        aid TEXT NOT NULL,
        openid TEXT NOT NULL,
        out_trade_no TEXT DEFAULT '',
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS pay_log (
        aid VARCHAR(32) NOT NULL,
        openid VARCHAR(64) NOT NULL,
        out_trade_no VARCHAR(64) DEFAULT '',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        KEY idx_paylog_openid (openid)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.8.0 支付订单表（对抗审查 CRITICAL-2/HIGH-3/MEDIUM-4 根治）：
    # 签名即落单（otn 主键）；回调腿凭订单 + 微信查单核验才放行；
    # 批量单快照 aid_list——签名时刻与支付时刻之间新完成的咨询不被顺带解锁。
    ("""CREATE TABLE IF NOT EXISTS pay_order (
        out_trade_no TEXT NOT NULL PRIMARY KEY,
        openid TEXT NOT NULL,
        kind TEXT NOT NULL,
        aid TEXT DEFAULT '',
        aid_list TEXT DEFAULT '',
        buy_quantity INTEGER NOT NULL,
        total_fen INTEGER NOT NULL,
        status TEXT DEFAULT 'signed',
        created_at TEXT DEFAULT (datetime('now','localtime')),
        paid_at TEXT DEFAULT ''
    )""",
     """CREATE TABLE IF NOT EXISTS pay_order (
        out_trade_no VARCHAR(64) NOT NULL PRIMARY KEY,
        openid VARCHAR(64) NOT NULL,
        kind VARCHAR(8) NOT NULL,
        aid VARCHAR(32) DEFAULT '',
        aid_list TEXT,
        buy_quantity INT NOT NULL,
        total_fen INT NOT NULL,
        status VARCHAR(8) DEFAULT 'signed',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        paid_at DATETIME NULL,
        rowid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        UNIQUE KEY uk_payorder_rowid (rowid),
        KEY idx_payorder_openid (openid)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.9.0 报告商城解锁（openid × sku 幂等；对账走 pay_order/pay_log）
    ("""CREATE TABLE IF NOT EXISTS report_unlocks (
        openid TEXT NOT NULL,
        sku TEXT NOT NULL,
        out_trade_no TEXT DEFAULT '',
        created_at TEXT DEFAULT (datetime('now','localtime')),
        PRIMARY KEY(openid, sku)
    )""",
     """CREATE TABLE IF NOT EXISTS report_unlocks (
        openid VARCHAR(64) NOT NULL,
        sku VARCHAR(32) NOT NULL,
        out_trade_no VARCHAR(64) DEFAULT '',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY(openid, sku)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.7.0 依据来源全文展开（智谱接地生成，按 aid+n 永久缓存）
    ("CREATE TABLE IF NOT EXISTS citations_ft ("
     "aid TEXT NOT NULL, n INTEGER NOT NULL, text TEXT NOT NULL,"
     " created_at REAL, PRIMARY KEY(aid, n))",
     """CREATE TABLE IF NOT EXISTS citations_ft (
        aid VARCHAR(32) NOT NULL,
        n INT NOT NULL,
        text MEDIUMTEXT NOT NULL,
        created_at DOUBLE,
        PRIMARY KEY (aid, n)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.9.4 发票申请（1009 用户令：满 ¥200 可申请增值税专用发票；运营侧企业微信收单）
    ("""CREATE TABLE IF NOT EXISTS invoice_apps (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        openid TEXT NOT NULL,
        total_fen INTEGER NOT NULL,
        title TEXT NOT NULL,
        tax_no TEXT NOT NULL,
        addr_phone TEXT DEFAULT '',
        bank_acct TEXT DEFAULT '',
        email TEXT NOT NULL,
        note TEXT DEFAULT '',
        status TEXT DEFAULT 'pending',
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS invoice_apps (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        openid VARCHAR(64) NOT NULL,
        total_fen INT NOT NULL,
        title VARCHAR(128) NOT NULL,
        tax_no VARCHAR(32) NOT NULL,
        addr_phone VARCHAR(255) DEFAULT '',
        bank_acct VARCHAR(255) DEFAULT '',
        email VARCHAR(128) NOT NULL,
        note VARCHAR(512) DEFAULT '',
        status VARCHAR(16) DEFAULT 'pending',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        KEY idx_invoice_openid (openid)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
    # v0.9.6 真机遥测（1009 真机根因战）：客户端匿名执行轨迹（事件名+匿名boot+短extra），
    # 地面真值腿——不依赖弹窗/控制台（wx.showModal 真机静默 fail 的双盲区补位）
    ("""CREATE TABLE IF NOT EXISTS telemetry_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event TEXT NOT NULL,
        boot TEXT DEFAULT '',
        ver TEXT DEFAULT '',
        extra TEXT DEFAULT '',
        created_at TEXT DEFAULT (datetime('now','localtime'))
    )""",
     """CREATE TABLE IF NOT EXISTS telemetry_events (
        id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
        event VARCHAR(40) NOT NULL,
        boot VARCHAR(24) DEFAULT '',
        ver VARCHAR(16) DEFAULT '',
        extra VARCHAR(255) DEFAULT '',
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        KEY idx_tel_event (event)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"""),
)

# 增列（老库平滑升级：已存在则忽略）——sqlite 原文 / mysql 变体（TEXT 不可带 DEFAULT）
# 沿革：v0.2.2 error_text / v0.2.5 支付两列 / v0.5.0 优化计数 / v0.6.0 tldr·related / v0.7.0 shared·env
_ANSWER_UPGRADES: tuple = (
    ("error_text TEXT DEFAULT ''", "error_text TEXT"),
    ("out_trade_no TEXT DEFAULT ''", "out_trade_no VARCHAR(64) DEFAULT ''"),
    ("paid INTEGER DEFAULT 0", "paid INT DEFAULT 0"),
    ("views INTEGER DEFAULT 0", "views INT DEFAULT 0"),
    ("shares INTEGER DEFAULT 0", "shares INT DEFAULT 0"),
    ("tldr TEXT DEFAULT ''", "tldr TEXT"),
    ("related TEXT DEFAULT ''", "related TEXT"),
    ("shared INTEGER DEFAULT 0", "shared INT DEFAULT 0"),
    # v0.8.0 用户令 1008：咨询全免费，导出按条收费（¥0.1/条，虚拟支付）
    ("export_paid INTEGER DEFAULT 0", "export_paid INT DEFAULT 0"),
)
_USER_UPGRADES: tuple = (
    ("opt_day TEXT DEFAULT ''", "opt_day VARCHAR(10) DEFAULT ''"),
    ("opt_used INTEGER DEFAULT 0", "opt_used INT DEFAULT 0"),
)
_POSTER_UPGRADES: tuple = (("env TEXT DEFAULT ''", "env VARCHAR(16) DEFAULT ''"),)


def init() -> None:
    global _init_done
    with _LOCK:
        if _init_done:
            return
        with _db() as c:
            for sq, my in _SCHEMA:
                if _IS_MYSQL and my is None:
                    continue      # mysql 无对应语句（CREATE INDEX IF NOT EXISTS：索引已内联建表 KEY）
                c.execute(my if _IS_MYSQL else sq)
        _upgrade("answers", _ANSWER_UPGRADES)
        _upgrade("users", _USER_UPGRADES)
        _upgrade("posters", _POSTER_UPGRADES)
        _init_done = True


def _upgrade(table: str, cols: tuple) -> None:
    """逐列 ALTER 平滑升级：列已存在（duplicate column）→ OperationalError 吞掉；
    mysql 侧异常由 _MyConn 翻译为 sqlite3.OperationalError，两方言同一条路径。"""
    for sq, my in cols:
        try:
            with _db() as c:
                c.execute(f"ALTER TABLE {table} ADD COLUMN {my if _IS_MYSQL else sq}")
        except sqlite3.OperationalError:
            pass


def _today() -> str:
    """北京日期（UTC+8 固定偏移，无夏令时）——清零时点=北京时间 00:00，与服务器时区无关。"""
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600))


def _row_user(c: sqlite3.Connection, openid: str) -> sqlite3.Row:
    row = c.execute("SELECT * FROM users WHERE openid=?", (openid,)).fetchone()
    if row is None:
        c.execute("INSERT INTO users(openid, quota_day) VALUES(?,?)", (openid, _today()))
        row = c.execute("SELECT * FROM users WHERE openid=?", (openid,)).fetchone()
    # 跨日重置
    if row["quota_day"] != _today():
        c.execute(
            "UPDATE users SET free_used=0, bonus_earned=0, bonus_used=0,"
            " like_granted=0, quota_day=? WHERE openid=?",
            (_today(), openid))
        row = _row_user(c, openid)
    return row


def quota_left(openid: str) -> dict:
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        free_left = max(0, config.FREE_PER_DAY - row["free_used"])
        bonus_left = max(0, row["bonus_earned"] - row["bonus_used"])
        return {
            "free_left": free_left,
            "bonus_left": bonus_left,
            "total_left": free_left + bonus_left,
            "free_per_day": config.FREE_PER_DAY,
        }


def consume_one(openid: str) -> bool:
    """扣一次提问配额（先免费后赠次）。返回 False=无配额。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["free_used"] < config.FREE_PER_DAY:
            c.execute("UPDATE users SET free_used=free_used+1 WHERE openid=?", (openid,))
            return True
        if row["bonus_used"] < row["bonus_earned"]:
            c.execute("UPDATE users SET bonus_used=bonus_used+1 WHERE openid=?", (openid,))
            return True
        return False


# ── v0.5.0 互动赠次；v0.7.3 起三动作：有用/分享/纠错，每答案每动作一次，总量上不封顶 ──
def reward_exists(openid: str, aid: str, action: str) -> bool:
    init()
    with _db() as c:
        row = c.execute(
            "SELECT 1 FROM rewards WHERE openid=? AND aid=? AND action=?",
            (openid, aid, action)).fetchone()
        return row is not None


def grant_reward(openid: str, aid: str, action: str) -> bool:
    """互动赠次（+1）。UNIQUE(openid,aid,action)=每答案每动作一次；返回 False=已领过。"""
    if action not in config.REWARD_ACTIONS:
        raise ValueError(f"未知赠次动作: {action}")
    init()
    with _LOCK, _db() as c:
        _row_user(c, openid)  # 确保用户在册且当日计数已重置
        try:
            c.execute(
                "INSERT INTO rewards(openid, aid, action) VALUES(?,?,?)",
                (openid, aid, action))
        except sqlite3.IntegrityError:
            return False
        c.execute("UPDATE users SET bonus_earned=bonus_earned+1 WHERE openid=?", (openid,))
        return True


def new_answer_id() -> str:
    # 短 ID（海报 scene 用，≤32 字符且免中文 urlencode）
    return pysecrets.token_urlsafe(6)


def save_answer(openid: str, question: str, answer_full: str,
                citations: list, via: str = "kb", elapsed: float = 0.0) -> str:
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO answers(id, openid, question, answer_full, citations, via, elapsed_sec)"
            " VALUES(?,?,?,?,?,?,?)",
            (aid, openid, question, answer_full,
             json.dumps(citations, ensure_ascii=False), via, elapsed),
        )
    return aid


def create_pending(openid: str, question: str) -> str:
    """v0.2.2 异步流水线：先落 pending 行，完成后回填。
    v0.7.0：公益免费令——付费墙拆除，出生即解锁（unlocked=1）。"""
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        # answer_full/citations 显式置空：sqlite 原靠列默认值；mysql TEXT 无列默认（NULL），
        # 显式写 '' 使两方言落库值一致
        c.execute(
            "INSERT INTO answers(id, openid, question, status, unlocked, answer_full, citations)"
            " VALUES(?,?,?,'pending',1,'','[]')",
            (aid, openid, question),
        )
    return aid


def complete_answer(aid: str, answer_full: str, citations: list,
                    elapsed: float = 0.0) -> bool:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE answers SET answer_full=?, citations=?, elapsed_sec=?,"
            " status='ready', unlocked=1, error_text='' WHERE id=? AND status='pending'",
            (answer_full, json.dumps(citations, ensure_ascii=False), elapsed, aid),
        )
        return c.total_changes > 0


def fail_answer(aid: str, err: str) -> bool:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE answers SET status='error', error_text=? WHERE id=? AND status='pending'",
            ((err or "")[:300], aid),
        )
        return c.total_changes > 0


def refund_one(openid: str) -> None:
    """失败退次：consume_one 的逆操作（优先退赠次）。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["bonus_used"] > 0:
            c.execute("UPDATE users SET bonus_used=bonus_used-1 WHERE openid=?", (openid,))
        elif row["free_used"] > 0:
            c.execute("UPDATE users SET free_used=free_used-1 WHERE openid=?", (openid,))


def get_answer(aid: str, openid: Optional[str] = None) -> Optional[dict]:
    init()
    with _db() as c:
        row = c.execute("SELECT * FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None:
            return None
        if openid is not None and row["openid"] != openid:
            return None
        d = dict(row)
        d["citations"] = json.loads(d.get("citations") or "[]")
        # mysql TEXT 无列默认值（NULL 归一为 ''；sqlite 恒 ''，输出不变）
        d["answer_full"] = d.get("answer_full") or ""
        d["error_text"] = d.get("error_text") or ""
        return d


def get_answer_visible(aid: str, openid: str) -> Optional[dict]:
    """可见性=本人答案 或 锅圈公共答案（v0.5.0）。
    v0.7.3（用户令语义收紧）：未共享的提问永远仅本人可见（只进我的历史）；
    只有共享入锅圈（pot_items 有行）或官方种子（POT_OPENID）才对所有人开详情。
    修前缺陷：用户共享的答案 openid=本人≠POT_OPENID → 他人在锅圈点详情 404。"""
    row = get_answer(aid)
    if row is None:
        return None
    if row["openid"] == openid or row["openid"] == config.POT_OPENID:
        return row
    init()
    with _db() as c:
        in_pot = c.execute("SELECT 1 FROM pot_items WHERE aid=?", (aid,)).fetchone()
    return row if in_pot else None


def bump_views(aid: str) -> int:
    """v0.7.3（用户令）观看计数：点开看到全文即 +1（同一用户重复看也持续 +1，不去重）。
    原子自增；返回自增后的新值。仅在 status=ready 的详情下发路径调用（pending 轮询不计）。"""
    init()
    with _LOCK, _db() as c:
        c.execute("UPDATE answers SET views = views + 1 WHERE id=?", (aid,))
        row = c.execute("SELECT views FROM answers WHERE id=?", (aid,)).fetchone()
    return (row["views"] if row else 0) or 0


def bump_shares(aid: str) -> int:
    """v0.7.3（用户令）转发计数：任何用户转发/分享（分享钮、海报传播）即 +1，持续累计。
    返回自增后的新值。"""
    init()
    with _LOCK, _db() as c:
        c.execute("UPDATE answers SET shares = shares + 1 WHERE id=?", (aid,))
        row = c.execute("SELECT shares FROM answers WHERE id=?", (aid,)).fetchone()
    return (row["shares"] if row else 0) or 0


def mark_liked(aid: str, openid: str) -> bool:
    """本人答案的行级点赞标记（老语义）。锅圈点赞不走这里——走 grant_reward 的 UNIQUE 去重。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT liked, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid:
            return False
        if row["liked"]:
            return False
        c.execute("UPDATE answers SET liked=1 WHERE id=?", (aid,))
        return True


def save_criticism(aid: str, openid: str, text: str, score: Optional[int] = None,
                   refund_tier: str = "") -> bool:
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT criticized, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None:
            return False
        is_owner = row["openid"] == openid
        is_pot = row["openid"] == config.POT_OPENID
        if not is_owner and not is_pot:
            return False
        if is_owner and row["criticized"]:
            return False
        if is_pot:
            seen = c.execute(
                "SELECT 1 FROM rewards WHERE openid=? AND aid=? AND action='criticize'",
                (openid, aid)).fetchone()
            if seen:
                return False
        if is_owner:
            c.execute("UPDATE answers SET criticized=1 WHERE id=?", (aid,))
        c.execute(
            "CREATE TABLE IF NOT EXISTS criticisms"
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, aid TEXT, openid TEXT, text TEXT,"
            " score INTEGER, refund_tier TEXT, created_at TEXT DEFAULT (datetime('now','localtime')))"
        )
        c.execute("INSERT INTO criticisms(aid, openid, text, score, refund_tier) VALUES(?,?,?,?,?)",
                  (aid, openid, text, score, refund_tier))
        return True


def mark_unlocked(aid: str, openid: str) -> bool:
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT unlocked, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid or row["unlocked"]:
            return False
        c.execute("UPDATE answers SET unlocked=1 WHERE id=?", (aid,))
        return True


# ── v0.2.5 虚拟支付：session_key 存取 + 支付解锁 ──────────────
def save_session(openid: str, session_key: str) -> None:
    """登录态留存 session_key（仅服务端使用，绝不下发客户端）。"""
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO mp_session(openid, session_key) VALUES(?,?)"
            " ON CONFLICT(openid) DO UPDATE SET"
            " session_key=excluded.session_key, updated_at=datetime('now','localtime')",
            (openid, session_key or ""),
        )


def get_session(openid: str) -> str:
    init()
    with _db() as c:
        row = c.execute("SELECT session_key FROM mp_session WHERE openid=?", (openid,)).fetchone()
        return (row["session_key"] if row else "") or ""


def mark_export_paid(aid: str, openid: str, out_trade_no: str = "") -> bool:
    """单条导出解锁（¥0.1/条）：幂等（重复回调恒 True）；首次落 pay_log 供对账。
    v0.8.0 用户令 1008：¥1 整篇解锁已下线，咨询全免费，仅导出按条收费。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT openid, export_paid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid:
            return False
        if not row["export_paid"]:
            c.execute("UPDATE answers SET export_paid=1 WHERE id=?", (aid,))
            c.execute("INSERT INTO pay_log(aid, openid, out_trade_no) VALUES(?,?,?)",
                      (aid, openid, (out_trade_no or aid)[:64]))
        return True


def mark_all_export_paid(openid: str, out_trade_no: str = "") -> int:
    """[兼容旧测试] 批量导出解锁：本人全部 ready 答案一次性标记（幂等重跑安全）。
    生产链路 v0.8.0 审计后改走 mark_export_paid_many（快照制，防批量漂移）。"""
    init()
    with _LOCK, _db() as c:
        rows = c.execute(
            "SELECT id, export_paid FROM answers WHERE openid=? AND status='ready'",
            (openid,),
        ).fetchall()
        n_new = 0
        for r in rows:
            if not r["export_paid"]:
                c.execute("UPDATE answers SET export_paid=1 WHERE id=?", (r["id"],))
                n_new += 1
        if n_new:
            c.execute("INSERT INTO pay_log(aid, openid, out_trade_no) VALUES(?,?,?)",
                      ("*batch*", openid, (out_trade_no or "*batch*")[:64]))
        return len(rows)


def mark_export_paid_many(openid: str, aids: list, out_trade_no: str = "") -> int:
    """批量导出解锁（快照制，v0.8.0 审计 MEDIUM-4 根治）：只标记签名时刻快照 ∩ 仍未
    解锁的条目；快照之外新完成的咨询留给下一单。返回解锁后的总条数（幂等重跑安全；
    pay_log 仅在真有新解锁时落行）。"""
    if not aids:
        return 0
    init()
    marks = [(a,) for a in aids]
    with _LOCK, _db() as c:
        rows = c.execute(
            "SELECT id, export_paid FROM answers WHERE openid=? AND status='ready'",
            (openid,),
        ).fetchall()
        want = {r["id"]: r["export_paid"] for r in rows}
        n_new = 0
        for a in aids:
            if a in want and not want[a]:   # 在快照内、本人、ready、未解锁
                c.execute("UPDATE answers SET export_paid=1 WHERE id=?", (a,))
                n_new += 1
        if n_new:
            c.execute("INSERT INTO pay_log(aid, openid, out_trade_no) VALUES(?,?,?)",
                      ("*batch*", openid, (out_trade_no or "*batch*")[:64]))
        return sum(1 for a in aids if a in want)


# ── v0.8.0 支付订单（对抗审查 CRITICAL-2/HIGH-3）：签名即落单，回调凭单核验 ──
def create_pay_order(out_trade_no: str, openid: str, kind: str, aid: str = "",
                     aid_list: str = "", buy_quantity: int = 1, total_fen: int = 0) -> bool:
    """签名腿落单（otn 主键防重）；已存在同号单返回 False。"""
    init()
    with _LOCK, _db() as c:
        if c.execute("SELECT 1 FROM pay_order WHERE out_trade_no=?",
                     (out_trade_no,)).fetchone():
            return False
        c.execute(
            "INSERT INTO pay_order(out_trade_no, openid, kind, aid, aid_list,"
            " buy_quantity, total_fen) VALUES(?,?,?,?,?,?,?)",
            ((out_trade_no or "")[:64], openid, kind, (aid or "")[:32],
             (aid_list or "")[:2000], int(buy_quantity), int(total_fen)))
        return True


def get_pay_order(out_trade_no: str) -> Optional[dict]:
    init()
    with _db() as c:
        row = c.execute(
            "SELECT * FROM pay_order WHERE out_trade_no=?", (out_trade_no,)).fetchone()
        return dict(row) if row else None


def open_pay_order(openid: str, kind: str, aid: str = "") -> Optional[dict]:
    """本人最近一张 signed 未付单（同一目标重复发起时复用同一 otn——已付未标记
    走查单补标记，未付走同一单续付，根治二次扣款；HIGH-3）。"""
    init()
    with _db() as c:
        sql = ("SELECT * FROM pay_order WHERE openid=? AND kind=? AND status='signed'"
               " AND aid=? ORDER BY rowid DESC LIMIT 1")
        row = c.execute(sql, (openid, kind, aid or "")).fetchone()
        return dict(row) if row else None


def mark_order_paid(out_trade_no: str) -> bool:
    """订单转 paid（幂等：仅 signed → paid 真；重复回调/已 paid 返回 False 不重复记账）。"""
    init()
    with _LOCK, _db() as c:
        cur = c.execute(
            "UPDATE pay_order SET status='paid',"
            " paid_at=datetime('now','localtime')"
            " WHERE out_trade_no=? AND status='signed'", (out_trade_no,))
        return bool(getattr(cur, "rowcount", 0))


# ── v0.9.0 报告商城解锁（kind='report'，pay_order.aid 存 sku）──
def report_unlocked_skus(openid: str) -> set:
    """本人已解锁报告 sku 集合（目录/详情页标记用）。"""
    init()
    with _db() as c:
        rows = c.execute(
            "SELECT sku FROM report_unlocks WHERE openid=?", (openid,)).fetchall()
        return {r["sku"] for r in rows}


def mark_report_paid(openid: str, sku: str, out_trade_no: str = "") -> bool:
    """报告解锁标记（幂等：重复回调恒 True；首次落 pay_log 对账行）。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute(
            "SELECT 1 FROM report_unlocks WHERE openid=? AND sku=?",
            (openid, sku)).fetchone()
        if row is None:
            c.execute(
                "INSERT INTO report_unlocks(openid, sku, out_trade_no) VALUES(?,?,?)",
                (openid, sku, (out_trade_no or sku)[:64]))
            c.execute(
                "INSERT INTO pay_log(aid, openid, out_trade_no) VALUES(?,?,?)",
                (sku, openid, (out_trade_no or sku)[:64]))
        return True


def history(openid: str, limit: int = 20) -> list:
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT id, question, substr(answer_full,1,60) AS preview, liked, criticized,"
            " status, unlocked, shared, export_paid, created_at FROM answers WHERE openid=?"
            " ORDER BY rowid DESC LIMIT ?",
            (openid, limit),
        )
        return [dict(r) for r in cur.fetchall()]


def history_all(openid: str) -> list:
    """全部已完成答案（批量导出用，时间正序）。"""
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT * FROM answers WHERE openid=? AND status='ready'"
            " ORDER BY rowid ASC",
            (openid,),
        )
        out = []
        for r in cur.fetchall():
            d = dict(r)
            d["citations"] = json.loads(d.get("citations") or "[]")
            out.append(d)
        return out


# ── v0.5.0 AI 优化提问：每用户每日计数（护共享 KB 免费池） ──
def consume_optimize(openid: str) -> bool:
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        today = _today()
        if row["opt_day"] != today:
            c.execute("UPDATE users SET opt_day=?, opt_used=0 WHERE openid=?", (today, openid))
            opt_used = 0
        else:
            opt_used = row["opt_used"]
        if opt_used >= config.OPTIMIZE_DAILY_CAP:
            return False
        c.execute("UPDATE users SET opt_used=opt_used+1 WHERE openid=?", (openid,))
        return True


def refund_optimize(openid: str) -> None:
    """优化失败退计数。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["opt_day"] == _today() and row["opt_used"] > 0:
            c.execute("UPDATE users SET opt_used=opt_used-1 WHERE openid=?", (openid,))


def opt_used_today(openid: str) -> int:
    init()
    with _db() as c:
        row = _row_user(c, openid)
        return row["opt_used"] if row["opt_day"] == _today() else 0


# ── v0.5.0 锅圈：公共热点问题展区 ──
_MD_STRIP_RE = re.compile(
    r"(\[\[[^\[\]†]*†\d+\]\]"      # [[书名†页]] 引用标记
    r"|\*\*|__|`{1,3}"              # 加粗/行内代码/围栏
    r"|^#{1,6}\s*"                  # 标题井号
    r"|^\s*[-*+]\s+"                # 无序列表符
    r"|^\s*\d+\.\s+"                # 有序列表符
    r"|^\s*>\s?"                    # 引用符
    r"|\|)",                        # 表格竖线
    re.MULTILINE)


def strip_md(text: str) -> str:
    """纯文本化（锅圈预览用）：去 Markdown 特有符号，压空白。"""
    t = _MD_STRIP_RE.sub("", (text or ""))
    return re.sub(r"[ \t]+", " ", t.replace("\r", "\n")).strip()


def pot_add(aid: str, sort: int = 0) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO pot_items(aid, sort) VALUES(?,?)"
            " ON CONFLICT(aid) DO UPDATE SET sort=excluded.sort",
            (aid, sort))


def pot_remove(aid: str) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute("DELETE FROM pot_items WHERE aid=?", (aid,))


def pot_list() -> list:
    """锅圈列表（v0.7.0 用户令）：200 字纯文本预览；排序=时间最新优先，
    兼顾互动（每份互动≈半天新鲜度：有用×2 + 共享×1 + 海报×1）。"""
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT a.id AS aid, a.question, a.answer_full, a.created_at,"
            " (SELECT COUNT(*) FROM rewards r"
            "  WHERE r.aid=a.id AND r.action='like') AS likes,"
            " a.views, a.shares, a.shared"
            " FROM pot_items p JOIN answers a ON a.id=p.aid"
            " WHERE a.status='ready' AND a.answer_full != ''"
        )
        rows = [dict(r) for r in cur.fetchall()]
        for r in rows:
            try:
                ts = time.mktime(time.strptime(r["created_at"] or "", "%Y-%m-%d %H:%M:%S"))
            except ValueError:
                ts = 0.0
            hot = (r["likes"] or 0) * 2 + (1 if r["shared"] else 0)
            r["_score"] = ts + hot * 43200.0
        rows.sort(key=lambda r: r["_score"], reverse=True)
        return [{
            "id": r["aid"],
            "question": r["question"],
            "preview": strip_md(r["answer_full"] or "")[:config.POT_PREVIEW_CHARS],
            "likes": r["likes"] or 0,
            "views": r["views"] or 0,
            "shares": r["shares"] or 0,
            "full_chars": len(r["answer_full"] or ""),
            "created_at": r["created_at"],
        } for r in rows]


def pot_liked_by(aid: str, openid: str) -> bool:
    return reward_exists(openid, aid, "like")


def pot_exists(question: str) -> bool:
    """播种幂等：同一问题已入锅则跳过（跨日补种用）。"""
    init()
    with _db() as c:
        row = c.execute(
            "SELECT 1 FROM answers WHERE openid=? AND question=? LIMIT 1",
            (config.POT_OPENID, question)).fetchone()
        return row is not None


# ── v0.7.0 用户共享入锅圈：共享赠 1 次 / 取消共享扣 1 次 ──
def share_on(aid: str, openid: str) -> bool:
    """本人的已完成答案 → 共享进锅圈 + 赠 1 次咨询机会。返回 False=不可共享。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute(
            "SELECT openid, status, shared, length(answer_full) AS alen"
            " FROM answers WHERE id=?", (aid,)).fetchone()
        if (row is None or row["openid"] != openid or row["openid"] == config.POT_OPENID
                or row["status"] != "ready" or not row["alen"] or row["shared"]):
            return False
        c.execute("UPDATE answers SET shared=1 WHERE id=?", (aid,))
        c.execute(
            "INSERT INTO pot_items(aid, sort) VALUES(?, 0)"
            " ON CONFLICT(aid) DO UPDATE SET sort=0", (aid,))
        c.execute("UPDATE users SET bonus_earned=bonus_earned+1 WHERE openid=?", (openid,))
        return True


def share_off(aid: str, openid: str) -> bool:
    """取消共享：撤出锅圈 + 扣 1 次咨询机会（未共享过 → False）。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute(
            "SELECT openid, shared FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid or not row["shared"]:
            return False
        c.execute("UPDATE answers SET shared=0 WHERE id=?", (aid,))
        c.execute("DELETE FROM pot_items WHERE aid=?", (aid,))
        row_u = c.execute(
            "SELECT bonus_earned, bonus_used FROM users WHERE openid=?", (openid,)).fetchone()
        if row_u is not None and row_u["bonus_earned"] > 0:
            c.execute(
                "UPDATE users SET bonus_earned=bonus_earned-1 WHERE openid=?", (openid,))
        return True


def save_pot_report(aid: str, openid: str, reason: str) -> bool:
    """v0.7.4 提审合规：锅圈内容举报（每用户每条限一次）。False=条目不存在或重复举报。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT 1 FROM pot_items WHERE aid=?", (aid,)).fetchone()
        if row is None:
            return False
        try:
            c.execute(
                "INSERT INTO pot_reports(aid, openid, reason) VALUES(?,?,?)",
                (aid, openid, reason))
        except sqlite3.IntegrityError:
            return False
    return True


def save_pot_answer(question: str, answer_full: str, citations: list,
                    sort: int = 0, elapsed: float = 0.0, via: str = "kb") -> str:
    """锅圈条目落库：answers 行（POT_OPENID · ready · unlocked）+ pot_items 登记。
    v0.7.3：via 参数区分 kb（KB 接地）/ pot_zhipu（智谱免费链）——锅圈扩容不烧 KB 积分。"""
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO answers(id, openid, question, answer_full, citations, via,"
            " status, unlocked, elapsed_sec) VALUES(?,?,?,?,?,?,'ready',1,?)",
            (aid, config.POT_OPENID, question, answer_full,
             json.dumps(citations, ensure_ascii=False), via, elapsed),
        )
        c.execute("INSERT INTO pot_items(aid, sort) VALUES(?,?)", (aid, sort))
    return aid


def any_pending() -> bool:
    """是否有引擎在跑的问题（播种器据此让路，两进程经 DB 串行化）。"""
    init()
    with _db() as c:
        row = c.execute("SELECT 1 FROM answers WHERE status='pending' LIMIT 1").fetchone()
        return row is not None


# ── v0.6.0 追问（免费智谱接地）：双日限原子闸 + 异步终态回填 ──
def _bj_midnight_ts() -> float:
    """最近一个北京时间 0 点的 unix 时间戳（追问日限清零时点，与配额同口径）。"""
    now = time.time()
    return now - ((now + 8 * 3600) % 86400)


def create_followup(aid: str, openid: str, question: str) -> tuple:
    """落一条追问（pending）。双日限原子检查：①每答案每人 ≤FOLLOWUP_PER_ANSWER_DAILY
    ②每人全局 ≤FOLLOWUP_GLOBAL_DAILY（北京时间 0 点清零）。
    返回 (fid, left_answer, left_global)；超限返回 (None, 原因, None)。"""
    init()
    midnight = _bj_midnight_ts()
    with _LOCK, _db() as c:
        n_ans = c.execute(
            "SELECT COUNT(*) FROM followups WHERE aid=? AND openid=? AND created_at>=?",
            (aid, openid, midnight)).fetchone()[0]
        if n_ans >= config.FOLLOWUP_PER_ANSWER_DAILY:
            return None, "per_answer", None
        n_all = c.execute(
            "SELECT COUNT(*) FROM followups WHERE openid=? AND created_at>=?",
            (openid, midnight)).fetchone()[0]
        if n_all >= config.FOLLOWUP_GLOBAL_DAILY:
            return None, "global", None
        cur = c.execute(
            "INSERT INTO followups(aid, openid, question, created_at) VALUES(?,?,?,?)",
            (aid, openid, question, time.time()))
        return (cur.lastrowid,
                config.FOLLOWUP_PER_ANSWER_DAILY - n_ans - 1,
                config.FOLLOWUP_GLOBAL_DAILY - n_all - 1)


def finish_followup(fid: int, answer: str) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE followups SET status='ready', answer=?, error_text='' WHERE id=?",
            (answer, fid))


def followup_left(aid: str, openid: str) -> tuple:
    """(该答案今日追问剩余, 全局今日剩余)——供前端配额展示。"""
    init()
    midnight = _bj_midnight_ts()
    with _db() as c:
        n_ans = c.execute(
            "SELECT COUNT(*) FROM followups WHERE aid=? AND openid=? AND created_at>=?",
            (aid, openid, midnight)).fetchone()[0]
        n_all = c.execute(
            "SELECT COUNT(*) FROM followups WHERE openid=? AND created_at>=?",
            (openid, midnight)).fetchone()[0]
        return (max(0, config.FOLLOWUP_PER_ANSWER_DAILY - n_ans),
                max(0, config.FOLLOWUP_GLOBAL_DAILY - n_all))


def fail_followup(fid: int, err: str) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE followups SET status='error', error_text=? WHERE id=?",
            ((err or "")[:300], fid))


def list_followups(aid: str, openid: str) -> list:
    """本人在本答案下的追问对话（时间正序=对话序）。"""
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT id, question, answer, status, error_text, created_at"
            " FROM followups WHERE aid=? AND openid=? ORDER BY id ASC",
            (aid, openid))
        out = []
        for r in cur.fetchall():
            d = dict(r)
            d["answer"] = d.get("answer") or ""       # mysql NULL 归一（sqlite 恒 ''）
            d["error_text"] = d.get("error_text") or ""
            out.append(d)
        return out


# ── v0.6.0 要点速览/相关问题（digest）：每答案生成一次永久缓存 ──
def get_digest(aid: str) -> tuple:
    """返回 (tldr_list, related_list)；未生成过=([], [])。"""
    init()
    with _db() as c:
        row = c.execute("SELECT tldr, related FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None:
            return [], []
        try:
            tldr = json.loads(row["tldr"] or "[]")
        except ValueError:
            tldr = []
        try:
            related = json.loads(row["related"] or "[]")
        except ValueError:
            related = []
        return tldr, related


def save_digest(aid: str, tldr: list, related: list) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE answers SET tldr=?, related=? WHERE id=?",
            (json.dumps(tldr, ensure_ascii=False),
             json.dumps(related, ensure_ascii=False), aid))


# ── v0.6.0 分享海报：PNG 缓存（独立表，不进 answers 宽行）──
# v0.7.0：按 env 版本隔离（trial/release 切换自动失效重生成，防旧码海报外流）
def get_poster(aid: str, env: str = "") -> Optional[bytes]:
    init()
    with _db() as c:
        row = c.execute(
            "SELECT png FROM posters WHERE aid=? AND env=?", (aid, env)).fetchone()
        return bytes(row["png"]) if row and row["png"] else None


def save_poster(aid: str, png: bytes, env: str = "") -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO posters(aid, png, created_at, env) VALUES(?,?,?,?)"
            " ON CONFLICT(aid) DO UPDATE SET png=excluded.png, env=excluded.env",
            (aid, png, time.time(), env))


# ── v0.7.0 依据来源全文展开：智谱接地生成，按 (aid, n) 永久缓存 ──
def get_citation_ft(aid: str, n: int) -> str:
    init()
    with _db() as c:
        row = c.execute(
            "SELECT text FROM citations_ft WHERE aid=? AND n=?", (aid, n)).fetchone()
        return row["text"] if row else ""


def save_citation_ft(aid: str, n: int, text: str) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO citations_ft(aid, n, text, created_at) VALUES(?,?,?,?)"
            " ON CONFLICT(aid, n) DO UPDATE SET text=excluded.text",
            (aid, n, text, time.time()))


# ── v0.9.4 发票（1009 用户令：累计消费满 ¥200 可申请增值税专用发票）──
def paid_total_fen(openid: str) -> int:
    """累计已支付金额（分）：pay_order status='paid' 全订单求和（导出+报告）。"""
    init()
    with _db() as c:
        row = c.execute(
            "SELECT COALESCE(SUM(total_fen),0) AS s FROM pay_order"
            " WHERE openid=? AND status='paid'", (openid,)).fetchone()
        return int(row["s"] or 0) if row else 0


def invoice_apps(openid: str) -> list:
    """本人发票申请记录（新→旧）。"""
    init()
    with _db() as c:
        rows = c.execute(
            "SELECT id,total_fen,title,tax_no,addr_phone,bank_acct,email,note,status,created_at"
            " FROM invoice_apps WHERE openid=? ORDER BY id DESC", (openid,)).fetchall()
        return [dict(r) for r in rows]


def create_invoice_app(openid: str, total_fen: int, title: str, tax_no: str,
                       addr_phone: str, bank_acct: str, email: str, note: str) -> bool:
    """落一条申请单（status='pending'，运营侧开票后人工改状态）。"""
    init()
    with _LOCK, _db() as c:
        cur = c.execute(
            "INSERT INTO invoice_apps"
            " (openid,total_fen,title,tax_no,addr_phone,bank_acct,email,note)"
            " VALUES (?,?,?,?,?,?,?,?)",
            (openid, total_fen, title, tax_no, addr_phone, bank_acct, email, note))
        return bool(getattr(cur, "lastrowid", 0) or getattr(cur, "rowcount", 0))


# ── v0.9.6 真机遥测（1009 真机根因战）：匿名执行轨迹落库/读数 ──
def save_telemetry(event: str, boot: str, ver: str, extra: str) -> bool:
    """落一条遥测事件；容量护持——每 50 条修剪到 TELEMETRY_KEEP_ROWS
    （公开写端点防灌水膨胀；修剪失败不伤写入）。"""
    init()
    with _LOCK, _db() as c:
        cur = c.execute(
            "INSERT INTO telemetry_events (event,boot,ver,extra) VALUES (?,?,?,?)",
            (event, boot, ver, extra))
        rid = int(getattr(cur, "lastrowid", 0) or 0)
        if rid and rid % 50 == 0:
            try:
                c.execute("DELETE FROM telemetry_events WHERE id <= ? - ?",
                          (rid, config.TELEMETRY_KEEP_ROWS))
            except sqlite3.OperationalError:
                pass
        return bool(rid)


def recent_telemetry(limit: int = 200) -> list:
    """最新遥测事件（新→旧；运营读数腿，端点层鉴权）。"""
    init()
    with _db() as c:
        rows = c.execute(
            "SELECT id,event,boot,ver,extra,created_at"
            " FROM telemetry_events ORDER BY id DESC LIMIT ?", (limit,)).fetchall()
        return [dict(r) for r in rows]
