# -*- coding: utf-8 -*-
"""test_sprint_ledger — ¥100k 冲刺周对账账本单测 (T-011, REQ-034.AC1).

覆盖:
  a) settle 追加记录: 字段/plan 快照/实绩如实 (0 就是 0)
  b) 账本追加式: 二次 settle 不改写既有行
  c) status 计算: 累计实绩/累计目标(已对账周)/缺口/剩余天数
  d) 同周修正语义: 取该周最后一行
  e) 防呆: 未知周标/负数/非数拒收; 坏账本行显式报错
  f) 空账本: 缺口=全额, 周表全「未对账」
  g) 镜像: 权威/镜像双写同一行

跑法: py -m pytest reforge_factory/tests/test_sprint_ledger.py -q
"""
import json
import sys
from datetime import date
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import sprint_ledger as SL                                    # noqa: E402


@pytest.fixture
def ledger(tmp_path: Path) -> Path:
    return tmp_path / "work" / "sprint_ledger.jsonl"


def _lines(path: Path) -> list[dict]:
    return [json.loads(l) for l in path.read_text(encoding="utf-8").splitlines() if l.strip()]


def test_a_settle_appends_full_record(ledger: Path):
    """a) 一条记录含 week/span/target(plan)/actual/note/ts, 零入账如实=0."""
    rec = SL.settle("W1", 0, note="冲刺启动周，G5 未破零", ledger=ledger)
    assert rec["week"] == "W1"
    assert rec["target"] == 5_000                 # plan 快照
    assert rec["actual"] == 0.0                   # 数字零造假: 0 就是 0
    assert rec["note"] == "冲刺启动周，G5 未破零"
    assert rec["ts"]
    rows = _lines(ledger)
    assert len(rows) == 1 and rows[0]["week"] == "W1"
    assert rows[0]["span"] == SL.WEEK_PLAN["W1"]["span"]


def test_b_ledger_is_append_only(ledger: Path):
    """b) 第二次 settle 只追加, 既有行原样保留."""
    SL.settle("W1", 0, ledger=ledger)
    first = _lines(ledger)[0]
    SL.settle("W2", 25_000, note="存量走量", ledger=ledger)
    rows = _lines(ledger)
    assert len(rows) == 2
    assert rows[0] == first                        # 既有行一字不动
    assert rows[1]["week"] == "W2" and rows[1]["target"] == 25_000


def test_c_status_cum_gap_days(ledger: Path):
    """c) 累计实绩/累计目标/缺口/剩余天数."""
    SL.settle("W1", 5_000, ledger=ledger)
    SL.settle("W2", 25_000, ledger=ledger)
    st = SL.status(ledger)
    assert st["actual_cum"] == 30_000
    assert st["plan_cum_of_settled"] == 30_000     # W1 5k + W2 25k (plan, 已对账周)
    assert st["gap"] == 100_000 - 30_000
    assert st["days_left"] == max(0, (SL.DEADLINE - date.today()).days)
    assert st["goal"] == 100_000 and st["deadline"] == "2026-11-07"


def test_d_last_settle_per_week_wins(ledger: Path):
    """d) 同周修正=追加新行, 对账取最后一行."""
    SL.settle("W1", 0, ledger=ledger)
    SL.settle("W1", 3_000, note="周内补记", ledger=ledger)
    st = SL.status(ledger)
    assert st["records"] == 2                      # 账本保留两条
    assert st["actual_cum"] == 3_000               # 取 W1 最后一行
    wk1 = [w for w in st["weeks"] if w["week"] == "W1"][0]
    assert wk1["settled"] and wk1["actual"] == 3_000


def test_e1_settle_rejects_unknown_week(ledger: Path):
    with pytest.raises(ValueError):
        SL.settle("W9", 100, ledger=ledger)


def test_e2_settle_rejects_bad_amount(ledger: Path):
    with pytest.raises(ValueError):
        SL.settle("W1", -1, ledger=ledger)         # 负数拒收
    with pytest.raises(ValueError):
        SL.settle("W1", "很多", ledger=ledger)     # 非数拒收
    with pytest.raises(ValueError):
        SL.settle("W1", float("nan"), ledger=ledger)


def test_e3_corrupt_ledger_line_raises(ledger: Path):
    ledger.parent.mkdir(parents=True, exist_ok=True)
    ledger.write_text('{"week": "W1"\n', encoding="utf-8")   # 坏 JSON 行
    with pytest.raises(ValueError):
        SL.status(ledger)


def test_f_empty_ledger_full_gap(tmp_path: Path):
    """f) 无账本=缺口全额, 四周全未对账."""
    st = SL.status(tmp_path / "absent.jsonl")
    assert st["actual_cum"] == 0 and st["gap"] == 100_000
    assert st["plan_cum_of_settled"] == 0 and st["records"] == 0
    assert all(not w["settled"] for w in st["weeks"]) and len(st["weeks"]) == 4
    assert sum(w["target"] for w in st["weeks"]) == 100_000  # 四周 plan 合计=总目标


def test_g_mirror_gets_same_line(tmp_path: Path):
    """g) 显式镜像与账本收到同一行."""
    main_ledger = tmp_path / "main.jsonl"
    mirror = tmp_path / "mirror.jsonl"
    rec = SL.settle("W1", 0, note="n", ledger=main_ledger, mirror=mirror)
    assert _lines(main_ledger) == [rec]
    assert _lines(mirror) == [rec]


def test_week_plan_matches_goal():
    """周分解 plan 合计 >= 硬指标 (W1..W4 = 5k/25k/45k/25k)."""
    assert [SL.WEEK_PLAN[w]["target"] for w in SL.WEEK_ORDER] == [5_000, 25_000, 45_000, 25_000]
    assert sum(SL.WEEK_PLAN[w]["target"] for w in SL.WEEK_ORDER) >= SL.GOAL_YUAN
