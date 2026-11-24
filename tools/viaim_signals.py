# -*- coding: utf-8 -*-
"""viaim_signals — 讯飞耳机录音 → 需求信号缓存 (1125 用户令: 需求洞察接入耳机录音).

拉取 viaim (iFLYBUDS) 最近录音的 title/overview/sub_title → 增量缓存
data/factory/viaim_signals.jsonl (record_id 去重)。内容留在本地, 挖掘时只送
标题+摘要给 GLM (与社群原话同信任边界), 原始录音/转写全文绝不出库。

用法:
  py -X utf8 tools/viaim_signals.py pull [--days 7] [--page-size 50]
  py -X utf8 tools/viaim_signals.py stats
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
OUT = REPO / "data" / "factory" / "viaim_signals.jsonl"
STATE = REPO / "data" / "factory" / "viaim_signals.state.json"


def _cli(args: list) -> dict:
    r = subprocess.run(["viaim-cli", *args], capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=120)
    try:
        return json.loads(r.stdout)
    except Exception:
        return {"ok": False, "error": {"message": (r.stdout or r.stderr or "")[:200]}}


def pull(days: int, page_size: int) -> int:
    seen = set()
    if OUT.is_file():
        for ln in OUT.read_text(encoding="utf-8").splitlines():
            try:
                seen.add(json.loads(ln).get("record_id"))
            except Exception:
                pass
    since = int((time.time() - days * 86400) * 1000)
    tag, added, scanned = "", 0, 0
    for _ in range(10):  # 分页保护 ≤10页
        args = ["record", "list", "--page-size", str(page_size),
                "--start-ts", str(since)]
        if tag:
            args += ["--page-tag", tag]
        d = _cli(args)
        if not d.get("ok"):
            print(f"[viaim] list 失败: {d.get('error', {}).get('message', '')[:120]}")
            return 1
        data = d.get("data", {})
        rows = data.get("data", [])
        scanned += len(rows)
        new_rows = []
        for r in rows:
            rid = r.get("record_id")
            if not rid or rid in seen:
                continue
            seen.add(rid)
            # 只收有实质摘要的 (overview 非空; 纯闲聊短概述也可入池由挖掘侧剔除)
            rec = {"record_id": rid,
                   "ts": time.strftime("%Y-%m-%d %H:%M", time.localtime(
                       (r.get("record_time") or 0) / 1000)),
                   "title": (r.get("title") or "").strip()[:80],
                   "overview": (r.get("overview") or "").strip()[:300],
                   "sub_title": (r.get("sub_title") or "").strip()[:120],
                   "duration_min": round((r.get("duration") or 0) / 60000, 1),
                   "pulled_at": time.strftime("%Y-%m-%d %H:%M:%S")}
            new_rows.append(rec)
        if new_rows:
            with OUT.open("a", encoding="utf-8") as f:
                for rec in new_rows:
                    f.write(json.dumps(rec, ensure_ascii=False) + "\n")
            added += len(new_rows)
        tag = data.get("page_tag") or ""
        if not tag:
            break
    STATE.write_text(json.dumps({"last_pull": time.strftime("%Y-%m-%d %H:%M:%S"),
                                 "scanned": scanned, "added": added,
                                 "total": len(seen)}, ensure_ascii=False), encoding="utf-8")
    print(f"[viaim] 扫描 {scanned} 条 → 新增信号 {added} 条 (累计 {len(seen)})")
    return 0


def stats() -> int:
    n = sum(1 for _ in OUT.open(encoding="utf-8")) if OUT.is_file() else 0
    st = json.loads(STATE.read_text(encoding="utf-8")) if STATE.is_file() else {}
    print(f"[viaim] 信号缓存 {n} 条 | {st}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    g = sub.add_parser("pull")
    g.add_argument("--days", type=int, default=7)
    g.add_argument("--page-size", type=int, default=50)
    sub.add_parser("stats")
    ns = ap.parse_args()
    return pull(ns.days, ns.page_size) if ns.cmd == "pull" else stats()


if __name__ == "__main__":
    raise SystemExit(main())
