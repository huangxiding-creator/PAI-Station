# -*- coding: utf-8 -*-
"""audit_corpus_slicer — EPC-SUBCON 判例语料切片件 (照 epc_caselaw_supply 同款, 1102).

corpus_stores 渠道正件: 判决语料年卷按签证索赔族主题互斥切片入池.
用法: py -X utf8 lumpsum_corpus_slicer.py [--dry|--only-scan] [--cap-chars N]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as AP  # noqa: E402

CID = "EPC-SUBCON"
POOL = AP.POOL_ROOT / CID
OUT = Path(r"E:\AI-Station\data\harvest\judgment_slices\EPC-SUBCON")
LEDGER = POOL / "corpus_slice_ledger.jsonl"
ERA1, ERA2 = (2009, 2016), (2017, 2021)

#: 签证索赔族主题 → (目标EEI, 正则). 互斥优先级: 专属在前, 泛词殿后.
TOPICS: list[tuple[str, str, str]] = [
    ("总分包界面纠纷",   "Q14-E1", r"总分包|界面.{0,10}(纠纷|争议|管理)|总分包界面"),
    ("转包与违法分包",   "Q14-E2", r"转包|违法分包|层层转包|变相转包"),
    ("挂靠与借用资质",   "Q14-E3", r"挂靠|借用资质|借照|实际施工人"),
    ("劳务分包",         "Q14-E4", r"劳务分包|劳务派遣|劳务合同|农民工"),
    ("专业分包",         "Q11-E1", r"专业分包|专业工程|专项分包"),
    ("分包合同纠纷",     "Q14-E5", r"分包合同|分包.{0,10}(纠纷|诉讼|结算)"),
    ("连带责任",         "Q15-E1", r"连带责任|连带赔偿|共同责任|连带清偿"),
    ("分包资质",         "Q3-E1", r"分包资质|资质等级|施工资质|承包资质"),
    ("指定分包",         "Q11-E2", r"指定分包|指定分包人|发包人指定"),
    ("分包结算",         "Q14-E6", r"分包结算|分包.{0,10}(工程款|进度款)|背靠背"),
    ("分包安全责任",     "Q13-E1", r"分包.{0,10}(安全|事故|质量)|安全生产"),
    ("国际分包",         "Q23-E1", r"国际分包|海外分包|属地.{0,10}分包|FIDIC.{0,10}分包"),
]

_RX = [(name, eei, re.compile(rx)) for name, eei, rx in TOPICS]


def year_of(text: str) -> int:
    m = re.search(r"(20[01]\d|202[0-6])", text[:3000])
    return int(m.group(1)) if m else 0


_YEAR = re.compile(r"判决_(\d{4})_20")
_CASENO = re.compile(r"案号[:：]\s*(\S+)")


def year_rows() -> list[dict]:
    """源=EPC-CONTRACT 池 manifest 的 valid 年卷 (照 CASELAW 同款)."""
    mp = AP.POOL_ROOT / "EPC-CONTRACT" / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    out = [r for r in rows if r.get("judge") == "valid"
           and _YEAR.search(Path(r.get("source_path", "")).name)]
    return sorted(out, key=lambda r: r["source_path"])


def iter_blocks(path: Path):
    """流式产出块 — 整行 '---' 为分隔 (照 CASELAW 同款)."""
    buf, first = [], True
    with path.open(encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if line.rstrip("\r\n") == "---":
                blk = "\n".join(buf).strip()
                buf = []
                if first:
                    first = False
                    continue
                if blk:
                    yield blk
                continue
            buf.append(line)
    blk = "\n".join(buf).strip()
    if blk and not first:
        yield blk


def classify(block: str) -> tuple[str, str] | tuple[None, None]:
    head = block[:4000]
    for name, eei, rx in _RX:
        if rx.search(head):
            return name, eei
    return None, None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--cap-chars", type=int, default=1_200_000)
    ap.add_argument("--only-scan", action="store_true")
    ns = ap.parse_args()

    rows = year_rows()
    print(f"[slicer] 源年卷 {len(rows)} 件 | 总 "
          f"{sum(r['chars'] for r in rows):,} 字")
    stats: dict[tuple[str, str], dict] = {}
    written = 0
    for r in rows:
        p = Path(r["source_path"])
        yr = int(_YEAR.search(p.name).group(1))
        era = "2009-2016" if yr <= ERA1[1] else "2017-2021"
        for blk in iter_blocks(p):
            name, eei = classify(blk)
            if not name:
                continue
            k = (name, era)
            st = stats.setdefault(k, {"eei": eei, "blocks": 0, "chars": 0,
                                      "samples": [], "years": set()})
            st["blocks"] += 1
            st["chars"] += len(blk)
            st["years"].add(yr)
            if len(st["samples"]) < 3:
                m = _CASENO.search(blk)
                st["samples"].append(m.group(1)[:28] if m else blk[:24])
            if ns.only_scan or ns.dry:
                continue
            out = OUT / f"判决语料切片_{name}_{era}.md"
            out.parent.mkdir(parents=True, exist_ok=True)
            with out.open("a", encoding="utf-8") as fh:
                fh.write(blk.rstrip() + "\n\n---\n\n")
            written += 1
        print(f"  扫 {p.name} 完", flush=True)

    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({"ts": time.strftime("%F %T"), "phase": "plan",
                             "cap_chars": ns.cap_chars,
                             "distribution": {f"{n}|{e}": {
                                 "eei": s["eei"], "blocks": s["blocks"],
                                 "chars": s["chars"],
                                 "years": sorted(s["years"])}
                                 for (n, e), s in stats.items()},
                             }, ensure_ascii=False) + "\n")
    total = sum(s["chars"] for s in stats.values())
    print(f"\n[slicer] 分布 {len(stats)} 桶 | 总块字符 {total:,} | "
          f"{'只扫描未写' if (ns.only_scan or ns.dry) else f'已写块 {written}'}")
    for (n, e) in sorted(stats, key=lambda k: -stats[k]["chars"])[:12]:
        s = stats[(n, e)]
        print(f"  {n}|{e}: blocks={s['blocks']} chars={s['chars']:,} "
              f"样本={s['samples'][:2]}")

    # ---- 正道入池 (照 epc_caselaw_supply/judgment_corpus_slicer.py, 1108补) ----
    if ns.only_scan or ns.dry:
        return 0
    n_ing = 0
    for (n, e), s in sorted(stats.items()):
        f = OUT / f"判决语料切片_{n}_{e}.md"
        if not f.is_file():
            continue
        eei = s["eei"]
        rc = AP.ingest(CID, str(f),
                       engine="corpus_stores:judgment_slice",
                       url="", cred="research",
                       tree=eei, stance="support", band="gap")
        with LEDGER.open("a", encoding="utf-8") as lf:
            lf.write(json.dumps({"ts": time.strftime("%F %T"),
                                 "file": str(f), "topic": n, "era": e,
                                 "eei": eei, "bytes": f.stat().st_size,
                                 "ingest_rc": rc,
                                 "source_corpus": "EPC-CONTRACT 年卷(只读)"},
                                ensure_ascii=False) + "\n")
        n_ing += 1
        print(f"[ingest] {f.name} → tree={eei} rc={rc}")
    print(f"[slicer] 入池 {n_ing} 卷 (engine=corpus_stores:judgment_slice)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
