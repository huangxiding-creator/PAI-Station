"""M7a 前台窗口焦点流：签名去重 + attention 分类 + 事件合规。"""
from datetime import datetime

from paistation.sense.voice_events import validate_event
from paistation.sense.window_watcher import WindowTracker

_NOW = datetime(2026, 9, 15, 10, 0, 0)


def _tracker(deepwork=()):
    return WindowTracker(deepwork_apps=deepwork, now_fn=lambda: _NOW)


def test_first_sample_emits_baseline_event():
    ev = _tracker().feed({"title": "main.py - PyCharm", "process": "pycharm64.exe"})
    assert ev is not None
    assert ev["type"] == "window.focus"
    assert ev["text"] == "main.py - PyCharm"
    assert ev["meta"]["process"] == "pycharm64.exe"
    assert ev["meta"]["attention"] == "focus"
    assert validate_event(ev)


def test_same_signature_no_event():
    t = _tracker()
    t.feed({"title": "某文档 - WPS", "process": "wps.exe"})
    assert t.feed({"title": "某文档 - WPS", "process": "wps.exe"}) is None


def test_title_change_emits_with_prev_evidence():
    t = _tracker()
    t.feed({"title": "旧标题", "process": "wps.exe"})
    ev = t.feed({"title": "新标题", "process": "wps.exe"})
    assert ev["text"] == "新标题"
    assert ev["evidence"]["prev_title"] == "旧标题"
    assert ev["evidence"]["prev_process"] == "wps.exe"


def test_deepwork_app_classified():
    ev = _tracker(deepwork=("pycharm64.exe",)).feed(
        {"title": "code", "process": "pycharm64.exe"})
    assert ev["meta"]["attention"] == "deepwork"


def test_empty_window_silent():
    assert _tracker().feed({"title": "", "process": ""}) is None
    assert _tracker().feed({}) is None
