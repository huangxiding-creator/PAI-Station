# -*- coding: utf-8 -*-
"""handov_corpus_slicer — EPC-HANDOV 判例语料切片件 (照生产法)."""
from __future__ import annotations
import sys, json, re, time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP

CID = "EPC-HANDOV"
POOL = AP.POOL_ROOT / CID
OUT = Path(r"E:\AI-Station\EPC-HANDOV_slices")
LEDGER = POOL / "corpus_slice_ledger.jsonl"
ERA1, ERA2 = (2009, 2016), (2017, 2021)
TOPICS: list[tuple[str, str, str]] = [
    ("竣工验收纠纷",     "Q14-E1", r"竣工验收.{0,10}(纠纷|争议|诉讼)|竣工验收.{0,10}条件"),
    ("验收程序",         "Q14-E2", r"验收程序|验收流程|验收组织|验收备案"),
    ("竣工资料移交",     "Q14-E3", r"竣工资料|竣工图纸.{0,10}移交|档案移交|技术资料"),
    ("缺陷责任期",       "Q14-E4", r"缺陷责任期|缺陷通知|保修期.{0,10}届满|缺陷修复"),
    ("质保金退还",       "Q14-E5", r"质保金.{0,8}(退还|返还|扣留)|保修金.{0,8}(退还|返还)"),
    ("甩项与分段验收",   "Q11-E1", r"甩项|分段验收|部分验收|单项验收"),
    ("竣工日期争议",     "Q14-E6", r"竣工日期.{0,8}(争议|确定|认定)|实际竣工"),
    ("移交责任",         "Q14-E7", r"移交.{0,10}(责任|义务|风险转移)"),
    ("质量保修义务",     "Q13-E1", r"质量保修|保修义务|维修义务|返修责任"),
    ("验收与结算联动",   "Q14-E8", r"验收.{0,10}结算|竣工验收.{0,10}结算条件"),
    ("验收标准争议",     "Q14-E9", r"验收标准|质量标准.{0,10}(争议|不符合)|合同约定.{0,10}质量"),
    ("国际移交",         "Q23-E1", r"国际.{0,10}(验收|移交|接管)|FIDIC.{0,10}(移交|接收|竣工)"),
]
_RX = [(name, eei, re.compile(rx)) for name, eei, rx in TOPICS]
_YEAR = re.compile(r"判决_(\d{4})_20")
_CASENO = re.compile(r"案号[:：]\s*(\S+)")

def year_rows() -> list[dict]:
    mp = AP.POOL_ROOT / "EPC-CONTRACT" / "manifest.jsonl"
    rows = [json.loads(x) for x in mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    return [r for r in rows if r.get("judge") == "valid" and _YEAR.search(Path(r.get("source_path", "")).name)]

def iter_blocks(path: Path):
    buf, first = [], True
    with path.open(encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if line.rstrip("\r\n") == "---":
                blk = "\n".join(buf).strip()
                buf = []
                if first: first = False; continue
                if blk: yield blk
                continue
            buf.append(line)
    blk = "\n".join(buf).strip()
    if blk and not first: yield blk

def classify(block: str) -> tuple[str, str] | tuple[None, None]:
    head = block[:4000]
    for name, eei, rx in _RX:
        if rx.search(head): return name, eei
    return None, None

def main() -> int:
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--cap-chars", type=int, default=1_200_000)
    ns = ap.parse_args()
    rows = year_rows()
    print(f"[slicer] valid年卷 {len(rows)} 卷")
    stats, written = {}, {}
    for r in rows:
        p = Path(r["source_path"])
        yr = int(_YEAR.search(p.name).group(1))
        era = "2009-2016" if yr <= ERA1[1] else "2017-2021"
        for blk in iter_blocks(p):
            name, eei = classify(blk)
            if not name: continue
            k = (name, era)
            st = stats.setdefault(k, {"eei": eei, "blocks": 0, "chars": 0, "samples": set(), "years": set()})
            st["blocks"] += 1; st["chars"] += len(blk)
            m = _CASENO.search(blk[:2000])
            st["samples"].add(m.group(1)[:28] if m else blk[:24]); st["years"].add(yr)
            if ns.dry or ns.only_scan: continue
            outf = OUT / f"判决语料切片_{name}_{era}.md"
            outf.parent.mkdir(parents=True, exist_ok=True)
            with outf.open("a", encoding="utf-8") as fh:
                fh.write(blk.rstrip() + "\n\n---\n\n")
            written[k] = outf
    for k in sorted(stats, key=lambda x: -stats[x]["chars"])[:12]:
        print(f"  {k[0]}|{k[1]}: blocks={stats[k]['blocks']} chars={stats[k]['chars']:,} 样本={list(stats[k]['samples'])[:2]}")
    if ns.dry: return 0
    # 入池
    n_ing = 0
    for (name, era), st in stats.items():
        outf = OUT / f"判决语料切片_{name}_{era}.md"
        if not outf.is_file(): continue
        eei = st["eei"]
        rc = AP.ingest(CID, str(outf), engine="corpus_stores:judgment_slice",
                       url="", cred="research", tree=eei, stance="support", band="gap")
        with LEDGER.open("a", encoding="utf-8") as lf:
            lf.write(json.dumps({"ts": time.strftime("%F %T"), "file": str(outf), "topic": name, "era": era,
                                 "eei": eei, "bytes": outf.stat().st_size, "ingest_rc": rc}, ensure_ascii=False) + "\n")
        n_ing += 1
        print(f"[ingest] {outf.name} → tree={eei} rc={rc}")
    print(f"[slicer] 入池 {n_ing} 卷")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
