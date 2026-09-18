# -*- coding: utf-8 -*-
"""金标准未命中归因（月度跑分后的工程诊断口）。

对每道未命中题输出：
- 路由缺口：答案 token 在卷宗语料里，但没进 top-8 节 → 检索质量问题
- 语料缺口：答案 token 不在卷宗语料任何地方 → 语料覆盖问题
- token 缺口：答案提不出区分 token → 考卷/口径问题

用法：python tools/cx_golden_diagnose.py [--golden 路径]
"""
from __future__ import annotations

import argparse
import json
import sys
from collections import Counter
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.dossier import load_dossiers  # noqa: E402
from paistation.cx.golden import extract_tokens  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--golden", default=str(
        REPO / "SELF_PROFILE" / "golden_set" / "golden_100_v1.jsonl"))
    args = ap.parse_args()

    idx = load_dossiers(REPO / "SELF_PROFILE")
    corpus = "\n".join(s.text for s in idx.sections)
    questions = [json.loads(ln)
                 for ln in open(args.golden, encoding="utf-8")]

    n_hit = 0
    miss: list[tuple[str, str, str, str]] = []
    for q in questions:
        toks = extract_tokens(q["a"])
        top = idx.route(q["q"], k=8)
        if toks and any(t in h.text for t in toks for h in top):
            n_hit += 1
            continue
        if not toks:
            miss.append((q["id"], "token缺口", q["q"][:30], ""))
        elif any(t in corpus for t in toks):
            heads = "→".join((s.header or s.dossier)[:18] for s in top[:2])
            miss.append((q["id"], "路由缺口", q["q"][:30], heads))
        else:
            miss.append((q["id"], "语料缺口", q["q"][:30], ";".join(toks[:2])))

    cnt = Counter(m[1] for m in miss)
    print(f"卷宗通道：{n_hit}/{len(questions)} 命中；未命中归因 "
          + " ".join(f"{k} {v}" for k, v in cnt.most_common()))
    out = REPO / "SELF_PROFILE" / "golden_set" / f"diagnose_{datetime.now():%Y%m%d_%H%M}.md"
    L = ["# 金标准未命中归因", "",
         f"> {datetime.now():%Y-%m-%d %H:%M} · 命中 {n_hit}/{len(questions)} · "
         + " ".join(f"{k} {v}" for k, v in cnt.most_common()), ""]
    for mid, kind, qq, extra in miss:
        L.append(f"- #{mid} [{kind}] {qq} | {extra[:60]}")
    out.write_text("\n".join(L), encoding="utf-8")
    print(f"归因报告 → {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
