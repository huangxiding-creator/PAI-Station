"""微信深读安全脑（M10.1，PROPOSAL_V2.md 第 6 章 + R13 红线）。

实机视觉通道之外的 全部 纯逻辑安全件：
NightWindow / Reminder / BudgetGuard / CircuitBreaker / Presence。
红线（永久生效，收紧免问放宽须批）：
- 夜间窗口 00:00-05:00 执行（用户 2026-09-11 指示）
- 启动前 10 分钟企微提醒，仅一次（用户 2026-09-11 指示）
- 每夜 ≤1 会话；每会话 ≤300 屏 / ≤90 分钟（先到为准）
- 连续 2 夜熔断 → 暂停等用户确认
- 用户活跃（最近键鼠 <5 分钟）自动让路
"""
from __future__ import annotations

from dataclasses import dataclass, field
from datetime import datetime, timedelta

REMIND_LEAD_MINUTES = 10


# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class NightWindow:
    """夜间执行窗口 + 每夜单会话闸门。"""

    start: int = 0   # 小时，含
    end: int = 5     # 小时，不含

    def in_window(self, now: datetime) -> bool:
        return self.start <= now.hour < self.end

    def should_run(self, last_run_date: str | None, now: datetime) -> bool:
        """窗口内 且 当夜未跑过（日期以会话发生日的凌晨归属当夜）。"""
        if not self.in_window(now):
            return False
        return last_run_date != now.strftime("%Y-%m-%d")


# ---------------------------------------------------------------------------

@dataclass
class Reminder:
    """R13 启动提醒：会话前 10 分钟发一次，含 STOP 拦停选项。"""

    session_at: datetime | None = None
    notify: object = None
    _fired: bool = False

    def render(self, now: datetime) -> str:
        wait = (self.session_at - now) if self.session_at else timedelta(0)
        return (f"【微信深读提醒】预计 {wait} 后开始（夜间窗口，"
                "近一年聊天/朋友圈/收藏增量入画像）。不需要请回复 STOP。")

    def maybe_fire(self, now: datetime) -> bool:
        """距会话 ≤10 分钟且未发过 → 发送（仅一次）。无会话时间不发。"""
        if self._fired or self.session_at is None:
            return False
        if timedelta(0) <= self.session_at - now <= timedelta(
                minutes=REMIND_LEAD_MINUTES):
            if callable(self.notify):
                self.notify(self.render(now))
            self._fired = True
            return True
        return False


# ---------------------------------------------------------------------------

@dataclass
class BudgetGuard:
    """会话硬顶：屏数 300 / 分钟 90，先到为准。"""

    max_screens: int = 300
    max_minutes: int = 90
    screens: int = 0
    started_at: datetime | None = None

    def start(self, at: datetime) -> None:
        self.started_at = at

    def add(self, n: int) -> None:
        self.screens += n

    def allow_add(self, n: int) -> bool:
        return self.screens + n <= self.max_screens

    def allow_at(self, now: datetime) -> bool:
        if self.started_at is None:
            return True
        return now - self.started_at <= timedelta(minutes=self.max_minutes)


# ---------------------------------------------------------------------------

@dataclass
class CircuitBreaker:
    """连续 N 夜失败 → 跳闸暂停；用户确认后恢复；成功重置连败。"""

    threshold: int = 2
    _streak: int = 0
    _tripped: bool = False

    def record_failure(self, night: str) -> None:  # noqa: ARG002 - 夜次仅日志用
        self._streak += 1
        if self._streak >= self.threshold:
            self._tripped = True

    def record_success(self, night: str) -> None:  # noqa: ARG002
        self._streak = 0
        self._tripped = False

    def tripped(self) -> bool:
        return self._tripped

    def user_ack(self) -> None:
        self._streak = 0
        self._tripped = False


# ---------------------------------------------------------------------------

@dataclass(frozen=True)
class Presence:
    """用户在场检测：最近键鼠事件 < 阈值 → 深读让路（夜间也绝不抢鼠标）。"""

    idle_seconds_threshold: int = 300

    def yield_to_user(self, last_input: datetime | None,
                      now: datetime) -> bool:
        if last_input is None:
            return False
        return now - last_input < timedelta(seconds=self.idle_seconds_threshold)
