# -*- coding: utf-8 -*-
"""cx_search 驱动：全盘关键词检索（FTS5）。

用法：
  python tools/cx_search.py 白龟湖
  python tools/cx_search.py "黄藏寺 变电站" --files 10 --samples 3
多词空格分隔 = AND。
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.search import (  # noqa: E402
    aggregate_by_file,
    keyword_window,
    run_query,
)

INDEX = REPO / "data/local_index/index.db"


def main() -> int:
    ap = argparse.ArgumentParser(description="全盘文件关键词检索（FTS5+LIKE兜底）")
    ap.add_argument("query", help="关键词，空格分隔=AND；短词(<3字)自动LIKE兜底")
    ap.add_argument("--files", type=int, default=20, help="最多显示文件数")
    ap.add_argument("--samples", type=int, default=2, help="每文件样本行数")
    ap.add_argument("--limit", type=int, default=500, help="命中块上限")
    a = ap.parse_args()

    if not INDEX.exists():
        print(f"索引不存在：{INDEX}")
        return 1
    rows, mode = run_query(INDEX, a.query, limit=a.limit)
    agg = aggregate_by_file(rows)
    total = sum(len(v) for _, v in agg)
    print(f"「{a.query}」[{mode}] → {total} 命中块 / {len(agg)} 文件"
          f"（块上限 {a.limit}）")
    words = a.query.split()
    for path, texts in agg[: a.files]:
        print(f"\n[{len(texts)}] {path}")
        for t in texts[: a.samples]:
            print("   " + keyword_window(t, words))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
