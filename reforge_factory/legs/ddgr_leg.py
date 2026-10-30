# -*- coding: utf-8 -*-
"""ddgr 腿 — DuckDuckGo 终端搜索 CLI (1025 渠道普查纳管令; A级·通用网研).

注册表: channels_survey_2026/MASTER_REGISTRY.json (ddgr, jarun/ddgr,
免key CLI(pip/npm), 3559★, push 2026-08-16); DuckDuckGo 终端搜索 REPL。
本腿=CLI 型采集骨架: ddgr 在盘则跑 (--json --np, 输出JSON结构化),
CLI 缺件如实记零伪造 (不擅自 pip install — 装件待用户令)。
staging+ingest 照 last30days_leg.py 模式 (共用芯 build_md/pool_ingest)。

用法: py reforge_factory/legs/ddgr_leg.py --campaign EPC-JIAGE
      --queries "construction cost index"
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import api_replica_bridge as arb
import http_api_leg_core as core

REPO = Path(__file__).resolve().parents[2]
ENGINE = "ddgr"


def main() -> int:
    ap = argparse.ArgumentParser(description="ddgr 渠道腿 (DDG CLI→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--rows", type=int, default=8)
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args()
    ddgr = shutil.which("ddgr")
    print("[leg] engine=ddgr | CLI=%s" % (ddgr or "缺件(不在PATH)"))

    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_hits = tot_items = tot_chars = 0
    per_q, fails = [], []
    for q in ns.queries:
        if not ddgr:
            fails.append({"query": q, "status": 0,
                          "err": "ddgr CLI 缺件 (PATH 不可寻址, 不擅自安装)"})
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0})
            print("    如实失败: ddgr CLI 缺件")
            continue
        print("[leg] 查询: " + q)
        try:
            r = subprocess.run(
                [ddgr, "--json", "--np", "-n", str(ns.rows), q],
                capture_output=True, text=True, encoding="utf-8",
                errors="replace", timeout=90)
            out = (r.stdout or "") + (r.stderr or "")
            hits = []
            for ln in out.splitlines():
                ln = ln.strip()
                if not ln.startswith("{"):
                    continue
                try:
                    d = json.loads(ln)
                except json.JSONDecodeError:
                    continue
                hits.append({"title": str(d.get("title") or "(无题)"),
                             "url": str(d.get("url") or ""),
                             "meta": [str(d.get("host") or "")],
                             "excerpt": str(d.get("abstract")
                                            or d.get("snippet") or "")[:1200]})
        except (OSError, subprocess.TimeoutExpired) as e:
            fails.append({"query": q, "status": 0,
                          "err": "ddgr 运行失败 %s: %s" % (type(e).__name__, e)})
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0})
            print("    如实失败: %s" % e)
            continue
        tot_hits += len(hits)
        if hits:
            md_text, url0 = core.build_md(
                ENGINE, "ddgr (DuckDuckGo 终端搜索 CLI)", q, hits,
                "CLI=%s" % ddgr)
            slug = core.slugify(q)
            md_path = stage / (slug + ".md")
            md_path.write_text(md_text, encoding="utf-8")
            (stage / (slug + ".json")).write_text(
                json.dumps(hits, ensure_ascii=False, indent=1), encoding="utf-8")
            print("    引擎命中 %d 条 -> %s (%d字面)" % (len(hits), md_path.name, len(md_text)))
            ing = ch = 0
            if not ns.no_ingest and len(md_text) >= 300:
                rc, ch = core.pool_ingest(ns.campaign, md_path, ENGINE, url0)
                if rc == 0 and ch > 0:
                    ing = 1
            tot_items += ing
            tot_chars += ch
            per_q.append({"query": q, "hits": len(hits), "ingested": ing, "chars": ch})
        else:
            print("    如实: 零命中 (不伪造)")
            per_q.append({"query": q, "hits": 0, "ingested": 0, "chars": 0})
    if not ns.no_ingest:
        yld = "%d查询%d命中/%d件%s字入池" % (
            len(ns.queries), tot_hits, tot_items, format(tot_chars, ","))
        if fails:
            yld += " | 失败%d: %s" % (len(fails), json.dumps(
                [{"q": f["query"]} for f in fails], ensure_ascii=False))
        arb.append_invocation(
            ENGINE, "cli_leg:ddgr (jarun/ddgr 3559★, --json --np)",
            "; ".join(ns.queries), yld,
            note="1025 渠道普查纳管令 A级接入; CLI=%s; 缺件=如实记不擅自安装"
                 % (ddgr or "缺件"), campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "queries": len(ns.queries), "hits": tot_hits,
                      "ingested": tot_items, "chars": tot_chars,
                      "fails": fails, "staging": str(stage),
                      "per_query": per_q}, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
