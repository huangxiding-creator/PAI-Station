# -*- coding: utf-8 -*-
"""aiddata_gcdf_ds 腿 — AidData GeoGCDF 数据集形态 (1026 B级数据集波·收尾件; B级·数据集/本地查询面).
本地样本面: data/datasets/aiddata/ (gcdf latest/version.txt + geojsons/100.geojson 样本,
源=github.com/aiddata/gcdf-geospatial-data raw直链, 1026 字节下载实测入盘,
台账=reforge_factory/channels_survey_2026/_btier_ds_manifest_1026.jsonl).
整库geojsons(上千件/全部项目id)接入待令 — 本腿只查本地样本, 不出网 (零浏览器零密钥).
与 batch1025 登记薄壳 aiddata_leg.py (远程探针面) 并存不互斥.
查询路由 (自然语句 → 本地实测, 不命中如实报告零命中, 零伪造):
  版本: 「AidData 版本」「version」→ version.txt 实测
  样本: 「100.geojson」「geojson」「样本」→ 样本件实测 feature数/属性面/几何类型
用法:
py reforge_factory/legs/aiddata_gcdf_ds_leg.py --campaign EPC-JIAGE
--queries "AidData 版本" [--tree Q23-E1] [--no-ingest]
"""
from __future__ import annotations
import argparse
import json
import re
import subprocess
import sys
import time
from collections import Counter
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb                     # noqa: E402 (台账只增)
REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
DS = REPO / "data" / "datasets" / "aiddata"
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
ENGINE = "aiddata_gcdf_ds"
SOURCE = "AidData GeoGCDF (github raw, aiddata/gcdf-geospatial-data, 免登录)"
def query_version(q: str):
    p = DS / "version.txt"
    if not p.exists() or not any(k in q.lower() for k in ("版本", "version", "aiddata")):
        return "", "", []
    ver = p.read_text(encoding="utf-8", errors="replace").strip()
    rows = [{"字段": "version", "值": ver},
            {"字段": "文件", "值": "latest/version.txt %d字节" % p.stat().st_size}]
    ev = "version.txt 实测 -> [%s]" % ver
    return "AidData GeoGCDF 版本 (latest)", ev, rows
def query_geojson(q: str):
    p = DS / "100.geojson"
    if not p.exists() or not any(k in q.lower() for k in ("geojson", "样本", "100", "项目")):
        return "", "", []
    try:
        gj = json.loads(p.read_text(encoding="utf-8", errors="replace"))
    except Exception:
        return "", "", []
    feats = gj.get("features") or []
    rows = [{"字段": "type", "值": str(gj.get("type", ""))},
            {"字段": "features", "值": "%d" % len(feats)}]
    gtypes = Counter(str((f.get("geometry") or {}).get("type", "?")) for f in feats)
    for g, n in gtypes.most_common(5):
        rows.append({"字段": "geometry", "值": "%s ×%d" % (g, n)})
    if feats:
        props = feats[0].get("properties") or {}
        for k in list(props)[:10]:
            rows.append({"字段": "property", "值": "%s = %s" % (k, str(props[k])[:60])})
    ev = "100.geojson 实测 -> %d个feature, %d个首件属性" % (len(feats), len(feats[0].get("properties") or {}) if feats else 0)
    return "AidData GeoGCDF 样本 100.geojson (%d要素)" % len(feats), ev, rows
def build_md(q, title, ev, rows):
    lines = ["# %s" % title, "",
             "- 查询: %s" % q,
             "- 数据源: %s (本地样本, 1026字节下载入盘)" % SOURCE,
             "- 实测证据: `%s`" % ev, "",
             "| # | " + " | ".join(rows[0].keys()) + " |",
             "|" + "---|" * (len(rows[0]) + 1)]
    for i, r in enumerate(rows, 1):
        lines.append("| %d | " % i + " | ".join(str(v) for v in r.values()) + " |")
    lines += ["", "(B级数据集波·骨架件; 整库geojsons直下待令; 出品=总包智库研究团队)"]
    return "\n".join(lines)
def pool_ingest(campaign, md, tree):
    cmd = [sys.executable, "-X", "utf8", str(AMMO_POOL_PY), "ingest", campaign,
           "--file", str(md), "--engine", ENGINE, "--cred", "research"]
    if tree:
        cmd += ["--tree", tree]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=180)
    out = (r.stdout or "") + (r.stderr or "")
    m = re.search(r"\+待审\s+([\d,]+)字", out)
    chars = int(m.group(1).replace(",", "")) if m else 0
    tail = out.strip().splitlines()[-1] if out.strip() else "(无输出)"
    print("    " + tail)
    return r.returncode, chars
def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="AidData GeoGCDF 数据集腿 (本地样本查询→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--tree", default="")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    if not (DS / "version.txt").exists():
        print("[%s] 本地样本缺席: %s (先跑 channels_survey_2026/_btier_ds_download_1026.sh)" % (ENGINE, DS))
        return 2
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_chars = tot_items = 0
    per_q = []
    for q in ns.queries:
        print("[%s] 查询: %s" % (ENGINE, q))
        title, ev, rows = query_version(q)
        if not ev:
            title, ev, rows = query_geojson(q)
        if not ev:
            print("    如实: 路由未命中 (不伪造)")
            per_q.append({"query": q, "rows": 0, "ingested": 0})
            continue
        md = build_md(q, title, ev, rows)
        slug = re.sub(r"[^0-9A-Za-z\u4e00-\u9fff]+", "-", q).strip("-")[:48] or "query"
        md_path = stage / (slug + ".md")
        md_path.write_text(md, encoding="utf-8")
        print("    实测 %d 行 -> %s (%d字面)" % (len(rows), md_path.name, len(md)))
        if not ns.no_ingest and len(md) >= 300:
            rc, ch = pool_ingest(ns.campaign, md_path, ns.tree)
            if rc == 0 and ch > 0:
                tot_items += 1
                tot_chars += ch
        per_q.append({"query": q, "rows": len(rows),
                      "ingested": 1 if (not ns.no_ingest and len(md) >= 300) else 0})
    if not ns.no_ingest:
        yld = "%d查询/%d件%s字入池" % (len(ns.queries), tot_items, format(tot_chars, ","))
        arb.append_invocation(
            ENGINE, "aiddata_gcdf_ds_leg:B级数据集本地查询面 (aiddata/gcdf-geospatial-data样本, 零浏览器零密钥)",
            "; ".join(ns.queries), yld,
            note="B级数据集波收尾(1026); 样本=data/datasets/aiddata; "
                 "台账=channels_survey_2026/_btier_ds_manifest_1026.jsonl; tree=%s" % (ns.tree or "-"),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "ingested": tot_items, "chars": tot_chars,
                      "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0
if __name__ == "__main__":
    raise SystemExit(main())
