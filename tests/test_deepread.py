"""M10.1 微信深读调度器 TDD（PROPOSAL_V2.md 第 6 章 + R13 红线）。

五大纯逻辑件（实机视觉通道之外的全部安全脑）：
- NightWindow：夜间窗口 00:00-05:00（用户指示）
- Reminder：启动前 10 分钟提醒，仅一次（R13 铁律）
- BudgetGuard：每会话 ≤300 屏 / ≤90 分钟硬顶（先到为准）
- CircuitBreaker：连续 2 夜熔断 → 暂停等用户确认
- Presence：用户活跃（最近键鼠 <5 分钟）→ 让路
"""
from datetime import datetime, timedelta

import pytest

from paistation.sense.deepread import (
    BudgetGuard,
    CircuitBreaker,
    NightWindow,
    Presence,
    Reminder,
)


# ---------------------------------------------------------------------------

def test_night_window():
    w = NightWindow(start=0, end=5)
    assert w.in_window(datetime(2026, 9, 12, 0, 30)) is True
    assert w.in_window(datetime(2026, 9, 12, 4, 59)) is True
    assert w.in_window(datetime(2026, 9, 12, 5, 0)) is False
    assert w.in_window(datetime(2026, 9, 12, 14, 0)) is False
    assert w.in_window(datetime(2026, 9, 12, 23, 59)) is False


def test_night_window_one_session_per_night():
    w = NightWindow(start=0, end=5)
    assert w.should_run(last_run_date=None,
                        now=datetime(2026, 9, 12, 1, 0)) is True
    assert w.should_run(last_run_date="2026-09-12",
                        now=datetime(2026, 9, 12, 2, 0)) is False  # 当夜已跑
    assert w.should_run(last_run_date="2026-09-11",
                        now=datetime(2026, 9, 12, 2, 0)) is True


# ---------------------------------------------------------------------------

def test_reminder_fires_once_ten_minutes_before():
    fired = []
    r = Reminder(notify=lambda msg: fired.append(msg))
    now = datetime(2026, 9, 12, 0, 50)
    assert r.maybe_fire(now) is False          # 距 01:00 会话还 10 分钟外？0:50→1:00=10min
    # 构造：会话 01:00，now=00:50 恰好 10 分钟 → 触发
    r2 = Reminder(session_at=datetime(2026, 9, 12, 1, 0),
                  notify=lambda msg: fired.append(msg))
    assert r2.maybe_fire(datetime(2026, 9, 12, 0, 50)) is True
    assert r2.maybe_fire(datetime(2026, 9, 12, 0, 52)) is False  # 仅一次
    assert any("微信深读" in m for m in fired)


def test_reminder_requires_ack_option():
    r = Reminder(session_at=datetime(2026, 9, 12, 1, 0),
                 notify=lambda msg: None)
    msg = r.render(datetime(2026, 9, 12, 0, 50))
    assert "STOP" in msg                       # 用户可拦停（R13 配套）


# ---------------------------------------------------------------------------

def test_budget_guard_screen_cap():
    g = BudgetGuard(max_screens=300, max_minutes=90)
    assert g.allow_add(299) is True
    g.add(299)
    assert g.allow_add(2) is False             # 300 硬顶


def test_budget_guard_time_cap():
    t0 = datetime(2026, 9, 12, 1, 0)
    g = BudgetGuard(max_screens=300, max_minutes=90)
    g.start(t0)
    assert g.allow_at(t0 + timedelta(minutes=89)) is True
    assert g.allow_at(t0 + timedelta(minutes=91)) is False


# ---------------------------------------------------------------------------

def test_circuit_breaker_two_nights_pause():
    cb = CircuitBreaker(threshold=2)
    assert cb.tripped() is False
    cb.record_failure("2026-09-12")
    assert cb.tripped() is False
    cb.record_failure("2026-09-13")            # 连续第 2 夜
    assert cb.tripped() is True
    cb.user_ack()
    assert cb.tripped() is False               # 确认后恢复


def test_circuit_breaker_success_resets_streak():
    cb = CircuitBreaker(threshold=2)
    cb.record_failure("2026-09-12")
    cb.record_success("2026-09-13")
    cb.record_failure("2026-09-14")
    assert cb.tripped() is False               # 非连续 → 不跳闸


# ---------------------------------------------------------------------------

def test_presence_yields_when_user_active():
    now = datetime(2026, 9, 12, 1, 0)
    p = Presence(idle_seconds_threshold=300)
    assert p.yield_to_user(last_input=now - timedelta(seconds=60),
                           now=now) is True    # 1 分钟前有键鼠 → 让路
    assert p.yield_to_user(last_input=now - timedelta(minutes=30),
                           now=now) is False   # 30 分钟无操作 → 可跑
    assert p.yield_to_user(last_input=None, now=now) is False
