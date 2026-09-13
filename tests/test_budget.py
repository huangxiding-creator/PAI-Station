"""M3.2 打扰预算+置信分档：即时通知有日上限，其余进晨报。"""
from datetime import datetime, timedelta

from paistation.proactive.budget import InterruptionBudget
from paistation.proactive.taskcards import extract_task_cards


def _card(text, ts="2026-09-13T10:00:00"):
    return extract_task_cards([{"ts": ts, "type": "voice.transcript",
                                "source": "mic", "text": text,
                                "speaker": "unknown",
                                "evidence": {}, "meta": {}}])[0]


def _now():
    return datetime(2026, 9, 13, 12, 0)


def test_high_confidence_urgent_notifies_now():
    budget = InterruptionBudget(daily_immediate_cap=3)
    card = _card("请帮我调研定价策略，今天下午四点前要。")
    assert budget.should_notify_now(card, now=_now()) is True


def test_low_urgency_goes_to_digest():
    budget = InterruptionBudget(daily_immediate_cap=3)
    card = _card("有空的时候把桌面文件归档一下。")
    assert budget.should_notify_now(card, now=_now()) is False


def test_daily_cap_exhausted_all_to_digest():
    budget = InterruptionBudget(daily_immediate_cap=1)
    first = _card("请帮我调研定价策略，今天下午四点前要。")
    second = _card("明天上午要把报告交给张总，别忘了。")
    assert budget.should_notify_now(first, now=_now()) is True
    assert budget.should_notify_now(second, now=_now()) is False  # 预算耗尽


def test_cap_resets_next_day():
    budget = InterruptionBudget(daily_immediate_cap=1)
    card = _card("请帮我调研定价策略，今天下午四点前要。")
    assert budget.should_notify_now(card, now=_now()) is True
    assert budget.should_notify_now(card, now=_now() + timedelta(days=1)) is True


def test_build_digest_groups_cards():
    budget = InterruptionBudget()
    cards = [
        _card("请帮我调研定价策略，明天上午要结果。"),
        _card("25号前提交季度总结。"),
    ]
    digest = budget.build_digest(cards, now=_now())
    assert "定价" in digest and "季度总结" in digest
    assert "晨报" in digest
    assert "明天" in digest or "09-14" in digest
