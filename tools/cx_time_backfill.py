# -*- coding: utf-8 -*-
"""存量 files 行回填 birthtime/atime（NTFS 三时间戳 K 组件）。

用法：python tools/cx_time_backfill.py
只回填 birthtime=0 的活文件；下轮全量扫描后新列自然常驻。
"""
from __future__ import annotations

import os
import sqlite3
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))
INV = REPO / "data/local_index/inventory.db"
WORKERS = 16


def stat_one(path: str) -> tuple[str, float, float] | None:
    try:
        st = os.stat(path)
    except OSError:
        return None  # 消失文件下轮扫描自然 gone
    return (path, float(getattr(st, "st_birthtime", st.st_ctime)),
            float(st.st_atime))


def main() -> int:
    from paistation.sense.localfiles.inventory import Inventory
    inv = Inventory(INV)._db  # 开库即自动补列（birthtime/atime）
    todo = [r[0] for r in inv.execute(
        "SELECT path FROM files WHERE status!='gone' AND birthtime=0"
    ).fetchall()]
    print(f"待回填 {len(todo)} 行（birthtime=0 活文件）")
    t0 = time.time()
    done = missing = 0
    with ThreadPoolExecutor(max_workers=WORKERS) as pool:
        for res in pool.map(stat_one, todo, chunksize=256):
            if res is None:
                missing += 1
                continue
            path, bt, at = res
            inv.execute(
                "UPDATE files SET birthtime=?, atime=? WHERE path=?",
                (bt, at, path))
            done += 1
            if done % 50_000 == 0:
                inv.commit()
                print(f"  {done} 行…")
    inv.commit()
    dt = time.time() - t0
    print(f"回填 {done} 行，消失 {missing}，耗时 {dt/60:.1f} 分钟")
    # 洞察样张：最老/最新的十个创建时间
    print("\n== 最早创建 5 件 ==")
    for path, bt in inv.execute(
            "SELECT path, birthtime FROM files WHERE birthtime>0"
            " ORDER BY birthtime LIMIT 5"):
        print(f"{time.strftime('%Y-%m-%d', time.localtime(bt))}  {path[:70]}")
    print("\n== 最新创建 5 件 ==")
    for path, bt in inv.execute(
            "SELECT path, birthtime FROM files WHERE birthtime>0"
            " ORDER BY birthtime DESC LIMIT 5"):
        print(f"{time.strftime('%Y-%m-%d', time.localtime(bt))}  {path[:70]}")
    inv.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
