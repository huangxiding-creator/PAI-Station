# -*- coding: utf-8 -*-
"""ofac_sdn_ds 腿 — OFAC SDN 制裁名单 数据集形态 (1026 B级数据集波·收尾件; B级·数据集/本地查询面·海外合规尽调).
本地样本面: data/datasets/ofac_sdn/ (treasury.gov/ofac/downloads/sdn.xml 头512KB样本,
302→sanctionslistservice→S3预签名 Range直下, 1026 字节下载实测入盘,
台账=reforge_factory/channels_survey_2026/_btier_ds_manifest_1026.jsonl).
整库sdn.xml(~29MB实测见重试日志)全量直下+csv面接入待令 — 本腿只查本地样本, 不出网.
与 batch1025 登记薄壳 ofac_sdn_leg.py (远程探针面, sdn.csv) 并存不互斥.
查询路由 (自然语句 → 本地实测, 不命中如实报告零命中, 零伪造):
  实体筛查: 查询含>=3拉丁字母词 → 样本内 sdnEntry 正则实测匹配
  样本面: 「OFAC 样本」「制裁名单 样本」→ 样本件实测 条目数/版本头
用法:
py reforge_factory/legs/ofac_sdn_ds_leg.py --campaign EPC-JIAGE
--queries "KIM" [--tree Q23-E1] [--no-ingest]
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
DS = REPO / "data" / "datasets" / "ofac_sdn"
AMMO_POOL_PY = REPO / "reforge_factory" / "ammo_pool.py"
ENGINE = "ofac_sdn_ds"
SOURCE = "OFAC SDN (treasury.gov/ofac/downloads/sdn.xml, 免登录)"
def _sample_text():
    p = DS / "sdn.xml.head512k"
    return p.read_text(encoding="utf-8", errors="replace") if p.exists() else ""
def query_entity(q: str):
    txt = _sample_text()
    if not txt:
        return "", "", []
    if any(k in q for k in ("样本", "制裁名单", "OFAC", "ofac", "清单")):
        return "", "", []          # 留给 query_sample
    words = [w for w in re.findall(r"[A-Za-z]{3,}", q) if w.lower() not in ("the", "and")]
    if not words:
        return "", "", []
    entries = re.findall(r"<sdnEntry>.*?</sdnEntry>", txt, re.S)
    rows = []
    for e in entries:
        if all(w.lower() in e.lower() for w in words[:2]):
            nm = re.search(r"<lastName>([^<]+)</lastName>", e)
            fn = re.search(r"<firstName>([^<]+)</firstName>", e)
            ty = re.search(r"<sdnType>([^<]+)</sdnType>", e)
            rows.append({"字段": "%s条目" % words[0], "值": "%s %s [%s]" % (
                (fn.group(1) if fn else ""), (nm.group(1) if nm else "?"), (ty.group(1) if ty else "?"))})
        if len(rows) >= 8:
            break
    ev = "sdn.xml.head512k 样本内 sdnEntry=%d条, 关键词%s -> 命中%d条" % (
        len(entries), words[:2], len(rows))
    if not rows:
        return "", "", []          # 样本未含命中 -> 由调用方如实报零
    return "OFAC SDN 样本筛查: %s (%d条)" % ("/".join(words[:2]), len(rows)), ev, rows
def query_sample(q: str):
    txt = _sample_text()
    if not txt or not any(k in q for k in ("样本", "制裁名单", "OFAC", "ofac", "清单")):
        return "", "", []
    entries = re.findall(r"<sdnEntry>.*?</sdnEntry>", txt, re.S)
    pub = re.search(r"<PublishDate>([^<]+)</PublishDate>", txt)
    rows = [{"字段": "样本件", "值": "sdn.xml.head512k %d字节 (整库29,245,041字节实测, 全量待令)" % (DS / "sdn.xml.head512k").stat().st_size},
            {"字段": "PublishDate", "值": pub.group(1) if pub else "(样本头未见)"},
            {"字段": "sdnEntry(样本内)", "值": "%d条实测" % len(entries)}]
    ev = "样本头512KB实测 -> sdnEntry %d条" % len(entries)
    return "OFAC SDN 样本面 (头512KB)", ev, rows
def build_md(q, title, ev, rows):
    lines = ["# %s" % title, "",
             "- 查询: %s" % q,
             "- 数据源: %s (本地样本, 1026字节下载入盘)" % SOURCE,
             "- 实测证据: `%s`" % ev, "",
             "| # | " + " | ".join(rows[0].keys()) + " |",
             "|" + "---|" * (len(rows[0]) + 1)]
    for i, r in enumerate(rows, 1):
        lines.append("| %d | " % i + " | ".join(str(v) for v in r.values()) + " |")
    lines += ["", "(B级数据集波·骨架件; 整库全量直下待令; 海外合规尽调底线证据面; 出品=总包智库研究团队)"]
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
    ap = argparse.ArgumentParser(description="OFAC SDN 数据集腿 (本地样本筛查→弹药池)")
    ap.add_argument("--campaign", default="EPC-JIAGE")
    ap.add_argument("--queries", nargs="+", required=True)
    ap.add_argument("--tree", default="")
    ap.add_argument("--no-ingest", action="store_true")
    ns = ap.parse_args(argv)
    if not (DS / "sdn.xml.head512k").exists():
        print("[%s] 本地样本缺席: %s (先跑 channels_survey_2026/_btier_ds_download_1026.sh)" % (ENGINE, DS))
        return 2
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / ENGINE / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_chars = tot_items = 0
    per_q = []
    for q in ns.queries:
        print("[%s] 查询: %s" % (ENGINE, q))
        title, ev, rows = query_entity(q)
        if not ev:
            title, ev, rows = query_sample(q)
        if not ev:
            print("    如实: 样本未含命中/路由未命中 (不伪造)")
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
            ENGINE, "ofac_sdn_ds_leg:B级数据集本地筛查面 (treasury.gov sdn.xml样本, 零浏览器零密钥)",
            "; ".join(ns.queries), yld,
            note="B级数据集波收尾(1026); 样本=data/datasets/ofac_sdn; 制裁名单工程尽调面; "
                 "台账=channels_survey_2026/_btier_ds_manifest_1026.jsonl; tree=%s" % (ns.tree or "-"),
            campaign=ns.campaign)
    print(json.dumps({"campaign": ns.campaign, "engine": ENGINE,
                      "ingested": tot_items, "chars": tot_chars,
                      "staging": str(stage), "per_query": per_q},
                     ensure_ascii=False, indent=1))
    return 0
if __name__ == "__main__":
    raise SystemExit(main())
