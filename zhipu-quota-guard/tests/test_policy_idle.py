# -*- coding: utf-8 -*-
"""CC 空闲门（1023 用户令）：无任务在跑 → 不花卡，即使水位/预测达标。"""
import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from zqg.policy import decide  # noqa: E402


def _cfg(**over):
    return {"poll": {"threshold_pct": 90}, "policy": {
        "reserve_cards": 1, "lead_time_min": 30, "fifo_by_expiry": True,
        "mode": "auto", "idle_grace_min": 10, **over}}


def _snap(pct=95.0):
    return {"window_pct": pct, "remaining": 100 - pct, "next_reset_at": int(time.time()) + 4 * 3600}


def _cards():
    return {"five_hour": [{"count": 3, "expire_at": int(time.time()) + 86400 * 30}], "weekly": []}


def _burn(rate=200.0, idle_sec=None):
    return {"tokens_per_min": rate, "peak_now": False,
            "last_record_at": time.time() - idle_sec if idle_sec is not None else time.time() - 60}


def test_idle_cc_never_spends_card_even_at_95pct():
    d = decide(_snap(95), _burn(idle_sec=3600), _cards(), _cfg())
    assert d.action == "wait"
    assert "空闲" in d.reason


def test_active_cc_spends_when_threshold_and_burnout():
    d = decide(_snap(95), _burn(idle_sec=60), _cards(), _cfg())
    assert d.action == "reset"
    assert d.card_to_use == "five_hour"


def test_grace_boundary_9min_active_11min_idle():
    assert decide(_snap(95), _burn(idle_sec=9 * 60), _cards(), _cfg()).action == "reset"
    assert decide(_snap(95), _burn(idle_sec=11 * 60), _cards(), _cfg()).action == "wait"


def test_missing_last_record_at_backward_compatible():
    """旧形态 burn（无字段）不触发空闲门——按活跃处理，行为向后兼容。"""
    d = decide(_snap(95), {"tokens_per_min": 200.0, "peak_now": False}, _cards(), _cfg())
    assert d.action == "reset"
