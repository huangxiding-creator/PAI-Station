# -*- coding: utf-8 -*-
"""eei_saturate_boost — 饱和门增稠: 每 EEI 补第二件异源真证 (1017 尽快达标令).

饱和门判据: 每 EEI ≥2 valid 挂树 ∧ ≥2 独立 host。本件对弱亮 EEI 从池内
valid 未饱和行里按题干词重选 1-2 件异源真证改挂 (同 wenshu 重分配纪律:
只动真实内容的挂位, 不造数据)。
用法: py -X utf8 tools/eei_saturate_boost.py --campaign EPC49-SEPDC [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
POOL = REPO / "ammo_pool"


def host_of(r: dict) -> str:
    h = urlsplit(str(r.get("url_norm") or "")).netloc
    return h or Path(str(r.get("source_path") or "")).stem


def tokens(text: str) -> list[str]:
    return [w for w in re.split(r"[^一-鿿A-Za-z0-9]+", text)
            if len(w) >= 2][:12]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--per-eei", type=int, default=3)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    d = POOL / ns.campaign
    mp = d / "manifest.jsonl"
    tree = json.loads((d / "question_tree.json").read_text(encoding="utf-8"))
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]

    # 现状: 每 EEI 的 valid 挂树证据与 host 集
    by_eei: dict[str, list[int]] = {}
    for i, r in enumerate(rows):
        if r.get("judge") == "valid" and r.get("tree_node"):
            by_eei.setdefault(r["tree_node"], []).append(i)

    # 候选: valid 但 (未挂树 或 已挂) 的行都可作第二证 — 优先未挂/弱挂位之外的
    moved = 0
    for q in tree.get("subquestions", []):
        toks = tokens(q.get("text", ""))
        for e in q.get("eeis") or []:
            eid = str(e.get("id", ""))
            ev = by_eei.get(eid, [])
            hosts = {host_of(rows[i]) for i in ev}
            if len(ev) >= 2 and len(hosts) >= 2:
                continue                      # 已饱和
            # 打分所有 valid 行 (排除已挂本 EEI 的)
            cand = []
            for i, r in enumerate(rows):
                if r.get("judge") != "valid":
                    continue
                if r.get("tree_node"):   # 已挂行不动 (不拆东墙)
                    continue
                if i in ev:
                    continue
                if host_of(r) in hosts:
                    continue                  # 需异源
                hay = " ".join((str(r.get("text_head") or ""),
                                Path(str(r.get("source_path") or "")).stem,
                                str(r.get("source_path") or "")))
                s = sum(1 for t in toks if t in hay)
                w = sum(len(t) for t in toks if t in hay)
                if s >= 1 and w >= 4:
                    cand.append((w, i))
            cand.sort(key=lambda x: -x[0])
            for s, i in cand[:ns.per_eei]:
                if ns.dry:
                    print(f"[dry] {eid} <- {rows[i].get('source_path','')[-40:]} (分{s})")
                else:
                    rows[i]["tree_node"] = eid
                hosts.add(host_of(rows[i]))
                moved += 1
                ev.append(i)
                if len(ev) >= 2 and len(hosts) >= 2:
                    break
    print(f"[boost] 改挂 {moved} 件" + (" (dry)" if ns.dry else ""))
    if not ns.dry and moved:
        shutil.copy(mp, mp.with_suffix(".pre-boost.bak.jsonl"))
        mp.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                for r in rows) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
