# -*- coding: utf-8 -*-
"""提取优先级重算：pending 全量打分入列 + 缓存出局 + top 队列报表。

用法：python tools/cx_prioritize.py [--apply]（默认 dry-run 只出报表）
"""
from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.priority import score_file, should_skip  # noqa: E402

DB = REPO / "data/local_index/inventory.db"


def main() -> int:
    apply = "--apply" in sys.argv
    conn = sqlite3.connect(str(DB))
    cols = [r[1] for r in conn.execute("PRAGMA table_info(files)")]
    for col, ddl in (("priority", "REAL"), ("priority_reason", "TEXT")):
        if col not in cols:
            conn.execute(f"ALTER TABLE files ADD COLUMN {col} {ddl}")
    conn.commit()

    rows = conn.execute(
        "SELECT path, size, mtime FROM files WHERE status='pending'"
    ).fetchall()
    scored, skips = [], 0
    for path, size, mtime in rows:
        s, reason = score_file(path, size or 0, mtime or 0)
        if should_skip(s):
            skips += 1
        scored.append((s, reason, path))
    scored.sort(reverse=True)

    print(f"pending {len(rows)}：缓存出局建议 {skips}，其余 {len(rows)-skips} 入队")
    print("\n== 提取优先队 Top 20 ==")
    for s, reason, path in scored[:20]:
        print(f"{s:6.1f} [{reason}] {path[:90]}")
    print("\n== 队尾（最低价值）5 ==")
    for s, reason, path in scored[-5:]:
        print(f"{s:6.1f} [{reason}] {path[:90]}")

    if not apply:
        print("\ndry-run：--apply 写入 priority 列并跳过缓存")
        conn.close()
        return 0
    with conn:
        conn.executemany(
            "UPDATE files SET priority=?, priority_reason=? WHERE path=?",
            [(s, reason, p) for s, reason, p in scored])
        conn.execute(
            "UPDATE files SET status='skipped', priority_reason='cache-skip' "
            "WHERE status='pending' AND priority<=-50")
    left = conn.execute(
        "SELECT COUNT(*) FROM files WHERE status='pending'").fetchone()[0]
    print(f"\n已写入：pending 剩 {left}（skipped +{skips}）")
    conn.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
