# -*- coding: utf-8 -*-
"""EPC-CASELAW S1 跨池灌采件 (任务书 1031: BID26 判例司法解释 + JIAGE 造价鉴定
合同解除 + CONTRACT 合同纠纷).

规则: 源池 manifest 只读; 只取源池 judge==valid 行; 族过滤 = 标题(basename)
或 text_head 前300字命中族词; 文件失联如实跳过; 入 EPC-CASELAW 走
ammo_pool.ingest() 正道 (url_norm/credibility 继承 → 权威度与信源域不失真,
engine=crosspool:<源池> 全程可审计); 判层留给 judge (零造假).
台账: graft_ledger.jsonl 逐件留痕 (族/件/字/结果).
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool as AP  # noqa: E402

CID = "EPC-CASELAW"
FAMILIES = {                      # 任务书三源三族
    "EPC-BID26": ("判例/司法解释", ("判例", "司法解释", "裁判规则", "判决")),
    "EPC-JIAGE": ("造价鉴定/合同解除", ("造价鉴定", "合同解除", "解除合同",
                                         "鉴定意见")),
    "EPC-CONTRACT": ("合同纠纷", ("合同纠纷", "施工合同")),
}


def main() -> int:
    target = AP.POOL_ROOT / CID
    ledger = target / "graft_ledger.jsonl"
    summary = {}
    with ledger.open("a", encoding="utf-8") as lf:
        for src, (family, kws) in FAMILIES.items():
            mp = AP.POOL_ROOT / src / "manifest.jsonl"
            rows = [json.loads(x) for x in
                    mp.read_text(encoding="utf-8").splitlines() if x.strip()]
            valid = [r for r in rows if r.get("judge") == "valid"]
            cand = []
            for r in valid:
                title = Path(r.get("source_path") or "").name
                head = (r.get("text_head") or "")[:300]
                if any(k in title or k in head for k in kws):
                    cand.append(r)
            n_ok = n_dup = n_miss = 0
            chars_ok = 0
            for r in cand:
                fp = Path(r["source_path"])
                rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                       "source_pool": src, "family": family,
                       "file": str(fp), "chars": r.get("chars", 0)}
                if not fp.is_file():
                    n_miss += 1
                    rec["result"] = "file_missing"
                    lf.write(json.dumps(rec, ensure_ascii=False) + "\n")
                    continue
                rc = AP.ingest(CID, str(fp), engine=f"crosspool:{src}",
                               url=r.get("url_norm") or "",
                               cred=r.get("credibility") or "unknown")
                if rc == 0:
                    # ingest 对重复/太短/snippet 均静默 rc=0 — 用 manifest 回查
                    # source_path 是否已在本池 manifest
                    have = any(
                        json.loads(x).get("source_path") == str(fp)
                        for x in (target / "manifest.jsonl")
                        .read_text(encoding="utf-8").splitlines() if x.strip())
                    if have:
                        n_ok += 1
                        chars_ok += r.get("chars", 0)
                        rec["result"] = "ingested_pending"
                    else:
                        n_dup += 1
                        rec["result"] = "skipped_dup_or_gate"
                    lf.write(json.dumps(rec, ensure_ascii=False) + "\n")
            summary[src] = {"family": family, "source_valid": len(valid),
                            "candidates": len(cand), "ingested": n_ok,
                            "ingested_chars_source_account": chars_ok,
                            "skipped_dup_or_gate": n_dup, "file_missing": n_miss}
            print(f"[graft] {src} ({family}): 源valid {len(valid):,} | "
                  f"候选 {len(cand)} | 入池 {n_ok} | 重复/门拦 {n_dup} | "
                  f"失联 {n_miss}")
    print(json.dumps(summary, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
