"""M7a 信号源聚合服务：七路 watcher → 统一事件流。

服务契约与 VoicePipeline 同款（name/started/tick(paused)/stop）。
每源独立间隔节流防风暴；PAUSE 下跳过采样（银甲虫 setPaused 同义）。
浏览器 URL 为事件驱动：window.focus 命中浏览器进程时解析域名，
域名变更才产出（默认 DomainResolver 只读 History 副本）。
全部采样函数可注入（测试不打真系统）；缺源零产出不崩。
"""
from __future__ import annotations

import logging
import time
from datetime import datetime

from .browser_url import DomainResolver
from .clipboard import ClipboardTracker, read_clipboard
from .fgwindow import active_window
from .net_state import net_event, parse_wlan, run_netsh
from .presence_stream import AfkTracker, idle_seconds
from .process_snapshot import parse_tasklist, run_tasklist, snapshot_event, \
    top_by_memory
from .session_events import SessionTracker, input_desktop_available
from .window_watcher import WindowTracker

_log = logging.getLogger("paistation.sense.signals")

DEFAULT_INTERVALS = {
    "window": 5.0,      # 前台窗口焦点
    "afk": 30.0,        # 在场/离席
    "clipboard": 5.0,   # 剪贴板
    "process": 120.0,   # 进程快照
    "session": 10.0,    # 锁屏/解锁
    "net": 60.0,        # 网络 SSID
}


class SignalService:
    """M7a 七路信号源 → stream（tick 由 daemon 驱动）。"""

    name = "signals"

    def __init__(self, stream, deepwork_apps: tuple = (),
                 intervals: dict | None = None, *,
                 window_fn=active_window, idle_fn=idle_seconds,
                 clipboard_fn=read_clipboard, locked_fn=None,
                 tasklist_fn=run_tasklist, netsh_fn=run_netsh,
                 resolver=None, now_fn=None, mono_fn=None):
        self._stream = stream
        self._now = now_fn or datetime.now
        self._mono = mono_fn or time.monotonic
        self._intervals = dict(DEFAULT_INTERVALS, **(intervals or {}))
        self._window = WindowTracker(deepwork_apps, now_fn=self._now)
        self._afk = AfkTracker(now_fn=self._now)
        self._clipboard = ClipboardTracker(now_fn=self._now)
        self._session = SessionTracker(now_fn=self._now)
        self._resolver = resolver or DomainResolver()
        self._window_fn = window_fn
        self._idle_fn = idle_fn
        self._clipboard_fn = clipboard_fn
        self._locked_fn = locked_fn or _locked_default
        self._tasklist_fn = tasklist_fn
        self._netsh_fn = netsh_fn
        self._last_domain = ""
        self._last_net = None
        self._next_due: dict[str, float] = {}
        self.started = False

    # ---- 服务契约（daemon）----

    def start(self) -> None:
        self.started = True

    def stop(self) -> None:
        self.started = False

    def tick(self, paused: bool = False) -> None:
        if paused or not self.started:
            return
        mono = self._mono()
        for source in self._intervals:
            if mono >= self._next_due.get(source, 0.0):
                self._next_due[source] = mono + self._intervals[source]
                self._sample(source)

    # ---- 采样分发 ----

    def _sample(self, source: str) -> None:
        try:
            handler = getattr(self, "_src_" + source)
        except AttributeError:
            return
        try:
            handler()
        except Exception as exc:  # noqa: BLE001 - 单源故障不杀服务
            _log.warning("信号源 %s 采样异常: %s", source, exc)

    def _src_window(self) -> None:
        ev = self._window.feed(self._window_fn() or {})
        if not ev:
            return
        self._emit(ev)
        domain = self._resolver.resolve(ev["meta"]["process"],
                                        ev["text"])
        if domain and domain != self._last_domain:
            self._last_domain = domain
            self._emit({
                "ts": ev["ts"], "type": "browser.url", "source": "history",
                "text": domain,
                "evidence": {"title": ev["text"][:80]},
                "meta": {"domain": domain}})

    def _src_afk(self) -> None:
        for ev in self._afk.feed(self._idle_fn()):
            self._emit(ev)

    def _src_clipboard(self) -> None:
        ev = self._clipboard.feed(self._clipboard_fn() or {})
        if ev:
            self._emit(ev)

    def _src_process(self) -> None:
        top = top_by_memory(parse_tasklist(self._tasklist_fn()))
        if top:
            self._emit(snapshot_event(top, now_fn=self._now))

    def _src_session(self) -> None:
        ev = self._session.feed(self._locked_fn())
        if ev:
            self._emit(ev)

    def _src_net(self) -> None:
        state = parse_wlan(self._netsh_fn())
        if state["ssid"] is None and state["connected"] is None:
            return  # 有线/无网卡：缺席不产出
        key = (state["ssid"], state["connected"])
        if key == self._last_net:
            return
        self._last_net = key
        self._emit(net_event(state, now_fn=self._now))

    def _emit(self, ev: dict) -> None:
        self._stream.append(ev)


def _locked_default() -> bool | None:
    return not input_desktop_available()
