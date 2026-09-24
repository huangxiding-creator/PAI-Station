# -*- coding: utf-8 -*-
"""双轨周报生成器（P1 验收件：延迟/准确不降、成本归零的证明面）。

读 JudgmentClient traj 落盘（data/traj/jev-{position}.jsonl 等），
按位聚合：调用量/主引擎延迟分布/影子覆盖与一致率/缺席率。
口径（P1 DoD）：
  - 准确不降 ≈ 未过门位的 laya 影子与 typesafe 主答 agree 率（choice 同选
    / noul |Δ|≤0.15，见 client._answers_agree）；agree=None 不计分母
  - 延迟不降 ≈ 主引擎 vs 影子延迟分布（laya 影子额外开销≈其自身延迟）
  - 成本归零 ≈ 已切位的 calls 全落 laya 引擎、typesafe calls 仅剩未过门位
用法:
  python tools/dual_track_report.py [--days 7] [--traj <glob>...] [--out <md>]
"""
from __future__ import annotations

import argparse
import glob
import io
import json
import sys
import time
from collections import defaultdict
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def _pct(sorted_vals: list[float], q: float) -> float:
    if not sorted_vals:
        return 0.0
    i = min(int(len(sorted_vals) * q), len(sorted_vals) - 1)
    return sorted_vals[i]


def load_rows(paths: list[str], days: int) -> list[dict]:
    cutoff = time.strftime("%Y-%m-%dT%H:%M:%S",
                           time.localtime(time.time() - days * 86400))
    rows = []
    for pat in paths:
        for fp in glob.glob(pat):
            p = Path(fp)
            if not p.is_file():
                continue
            try:
                lines = io.open(p, encoding="utf-8").read().splitlines()
            except OSError:
                continue
            for ln in lines:
                ln = ln.strip()
                if not ln:
                    continue
                try:
                    r = json.loads(ln)
                except ValueError:
                    continue
                if r.get("ts", "") >= cutoff:
                    rows.append(r)
    return rows


def aggregate(rows: list[dict]) -> dict:
    """traj 行 → {position: metrics}（position 缺席归 "-"）。"""
    per: dict[str, dict] = defaultdict(lambda: {
        "calls": 0, "ok": 0, "lat": [], "engines": defaultdict(int),
        "dual_seen": 0, "dual_agree": 0, "dual_null": 0, "dual_err": 0,
        "dual_lat": [], "by_qtype": defaultdict(int)})
    for r in rows:
        pos = r.get("position") or "-"
        m = per[pos]
        m["calls"] += 1
        m["ok"] += 1 if r.get("ok") else 0
        if isinstance(r.get("latency_s"), (int, float)):
            m["lat"].append(float(r["latency_s"]))
        m["engines"][r.get("engine") or "?"] += 1
        for t in (r.get("q") or {}).values():
            m["by_qtype"][t or "?"] += 1
        d = r.get("dual")
        if isinstance(d, dict):
            m["dual_seen"] += 1
            if d.get("error"):
                m["dual_err"] += 1
            elif d.get("agree") is True:
                m["dual_agree"] += 1
            elif d.get("agree") is None:
                m["dual_null"] += 1
            if isinstance(d.get("latency_s"), (int, float)):
                m["dual_lat"].append(float(d["latency_s"]))
    return per


def render(per: dict, days: int, generated_at: str) -> str:
    lines = [f"# Jev 判断层双轨周报（近 {days} 天 · {generated_at}）", "",
             "| 位 | 调用 | ok率 | 主引擎 | 主延迟 p50/p95 | 影子覆盖 | "
             "影子一致率 | 影子延迟 p50 | 影子错误 |",
             "|---|---|---|---|---|---|---|---|---|"]
    for pos in sorted(per):
        m = per[pos]
        lat = sorted(m["lat"])
        dlat = sorted(m["dual_lat"])
        denom = m["dual_agree"] + (per[pos]["dual_seen"]
                                   - m["dual_agree"] - m["dual_null"]
                                   - m["dual_err"])
        agree = (f"{m['dual_agree'] / denom:.1%}" if denom else "—")
        cov = f"{m['dual_seen'] / m['calls']:.1%}" if m["calls"] else "—"
        engines = "+".join(f"{e}×{n}" for e, n in
                           sorted(m["engines"].items())) or "—"
        lines.append(
            f"| {pos} | {m['calls']} | {m['ok'] / m['calls']:.1%} | {engines} "
            f"| {_pct(lat, 0.5):.2f}s/{_pct(lat, 0.95):.2f}s "
            f"| {cov} | {agree} | {_pct(dlat, 0.5):.2f}s | {m['dual_err']} |")
    lines += ["", "口径：一致率=choice 同选或 noul |Δ|≤0.15（None 不计分母）；"
              "影子错误≥3 连发触发该实例影子停摆；ok率<100% 的位看熔断/网络日志。",
              "读法：未过门位影子一致率连续一周 ≥95% → 该位 [engines] 切 laya；"
              "已切位（taskcards/golden）主引擎应显示 laya×N、typesafe 调用归零。"]
    return "\n".join(lines) + "\n"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=7)
    ap.add_argument("--traj", nargs="*", default=None,
                    help="traj 文件/glob（默认 data/traj/*.jsonl）")
    ap.add_argument("--out", default=None, help="markdown 输出路径")
    args = ap.parse_args()
    paths = args.traj or [str(REPO / "data" / "traj" / "*.jsonl")]
    rows = load_rows(paths, args.days)
    if not rows:
        print(f"[dual-track] 窗口内零 traj 行（paths={paths}）——"
              "接线位尚未产生调用或 traj 未落盘")
        return 1
    per = aggregate(rows)
    md = render(per, args.days, time.strftime("%Y-%m-%d %H:%M"))
    out = Path(args.out) if args.out else REPO / "data" / "traj" / "dual_track_report.md"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(md, encoding="utf-8")
    print(md)
    print(f"[dual-track] 落档 {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
