"""M7a AFK 在场流（ActivityWatch afk watcher / 银甲虫 idle 判定）。

迟滞双阈值：空闲 ≥away_sec（默认 300s）判离席；恢复输入 ≤back_sec
（默认 60s）判回席。探测失败 → None → 不产出（安全默认：不误报离席）。
"""
from __future__ import annotations

from datetime import datetime

from .presence import last_input_at


def idle_seconds(now_fn=None) -> float | None:
    """当前空闲秒数；非 Windows/API 失败 → None。"""
    now = now_fn or datetime.now
    at = last_input_at(now_fn=now)
    if at is None:
        return None
    return max(0.0, (now() - at).total_seconds())


class AfkTracker:
    """空闲秒数采样 → presence.afk start/end 事件（迟滞防抖动）。"""

    def __init__(self, away_sec: float = 300.0, back_sec: float = 60.0,
                 now_fn=None):
        self._away = away_sec
        self._back = back_sec
        self._now = now_fn or datetime.now
        self._afk = False

    def feed(self, idle_s: float | None) -> list[dict]:
        if idle_s is None:
            return []
        if not self._afk and idle_s >= self._away:
            self._afk = True
            return [self._event("start", idle_s)]
        if self._afk and idle_s <= self._back:
            self._afk = False
            return [self._event("end", idle_s)]
        return []

    def _event(self, phase: str, idle_s: float) -> dict:
        return {
            "ts": self._now().isoformat(timespec="milliseconds"),
            "type": "presence.afk",
            "source": "presence",
            "text": "",
            "evidence": {"idle_s": round(idle_s, 1)},
            "meta": {"phase": phase},
        }
