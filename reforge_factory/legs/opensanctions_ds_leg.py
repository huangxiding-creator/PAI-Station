# -*- coding: utf-8 -*-
"""opensanctions_ds 腿 — OpenSanctions 数据集形态 (1026 B级数据集波·收尾件; B级·数据集/本地查询面).
本地样本面: data/datasets/opensanctions/ (index.json 全量 + us_ofac_sdn entities.ftm.json 头64KB,
1026 字节下载实测入盘, 台账=reforge_factory/channels_survey_2026/_btier_ds_manifest_1026.jsonl).
远程整库直下面(大批量gz)接入待令 — 本腿只查本地样本, 不出网 (零浏览器零密钥).
与 batch1025 登记薄壳 opensanctions_leg.py (远程探针面) 并存不互斥.
查询路由 (自然语句 → 本地实测, 不命中如实报告零命中, 零伪造):
  数据集卡片: 「us_ofac_sdn 制裁名单」→ index.json 实测 entity_count/资源清单
  目录总览: 「OpenSanctions 目录」「数据集总览」→ 全目录计数+实体量Top10
用法:
py reforge_factory/legs/opensanctions_ds_leg.py --campaign EPC-JIAGE
--queries "us_ofac_sdn 数据集卡片" [--tree Q23-E1] [--no-ingest]
"""
from __future__ import annotations
import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb                     # noqa: E402 (台账只增)
REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
DS = REPO / "data" / "datasets" / "opensanctions"
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
ENGINE = "opensanctions_ds"
SOURCE = "OpenSanctions datasets latest (data.opensanctions.org, 免登录直下)"
def _load_index():
    p = DS / "index.json"
    if not p.exists():
        return None
    try:
        return json.loads(p.read_text(encoding="utf-8", errors="replace"))
    except Exception:
        return None
def query_dataset_card(q: str):
    idx = _load_index()
    if not idx:
        return "", "", []
    name = next((n for n in ("us_ofac_sdn", "us_trade_csl", "eu_fsf", "ru_nsd_isin") if n in q.lower()), "")
    m = re.search(r"[a-z]{2,}_[a-z0-9_]{3,}", q.lower())
    if not name and m:
        name = m.group(0)
    ds = None
    if name:
        ds = next((d for d in idx.get("datasets", []) if d.get("name") == name), None)
    if ds is None:
        return "", "", []
    rows = [{"字段": k, "值": str(ds.get(k))} for k in
            ("name", "title", "version", "updated_at", "last_change",
             "entity_count", "thing_count", "target_count") if k in ds]
    for r in (ds.get("resources") or [])[:8]:
        rows.append({"字段": "resource", "值": "%s %s %s" % (
            r.get("name", ""), r.get("mime_type", ""), r.get("url") or r.get("path", ""))})
    ev = "index.json datasets[name=%s] -> %d字段实测" % (name, len(rows))
    return "OpenSanctions 数据集卡片: %s" % name, ev, rows
def query_catalog(q: str):
    idx = _load_index()
    if not idx:
        return "", "", []
    if not any(k in q for k in ("目录", "总览", "catalog", "overview", "Top")):
        return "", "", []
    dss = idx.get("datasets", [])
    top = sorted(dss, key=lambda d: d.get("entity_count") or 0, reverse=True)[:10]
    rows = [{"数据集": d.get("name", ""), "实体量": d.get("entity_count", 0),
             "更新": str(d.get("updated_at", ""))[:10]} for d in top]
    ev = "index.json datasets 全目录 -> %d个数据集实测, 实体量Top10" % len(dss)
    return "OpenSanctions 目录总览 (实体量Top10/全%d)" % len(dss), ev, rows
def build_md(q, title, ev, rows):
    lines = ["# %s" % title, "",
             "- 查询: %s" % q,
             "- 数据源: %s (本地样本, 1026字节下载入盘)" % SOURCE,
             "- 实测证据: `%s`" % ev, "",
             "| # | " + " | ".join(rows[0].keys()) + " |",
             "|" + "---|" * (len(rows[0]) + 1)]
    for i, r in enumerate(rows, 1):
        lines.append("| %d | " % i + " | ".join(str(v) for v in r.values()) + " |")
    ftm = DS / "us_ofac_sdn.ftm.json.head64k"
    if ftm.exists():
        lines += ["", "样本件: us_ofac_sdn.ftm.json.head64k = %d字节 (头样本, 整库直下待令)" % ftm.stat().st_size]
    lines += ["", "(B级数据集波·骨架件; 出品=总包智库研究团队)"]
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
    ap = argparse.ArgumentParser(description="OpenSanctions 数据集腿 (本地样本查询→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--tree", default="")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    if not (DS / "index.json").exists():
        print("[%s] 本地样本缺席: %s (先跑 channels_survey_2026/_btier_ds_download_1026.sh)" % (ENGINE, DS))
        return 2
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_chars = tot_items = 0
    per_q = []
    for q in ns.queries:
        print("[%s] 查询: %s" % (ENGINE, q))
        title, ev, rows = query_dataset_card(q)
        if not ev:
            title, ev, rows = query_catalog(q)
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
            ENGINE, "opensanctions_ds_leg:B级数据集本地查询面 (data.opensanctions.org样本, 零浏览器零密钥)",
            "; ".join(ns.queries), yld,
            note="B级数据集波收尾(1026); 样本=data/datasets/opensanctions; "
                 "台账=channels_survey_2026/_btier_ds_manifest_1026.jsonl; tree=%s" % (ns.tree or "-"),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "ingested": tot_items, "chars": tot_chars,
                      "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0
if __name__ == "__main__":
    raise SystemExit(main())
