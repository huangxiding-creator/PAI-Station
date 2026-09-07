"""M2 outbox：推送预算 + 勿扰时段 + 成果抽屉 retention。"""
from datetime import datetime

import pytest

from paistation.proactive.outbox import Outbox


class FakeChannel:
    def __init__(self, ok=True):
        self.sent: list[tuple] = []
        self._ok = ok

    def send(self, title, body):
        self.sent.append((title, body))
        return {"ok": self._ok, "errcode": 0 if self._ok else 1,
                "errmsg": "ok" if self._ok else "限流"}


def fixed_now(hhmm: str, day: int = 1):
    """可注入时钟：2026-09-{day} {hhmm}:00。"""
    def now():
        return datetime(2026, 9, day, *[int(x) for x in hhmm.split(":")])
    return now


@pytest.fixture
def state(tmp_path):
    return str(tmp_path / "outbox.json")


def test_push_within_budget_and_daytime(state):
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=2, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    r = ob.push(ch, "提醒", "内容")
    assert r["delivered"] is True
    assert ch.sent == [("提醒", "内容")]


def test_budget_exhausted_silences_to_drawer(state):
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    assert ob.push(ch, "第一条", "x")["delivered"] is True
    r2 = ob.push(ch, "第二条", "y")
    assert r2["delivered"] is False and "预算" in r2["reason"]
    assert len(ch.sent) == 1                 # 只发了一条
    assert any(d["title"] == "第二条" for d in ob.drawer())  # 静默进抽屉


def test_quiet_hours_hold_and_release(state):
    ch = FakeChannel()
    hours = ("23:00", "07:00")
    ob = Outbox(max_push_per_day=5, quiet_hours=hours,
                state_path=state, now_fn=fixed_now("23:30"))
    r = ob.push(ch, "深夜", "x")
    assert r["delivered"] is False and "勿扰" in r["reason"]
    ob2 = Outbox(max_push_per_day=5, quiet_hours=hours,
                 state_path=state, now_fn=fixed_now("07:30"))
    assert ob2.push(ch, "清晨", "x")["delivered"] is True


def test_quiet_hours_same_day_range(state):
    """勿扰不跨午夜：13:00-14:00。"""
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=5, quiet_hours=("13:00", "14:00"),
                state_path=state, now_fn=fixed_now("13:30"))
    assert ob.push(ch, "t", "b")["delivered"] is False


def test_budget_resets_next_day(state):
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00", day=1))
    ob.push(ch, "今天", "x")
    ob2 = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                 state_path=state, now_fn=fixed_now("10:00", day=2))
    assert ob2.push(ch, "明天", "x")["delivered"] is True  # 新一天预算重置


def test_failed_send_not_counted(state):
    ch = FakeChannel(ok=False)
    ob = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    r = ob.push(ch, "失败", "x")
    assert r["delivered"] is False
    ch2 = FakeChannel()
    assert ob.push(ch2, "重试", "x")["delivered"] is True  # 失败不占预算


def test_drawer_retention_cleanup(state):
    ch = FakeChannel(ok=False)  # 全进抽屉
    ob = Outbox(max_push_per_day=0, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    ob.push(ch, "旧消息", "x")
    ob._drawer[0]["ts"] = 0  # 手动老化
    ob.cleanup(older_than_days=3)
    assert ob.drawer() == []


def test_state_persists_across_instances(state):
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    ob.push(ch, "持久", "x")
    ob2 = Outbox(max_push_per_day=1, quiet_hours=("23:00", "07:00"),
                 state_path=state, now_fn=fixed_now("11:00"))
    r = ob2.push(ch, "再来", "x")
    assert r["delivered"] is False          # 跨实例预算仍在


def test_stats(state):
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=5, quiet_hours=("23:00", "07:00"),
                state_path=state, now_fn=fixed_now("10:00"))
    ob.push(ch, "a", "x")
    st = ob.stats()
    assert st["today_sent"] == 1 and st["drawer_items"] == 0


def test_quiet_hours_accepts_c1_dash_string(state):
    """附录 C.1 单串格式 '22:00-07:00' 直接可用。"""
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=5, quiet_hours="22:00-07:00",
                state_path=state, now_fn=fixed_now("23:30"))
    assert ob.push(ch, "t", "b")["delivered"] is False


def test_quiet_hours_rejects_garbage(state):
    import pytest as _pytest
    with _pytest.raises(ValueError):
        Outbox(max_push_per_day=1, quiet_hours="随时随地",
               state_path=state, now_fn=fixed_now("10:00"))


def test_real_struct_time_clock(state):
    """生产路径 time.localtime()（struct_time）与勿扰判定兼容。"""
    import time as _t
    ch = FakeChannel()
    ob = Outbox(max_push_per_day=5, quiet_hours="00:00-23:59",
                state_path=state, now_fn=_t.localtime)
    assert ob.push(ch, "t", "b")["delivered"] is False  # 全天勿扰
