# -*- coding: utf-8 -*-
"""一次性搬运：ECS SQLite → CloudBase MySQL（v0.8.0 云托管迁移）。

用法（MYSQL_* 环境变量指向目标库；DB_KIND 无需预设，脚本自置 mysql）：
    python scripts/migrate_sqlite_to_mysql.py <ECS 端 db.sqlite 路径> [--fresh]

- 建表：复用引擎运行时自举（store.init，DDL 与引擎同源，不漂移）
- 搬运：全部表按 sqlite rowid 序插入（answers 插入序即 mysql rowid 序，history
  排序语义保持）；自增 id（rewards/followups/criticisms）原值保留
- 防呆：目标表非空即拒（默认）；--fresh 先 TRUNCATE 再装
"""
from __future__ import annotations

import argparse
import os
import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

# 引擎侧全部表（含运行时惰性建表的 criticisms / pay_log）
TABLES = ("users", "answers", "mp_session", "rewards", "pot_items",
          "followups", "posters", "pot_reports", "citations_ft",
          "criticisms", "pay_log")
# 惰性表的建表文本与 store.save_criticism / store.mark_paid 同源（经 _sql 方言转换）
_LAZY_DDL = (
    "CREATE TABLE IF NOT EXISTS criticisms"
    "(id INTEGER PRIMARY KEY AUTOINCREMENT, aid TEXT, openid TEXT, text TEXT,"
    " score INTEGER, refund_tier TEXT, created_at TEXT DEFAULT (datetime('now','localtime')))",
    "CREATE TABLE IF NOT EXISTS pay_log(aid TEXT, openid TEXT, out_trade_no TEXT,"
    " created_at TEXT DEFAULT (datetime('now','localtime')))",
)
_CHUNK = 500


def _tables_count(c) -> dict:
    return {t: c.execute(f"SELECT COUNT(*) FROM {t}").fetchone()[0] for t in TABLES}


def main() -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:  # noqa: BLE001 — 旧终端无 reconfigure 时按默认编码打印
        pass
    ap = argparse.ArgumentParser(description="SQLite → MySQL 一次性搬运（ECS → CloudBase）")
    ap.add_argument("sqlite_path", help="ECS 端 SQLite 库文件路径")
    ap.add_argument("--fresh", action="store_true",
                    help="先 TRUNCATE 目标表再装（默认：目标非空即拒，防重复灌数）")
    args = ap.parse_args()

    src = Path(args.sqlite_path)
    if not src.is_file():
        print(f"[abort] SQLite 文件不存在: {src}")
        return 2
    if not (os.environ.get("MYSQL_HOST") and os.environ.get("MYSQL_DATABASE")):
        print("[abort] 缺 MYSQL_HOST / MYSQL_DATABASE 环境变量（目标库连接信息）")
        return 2

    os.environ["DB_KIND"] = "mysql"   # 须在 import store 之前置位（config 读环境变量）
    from qianwen_engine import store  # noqa: E402 — 建表/连接复用引擎同源实现

    lite = sqlite3.connect(f"file:{src.as_posix()}?mode=ro", uri=True)  # 只读打开，绝不写源库
    lite.row_factory = sqlite3.Row
    src_tables = {r["name"] for r in lite.execute(
        "SELECT name FROM sqlite_master WHERE type='table'")}

    store.init()                      # 建表（IF NOT EXISTS，幂等；DDL 与引擎运行时同源）
    with store._db() as c:            # noqa: SLF001 — 随引擎发布的配套脚本，复用连接层
        for ddl in _LAZY_DDL:
            c.execute(ddl)
        counts = _tables_count(c)
    nonempty = {t: n for t, n in counts.items() if n}
    if nonempty and not args.fresh:
        print(f"[abort] 目标库非空（防重复灌数）：{nonempty}；确认重装请加 --fresh")
        return 2
    if nonempty and args.fresh:
        with store._db() as c:        # noqa: SLF001
            for t in reversed(TABLES):
                c.execute(f"TRUNCATE TABLE {t}")
        print(f"[fresh] 已清空目标表: {sorted(nonempty)}")

    total = 0
    for t in TABLES:
        if t not in src_tables:
            print(f"[skip] {t}: 源库无此表")
            continue
        cols = [r["name"] for r in lite.execute(f"PRAGMA table_info({t})")]
        rows = lite.execute(
            f"SELECT {', '.join(cols)} FROM {t} ORDER BY rowid").fetchall()
        if rows:
            ph = ",".join(["%s"] * len(cols))
            with store._db() as c:    # noqa: SLF001
                for i in range(0, len(rows), _CHUNK):
                    c.executemany(
                        f"INSERT INTO {t} ({', '.join(cols)}) VALUES ({ph})",
                        [tuple(r) for r in rows[i:i + _CHUNK]])
        print(f"[ok] {t}: {len(rows)} 行")
        total += len(rows)
    print(f"[done] 共搬运 {total} 行 → MySQL {os.environ.get('MYSQL_DATABASE')}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
