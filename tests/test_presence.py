"""M10.2a 用户在场探测 TDD：GetLastInputInfo 零依赖只读查询。

夜间深读让路红线（R 系）：最近键鼠 <5 分钟 → 引擎 set_presence → 让路。
探测失败（非 Windows / API 异常）→ None → 不让路不熔断（安全默认）。
"""
from datetime import datetime, timedelta

from paistation.sense.presence import last_input_at


def test_last_input_at_math():
    now = datetime(2026, 9, 12, 0, 31)
    at = last_input_at(now_fn=lambda: now,
                       tick_fn=lambda: 1_000_000,
                       last_fn=lambda: 999_000)      # 1 秒前有输入
    assert at == now - timedelta(seconds=1)


def test_last_input_at_clamps_negative_idle():
    now = datetime(2026, 9, 12, 0, 31)
    at = last_input_at(now_fn=lambda: now,
                       tick_fn=lambda: 100_000,
                       last_fn=lambda: 100_500)      # tick 回绕等异常
    assert at == now                                 # 钳到 0 空闲


def test_last_input_at_probe_error_returns_none():
    def boom():
        raise OSError("非 Windows 环境")

    assert last_input_at(now_fn=datetime.now,
                         tick_fn=lambda: 0, last_fn=boom) is None


def test_real_probe_smoke():
    """真机只读探测：返回 datetime（或异常环境 None），绝不抛。"""
    at = last_input_at()
    assert at is None or isinstance(at, datetime)
