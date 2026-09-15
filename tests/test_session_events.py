"""M7a 会话事件：锁屏/解锁转换检测（首样本建基线）。"""
from datetime import datetime

from paistation.sense.session_events import SessionTracker
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 9, 0, 0)


def _tracker():
    return SessionTracker(now_fn=lambda: _NOW)


def test_first_sample_baseline_no_event():
    assert _tracker().feed(True) is None
    assert _tracker().feed(False) is None


def test_lock_unlock_transitions():
    t = _tracker()
    t.feed(False)
    ev = t.feed(True)
    assert ev["meta"]["phase"] == "lock"
    assert ev["meta"]["locked"] is True
    assert validate_event(ev)
    assert t.feed(True) is None  # 稳态无事件
    ev = t.feed(False)
    assert ev["meta"]["phase"] == "unlock"
    assert ev["meta"]["locked"] is False


def test_none_probe_silent():
    t = _tracker()
    t.feed(False)
    assert t.feed(None) is None
