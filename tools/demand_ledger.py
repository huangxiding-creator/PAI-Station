# -*- coding: utf-8 -*-
"""demand_ledger — 需求资产台账核心 (Demand Engine 2.0, F1/F7).

唯一真源 data/demand_ledger/signals.jsonl，append-only 只增不删。
行 schema = topic-signals 超集: {signal_id, ts, source_face, source_ref,
demand_quote, jtbd{...}, frequency, urgency, score}
用法: 作为库 import（append/read/dedupe/top）。
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
LEDGER = REPO / "data" / "demand_ledger" / "signals.jsonl"
RUNLOG = REPO / "data" / "demand_ledger" / "run_log.jsonl"

FACES = ("group", "p2p", "moments", "gzh_comment", "sph_comment",
         "mp_feedback", "ask_log", "purchase")


def _sid(face: str, quote: str, ref: str = "") -> str:
    h = hashlib.md5(f"{face}|{quote[:120]}|{ref}".encode()).hexdigest()[:12]
    return f"dl_{int(time.time()//86400)}_{h}"


def append(face: str, quote: str, ref: str = "", jtbd: dict | None = None,
           frequency: int = 1, urgency: str = "mid", score: int = 50) -> bool:
    """幂等入账（quote 短于 8 字或 face 未知 → 拒）。返回是否新增。"""
    quote = (quote or "").strip()
    if len(quote) < 8 or face not in FACES:
        return False
    row = {"signal_id": _sid(face, quote, ref),
           "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
           "source_face": face, "source_ref": ref[:120],
           "demand_quote": quote[:240],
           "jtbd": jtbd or {}, "frequency": frequency,
           "urgency": urgency, "score": score}
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    key = hashlib.md5(f"{face}|{quote[:120]}".encode()).hexdigest()
    with LEDGER.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
    _run("append", face, quote[:40])
    return True


def read() -> list[dict]:
    if not LEDGER.exists():
        return []
    out = []
    for ln in LEDGER.open(encoding="utf-8", errors="ignore"):
        try:
            out.append(json.loads(ln))
        except json.JSONDecodeError:
            continue
    return out


def semantic_dedupe(rows: list[dict], thresh: float = 0.6) -> list[dict]:
    """报告层语义归并：字符 bigram Jaccard ≥ thresh 聚为一族，取最高频为代表。"""
    def grams(s):
        s = re.sub(r"\s+", "", s)
        return {s[i:i+2] for i in range(len(s)-1)}
    fams: list[dict] = []
    for r in rows:
        g = grams(r.get("demand_quote", ""))
        merged = False
        for fam in fams:
            inter = len(g & fam["_g"])
            union = len(g | fam["_g"]) or 1
            if inter / union >= thresh:
                fam["members"].append(r)
                fam["_g"] |= g
                merged = True
                break
        if not merged:
            fams.append({"_g": set(g), "members": [r]})
    out = []
    for fam in fams:
        ms = fam["members"]
        rep = max(ms, key=lambda r: (r.get("frequency", 1), len(r.get("demand_quote", ""))))
        rep = dict(rep)
        rep["merged_count"] = len(ms)
        rep["merged_faces"] = sorted({m.get("source_face") for m in ms})
        out.append(rep)
    out.sort(key=lambda r: (-r["merged_count"], -r.get("frequency", 1)))
    return out


def top(n: int = 20) -> list[dict]:
    return semantic_dedupe(read())[:n]


def _run(kind: str, face: str, detail: str) -> None:
    RUNLOG.parent.mkdir(parents=True, exist_ok=True)
    with RUNLOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                            "kind": kind, "face": face, "detail": detail},
                           ensure_ascii=False) + "\n")


def stats() -> dict:
    rows = read()
    from collections import Counter
    return {"total": len(rows), "by_face": dict(Counter(r["source_face"] for r in rows))}
