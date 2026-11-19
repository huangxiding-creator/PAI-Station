# -*- coding: utf-8 -*-
"""audit_crosspool — 跨池收割入 EPC-FIN (1108): 兄弟池 valid 件按AUDIT词筛 → 重入池.
engine=crosspool:<源池> 溯源; 幂等(源路径+dedup 双查重); 只搬 judge=valid.
"""
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP  # noqa: E402

CID = "EPC-FIN"
SRC_POOLS = ["EPC-ESS", "EPC-LUMPSUM", "EPC-CASELAW", "EPC-OVERSEAS",
             "EPC-BID26", "EPC-JIAGE"]
KWS = re.compile(r"审计|决算|结算|送审|审减|造价鉴定|竣工结算|工程款|固定总价|变更签证|"
                 r"停窝工|优先受偿|视为认可|结算审核|司法鉴定|工程总承包|EPC|造价")
TREE_MAP = re.compile(
    r"审计|决算|结算|送审|审减|造价鉴定|视为认可|优先受偿|停窝工|变更签证|工期延误|固定总价")

def pick_tree(head: str) -> str:
    h = head[:2000]
    if re.search(r"审计|决算|视为认可", h):
        return "Q14-E3"
    if re.search(r"结算|送审|审减", h):
        return "Q14-E1"
    if re.search(r"造价鉴定|司法鉴定", h):
        return "Q14-E2"
    if re.search(r"固定总价|总价合同", h):
        return "Q12-E1"
    if re.search(r"变更签证|签证单", h):
        return "Q12-E2"
    if re.search(r"停窝工|窝工", h):
        return "Q12-E3"
    if re.search(r"工期延误|顺延", h):
        return "Q15-E1"
    if re.search(r"优先受偿", h):
        return "Q15-E2"
    if re.search(r"政策|规划|部令|办法|意见", h):
        return "Q1-E1"
    if re.search(r"市场规模|合同额|趋势", h):
        return "Q4-E1"
    if re.search(r"企业|央企|国企|排名|市场份额", h):
        return "Q7-E1"
    if re.search(r"营收|毛利率|应收账款|现金流", h):
        return "Q16-E1"
    if re.search(r"标准|专利|GB", h):
        return "Q20-E1"
    if re.search(r"FIDIC|国际|海外|属地", h):
        return "Q23-E1"
    if re.search(r"数字化|平台|智能", h):
        return "Q19-E1"
    return "Q26-E1"


def main() -> int:
    n = 0
    for sp in SRC_POOLS:
        mp = AP.POOL_ROOT / sp / "manifest.jsonl"
        if not mp.is_file():
            continue
        got = 0
        for ln in mp.read_text(encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            try:
                r = json.loads(ln)
            except json.JSONDecodeError:
                continue
            if r.get("judge") != "valid":
                continue
            hay = (r.get("text_head", "") or "")[:1500] + " " + \
                Path(r.get("source_path", "")).name
            if not KWS.search(hay):
                continue
            fp = Path(r.get("source_path", ""))
            if not fp.is_file() or fp.stat().st_size > 2_000_000:
                continue
            rc = AP.ingest(CID, str(fp),
                           engine=f"crosspool:{sp}",
                           url=r.get("url_norm", ""), cred=r.get("credibility", "research"),
                           tree=pick_tree(r.get("text_head", "")),
                           stance="support", band="gap")
            if rc == 0:
                got += 1
        n += got
        print(f"[cross] {sp}: 入 {got}")
    print(f"[done] 跨池合计入 {n} 件")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
