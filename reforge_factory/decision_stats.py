# -*- coding: utf-8 -*-
"""decision_stats — 决策账本统计查询 (T-005, REQ-040.AC1).

输出: 决策总数 / 已回填数 / 回填率 / 分域计数 (按八枚举 decision_type),
附已回填记录的均值分 (季度决策质量分底料, KB 问责回路).

用法:
    py reforge_factory/decision_stats.py --campaign EPC-BID26
    py reforge_factory/decision_stats.py --campaign EPC-BID26 --json
    py reforge_factory/decision_stats.py --campaign EPC-BID26 \
        --pool-root E:\\AI-Station\\ammo_pool

退出码: 0=正常 (含零决策账本), 1=账本脏行/参数错. 纯标准库.
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import decision_ledger as DL                           # noqa: E402


def summarize(records: list[dict]) -> dict:
    """纯函数: 账本记录列表 → 统计 dict (空账本不炸, 率为 0.0)."""
    total = len(records)
    filled = [r for r in records if r.get("outcome") is not None]
    by_type: dict[str, int] = {}
    for r in records:
        dt = str(r.get("decision_type") or "?")
        by_type[dt] = by_type.get(dt, 0) + 1
    scores = [r["score"] for r in filled
              if isinstance(r.get("score"), (int, float))
              and not isinstance(r.get("score"), bool)]
    return {
        "total": total,
        "filled": len(filled),
        "fill_rate": (len(filled) / total) if total else 0.0,
        "by_decision_type": dict(sorted(by_type.items())),
        "mean_score": (round(sum(scores) / len(scores), 4)) if scores else None,
    }


def _render(campaign: str, s: dict) -> str:
    lines = [
        f"campaign={campaign} total={s['total']} filled={s['filled']} "
        f"fill_rate={s['fill_rate'] * 100:.2f}%"
    ]
    if s["mean_score"] is not None:
        lines.append(f"mean_score={s['mean_score']}")
    if s["by_decision_type"]:
        dom = " ".join(f"{k}={v}" for k, v in s["by_decision_type"].items())
        lines.append(f"by_decision_type: {dom}")
    return "\n".join(lines)


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="决策账本统计 (REQ-040.AC1): 总数/已回填/回填率/分域计数")
    ap.add_argument("--campaign", required=True, help="战役 id (ammo_pool/<id>)")
    ap.add_argument("--pool-root", default=None,
                    help="池根目录 (缺省 reforge_factory 同级 ammo_pool/)")
    ap.add_argument("--json", action="store_true", help="机器可读 JSON 输出")
    args = ap.parse_args(argv)

    try:
        records = DL.load_records(args.campaign, pool_root=args.pool_root)
    except ValueError as exc:
        print(f"[decision_stats] ERROR {exc}", file=sys.stderr)
        return 1
    s = summarize(records)
    if args.json:
        print(json.dumps({"campaign": args.campaign, **s},
                         ensure_ascii=False, indent=2))
    else:
        print(_render(args.campaign, s))
    return 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:                                   # 非 Windows/无 tty 不致命
        pass
    sys.exit(main())
