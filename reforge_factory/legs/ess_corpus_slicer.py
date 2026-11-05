# -*- coding: utf-8 -*-
"""lumpsum_corpus_slicer — EPC-LUMPSUM 判例语料切片件 (照 epc_caselaw_supply 同款, 1102).

corpus_stores 渠道正件: 判决语料年卷按固定总价族主题互斥切片入池.
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

CID = "EPC-ESS"
POOL = AP.POOL_ROOT / CID
OUT = Path(r"E:\AI-Station\data\harvest\judgment_slices\EPC-ESS")
LEDGER = POOL / "corpus_slice_ledger.jsonl"
ERA1, ERA2 = (2009, 2016), (2017, 2021)

#: 固定总价族主题 → (目标EEI, 正则). 互斥优先级: 专属在前, 泛词殿后.
TOPICS: list[tuple[str, str, str]] = [
    ("储能EPC纠纷",     "Q1-E1",  r"储能.{0,12}(EPC|总承包|施工合同)|储能电站.{0,10}承包"),
    ("光伏电站EPC",     "Q2-E1",  r"光伏.{0,12}(EPC|总承包|施工合同)|光伏电站.{0,10}(承包|建设)"),
    ("风电EPC",         "Q3-E1",  r"风电.{0,12}(EPC|总承包|施工合同)|风电场.{0,10}(承包|建设)"),
    ("新能源EPC泛面",   "Q4-E1",  r"新能源.{0,12}(EPC|总承包)|清洁能源.{0,10}承包"),
    ("设备采购争议",     "Q5-E1",  r"(电池舱|PCS|逆变器|组件).{0,15}(采购|买卖|质量|货款)|设备采购合同.{0,10}纠纷"),
    ("并网与电网接入",   "Q6-E1",  r"并网.{0,10}(纠纷|争议|合同)|电网接入.{0,10}(纠纷|争议)|电网公司.{0,15}合同"),
    ("电力工程造价",     "Q7-E1",  r"电力工程.{0,10}(造价|结算|工程款)|电站.{0,10}(造价|结算)"),
    ("EPC总价包干",     "Q8-E1",  r"EPC.{0,12}(总价|包干|固定价)|工程总承包.{0,12}(总价|包干)"),
    ("停窝工损失",       "Q9-E1",  r"停窝工|停工损失|窝工|停工费|赶工"),
    ("固定总价判例",     "Q10-E1", r"固定总价|固定价格合同|总价合同"),
    ("变更签证",         "Q11-E1", r"工程变更|现场签证|签证单|设计变更|变更签证"),
    ("造价鉴定",         "Q12-E1", r"造价鉴定|司法鉴定|鉴定机构|鉴定意见"),
    ("结算审减",         "Q13-E1", r"竣工结算|结算审核|送审|审减|结算书"),
    ("工期延误",         "Q14-E1", r"工期延误|工期顺延|顺延工期|误期|逾期竣工"),
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
    return 0


if __name__ == "__main__":
    sys.exit(main())
