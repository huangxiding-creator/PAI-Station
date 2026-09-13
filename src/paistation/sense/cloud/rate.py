"""M2.6 账号安全四件套：节流+冷却+日限额+熔断（红线：账号安全第一）。

全部非阻塞：try_acquire() 不等待、不消耗配额，不满足即 False，
调用方稍后重试；report(ok) 反馈结果驱动冷却与熔断。串行铁律由
CloudSensingService 单线程轮询保证（连接器间也串行）。
"""
from __future__ import annotations

import time


class RateLimiter:
    def __init__(self, name: str, *, min_interval_s: float = 2.0,
                 daily_cap: int = 500, cooldown_s: float = 300.0,
                 breaker_threshold: int = 3,
                 breaker_reset_s: float = 1800.0, clock=None):
        self.name = name
        self._min_interval = min_interval_s
        self._daily_cap = daily_cap
        self._cooldown_s = cooldown_s
        self._breaker_threshold = breaker_threshold
        self._breaker_reset_s = breaker_reset_s
        self._clock = clock or time.monotonic
        self._last_acquire = float("-inf")
        self._last_failure = float("-inf")
        self._fail_streak = 0
        self._day: int | None = None
        self._day_count = 0

    def try_acquire(self) -> bool:
        now = self._clock()
        day = int(now // 86400)
        if day != self._day:  # 跨天重置日限额
            self._day, self._day_count = day, 0
        if now - self._last_failure < self._cooldown_s:
            return False  # 冷却中
        if (self._fail_streak >= self._breaker_threshold
                and now - self._last_failure < self._breaker_reset_s):
            return False  # 熔断开启
        if self._day_count >= self._daily_cap:
            return False  # 日限额硬顶
        if now - self._last_acquire < self._min_interval:
            return False  # 节流
        self._last_acquire = now
        self._day_count += 1
        return True

    def report(self, ok: bool) -> None:
        if ok:
            self._fail_streak = 0
        else:
            self._fail_streak += 1
            self._last_failure = self._clock()
