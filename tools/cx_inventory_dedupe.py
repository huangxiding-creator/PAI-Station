# -*- coding: utf-8 -*-
"""一次性手术：inventory.files 路径双写去重（2026-09-17 I 组发现）。

588,259 行中 285,320 行系 E:\\a\\b / E:/a/b 斜杠形态双写；gone 统计同被污染。
策略：按归一 path 分组，每组保留一行（优先非 gone → last_seen 新 → path 短），
保留行 path 统一为正斜杠归一形（与 index.chunks 下游一致），其余删除。
先备份 inventory.db → inventory.db.bak-20260917 再执行。
用法：python tools/cx_inventory_dedupe.py [--apply]（默认 dry-run）
"""
from __future__ import annotations

import shutil
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
DB = REPO / "data/local_index/inventory.db"
BAK = DB.with_suffix(".db.bak-20260917")


def norm(p: str) -> str:
    s = p.replace("\\", "/")
    while "//" in s:
        s = s.replace("//", "/")
    return s


def main() -> int:
    apply = "--apply" in sys.argv
    conn = sqlite3.connect(str(DB))
    rows = conn.execute(
        "SELECT path, status, last_seen FROM files").fetchall()
    groups: dict[str, list[tuple[str, str, float]]] = {}
    for path, status, last_seen in rows:
        groups.setdefault(norm(path), []).append((path, status, last_seen or 0))
    dups = {k: v for k, v in groups.items() if len(v) > 1}
    keep_sql, del_args = [], []
    for key, members in dups.items():
        members.sort(key=lambda m: (m[1] == "gone", -m[2], len(m[0])))
        keep_sql.append((key, members[0][0]))
        del_args += [(m[0],) for m in members[1:]]
    gone_revive = sum(1 for k, v in dups.items()
                      if v[0][1] != "gone"          # 保留行非 gone
                      and all(m[1] == "gone" or m is v[0] for m in v))
    print(f"总行 {len(rows)} / 归一唯一 {len(groups)} / 重复组 {len(dups)}"
          f" / 待删 {len(del_args)} 行（保留 {len(groups)} 行）")
    print(f"其中因形态切换被误标 gone 的组：约 {gone_revive}")
    if not apply:
        print("dry-run：加 --apply 执行（会先备份）")
        return 0
    if not BAK.exists():
        shutil.copy2(DB, BAK)
        print(f"已备份 → {BAK.name}")
    with conn:
        # 保留行统一为归一形（无变化则零开销）
        conn.executemany(
            "UPDATE files SET path=? WHERE path=?", keep_sql)
        conn.executemany("DELETE FROM files WHERE path=?", del_args)
    after = conn.execute("SELECT COUNT(*) FROM files").fetchone()[0]
    stats = conn.execute(
        "SELECT status, COUNT(*) FROM files GROUP BY status").fetchall()
    print(f"手术后行数 {after}；状态分布 {stats}")
    conn.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
