"""意图结算 CLI。

用法：
  python -m paistation.sovereign.settle settle    # 回执→价值入账（幂等）
  python -m paistation.sovereign.settle statement # per-outcome 对账单
  python -m paistation.sovereign.settle ledger    # 逐事件（含 basis 审计串）
  python -m paistation.sovereign.settle demo      # 验收 demo：意图→卡→交付→入账
"""
from __future__ import annotations

import argparse
import json
import sys
import tempfile
from pathlib import Path

from . import OutcomeLedger, ingest


def _find_root() -> Path:
    for parent in Path(__file__).resolve().parents:
        if (parent / "pyproject.toml").is_file():
            return parent
    return Path.cwd()


def _print_statement(ledger: OutcomeLedger) -> None:
    st = ledger.statement()
    print(f"成果 {st['outcomes']} 项｜价值当量 {st['total_points']} 点"
          f"｜≈ {st['hours_equivalent']} 人力小时")
    for k in sorted(st["by_task_type"], key=st["by_task_type"].get,
                    reverse=True):
        print(f"  {k:<8} {st['by_task_type'][k]:>6} 点")
    for day in sorted(st["by_day"]):
        print(f"  {day}  {st['by_day'][day]:>6} 点")
    print(f"汇率声明：{st['rate_note']}")


def _demo() -> int:
    """P3 验收 demo：真实 M3 抽卡→M4 交付→价值入账→对账单。"""
    from paistation.execute.deliver import Deliverer
    from paistation.proactive.taskcards import extract_task_cards

    workspace = Path(tempfile.mkdtemp(prefix="settle-demo-"))
    events = [
        {"text": "请帮我调研一下江巷灌区的数字孪生方案，周五要结果",
         "source": "mic"},
        {"text": "别忘了汇总本周的安全检查记录", "source": "meeting"},
        {"text": "麻烦提交白龟湖项目移交报告，周四前要", "source": "meeting"},
    ]
    cards = extract_task_cards(events)
    deliverer = Deliverer(workspace)
    for card in cards:
        deliverer.deliver(card, "成果正文内容。" * 400)
    ledger = OutcomeLedger(workspace / "value_ledger.jsonl")
    ingest(workspace / "deliveries" / "receipts.jsonl", ledger)
    print(f"per-outcome 计量 demo（workspace={workspace}）")
    for row in ledger.events():
        print(f"  +{row['value_points']:>3} 点  {row['title'][:24]}"
              f"  [{row['basis']}]")
    _print_statement(ledger)
    return 0


def main(argv=None) -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(prog="settle")
    ap.add_argument("--root", default=None,
                    help="数据根（回执在 <root>/deliveries/），默认仓库根")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("settle")
    sub.add_parser("statement")
    sub.add_parser("ledger")
    sub.add_parser("demo")
    args = ap.parse_args(argv)
    root = Path(args.root) if args.root else _find_root()

    if args.cmd == "demo":
        return _demo()
    ledger = OutcomeLedger(root / "value_ledger.jsonl")
    if args.cmd == "settle":
        n = ingest(root / "deliveries" / "receipts.jsonl", ledger)
        print(f"settled: {n}（幂等，重跑零重复）")
        return 0
    if args.cmd == "statement":
        _print_statement(ledger)
        return 0
    for row in ledger.events():
        print(json.dumps(row, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
