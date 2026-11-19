# -*- coding: utf-8 -*-
"""handov_crosspool — 跨池收割入 EPC-HANDOV (照subcon_crosspool法)."""
import json, re, sys
from pathlib import Path
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP

CID = "EPC-HANDOV"
SRC_POOLS = ["EPC-SUBCON", "EPC-VISA", "EPC-AUDIT", "EPC-LUMPSUM", "EPC-CASELAW", "EPC-ESS"]
KWS = re.compile(r"竣工|验收|移交|缺陷责任|质保金|保修金|竣工资料|竣工图纸|甩项|分段验收|竣工日期|保修期|维修义务|备案|返修|质量保修|EPC|工程总承包|施工合同|建设工程")

def pick_tree(head: str) -> str:
    h = head[:2000]
    if re.search(r"缺陷责任|保修期|维修|返修", h): return "Q14-E4"
    if re.search(r"质保金|保修金", h): return "Q14-E5"
    if re.search(r"竣工资料|竣工图纸|档案", h): return "Q14-E3"
    if re.search(r"甩项|分段|单项验收", h): return "Q11-E1"
    if re.search(r"竣工日期", h): return "Q14-E6"
    if re.search(r"验收程序|验收流程", h): return "Q14-E2"
    if re.search(r"移交", h): return "Q14-E7"
    if re.search(r"质量保修|保修义务", h): return "Q13-E1"
    if re.search(r"结算", h): return "Q14-E8"
    if re.search(r"FIDIC|国际|海外", h): return "Q23-E1"
    return "Q14-E1"

def main() -> int:
    n = 0
    for sp in SRC_POOLS:
        mp = AP.POOL_ROOT / sp / "manifest.jsonl"
        if not mp.is_file(): continue
        got = 0
        for ln in mp.read_text(encoding="utf-8").splitlines():
            if not ln.strip(): continue
            try: r = json.loads(ln)
            except json.JSONDecodeError: continue
            if r.get("judge") != "valid": continue
            hay = (r.get("text_head", "") or "")[:1500] + " " + Path(r.get("source_path", "")).name
            if not KWS.search(hay): continue
            fp = Path(r.get("source_path", ""))
            if not fp.is_file() or fp.stat().st_size > 2_000_000: continue
            rc = AP.ingest(CID, str(fp), engine=f"crosspool:{sp}",
                           url=r.get("url_norm", ""), cred=r.get("credibility", "research"),
                           tree=pick_tree(r.get("text_head", "")), stance="support", band="gap")
            if rc == 0: got += 1
        n += got
        print(f"[cross] {sp}: 入 {got}")
    print(f"[done] 跨池合计入 {n} 件")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
