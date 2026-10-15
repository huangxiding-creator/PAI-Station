# -*- coding: utf-8 -*-
"""sprint_ledger — ¥100k 冲刺周分解对账账本 (T-011, REQ-034).

背景 (GOAL_LEDGER 1015 V3 令): 硬指标=2026-11-07 前平台订单库真实入账
累计 >= ¥100,000; 周期 2026-10-15 起共 3.5 周。本工具把周目标 (plan) 与
周实绩 (对账值) 落追加式 JSONL 账本, 并输出累计/缺口/剩余天数。

纪律:
  - 数字零造假: 零入账周如实记 0, 实绩只来自平台订单库对账;
  - 目标=计划值 (plan) 非实绩, 账本逐条带 target 快照以供审计;
  - 账本追加式 (append-only): 同周修正=追加新行, 对账以「该周最后一行」为准;
  - 权威账本在产线侧 (跨会话可达):
      _proposals/flagship-paid-report-1007/work/sprint_ledger.jsonl
    每次 settle 同步镜像一行到 V3 计划工作区 (tasks.json T-011 声明件):
      ResearchFactory-Eng/06 迭代优化/百倍V3_极致调研变现计划/work/sprint_ledger.jsonl

CLI:
  py reforge_factory/sprint_ledger.py --settle W1 0 --note "冲刺启动周，G5 未破零"
  py reforge_factory/sprint_ledger.py --status            # 人类可读
  py reforge_factory/sprint_ledger.py --status --json     # 机读

周分解 (plan, 全为计划值): W1=5,000 / W2=25,000 / W3=45,000 / W4=25,000,
累计 >= 100,000。分解逻辑: 漏斗=流量x转化率x客单价——W1 低门槛破零建信任
基线并启动日更流量; W2 流量爬坡带动存量走量; W3 流量峰值配 ¥10,000 蓝皮书
高客单主升; W4 短周收尾以企业定制线索/尾款清缺口。

跑法: py -m pytest reforge_factory/tests/test_sprint_ledger.py -q
"""
from __future__ import annotations

import argparse
import json
import math
import sys
from datetime import date, datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

# 权威账本 (产线侧) 与镜像 (V3 计划工作区, tasks.json T-011 声明件)
CANONICAL_LEDGER = ROOT / "_proposals" / "flagship-paid-report-1007" / "work" / "sprint_ledger.jsonl"
MIRROR_LEDGER = ROOT / "ResearchFactory-Eng" / "06 迭代优化" / "百倍V3_极致调研变现计划" / "work" / "sprint_ledger.jsonl"

GOAL_YUAN = 100_000
SPRINT_START = date(2026, 10, 15)
DEADLINE = date(2026, 11, 7)

# 周分解: span/target/actions 全为 plan (计划值), 与 GOAL_LEDGER 周表一字同源
WEEK_PLAN = {
    "W1": {"span": "2026-10-15~2026-10-21", "target": 5_000,
           "actions": "首单破零为主（G5：蓝皮书/单章199/存量SKU任一真实付费）+三号+视频号日更流量起步"},
    "W2": {"span": "2026-10-22~2026-10-28", "target": 25_000,
           "actions": "存量长尾（65在售+单章199拆分）走量+蓝皮书高意向线索培育"},
    "W3": {"span": "2026-10-29~2026-11-04", "target": 45_000,
           "actions": "冲刺主升：蓝皮书N单（10000xN高客单）+流量峰值转化存量"},
    "W4": {"span": "2026-11-05~2026-11-07", "target": 25_000,
           "actions": "收尾：企业定制线索转化+缺口清零冲刺对账"},
}
WEEK_ORDER = ["W1", "W2", "W3", "W4"]


def _now_iso() -> str:
    return datetime.now().astimezone().isoformat(timespec="seconds")


def _fmt(amount: float) -> str:
    """千元分隔, 无小数拖尾 (GBK 控制台安全: 不用半角 ¥ 符号, 用元)."""
    if float(amount).is_integer():
        return f"{int(amount):,}"
    return f"{amount:,.2f}"


def _validate_week(week: str) -> str:
    w = str(week).strip().upper()
    if w not in WEEK_PLAN:
        raise ValueError(f"unknown week label: {week!r} (expect one of {WEEK_ORDER})")
    return w


def _validate_amount(actual) -> float:
    if isinstance(actual, bool) or not isinstance(actual, (int, float)):
        raise ValueError(f"actual_income must be a number, got {type(actual).__name__}")
    a = float(actual)
    if not math.isfinite(a) or a < 0:
        raise ValueError(f"actual_income must be finite and >= 0, got {actual!r}")
    return a


def _append_line(path: Path, record: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)  # 只增不删: a 模式追加, 不触碰既有行
    with open(path, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(record, ensure_ascii=False) + "\n")


def read_records(ledger: Path | None = None) -> list[dict]:
    """读全部对账行 (跳过空行; 坏行显式报错, 不静默吞账)."""
    path = ledger or CANONICAL_LEDGER
    if not path.exists():
        return []
    records = []
    with open(path, "r", encoding="utf-8") as fh:
        for i, line in enumerate(fh, 1):
            if not line.strip():
                continue
            try:
                records.append(json.loads(line))
            except json.JSONDecodeError as exc:
                raise ValueError(f"corrupt ledger line {i} in {path}: {exc}") from exc
    return records


def settle(week: str, actual_income, note: str = "",
           ledger: Path | None = None, mirror: Path | None = None) -> dict:
    """追加一条周对账记录 {week, span, target(plan快照), actual, note, ts}.

    默认写权威账本 (产线侧) 并镜像一行到 V3 计划工作区; 显式传 ledger 时为
    测试/私有账本, 默认不镜像 (传 mirror 可指定镜像).
    """
    w = _validate_week(week)
    amount = _validate_amount(actual_income)
    plan = WEEK_PLAN[w]
    record = {
        "week": w,
        "span": plan["span"],
        "target": plan["target"],          # plan 快照, 非实绩
        "actual": amount,                  # 平台订单库对账实绩 (0 就是 0)
        "note": str(note),
        "ts": _now_iso(),
    }
    if ledger is None:
        _append_line(CANONICAL_LEDGER, record)
        _append_line(mirror or MIRROR_LEDGER, record)
    else:
        _append_line(ledger, record)
        if mirror is not None:
            _append_line(mirror, record)
    return record


def status(ledger: Path | None = None) -> dict:
    """累计/缺口/剩余天数; 同周取最后一行 (追加式账本的修正语义)."""
    path = ledger or CANONICAL_LEDGER
    records = read_records(path)
    last_by_week: dict[str, dict] = {}
    for rec in records:
        last_by_week[rec.get("week", "?")] = rec
    weeks = []
    for w in WEEK_ORDER:
        rec = last_by_week.get(w)
        plan = WEEK_PLAN[w]
        weeks.append({
            "week": w, "span": plan["span"], "target": plan["target"], "plan": True,
            "settled": rec is not None,
            "actual": (rec or {}).get("actual"),
            "note": (rec or {}).get("note", ""),
            "ts": (rec or {}).get("ts", ""),
        })
    settled = [wk for wk in weeks if wk["settled"]]
    actual_cum = sum(float(wk["actual"]) for wk in settled)
    plan_cum = sum(int(wk["target"]) for wk in settled)
    days_left = max(0, (DEADLINE - date.today()).days)
    return {
        "goal": GOAL_YUAN,
        "start": SPRINT_START.isoformat(),
        "deadline": DEADLINE.isoformat(),
        "days_left": days_left,
        "actual_cum": actual_cum,
        "plan_cum_of_settled": plan_cum,
        "gap": GOAL_YUAN - actual_cum,          # 负值=超额
        "records": len(records),
        "ledger": str(path),
        "weeks": weeks,
    }


def _print_status(st: dict) -> None:
    print(f"== 100k 冲刺周对账 (目标 {st['goal']:,} 元, {st['start']} 起, 截止 {st['deadline']}) ==")
    print(f"账本   : {st['ledger']} (追加式, {st['records']} 条记录; 目标全为 plan 非实绩)")
    for wk in st["weeks"]:
        if wk["settled"]:
            print(f"{wk['week']} {wk['span']}  plan {_fmt(wk['target']):>9}  "
                  f"实绩 {_fmt(wk['actual']):>9}  {wk['note']}")
        else:
            print(f"{wk['week']} {wk['span']}  plan {_fmt(wk['target']):>9}  实绩 {'未对账':>9}")
    print(f"累计实绩 : {_fmt(st['actual_cum'])} / {st['goal']:,} 元")
    print(f"累计目标 : {_fmt(st['plan_cum_of_settled'])} 元 (plan, 已对账周合计)")
    gap = st["gap"]
    print(f"缺口     : {_fmt(gap)} 元" + (" (已超额)" if gap < 0 else ""))
    print(f"剩余天数 : {st['days_left']} 天 (至 {st['deadline']})")


def main(argv=None) -> int:
    # 重定向/管道下 Windows 默认 cp936, 统一 utf-8 (真控制台走 WriteConsoleW 不受影响)
    for stream in (sys.stdout, sys.stderr):
        if hasattr(stream, "reconfigure"):
            try:
                stream.reconfigure(encoding="utf-8")
            except (ValueError, OSError):
                pass
    ap = argparse.ArgumentParser(description="¥100k 冲刺周对账 (REQ-034; 目标=plan, 实绩=订单库对账)")
    ap.add_argument("--settle", nargs=2, metavar=("WEEK", "ACTUAL"),
                    help="追加周对账记录, 如 --settle W1 0")
    ap.add_argument("--note", default="", help="settle 附注 (如: 冲刺启动周，G5 未破零)")
    ap.add_argument("--status", action="store_true", help="输出累计/缺口/剩余天数")
    ap.add_argument("--json", action="store_true", help="status 用 JSON 输出")
    ap.add_argument("--ledger", default=None, help="账本路径覆盖 (默认产线侧权威账本+镜像)")
    ap.add_argument("--mirror", default=None, help="镜像账本路径 (默认仅在权威账本模式下镜像)")
    args = ap.parse_args(argv)

    ledger = Path(args.ledger) if args.ledger else None
    mirror = Path(args.mirror) if args.mirror else None
    if args.settle:
        week, raw = args.settle
        try:
            amount = float(raw)
        except ValueError:
            print(f"bad ACTUAL value: {raw!r}", file=sys.stderr)
            return 2
        try:
            rec = settle(week, amount, note=args.note, ledger=ledger, mirror=mirror)
        except ValueError as exc:
            print(f"settle rejected: {exc}", file=sys.stderr)
            return 2
        target_path = ledger or CANONICAL_LEDGER
        mirror_path = (mirror or MIRROR_LEDGER) if ledger is None else mirror
        print(f"已落账: {rec['week']} span={rec['span']} plan={_fmt(rec['target'])} "
              f"实绩={_fmt(rec['actual'])} note={rec['note']} ts={rec['ts']}")
        print(f"账本   : {target_path}")
        if mirror_path is not None:
            print(f"镜像   : {mirror_path}")
        return 0
    if args.status or not args.settle:
        st = status(ledger)
        if args.json:
            print(json.dumps(st, ensure_ascii=False, indent=2))
        else:
            _print_status(st)
        return 0
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
