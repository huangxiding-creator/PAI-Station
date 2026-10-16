# -*- coding: utf-8 -*-
"""demand_signals_ask — 需求信号源①小程序提问日志采集器 (L1, TOPIC_FRAMEWORK).

问题=付费前真实犹豫。数据源: qianwen 引擎 answers 表 (本地 sqlite 旧线
逐位可用; TCB MySQL 生产线的公网导出待接线 — 有内网地址, 本机不可达).
输出: data/demand_signals/raw_ask_<date>.jsonl (公共 schema).

用法: py -X utf8 tools/demand_signals_ask.py [--db data/qianwen/db.sqlite] [--days 60]
"""
from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
OUT = REPO / "data" / "demand_signals"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--db", default=str(REPO / "data" / "qianwen" / "db.sqlite"))
    ap.add_argument("--days", type=int, default=90)
    ns = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    db = sqlite3.connect(ns.db)
    cutoff = time.strftime(
        "%Y-%m-%d %H:%M:%S", time.localtime(time.time() - ns.days * 86400))
    rows = db.execute(
        "SELECT created_at, openid, question, via FROM answers "
        "WHERE question IS NOT NULL AND created_at >= ? ORDER BY created_at",
        (cutoff,)).fetchall()
    n = 0
    out = OUT / f"raw_ask_{time.strftime('%Y%m%d')}.jsonl"
    with out.open("a", encoding="utf-8") as f:
        for ts, openid, q, via in rows:
            q = (q or "").strip()
            if len(q) < 6:                 # 过短噪声 (问候/测试)
                continue
            if re.fullmatch(r"(测试|test|你好|您好)[!！?]?", q):
                continue
            f.write(json.dumps({
                "ts": str(ts), "source": "ask",
                "channel": f"miniprogram:{via or 'ask'}",
                "actor": str(openid or "")[:18] + "…",
                "text": q[:500], "meta": {}}, ensure_ascii=False) + "\n")
            n += 1
    print(f"[ask] {n} 条真实提问 → {out.name} (窗 {ns.days}d)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
