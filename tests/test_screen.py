"""R1 截屏感知：fgwindow 前台窗口 + screen 黑名单过滤/滚动缓冲 + vision 事件结构化。"""
import os

import pytest

from paistation.sense.fgwindow import active_window, classify_attention
from paistation.sense.screen import ScreenMonitor
from paistation.sense.vision import describe_event, wechat_snapshot


class FakeFg:
    """可编程前台窗口源。"""

    def __init__(self, result):
        self._result = result

    def __call__(self):
        return self._result


# ---- fgwindow ----

def test_active_window_shape():
    win = active_window()
    assert isinstance(win, dict)
    assert set(win) >= {"title", "process"}
    assert all(isinstance(v, str) for v in win.values())


def test_classify_deepwork_by_process():
    state = classify_attention({"title": "报告.docx - Word", "process": "WINWORD.EXE"},
                               deepwork_apps=("WINWORD.EXE", "Code.exe"))
    assert state == "deepwork"


def test_classify_focus_other_window():
    state = classify_attention({"title": "浏览器", "process": "chrome.exe"},
                               deepwork_apps=("WINWORD.EXE",))
    assert state == "focus"


def test_classify_empty_is_idle():
    assert classify_attention({"title": "", "process": ""},
                              deepwork_apps=("WINWORD.EXE",)) == "idle"


# ---- screen ----

@pytest.fixture
def buf(tmp_path):
    return tmp_path / "screenbuf"


def test_tick_captures_when_allowed(buf):
    mon = ScreenMonitor(interval_sec=600, blacklist=("银行",),
                        buffer_dir=str(buf), now_fn=lambda: 1000.0,
                        capture_fn=lambda: b"PNGDATA",
                        fg_fn=FakeFg({"title": "IDE 主窗口", "process": "Code.exe"}))
    path = mon.tick()
    assert path and os.path.isfile(path)
    with open(path, "rb") as fh:
        assert fh.read() == b"PNGDATA"


def test_tick_skips_blacklisted_title(buf):
    mon = ScreenMonitor(interval_sec=600, blacklist=("银行", "支付"),
                        buffer_dir=str(buf), now_fn=lambda: 1000.0,
                        capture_fn=lambda: pytest.fail("黑名单不应截图"),
                        fg_fn=FakeFg({"title": "XX银行客户端", "process": "bank.exe"}))
    assert mon.tick() is None
    assert os.listdir(buf) == []  # 黑名单跳过且不留任何文件


def test_tick_respects_interval(buf):
    now = [1000.0]
    mon = ScreenMonitor(interval_sec=600, blacklist=(),
                        buffer_dir=str(buf), now_fn=lambda: now[0],
                        capture_fn=lambda: b"P", fg_fn=FakeFg({"title": "t", "process": "x"}))
    assert mon.tick()  # 首次立即
    now[0] = 1300.0
    assert mon.tick() is None  # 间隔未到
    now[0] = 1601.0
    assert mon.tick()  # 间隔过后恢复


def test_rolling_buffer_evicts_old(buf):
    times = [1000.0]
    files = []

    def fake_cap():
        files.append(f"f{len(files)}.png")
        return files[-1].encode()

    mon = ScreenMonitor(interval_sec=0, blacklist=(), buffer_dir=str(buf),
                        now_fn=lambda: times[0], capture_fn=fake_cap,
                        fg_fn=FakeFg({"title": "t", "process": "x"}))
    mon.tick()
    times[0] = 1200.0
    mon.tick()
    times[0] = 2000.0
    assert mon.tick()  # 此刻 f0(1000s 前)/f1(800s 前) 均超 600s 窗口被清
    remaining = sorted(os.listdir(buf))
    assert len(remaining) == 1  # 只留最新一张
    with open(os.path.join(buf, remaining[0]), "rb") as fh:
        assert fh.read() == b"f2.png"  # 留下的确是最新截图


def test_capture_failure_returns_none_not_raise(buf):
    def bad_cap():
        raise OSError("no monitor")

    mon = ScreenMonitor(interval_sec=0, blacklist=(), buffer_dir=str(buf),
                        now_fn=lambda: 1.0, capture_fn=bad_cap,
                        fg_fn=FakeFg({"title": "t", "process": "x"}))
    assert mon.tick() is None


# ---- vision ----

def test_describe_event_structured():
    def fake_vision(path, schema):
        assert schema["properties"]["app"]
        return {"json": {"app": "Code.exe", "activity": "写代码",
                         "topics": ["PAI-Station"]}}

    ev = describe_event(fake_vision, "x.png")
    assert ev["app"] == "Code.exe" and ev["activity"] == "写代码"
    assert ev["topics"] == ["PAI-Station"]


def test_describe_event_degrades_on_failure():
    def bad_vision(path, schema):
        raise RuntimeError("vision down")

    ev = describe_event(bad_vision, "x.png")
    assert ev["app"] == "" and ev["topics"] == []
    assert ev.get("error")  # 留痕但不崩


def test_wechat_snapshot_detects_and_summarizes():
    def fake_vision(path, schema):
        return {"json": {"is_wechat": True,
                         "messages_summary": "3 条工作群消息，1 条私聊"}}

    snap = wechat_snapshot(fake_vision, "x.png")
    assert snap["is_wechat"] is True
    assert "工作群" in snap["messages_summary"]


def test_wechat_snapshot_non_wechat_screen():
    def fake_vision(path, schema):
        return {"json": {"is_wechat": False, "messages_summary": ""}}

    snap = wechat_snapshot(fake_vision, "x.png")
    assert snap["is_wechat"] is False
