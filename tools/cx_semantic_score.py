# -*- coding: utf-8 -*-
"""金标准语义/混合通道跑分——A/B/C 三列同 corpus 实测。

keyword 通道已收口（79/100，剩 miss 全是措辞变体类）。本工具在同一
golden_set 上实测：A=卷宗 keyword 路由（基线）；B=纯语义（bge-m3 余弦
top-8）；C=RRF 融合（A+B 双路倒数排名融合）。判定口径不变
（paistation.cx.golden.is_hit——token 命中节文本）。

用法：python tools/cx_semantic_score.py [--k 8]
产出：SELF_PROFILE/golden_set/semantic_score_<ts>.md
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.dossier import load_dossiers  # noqa: E402
from paistation.cx.golden import extract_tokens, is_hit  # noqa: E402
from paistation.cx.semantic import SemanticIndex, rrf_fuse  # noqa: E402
from paistation.sense.localfiles.embedder import make_ollama_embedder  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--k", type=int, default=8)
    ap.add_argument("--depth", type=int, default=40,
                    help="融合候选池深度（出口 k 不变；深池 RRF 是标准做法）")
    ap.add_argument("--golden", default=str(
        REPO / "SELF_PROFILE" / "golden_set" / "golden_100_v1.jsonl"))
    args = ap.parse_args()

    embedder = make_ollama_embedder()
    idx = load_dossiers(REPO / "SELF_PROFILE")
    questions = [json.loads(ln) for ln in open(args.golden, encoding="utf-8")]

    sem = None
    if embedder:
        sem = SemanticIndex.build(idx.sections, embedder,
                                  REPO / "data" / "cx" / "dossier_vecs.npz")

    hits = {"kw": 0, "sem": 0 if sem else -1, "rrf": 0}
    per_q = []
    for q in questions:
        toks = extract_tokens(q["a"])
        kw_top = idx.route(q["q"], k=args.k)
        h_kw = is_hit(kw_top, toks)
        hits["kw"] += h_kw
        row = {"id": q["id"], "kw": h_kw}
        if sem:
            sem_top = sem.route(q["q"], embedder, k=args.k)
            h_sem = is_hit(sem_top, toks)
            hits["sem"] += h_sem
            kw_pool = idx.route(q["q"], k=args.depth)
            sem_pool = sem.route(q["q"], embedder, k=args.depth)
            fused = rrf_fuse(kw_pool, sem_pool, k=args.k)
            h_rrf = is_hit(fused, toks)
            hits["rrf"] += h_rrf
            row.update(sem=h_sem, rrf=h_rrf)
        per_q.append(row)

    n = len(questions)
    L = ["# 金标准语义/混合通道跑分", "",
         f"> {datetime.now():%Y-%m-%d %H:%M} · k={args.k} · "
         f"语料 {len(idx.sections)} 节 · 判定口径 golden.is_hit", "",
         "| 通道 | hit |", "|---|---:|",
         f"| A 卷宗 keyword | {hits['kw']}/{n} |"]
    if sem:
        L.append(f"| B 纯语义 bge-m3 | {hits['sem']}/{n} |")
        L.append(f"| C RRF 融合 | {hits['rrf']}/{n} |")
    else:
        L.append("| B/C | 嵌入服务不在位，跳过 |")
    L.append("")
    L.append("## 双通道互补明细（仅 keyword 与语义结论不同的题）")
    L.append("")
    for r in per_q:
        if "sem" not in r:
            break
        if r["kw"] != r["sem"] or r["rrf"] != r["kw"]:
            L.append(f"- #{r['id']}: kw={int(r['kw'])} sem={int(r['sem'])} "
                     f"rrf={int(r['rrf'])}")
    out = REPO / "SELF_PROFILE" / "golden_set" / f"semantic_score_{datetime.now():%Y%m%d_%H%M%S}.md"
    out.write_text("\n".join(L), encoding="utf-8")
    print(f"kw {hits['kw']} | sem {hits['sem']} | rrf {hits['rrf']} → {out.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
