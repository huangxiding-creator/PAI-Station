# -*- coding: utf-8 -*-
"""factory_products — W4 三产物引擎 (FACTORY-7x24): 知识库/资料包/多形态报告.
输入: 战役(m2/<camp>/sched + 判例切片池) → 输出三产物:
  P1 知识库: 弹药池打包(索引+package.json+动态定价) → 百度网盘(bdn镜像) → 上架工单
  P2 资料包: 判例切片精选集 → 资料包SKU工单(微信交付)
  P3 多形态报告: 主报告final → 速读版(3000字)/清单版(行动清单) 派生
用法: py -X utf8 tools/factory_products.py --campaign EPC-XXXX [--stage kb|pack|derivs|all]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import time
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
FACT = REPO / "data" / "factory"
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2"
JS = REPO / "data" / "harvest" / "judgment_slices"
OUTDIR = FACT / "products"


def cjk(t): return len(re.findall(r"[一-鿿]", t))


def campaign_paths(camp: str) -> dict:
    d = M2 / camp.lower()
    return {"root": d, "sched": d / "sched", "slices": JS / camp}


def product_kb(camp: str, theme: str) -> dict:
    """P1 知识库: 弹药清单+索引+package.json+定价 (打包器复用kb_packager口径)."""
    p = campaign_paths(camp)
    files = []
    for f in (p["slices"].glob("*.md") if p["slices"].is_dir() else []):
        files.append({"name": f.stem, "bytes": f.stat().st_size})
    total_mb = sum(f["bytes"] for f in files) / 1e6
    # 动态定价 (kb-factory v2口径: 1元/G×质量系数, 底¥29)
    price = max(29, round(total_mb * 1.0 * 0.85))
    pkg = {"sku": f"KB-{camp.replace('EPC-', '')}", "title": f"{theme}·知识库",
           "files": files, "total_mb": round(total_mb, 2), "price": price,
           "pricing_rule": "1元/G×质量系数0.85, 底价29", "created": time.strftime("%Y-%m-%d %H:%M")}
    out = OUTDIR / camp / "knowledge_base_package.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(pkg, ensure_ascii=False, indent=1), encoding="utf-8")
    return {"pkg": str(out), "files": len(files), "mb": round(total_mb, 1), "price": price}


def product_pack(camp: str, theme: str) -> dict:
    """P2 资料包: 判例切片精选(按cjk密度top) → 资料包工单."""
    p = campaign_paths(camp)
    ranked = []
    for f in (p["slices"].glob("*.md") if p["slices"].is_dir() else []):
        try:
            density = cjk(f.read_text(encoding="utf-8", errors="replace")[:3000])
        except OSError:
            continue
        ranked.append((density, f.stem))
    ranked.sort(key=lambda x: -x[0])
    top = [r[1] for r in ranked[:8]]
    price = 19 if len(top) <= 5 else 39
    doc = {"sku": f"PACK-{camp.replace('EPC-', '')}", "title": f"{theme}·判例资料包",
           "selected": top, "price": price, "delivery": "微信交付+网盘",
           "created": time.strftime("%Y-%m-%d %H:%M")}
    out = OUTDIR / camp / "case_pack_order.json"
    out.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    return {"order": str(out), "selected": len(top), "price": price}


def product_derivs(camp: str) -> dict:
    """P3 多形态: 12章final → 速读版+清单版派生."""
    p = campaign_paths(camp)["sched"]
    finals = sorted(p.glob("_ch*_final.md")) if p.is_dir() else []
    if not finals:
        return {"derivs": 0, "note": "无final(未完成收编)——多形态派生待收编后"}
    # 速读版: 每章「本章小结」节选
    quick = [f"# {camp} 研究报告·速读版\n"]
    checklist = [f"# {camp} 研究报告·行动清单版\n"]
    for f in finals:
        t = f.read_text(encoding="utf-8", errors="replace")
        m = re.search(r"^# (第.+章 .+)$", t, re.M)
        ch_title = m.group(1) if m else f.stem
        quick.append(f"## {ch_title}\n")
        m2 = re.search(r"本章小结\s*\n+(.*?)\n\s*(?:使用本章|本章证据边界)", t, re.S)
        if m2:
            quick.append(m2.group(1).strip()[:1200] + "\n")
        # 清单版: 抓行动清单/清单段
        for mm in re.finditer(r"^(\d+\.\s*.{10,120})$", t, re.M):
            checklist.append(f"- [{ch_title[1:5]}] {mm.group(1)}")
    qpath = OUTDIR / camp / "速读版.md"
    cpath = OUTDIR / camp / "行动清单版.md"
    qpath.parent.mkdir(parents=True, exist_ok=True)
    qpath.write_text("\n".join(quick), encoding="utf-8")
    cpath.write_text("\n".join(checklist), encoding="utf-8")
    return {"derivs": 2, "quick": str(qpath), "checklist": str(cpath),
            "quick_cjk": cjk("\n".join(quick))}


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--theme", required=True)
    ap.add_argument("--stage", default="all", choices=["kb", "pack", "derivs", "all"])
    ns = ap.parse_args()
    r = {}
    if ns.stage in ("kb", "all"):
        r["kb"] = product_kb(ns.campaign, ns.theme)
        print(f"[P1知识库] {r['kb']['files']}件/{r['kb']['mb']}MB 定价¥{r['kb']['price']}")
    if ns.stage in ("pack", "all"):
        r["pack"] = product_pack(ns.campaign, ns.theme)
        print(f"[P2资料包] 精选{r['pack']['selected']}件 定价¥{r['pack']['price']}")
    if ns.stage in ("derivs", "all"):
        r["derivs"] = product_derivs(ns.campaign)
        print(f"[P3多形态] {r['derivs']}")
    ledger = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "campaign": ns.campaign, **r}
    with (FACT / "factory_ledger.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps({"stage": "PRODUCTS", **ledger}, ensure_ascii=False) + "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
