# -*- coding: utf-8 -*-
"""REQ-032.AC1 端到端冒烟 (taskgraph verify 目标件): 合成事件→--sku 查得四级
漏斗数; --week 汇总; 零数据 SKU/零数据周不炸且如实呈现.

细粒度单测见 test_funnel_query.py / test_weekly_north_star.py.
"""
from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import funnel_query as FQ   # noqa: E402
import weekly_north_star as WN   # noqa: E402


def _d() -> Path:
    return Path(tempfile.mkdtemp(prefix="tf_smoke_"))


def test_cli_sku_prints_four_level_counts(capsys):
    d = _d()
    lg = d / "funnel_events.jsonl"
    for lv, n in (("visit", 4), ("sample_read", 2), ("click_buy", 1),
                  ("pay", 1)):
        for _ in range(n):
            FQ.record("BID26-FULL", "gzh-zbzs", lv, ref="r1", path=lg)
    rc = FQ._main(["--sku", "BID26-FULL", "--ledger", str(lg),
                   "--db", str(d / "no.db")])
    out = capsys.readouterr().out
    assert rc == 0
    for lv, n in (("visit", 4), ("sample_read", 2), ("click_buy", 1),
                  ("pay", 1)):
        assert f"{lv}" in out and f"{n:>6}" in out
    assert "25.0%" in out and "6.6%" in out      # visit→pay 1/4 + 对标行


def test_cli_json_week_sitewide(capsys):
    d = _d()
    lg = d / "funnel_events.jsonl"
    ev = FQ.record("S-A", "site", "visit", path=lg)
    wk = FQ.event_week(ev)                    # 事件真实落周 (与运行日无关)
    rc = FQ._main(["--week", wk, "--ledger", str(lg),
                   "--db", str(d / "no.db"), "--json"])
    assert rc == 0
    js = json.loads(capsys.readouterr().out)
    assert js["levels"]["visit"] == 1 and "per_sku" in js


def test_cli_sku_zero_data_not_crash(capsys):
    d = _d()   # REQ-032.AC1 验收命令形态: 零账本零库照样出数 (全 0)
    rc = FQ._main(["--sku", "BID26-FULL", "--ledger", str(d / "none.jsonl"),
                   "--db", str(d / "no.db")])
    out = capsys.readouterr().out
    assert rc == 0 and "visit" in out and "pay" in out


def test_weekly_first_report_zero_week(tmp_path):
    f = WN.build("2026-W42", db_path=tmp_path / "no.db",
                 ledger=tmp_path / "none.jsonl", out_dir=tmp_path / "weekly")
    assert f.name == "2026-W42.md"
    md = f.read_text(encoding="utf-8")
    assert "零数据周如实呈现" in md and "6.6%" in md and "无数据" in md


def test_record_then_collect_roundtrip():
    d = _d()
    lg = d / "l.jsonl"
    ev = FQ.record("R50-SNEI", "wx-video", "click_buy", path=lg)
    r = FQ.collect(sku="R50-SNEI", ledger=lg, db_path=d / "no.db")
    assert r["levels"]["click_buy"] == 1 and r["by_channel"]["wx-video"]
    assert ev["level"] in FQ.LEVELS


@pytest.mark.parametrize("lvl", FQ.LEVELS)
def test_all_four_levels_accepted(lvl, tmp_path):
    ev = FQ.record("X-1", "site", lvl, path=tmp_path / "l.jsonl")
    assert ev["level"] == lvl
