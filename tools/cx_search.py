# -*- coding: utf-8 -*-
"""cx_search 驱动：全盘关键词检索（FTS5）+ 卷宗混合路由（--dossier）。

用法：
  python tools/cx_search.py 白龟湖
  python tools/cx_search.py "黄藏寺 变电站" --files 10 --samples 3
  python tools/cx_search.py "我的工具付费观" --dossier
多词空格分隔 = AND；--dossier 走卷宗通道（keyword×语义 RRF 深池融合，
嵌入服务不在位自动降级 keyword）。
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
    facet_exts,
    filter_rows,
    keyword_window,
    run_query,
)

INDEX = REPO / "data/local_index/index.db"


def main() -> int:
    ap = argparse.ArgumentParser(description="全盘文件关键词检索（FTS5+LIKE兜底+facets）")
    ap.add_argument("query", help="关键词，空格分隔=AND；短词(<3字)自动LIKE兜底")
    ap.add_argument("--files", type=int, default=20, help="最多显示文件数")
    ap.add_argument("--samples", type=int, default=2, help="每文件样本行数")
    ap.add_argument("--limit", type=int, default=500, help="命中块上限")
    ap.add_argument("--ext", help="按扩展名过滤，如 .pdf")
    ap.add_argument("--dir", help="按路径包含过滤，如 白龟湖")
    ap.add_argument("--facets", action="store_true", help="打印命中块扩展名分布")
    ap.add_argument("--dossier", action="store_true",
                    help="卷宗通道：SELF_PROFILE 策展卷宗混合路由 top-k")
    ap.add_argument("--k", type=int, default=8, help="--dossier 返回节数")
    a = ap.parse_args()

    if a.dossier:
        return run_dossier(a)

    if not INDEX.exists():
        print(f"索引不存在：{INDEX}")
        return 1
    rows, mode = run_query(INDEX, a.query, limit=a.limit)
    rows = filter_rows(rows, ext=a.ext, dir_contains=a.dir)
    agg = aggregate_by_file(rows)
    total = sum(len(v) for _, v in agg)
    print(f"「{a.query}」[{mode}] → {total} 命中块 / {len(agg)} 文件"
          f"（块上限 {a.limit}）")
    if a.facets:
        dist = "  ".join(f"{e}×{n}" for e, n in facet_exts(rows))
        print(f"扩展名分布：{dist}")
    words = a.query.split()
    for path, texts in agg[: a.files]:
        print(f"\n[{len(texts)}] {path}")
        for t in texts[: a.samples]:
            print("   " + keyword_window(t, words))
    return 0


def run_dossier(a) -> int:
    """卷宗混合路由：keyword 深池×语义深池 RRF → top-k 节。"""
    from paistation.cx.dossier import load_dossiers
    from paistation.cx.semantic import SemanticIndex, hybrid_route
    from paistation.sense.localfiles.embedder import make_ollama_embedder

    sp = REPO / "SELF_PROFILE"
    if not sp.is_dir():
        print(f"卷宗目录不存在：{sp}")
        return 1
    idx = load_dossiers(sp)
    embedder = make_ollama_embedder()
    sem = None
    mode = "keyword"
    if embedder:
        sem = SemanticIndex.build(idx.sections, embedder,
                                  REPO / "data" / "cx" / "dossier_vecs.npz")
        mode = "hybrid(rrf)"
    top = hybrid_route(idx, sem, embedder, a.query, k=a.k)
    print(f"「{a.query}」[dossier/{mode}] → {len(top)}/{len(idx.sections)} 节")
    for i, s in enumerate(top, 1):
        head = s.header or s.text.splitlines()[0][:30] if s.text else ""
        snippet = s.text[:120].replace("\n", " ")
        print(f"\n{i}. [{s.dossier}] {head}（score {s.score:.6g}）")
        print(f"   {snippet}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
