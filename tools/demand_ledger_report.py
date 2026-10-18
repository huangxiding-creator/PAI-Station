# -*- coding: utf-8 -*-
"""demand_ledger_report — 需求台账热力周报 (F8) + 选题直通 (F9).

跨面语义归并 → 热力榜 + JTBD 精选 + 选题建议（写 radar_topics 候选）。
用法: py -X utf8 tools/demand_ledger_report.py [--top 15] [--no-bridge]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import demand_ledger as dl  # noqa: E402

REPO = Path(__file__).resolve().parents[1]
TOPICS = REPO / "reforge_factory" / "superline" / "radar_topics.json"
OUTDIR = REPO / "data" / "demand_ledger"

FACE_CN = {"group": "群聊", "p2p": "私聊", "moments": "朋友圈",
           "gzh_comment": "公众号评论", "sph_comment": "视频号评论",
           "mp_feedback": "买家反馈", "ask_log": "咨询问答", "purchase": "购买行为"}


def bridge(top_rows: list[dict]) -> int:
    """F9: Top 选题 → radar_topics.json 候选（幂等）。"""
    topics = json.loads(TOPICS.read_text(encoding="utf-8")) if TOPICS.exists() else []
    existed = {str(t.get("topic")) for t in topics}
    added = 0
    for r in top_rows[:6]:
        quote = r.get("demand_quote", "")[:20]
        title = f"群众需求·{quote}"
        if title in existed:
            continue
        topics.append({"topic": title, "pool": "ammo_pool/EPC-JSFDD",
                       "note": f"需求台账Top({r['merged_count']}面聚合): {r.get('demand_quote','')[:44]}"})
        added += 1
    if added:
        TOPICS.write_text(json.dumps(topics, ensure_ascii=False, indent=1), encoding="utf-8")
    return added


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=15)
    ap.add_argument("--no-bridge", action="store_true")
    ns = ap.parse_args()
    rows = dl.read()
    if not rows:
        print("[报告] 台账为空")
        return 1
    merged = dl.semantic_dedupe(rows)
    st = dl.stats()
    lines = [f"# 需求资产台账·热力周报 {time.strftime('%Y-%m-%d')}", "",
             f"> 总信号 {st['total']} | 面分布 {st['by_face']}",
             f"> 语义归并族 {len(merged)}", "",
             "## 热力榜（跨面聚合 Top）", "",
             "| # | 需求（代表句） | 聚合 | 面 | 频率 |", "|---|---|---|---|---|"]
    for i, r in enumerate(merged[:ns.top], 1):
        faces = "+".join(FACE_CN.get(f, f) for f in r.get("merged_faces", []))
        lines.append(f"| {i} | {r['demand_quote'][:40]} | ×{r['merged_count']} "
                     f"| {faces} | {r.get('frequency',1)} |")
    lines += ["", "## JTBD 精选（前5条完整）", ""]
    for r in merged[:5]:
        lines.append(f"**{r['demand_quote'][:50]}**")
        lines.append(f"- 面来源: {r['source_face']} | 触发: {r.get('jtbd',{}).get('trigger','?')}")
        lines.append(f"- 任务: {r.get('jtbd',{}).get('job_statement','—')}")
        lines.append(f"- 期望: {r.get('jtbd',{}).get('outcome','—')}")
        lines.append("")
    OUTDIR.mkdir(parents=True, exist_ok=True)
    fp = OUTDIR / f"weekly_{time.strftime('%Y%m%d')}.md"
    fp.write_text("\n".join(lines), encoding="utf-8")
    (OUTDIR / "latest.md").write_text("\n".join(lines), encoding="utf-8")
    added = 0 if ns.no_bridge else bridge(merged)
    print(f"[报告] {fp.name} | 信号{st['total']} 族{len(merged)} | 桥接新增候选 {added}")
    print("\n".join(lines[:18]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
