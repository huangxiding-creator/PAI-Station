# -*- coding: utf-8 -*-
"""jsfdd_wenshu_ingest — wenshu 全文库 → EPC-JSFDD 定向入池 (1018 S2 司法鉴定战役).

源: /f/wenshu_bt/extract/EPC49-SEPDC/*.jsonl (436 卷 10,564 案, EPC 系纠纷全文库)
滤: 案文命中 JSFDD 词 (鉴定/工程价款/结算/造价/质证等) → 案例md → manifest 直写
(engine=wenshu:jsfdd, credit=archive)。T1 词命中优先档。
"""
from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, r"E:\AI-Station")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as ap  # noqa: E402

SRC = Path(r"F:\wenshu_bt\extract\EPC49-SEPDC")
CAMP = ap._camp_dir("EPC-JSFDD")
KWS = ["工程价款司法鉴定", "工程造价鉴定", "鉴定申请", "不予受理", "鉴定意见",
       "重新鉴定", "鉴定机构", "鉴定费", "结算争议", "司法鉴定"]
HIT = re.compile(r"鉴定|工程价款|结算|造价|质证|重新鉴定")
T1 = re.compile(r"鉴定")
MAXC = 30000

def main() -> int:
    n = hit_n = t1_chars = tot_chars = 0
    ts = time.strftime("%Y-%m-%dT%H:%M:%S")
    with ap._pool_lock(CAMP):
        with (CAMP / "manifest.jsonl").open("a", encoding="utf-8") as out:
            for fp in sorted(SRC.glob("*.jsonl")):
                for ln in fp.open(encoding="utf-8", errors="ignore"):
                    if not ln.strip():
                        continue
                    try:
                        d = json.loads(ln)
                    except json.JSONDecodeError:
                        continue
                    case = d.get("case", {})
                    full = str(d.get("全文", ""))[:MAXC]
                    if len(full) < 400:
                        continue
                    n += 1
                    hay = full[:4000]
                    if not HIT.search(hay):
                        continue
                    title = f"{case.get('案号','')}_{case.get('案件名称','')[:40]}_{case.get('案由','')}"
                    md = (f"# {title}\n\n> 案号 {case.get('案号','')} | 法院 "
                          f"{case.get('法院','')} | 日期 {case.get('裁判日期','')} | "
                          f"案由 {case.get('案由','')}\n\n{full}\n")
                    key = ap.dedup_key(None, md)
                    ch = len(full)
                    is_t1 = bool(T1.search(hay))
                    out.write(json.dumps({
                        "ts": ts, "engine": "wenshu:jsfdd",
                        "source_path": f"wenshu:jsfdd:{title[:60]}",
                        "url_norm": "", "chars": ch, "credibility": "archive",
                        "dedup_key": key, "judge": "valid",
                        "judge_reason": "wenshu_extract_hit", "judge_engine": "stock2level",
                        "tree_node": "", "stance": "support",
                        "grade": "T1" if is_t1 else "T2"}, ensure_ascii=False) + "\n")
                    hit_n += 1
                    tot_chars += ch
                    if is_t1:
                        t1_chars += ch
                    if hit_n % 500 == 0:
                        print(f"  入池 {hit_n} (T1 {t1_chars:,}字 / 总 {tot_chars:,}字)", flush=True)
    print(f"[wenshu-jsfdd] 扫 {n} 案 → 入池 {hit_n} | T1字 {t1_chars:,} | 总字 {tot_chars:,}")
    # 池账重算
    ap.recount("EPC-JSFDD") if hasattr(ap, "recount") else None
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
