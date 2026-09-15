"""M7a 会话事件流（锁屏/解锁；ActivityWatch 同款信号）。

OpenInputDesktop 探测：锁屏/切换桌面时输入桌面不可用。探测失败 →
True（安全默认=不误报锁屏）。SessionTracker 纯逻辑首样本建基线。
"""
from __future__ import annotations

import ctypes
from datetime import datetime

_DESKTOP_READOBJECTS = 0x0001


def input_desktop_available() -> bool:
    """输入桌面是否可用（锁屏/断连 → False）。"""
    try:
        user32 = ctypes.windll.user32
        handle = user32.OpenInputDesktop(0, False, _DESKTOP_READOBJECTS)
        if not handle:
            return False
        user32.CloseDesktop(handle)
        return True
    except Exception:  # noqa: BLE001 - 非 Windows / API 失败
        return True


class SessionTracker:
    """锁屏布尔采样 → session.state 事件（仅变化时产出）。"""

    def __init__(self, now_fn=None):
        self._now = now_fn or datetime.now
        self._locked = None

    def feed(self, locked: bool | None) -> dict | None:
        if locked is None:
            return None
        if self._locked is None:
            self._locked = locked  # 首样本建基线不产出
            return None
        if locked == self._locked:
            return None
        self._locked = locked
        return {
            "ts": self._now().isoformat(timespec="milliseconds"),
            "type": "session.state",
            "source": "wts",
            "text": "",
            "evidence": {"locked": locked},
            "meta": {"locked": locked,
                     "phase": "lock" if locked else "unlock"},
        }
