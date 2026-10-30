# -*- coding: utf-8 -*-
"""PAN-HUNTER 源健康轮（W3 · 2026-10-30）

跑法：python scripts/health_round.py            # 全 LIVE 源探活 → analysis/health_rounds/<ts>.json
      python scripts/health_round.py --kw 民法典 # 自定探针词（默认「测试」，对齐 ph.py doctor）

每轮产出：逐源 verdict（LIVE*/ALIVE_EMPTY/FAIL/...）+ 发数 + 与历轮对比的趋势（↑↓±）。
趋势=最近一轮该源 verdict 与本轮的迁移；首轮无趋势（baseline）。

7 天周期挂接（二选一，均**不自动注册**——按站内纪律留用户令）：
  ① OPE 调度腿（推荐，站内常令优先）：OPE 任务命令行=
     E:/AI-Station/.venv/Scripts/python.exe E:/AI-Station/逆向工程/pan-hunter/scripts/health_round.py
     周期=每 7 天一次（OPE cron 表达式 0 3 */7 * * 或工作流日历型）。
  ② Windows 计划任务（如用户明示要系统级）：
     schtasks /Create /TN "PANHUNTER_HealthRound" /SC WEEKLY /D MON /ST 03:30 ^
       /TR "E:\AI-Station\.venv\Scripts\python.exe E:\AI-Station\逆向工程\pan-hunter\scripts\health_round.py"
     删除=schtasks /Delete /TN "PANHUNTER_HealthRound" /F

预算：每轮 9 源×1 发（SearchSession 直连+代理重试均计）≈9-12 发；周期 7 天无频控压力。
判定词表沿用 searchagg/core（LIVE_JSON/HTML/SSE=活；ALIVE_EMPTY=活而零命中；FAIL=死/墙）。
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import LIVE_SOURCES, SearchSession, SearchLedger   # noqa: E402

ROUNDS_DIR = ROOT / "analysis" / "health_rounds"


def _verdict_of(status: int, hits: int, err: str) -> str:
    if err:
        return "FAIL"
    if status == 200:
        return f"LIVE(hits={hits})" if hits else "ALIVE_EMPTY"
    return f"HTTP_{status}"


def _prev_rounds() -> list[Path]:
    if not ROUNDS_DIR.exists():
        return []
    return sorted(ROUNDS_DIR.glob("*.json"))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--kw", default="测试")
    args = ap.parse_args()

    ROUNDS_DIR.mkdir(parents=True, exist_ok=True)
    prev = _prev_rounds()
    prev_status: dict[str, str] = {}
    if prev:
        try:
            old = json.loads(prev[-1].read_text(encoding="utf-8"))
            prev_status = {s["source"]: s["verdict"] for s in old.get("sources", [])}
        except Exception:
            pass

    ledger = SearchLedger(str(ROUNDS_DIR / f"ledger_{time.strftime('%Y%m%d_%H%M%S')}.jsonl"))
    rows = []
    for src in LIVE_SOURCES:
        t0 = time.time()
        try:
            sess = SearchSession(src, ledger)
            hits = sess.search(args.kw)
            last = ledger.rows[-1] if ledger.rows else {}
            v = _verdict_of(last.get("status", 0), len(hits), "")
        except Exception as e:
            v = f"FAIL({type(e).__name__})"
        trend = ""
        if src in prev_status:
            a, b = prev_status[src], v
            trend = "±持平" if a == b else ("↑" if b.startswith("LIVE") and not a.startswith("LIVE")
                                           else ("↓" if a.startswith("LIVE") and not b.startswith("LIVE")
                                                 else f"迁移:{a[:12]}→{b[:12]}"))
        rows.append({"source": src, "verdict": v, "elapsed_s": round(time.time() - t0, 1),
                     "trend_vs_prev": trend})
        print(f"  {src:16s} {v:22s} {rows[-1]['elapsed_s']:5.1f}s  {trend}", flush=True)

    live_n = sum(1 for r in rows if r["verdict"].startswith("LIVE"))
    doc = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "kw": args.kw,
           "live_sources": live_n, "total_sources": len(rows),
           "shots": ledger.shots, "prev_round": prev[-1].name if prev else None,
           "sources": rows}
    out = ROUNDS_DIR / (time.strftime("%Y%m%d_%H%M%S") + ".json")
    out.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\n== 健康轮收官：活源 {live_n}/{len(rows)}（{ledger.shots} 发）→ {out.name}")
    print(f"   历轮档案 {len(prev)} 份；7 天周期挂接法见本文件头注（OPE/计划任务二选一，不自动注册）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
