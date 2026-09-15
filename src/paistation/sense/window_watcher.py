"""M7a 前台窗口焦点流（第 11 路：ActivityWatch bucket / 银甲虫采集）。

WindowTracker 纯逻辑（(process,title) 变更去重 → window.focus 事件，
含 attention 分类）；采样薄壳由 signal_service 注入 fgwindow.active_window。
缺席不崩：无交互会话（空窗口）零产出。
"""
from __future__ import annotations

from datetime import datetime

from .fgwindow import classify_attention


class WindowTracker:
    """(process, title) 签名变更 → window.focus 事件；首样本即建基线。"""

    def __init__(self, deepwork_apps: tuple = (), now_fn=None):
        self._deepwork = tuple(deepwork_apps)
        self._now = now_fn or datetime.now
        self._last = ("", "")

    def feed(self, window: dict) -> dict | None:
        title = (window.get("title") or "").strip()
        process = (window.get("process") or "").strip()
        if not process and not title:
            return None  # 无窗口（服务会话）缺席不崩
        sig = (process, title)
        if sig == self._last:
            return None
        prev = self._last
        self._last = sig
        return {
            "ts": self._now().isoformat(timespec="milliseconds"),
            "type": "window.focus",
            "source": "fgwindow",
            "text": title,
            "evidence": {"prev_process": prev[0], "prev_title": prev[1]},
            "meta": {"process": process,
                     "attention": classify_attention(window, self._deepwork)},
        }
