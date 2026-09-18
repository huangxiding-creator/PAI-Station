# -*- coding: utf-8 -*-
"""金标准 100 题月度跑分（L4 验收机制）——检索命中代理 v0。

口径（v0，keyword-only）：
- 检索：ChunkIndex.search(问题原文, k=8)（FTS+LIKE 分级路由；语义路由待
  嵌入回填完成后接入）
- 命中：top-8 块任一块文本含答案关键 token（取答案里最长的 ≤3 个 token，
  长词最具区分度；全短词答案退 2 字 token）
- 报告：总 hit@8 + 按维 × 按难度 + 未命中清单（区分"零结果"vs"词面不匹配"
  ——后者才是词汇鸿沟真问题）

用法：python tools/cx_golden_score.py [--k 8] [--golden 路径]
产出：SELF_PROFILE/golden_set/score_<date>.md（本地私有）
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.dossier import load_dossiers  # noqa: E402
from paistation.cx.golden import classify_miss, extract_tokens, is_hit  # noqa: E402
from paistation.cx.semantic import SemanticIndex, hybrid_route  # noqa: E402
from paistation.sense.localfiles.embedder import make_ollama_embedder  # noqa: E402
from paistation.sense.localfiles.store import ChunkIndex  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--golden", default=str(
        REPO / "SELF_PROFILE" / "golden_set" / "golden_100_v1.jsonl"))
    ap.add_argument("--k", type=int, default=8)
    args = ap.parse_args()

    questions = [json.loads(ln) for ln in open(args.golden, encoding="utf-8")]
    index = ChunkIndex(REPO / "data" / "local_index" / "index.db")
    dossier = load_dossiers(REPO / "SELF_PROFILE")
    embedder = make_ollama_embedder()
    sem = None
    if embedder:
        sem = SemanticIndex.build(dossier.sections, embedder,
                                  REPO / "data" / "cx" / "dossier_vecs.npz")

    rows = []
    for q in questions:
        toks = extract_tokens(q["a"])
        hits = index.search(q["q"], k=args.k)
        dhits = hybrid_route(dossier, sem, embedder, q["q"], k=args.k)
        hit_g = is_hit(hits, toks)
        hit_d = is_hit(dhits, toks)
        hit = hit_g or hit_d
        miss_type = ""
        if not hit:
            miss_type = classify_miss(
                hits or dhits, toks
            ) if (hits or dhits) else "零结果（索引无此词汇面）"
            if hits and dhits and not hit_g and not hit_d:
                miss_type = "词面不匹配（问答鸿沟：问题词≠文档词）"
        rows.append({
            "id": q["id"], "dim": q["dim"], "diff": q["diff"],
            "q": q["q"], "hit": hit, "hit_g": hit_g, "hit_d": hit_d,
            "miss_type": miss_type,
            "tokens": toks, "n_hits": len(hits), "n_dhits": len(dhits),
        })

    out = REPO / "SELF_PROFILE" / "golden_set" / f"score_{datetime.now():%Y%m%d_%H%M}.md"
    total = len(rows)
    n_hit = sum(r["hit"] for r in rows)
    by_dim = defaultdict(lambda: [0, 0])
    by_diff = defaultdict(lambda: [0, 0])
    for r in rows:
        by_dim[r["dim"]][1] += 1
        by_diff[r["diff"]][1] += 1
        if r["hit"]:
            by_dim[r["dim"]][0] += 1
            by_diff[r["diff"]][0] += 1

    L = ["# 金标准跑分 v0（keyword-only 检索命中代理）", ""]
    n_g = sum(r["hit_g"] for r in rows)
    n_d = sum(r["hit_d"] for r in rows)
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · 合并 hit@{args.k} = {n_hit}/{total}"
             f"（{n_hit / total:.0%}）· 全局通道 {n_g} + 卷宗通道 {n_d}"
             f" · 语义路由未接（嵌入回填中，分数为下界）")
    L.append("")
    L.append("| 维度 | 命中/总数 | 全局 | 卷宗 |")
    L.append("|---|---|---:|---:|")
    for d in sorted(by_dim):
        h, n = by_dim[d]
        g = sum(r["hit_g"] for r in rows if r["dim"] == d)
        c = sum(r["hit_d"] for r in rows if r["dim"] == d)
        L.append(f"| {d} | {h}/{n} | {g} | {c} |")
    L.append("")
    L.append("| 难度 | 命中/总数 | 全局 | 卷宗 |")
    L.append("|---|---|---:|---:|")
    for d in sorted(by_diff):
        h, n = by_diff[d]
        g = sum(r["hit_g"] for r in rows if r["diff"] == d)
        c = sum(r["hit_d"] for r in rows if r["diff"] == d)
        L.append(f"| {d} | {h}/{n} | {g} | {c} |")
    L.append("")
    L.append("## 未命中清单")
    L.append("")
    for r in rows:
        if not r["hit"]:
            L.append(f"- #{r['id']} [{r['dim']}/D{r['diff']}] {r['q']} — {r['miss_type']}")
    out.write_text("\n".join(L), encoding="utf-8")
    print(f"hit@{args.k} = {n_hit}/{total}（{n_hit / total:.0%}）→ {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
