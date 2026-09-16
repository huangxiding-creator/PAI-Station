# -*- coding: utf-8 -*-
"""存量 FTS 一次性补 Contextual 元前缀（幂等，二跑零成本）。

用法：python tools/cx_fts_prefix_rebuild.py
"""
from __future__ import annotations

import shutil
import sqlite3
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.sense.localfiles.store import rebuild_fts_prefix  # noqa: E402

INDEX_DB = REPO / "data/local_index/index.db"


def main() -> int:
    if not INDEX_DB.exists():
        print("index.db 不存在")
        return 1
    free_gb = shutil.disk_usage(INDEX_DB.parent).free / (1 << 30)
    size_gb = INDEX_DB.stat().st_size / (1 << 30)
    print(f"index.db {size_gb:.1f}GB，磁盘剩 {free_gb:.0f}GB")
    if free_gb < size_gb:  # 新 fts 表约与旧表同级，余量须覆盖
        print("磁盘余量不足（须 ≥ 现库大小），中止")
        return 1
    conn = sqlite3.connect(str(INDEX_DB))
    conn.row_factory = sqlite3.Row
    # 存量 chunks.path 反斜杠旧形态整体归一（已验双形态零冲突）：
    # 与 files 表同形态，JOIN/聚合不再分叉
    n_back = conn.execute(
        "SELECT COUNT(*) FROM chunks WHERE path LIKE '%'||char(92)||'%'"
    ).fetchone()[0]
    if n_back:
        t0 = time.time()
        with conn:
            conn.execute(
                "UPDATE chunks SET path = replace(replace("
                "path, char(92), '/'), '//', '/')")
        print(f"chunks.path 归一 {n_back} 行，耗时 {(time.time()-t0)/60:.1f} 分钟")
        with conn:  # 路径形态变了 → 强制重建 fts
            conn.execute("DELETE FROM meta WHERE key='fts_prefix'")
    n = conn.execute("SELECT COUNT(*) FROM chunks").fetchone()[0]
    print(f"chunks {n} 行，开始重建（期间旧表可查，换名一瞬切换）…")
    t0 = time.time()
    total = rebuild_fts_prefix(conn)
    dt = time.time() - t0
    if total == 0:
        print("meta 已标记，无需重建（幂等跳过）")
    else:
        print(f"重建 {total} 行，耗时 {dt/60:.1f} 分钟")
    # 抽检：路径词应命中正文无该词的块
    sample = conn.execute(
        "SELECT substr(text,1,40) t FROM chunks_fts LIMIT 1").fetchone()
    print(f"抽检 fts 首行：{sample['t']}")
    conn.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
