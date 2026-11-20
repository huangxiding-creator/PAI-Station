# -*- coding: utf-8 -*-
"""jes2_manifest — EPC-JES2 池定向编目器: 跨池判例切片 + ResearchTopics 底本 → manifest valid 行.
照 EPC-HANDOV crosspool 行格式 (engine=crosspool:<源池>, credibility=research).
用法: py -X utf8 jes2_manifest.py
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[5]
POOL = REPO / "ammo_pool" / "EPC-JES2"
JS = REPO / "data" / "harvest" / "judgment_slices" / "EPC-JES2"
RT = POOL / "staging" / "researchtopic"
MANIFEST = POOL / "manifest.jsonl"


def row(sp: Path, engine: str, cred: str, tree: str, head: str) -> dict:
    return {
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "engine": engine,
        "source_path": str(sp),
        "url_norm": "",
        "chars": sp.stat().st_size,
        "credibility": cred,
        "dedup_key": "c:" + hashlib.md5(str(sp).encode()).hexdigest()[:16],
        "judge": "valid",
        "judge_reason": "jes2_direct_harvest",
        "judge_engine": "heuristic",
        "tree_node": tree,
        "stance": "support",
        "budget_band": "core",
        "text_head": head,
    }


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    existing = set()
    if MANIFEST.is_file():
        for ln in MANIFEST.read_text(encoding="utf-8").splitlines():
            try:
                existing.add(json.loads(ln).get("source_path"))
            except json.JSONDecodeError:
                pass
    rows = []
    # 1) 跨池判例切片 (文件名前缀 = 源池)
    for f in sorted(JS.glob("*.md")):
        if str(f) in existing:
            continue
        m = re.match(r"(EPC-[A-Z0-9]+)_(.+)", f.stem)
        pool = m.group(1) if m else "EPC-CASELAW"
        head = f.read_text(encoding="utf-8", errors="replace")[:1200]
        rows.append(row(f, f"crosspool:{pool}", "research", "Q1-E1", head))
        print(f"[slice] {f.name[:56]} {f.stat().st_size:,}B")
    # 2) ResearchTopics 核心底本
    for f in sorted(RT.rglob("*.md")):
        if str(f) in existing:
            continue
        rel = f.relative_to(RT).as_posix()
        cred = "official" if ("00_核心法规" in rel or "02_最高法" in rel) else "analysis"
        head = f.read_text(encoding="utf-8", errors="replace")[:1200]
        rows.append(row(f, "researchtopic:JES2", cred, "Q1-E1", head))
        print(f"[core] {rel[:60]} {f.stat().st_size:,}B")
    with MANIFEST.open("a", encoding="utf-8") as fh:
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")
    print(f"[done] 新增 {len(rows)} valid 行 → {MANIFEST}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
