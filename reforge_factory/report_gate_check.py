# -*- coding: utf-8 -*-
"""report_gate_check — 成稿三门检查器 (1015 用户令: 调研搜集达标后自动走撰写).

读 gates.json 权威口径, 现算三门 + 各阻塞位, 落 JSON 快照; 全过时退出码 0
并打印 GO 旗 (cron/上游链据此触发撰写相位), 未过 exit 2 + 阻塞清单。

三门 (REPORT_PIPELINE v2):
  ① 字数门   T1 ≥ t1_min_chars (10,000,000) — tier_fulltext_reledger 口径
  ② 完备性门 五轴 all_green_or_waived — completeness/ 五传感器 sidecar 现值
  ③ 饱和门   ≥80% EEI: ≥2 有效证据 ∧ ≥2 独立 host — coverage 口径复算

用法: py reforge_factory/report_gate_check.py --campaign EPC-BID26
      [--json-out PATH]   # 快照落盘 (默认 V3 work/gate_check_<cid>.json)
exit: 0=三门全过(GO) / 2=未过(打印阻塞清单)
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
GATES = Path(__file__).resolve().parent / "config" / "gates.json"
WORK = Path(r"E:\AI-Station\ResearchFactory-Eng\06 迭代优化"
            r"\百倍V3_极致调研变现计划\work")


def t1_gate(cid: str) -> dict:
    """字数门: T1 有效字符 — pool_state 落账值 (reledger辖键, 账实一致;
    需要重算时先跑 tier_fulltext_reledger, 本件不重复全文扫描)."""
    p = POOL_ROOT / cid / "pool_state.json"
    val = json.loads(p.read_text(encoding="utf-8")).get("t1_chars", 0) \
        if p.is_file() else 0
    return {"t1_chars": int(val)}


def axes_gate(cid: str) -> dict:
    """完备性门: 五轴 sidecar green/waived 现值 (传感器现跑在收尾链,
    此处只读最新账本 — cidx sidecar 已是五轴汇总之源)."""
    p = POOL_ROOT / cid / "completeness" / "C_axis.json"
    out = {"axes": {}, "all_green_or_waived": False}
    # 各轴 sidecar
    for ax, f in (("T", "T_axis.json"), ("B", "B_axis.json"),
                  ("D", "D_axis.json"), ("P", "P_axis.json"),
                  ("C", "C_axis.json")):
        fp = POOL_ROOT / cid / "completeness" / f
        if fp.is_file():
            d = json.loads(fp.read_text(encoding="utf-8"))
            green = bool(d.get("green"))
            waived = bool(d.get("waived")) or bool(d.get("all_waived"))
            out["axes"][ax] = {"green": green, "waived": waived,
                               "score": d.get("hit_ratio",
                                              d.get("lit_ratio",
                                                    d.get("key_eei_ge_l3_pct",
                                                          d.get("score"))))}
        else:
            out["axes"][ax] = {"green": False, "waived": False, "score": None}
    out["all_green_or_waived"] = all(
        v["green"] or v["waived"] for v in out["axes"].values())
    return out


def saturation_gate(cid: str) -> dict:
    """饱和门: 树 EEI 中 (≥2 valid 挂树证据 ∧ ≥2 独立 host) 占比 ≥80%."""
    d = POOL_ROOT / cid
    tree = json.loads((d / "question_tree.json").read_text(encoding="utf-8"))
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    by_eei: dict[str, list[dict]] = {}
    for r in rows:
        if r.get("judge") == "valid" and r.get("tree_node"):
            by_eei.setdefault(r["tree_node"], []).append(r)
    total = sat = 0
    for q in tree.get("subquestions", []):
        for e in q.get("eeis", []):
            total += 1
            ev = by_eei.get(str(e.get("id")), [])
            hosts = {(urlsplit(str(r.get("url_norm") or "")).netloc
                      or Path(str(r.get("source_path") or "")).stem)
                     for r in ev}
            if len(ev) >= 2 and len(hosts) >= 2:
                sat += 1
    pct = round(sat / total, 4) if total else 0.0
    return {"saturated_eeis": sat, "total_eeis": total, "pct": pct,
            "green": pct >= 0.80}


def run(cid: str, json_out: Path | None = None) -> int:
    gates = json.loads(GATES.read_text(encoding="utf-8"))
    t1 = t1_gate(cid)
    axes = axes_gate(cid)
    satu = saturation_gate(cid)
    t1_pass = t1["t1_chars"] >= gates["t1_min_chars"]
    snap = {"campaign": cid, "checked": time.strftime("%Y-%m-%dT%H:%M:%S"),
            "gates_version": gates.get("version"),
            "t1": {**t1, "min": gates["t1_min_chars"], "pass": t1_pass},
            "completeness": axes, "saturation": satu,
            "all_pass": bool(t1_pass and axes["all_green_or_waived"]
                             and satu["green"])}
    out = json_out or (WORK / f"gate_check_{cid}.json")
    out.parent.mkdir(parents=True, exist_ok=True)
    tmp = out.with_suffix(".tmp")
    tmp.write_text(json.dumps(snap, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(out)
    print(f"[gate] {cid}: T1 {'✅' if t1_pass else '⏳'} "
          f"({t1['t1_chars']:,}/{gates['t1_min_chars']:,}) | 完备性 "
          f"{'✅' if axes['all_green_or_waived'] else '⏳'} "
          f"({''.join(a if v['green'] or v['waived'] else a.lower()
                      for a, v in axes['axes'].items())}) | 饱和 "
          f"{'✅' if satu['green'] else '⏳'} "
          f"({satu['saturated_eeis']}/{satu['total_eeis']}="
          f"{satu['pct']:.0%}/80%)")
    if snap["all_pass"]:
        print("[gate] 🚀 三门全过 — GO 撰写相位 (REPORT_PIPELINE v2 S2)")
        return 0
    blocked = []
    if not t1_pass:
        blocked.append(f"T1 差 {gates['t1_min_chars'] - t1['t1_chars']:,} 字")
    if not axes["all_green_or_waived"]:
        blocked += [f"{a}轴未绿" for a, v in axes["axes"].items()
                    if not (v["green"] or v["waived"])]
    if not satu["green"]:
        blocked.append(f"饱和差 {int(satu['total_eeis'] * .8) - satu['saturated_eeis']} EEI")
    print("[gate] 阻塞: " + "; ".join(blocked))
    return 2


def main() -> int:
    ap = argparse.ArgumentParser(description="成稿三门检查器")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--json-out", default=None)
    ns = ap.parse_args()
    return run(ns.campaign, Path(ns.json_out) if ns.json_out else None)


if __name__ == "__main__":
    sys.exit(main())
