# -*- coding: utf-8 -*-
"""brier_score — 校准账本对账腿 (T-013B / REQ-042.AC1).

settle: 到期回填单条 outcome (bool) + brier=(prob/100-outcome)²; 只动该条
outcome/brier 两字段, 其余行字节保真, 已对账记录拒绝二次回填 (历史不可翻改).

report: 账本统计 (预测总数 / 已对账数 / 平均 Brier / 命中率), --campaign 过滤
或 --all 聚合, --json 机器可读.

--synthetic: 10 条内置合成样本 (概率与结果已知) 跑出已知平均 Brier ——
REQ-042.AC1 的可测验收. 纯内存计算, 不读不写任何账本.

手算对拍 (Σ/10):
    (0.09 + 0.49 + 0.04 + 0.64 + 0.16 + 0.36 + 0.01 + 0.25 + 0.25 + 0.09) / 10
  = 2.38 / 10 = 0.238

用法:
    py reforge_factory/brier_score.py --synthetic
    py reforge_factory/brier_score.py --campaign EPC-BID26
    py reforge_factory/brier_score.py --all --json
    py reforge_factory/brier_score.py --settle C-0001 --outcome true

退出码: 0=正常, 1=账本/参数错 (含合成对拍不符). 纯标准库.
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import calibration_extract as CX                        # noqa: E402

#: 合成样本 (prob 百分比 int, outcome bool) ×10 — REQ-042.AC1 对拍底料
SYNTHETIC_SAMPLES: tuple[tuple[int, bool], ...] = (
    (70, True), (70, False),
    (80, True), (80, False),
    (60, True), (60, False),
    (90, True),
    (50, True), (50, False),
    (30, False),
)

#: 手算已知平均 Brier (写死对拍值; 测试同值复算)
SYNTHETIC_MEAN_BRIER = 0.238


def brier(prob: int, outcome: bool) -> float:
    """Brier 分 = (prob/100 − outcome)², 6 位小数. prob 为账本百分比整数."""
    return round((prob / 100.0 - (1.0 if outcome else 0.0)) ** 2, 6)


def synthetic_report() -> dict:
    """合成样本对拍: 实算均值 vs 手算常量 (不触碰任何账本文件)."""
    mean = sum(brier(p, o) for p, o in SYNTHETIC_SAMPLES) / len(SYNTHETIC_SAMPLES)
    return {
        "n": len(SYNTHETIC_SAMPLES),
        "mean_brier": round(mean, 6),
        "expected": SYNTHETIC_MEAN_BRIER,
        "match": abs(mean - SYNTHETIC_MEAN_BRIER) < 1e-9,
    }


def settle(row_id, outcome, ledger=None) -> dict:
    """回填一条预测的对账结果 (仅 outcome/brier 两字段).

    - outcome 须为严格 bool; row_id 须在账本; 已对账 (outcome 非 null) 拒二次;
    - 整文件重写、其余行按原字节写回 (追加式账本, 只增不删, 回填只改该条).
    """
    if not isinstance(outcome, bool):
        raise ValueError(f"outcome 须为 bool, 实得 {outcome!r}")
    path = Path(ledger) if ledger is not None else CX.DEFAULT_LEDGER
    if not path.exists():
        raise ValueError(f"账本不存在: {path}")
    lines = path.read_bytes().splitlines(keepends=True)
    target_idx = None
    for i, raw in enumerate(lines):
        text = raw.decode("utf-8", errors="replace").strip()
        if not text:
            continue
        try:
            rec = json.loads(text)
        except ValueError:
            continue
        if str(rec.get("id") or "") == str(row_id):
            target_idx = i
            break
    if target_idx is None:
        raise ValueError(f"预测 {row_id} 不在账本 {path}")

    old = json.loads(lines[target_idx].decode("utf-8"))
    if old.get("outcome") is not None:
        raise ValueError(f"预测 {row_id} 已对账, 拒绝二次回填 (历史不可翻改)")
    prob = old.get("prob")
    if isinstance(prob, bool) or not isinstance(prob, int) or not 1 <= prob <= 99:
        raise ValueError(f"预测 {row_id} prob={prob!r} 非法, 无法计 Brier")

    new = dict(old)                                      # 其余字段原样携带
    new["outcome"] = outcome
    new["brier"] = brier(prob, outcome)
    lines[target_idx] = (json.dumps(new, ensure_ascii=False,
                                    separators=(",", ":")) + "\n").encode("utf-8")
    path.write_bytes(b"".join(lines))
    return new


def summarize(rows: list[dict]) -> dict:
    """纯函数: 账本行 → 统计 dict (空账本不炸, 率为 None)."""
    total = len(rows)
    settled = [r for r in rows if r.get("outcome") is not None]
    briers = [r["brier"] for r in settled
              if isinstance(r.get("brier"), (int, float))]
    hits = sum(1 for r in settled if r.get("outcome") is True)
    return {
        "total": total,
        "settled": len(settled),
        "pending": total - len(settled),
        "mean_brier": (round(sum(briers) / len(briers), 4)) if briers else None,
        "hit_rate": (round(hits / len(settled), 4)) if settled else None,
    }


def _render(scope: str, s: dict) -> str:
    hit = f"{s['hit_rate'] * 100:.2f}%" if s["hit_rate"] is not None else "n/a"
    mean = s["mean_brier"] if s["mean_brier"] is not None else "n/a"
    return (f"campaign={scope} total={s['total']} settled={s['settled']} "
            f"pending={s['pending']} mean_brier={mean} hit_rate={hit}")


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="校准账本对账腿 (REQ-042): settle 回填 / report 统计 / "
                    "--synthetic 已知分对拍")
    ap.add_argument("--settle", metavar="ID", default=None,
                    help="回填指定 C-#### 的对账结果")
    ap.add_argument("--outcome", default=None,
                    help="对账结果 true/false (配 --settle)")
    ap.add_argument("--campaign", default=None, help="按战役过滤统计")
    ap.add_argument("--all", action="store_true", help="全战役聚合统计")
    ap.add_argument("--synthetic", action="store_true",
                    help="合成样本已知 Brier 对拍 (不碰账本)")
    ap.add_argument("--ledger", default=None, help="账本路径 (缺省 reforge_factory/)")
    ap.add_argument("--json", action="store_true", help="机器可读 JSON 输出")
    args = ap.parse_args(argv)

    try:
        if args.settle:
            if args.outcome is None or str(args.outcome).lower() not in \
                    ("true", "false"):
                print("[brier_score] ERROR --settle 须配 --outcome true|false",
                      file=sys.stderr)
                return 1
            rec = settle(args.settle,
                         str(args.outcome).lower() == "true",
                         ledger=args.ledger)
            print(f"settled {rec['id']} outcome={rec['outcome']} "
                  f"prob={rec['prob']}% brier={rec['brier']}")
            return 0

        if args.synthetic:
            s = synthetic_report()
            if not s["match"]:
                print(f"[brier_score] ERROR 合成对拍不符: 实算 "
                      f"{s['mean_brier']} != 已知 {s['expected']}",
                      file=sys.stderr)
                return 1
            print(f"synthetic n={s['n']} mean_brier={s['mean_brier']} "
                  f"expected={s['expected']} OK")
            return 0

        if args.all or args.campaign:
            rows = CX.load_rows(args.ledger)
            if args.campaign and not args.all:
                rows = [r for r in rows
                        if r.get("campaign") == args.campaign]
            s = summarize(rows)
            scope = args.campaign if (args.campaign and not args.all) else "ALL"
            if args.json:
                print(json.dumps({"campaign": scope, **s},
                                 ensure_ascii=False, indent=2))
            else:
                print(_render(scope, s))
            return 0

        ap.print_usage()
        print("[brier_score] ERROR 须指定 --settle / --synthetic / "
              "--campaign / --all 之一", file=sys.stderr)
        return 1
    except (ValueError, OSError) as exc:
        print(f"[brier_score] ERROR {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:                                   # 非 Windows/无 tty 不致命
        pass
    sys.exit(main())
