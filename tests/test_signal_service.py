"""M7a 信号源聚合服务：七路采样调度 + 暂停熔断 + 单源故障隔离。"""
from datetime import datetime

from paistation.sense.signal_service import SignalService
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 16, 0, 0)


class _FakeStream:
    def __init__(self):
        self.events = []

    def append(self, ev):
        assert validate_event(ev), f"事件不合规: {ev}"
        self.events.append(ev)


class _ResolverStub:
    def __init__(self, domain="github.com"):
        self.domain = domain

    def resolve(self, process, title):
        return self.domain if "chrome" in (process or "") else ""


class _Clock:
    """手动单调钟（tick 之间手动推进）。"""

    def __init__(self):
        self.t = 0.0

    def __call__(self):
        return self.t


def _service(stream, *, window_fn=None, intervals=None, clock=None):
    return SignalService(
        stream,
        intervals=intervals,
        window_fn=window_fn or (lambda: {"title": "X - Google Chrome",
                                         "process": "chrome.exe"}),
        idle_fn=lambda: 5.0,
        clipboard_fn=lambda: {"kind": "text", "text": "普通文本"},
        locked_fn=lambda: False,
        tasklist_fn=lambda: '"chrome.exe","1","C","1","100 K"\n',
        netsh_fn=lambda: "    SSID                   : Home\n"
                         "    状态                   : 已连接\n",
        resolver=_ResolverStub(),
        now_fn=lambda: _NOW,
        mono_fn=clock or _Clock())


def test_first_tick_collects_all_sources():
    stream = _FakeStream()
    svc = _service(stream)
    svc.start()
    svc.tick()
    types = [e["type"] for e in stream.events]
    assert "window.focus" in types
    assert "browser.url" in types        # 窗口事件驱动域名
    assert "clipboard.change" in types
    assert "process.snapshot" in types
    assert "net.state" in types
    # AFK 未离席 / 会话基线 → 无事件（正确行为，不是缺失）


def test_paused_and_stopped_ticks_silent():
    stream = _FakeStream()
    svc = _service(stream)
    svc.tick()                            # 未 start → 静默
    assert stream.events == []
    svc.start()
    svc.tick(paused=True)                 # PAUSE 熔断 → 跳过采样
    assert stream.events == []


def test_interval_throttle():
    stream = _FakeStream()
    clock = _Clock()
    calls = {"window": 0, "clipboard": 0}

    def window_fn():
        calls["window"] += 1
        return {"title": f"标题{calls['window']} - Google Chrome",
                "process": "chrome.exe"}

    def clipboard_fn():
        calls["clipboard"] += 1
        return {"kind": "text", "text": f"文本{calls['clipboard']}"}

    svc = SignalService(
        stream, intervals={"window": 5.0, "afk": 30.0, "clipboard": 5.0,
                           "process": 120.0, "session": 10.0, "net": 60.0},
        window_fn=window_fn, idle_fn=lambda: 5.0, clipboard_fn=clipboard_fn,
        locked_fn=lambda: False, tasklist_fn=lambda: "",
        netsh_fn=lambda: "", resolver=_ResolverStub(),
        now_fn=lambda: _NOW, mono_fn=clock)
    svc.start()
    svc.tick()
    assert calls == {"window": 1, "clipboard": 1}
    clock.t += 3.0                       # +3s：全部未到期
    svc.tick()
    assert calls == {"window": 1, "clipboard": 1}
    clock.t += 3.0                       # +6s：window/clipboard 到期再采
    svc.tick()
    assert calls == {"window": 2, "clipboard": 2}


def test_single_source_failure_isolated():
    stream = _FakeStream()

    def boom():
        raise RuntimeError("窗口 API 失联")

    svc = _service(stream, window_fn=boom)
    svc.start()
    svc.tick()
    types = [e["type"] for e in stream.events]
    assert "window.focus" not in types
    assert "clipboard.change" in types   # 其余源不受牵连


def test_browser_domain_change_only_emits_on_change():
    stream = _FakeStream()
    clock = _Clock()
    windows = iter([
        {"title": "X - Google Chrome", "process": "chrome.exe"},
        {"title": "Y - Google Chrome", "process": "chrome.exe"},
    ])
    svc = _service(stream, window_fn=lambda: next(windows, {
        "title": "Y - Google Chrome", "process": "chrome.exe"}),
        clock=clock)
    svc.start()
    svc.tick()
    urls = [e for e in stream.events if e["type"] == "browser.url"]
    assert len(urls) == 1
    clock.t += 10.0                      # 标题变了但域名不变
    svc.tick()
    urls = [e for e in stream.events if e["type"] == "browser.url"]
    assert len(urls) == 1                # 域名未变不重复产出
    assert len([e for e in stream.events
                if e["type"] == "window.focus"]) == 2
