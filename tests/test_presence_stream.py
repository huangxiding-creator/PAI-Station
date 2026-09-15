"""M7a AFK 在场流：迟滞双阈值（300s 离席 / 60s 回席）。"""
from datetime import datetime

from paistation.sense.presence_stream import AfkTracker
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 14, 0, 0)


def _tracker():
    return AfkTracker(now_fn=lambda: _NOW)


def test_stay_present_below_threshold():
    assert _tracker().feed(10.0) == []
    assert _tracker().feed(299.9) == []


def test_afk_start_at_300():
    evs = _tracker().feed(300.0)
    assert len(evs) == 1
    assert evs[0]["meta"]["phase"] == "start"
    assert validate_event(evs[0])


def test_hysteresis_no_flip_flop():
    """离席后 100s 空闲（>60s 回席线）不得回席——防抖动。"""
    t = _tracker()
    t.feed(400.0)
    assert t.feed(100.0) == []


def test_afk_end_below_60():
    t = _tracker()
    t.feed(400.0)
    evs = t.feed(30.0)
    assert len(evs) == 1
    assert evs[0]["meta"]["phase"] == "end"


def test_none_probe_silent():
    """探测失败（非 Windows）→ 无事件（不误报离席）。"""
    assert _tracker().feed(None) == []
