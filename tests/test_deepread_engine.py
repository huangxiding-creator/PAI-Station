"""M10.1b 深读引擎 TDD：tick 状态机（提醒→执行→水位→熔断→STOP）。

DeepReadEngine = 安全脑（NightWindow/Reminder/Guard/Breaker/Presence）
+ 状态持久化 + 企微通道 + 注入式 reader_fn（真实视觉读取缺席时零动作）。
"""
import json
from datetime import datetime

from paistation.sense.deepread_engine import DeepReadEngine


class FakeChannel:
    def __init__(self):
        self.sent = []

    def send(self, title, body):
        self.sent.append((title, body))
        return {"ok": True}


def test_tick_outside_window_no_action(tmp_path):
    ch = FakeChannel()
    eng = DeepReadEngine(state_path=tmp_path / "st.json", channel=ch)
    eng.tick(datetime(2026, 9, 12, 14, 0))
    assert ch.sent == []
    assert not (tmp_path / "st.json").exists() or \
        json.loads((tmp_path / "st.json").read_text(encoding="utf-8"))["last_run_date"] == ""


def test_reminder_then_execute_then_watermark(tmp_path):
    ch = FakeChannel()
    calls = []

    def reader(guard, watermark):
        calls.append(dict(watermark))
        guard.add(50)
        return {"chat": "2026-09-11T23:40:00", "screens": 50}

    eng = DeepReadEngine(state_path=tmp_path / "st.json", channel=ch,
                         reader_fn=reader, session_hhmm="00:30")
    # 00:20 提醒（会话前 10 分钟）
    eng.tick(datetime(2026, 9, 12, 0, 20))
    assert len(ch.sent) == 1 and "微信深读" in ch.sent[0][0]
    # 00:29 还没到会话点 → 不执行
    eng.tick(datetime(2026, 9, 12, 0, 29))
    assert calls == []
    # 00:31 执行
    eng.tick(datetime(2026, 9, 12, 0, 31))
    assert len(calls) == 1
    st = json.loads((tmp_path / "st.json").read_text(encoding="utf-8"))
    assert st["last_run_date"] == "2026-09-12"
    assert st["watermark"]["chat"] == "2026-09-11T23:40:00"
    assert st["reminded_date"] == ""           # 提醒名额已消耗并复位
    # 当夜再 tick → 不重复
    eng.tick(datetime(2026, 9, 12, 2, 0))
    assert len(calls) == 1
    assert ch.sent == ch.sent[:1] or len(ch.sent) == 1


def test_stop_reply_blocks_tonight(tmp_path):
    ch = FakeChannel()
    calls = []
    eng = DeepReadEngine(state_path=tmp_path / "st.json", channel=ch,
                         reader_fn=lambda g, w: calls.append(1) or {},
                         session_hhmm="00:30")
    eng.user_stop(datetime(2026, 9, 12, 0, 10))
    eng.tick(datetime(2026, 9, 12, 0, 20))     # 提醒照发（在 STOP 之前已设？）
    eng.tick(datetime(2026, 9, 12, 0, 31))
    # STOP 状态下不执行；提醒是否发出取决于 STOP 时序——本用例 STOP 在提醒前
    assert calls == []


def test_circuit_breaker_pauses_engine(tmp_path):
    ch = FakeChannel()

    def failing(guard, watermark):
        raise RuntimeError("风控页异常")

    eng = DeepReadEngine(state_path=tmp_path / "st.json", channel=ch,
                         reader_fn=failing, session_hhmm="00:30")
    for night in (11, 12):
        eng.tick(datetime(2026, 9, night, 0, 20))
        eng.tick(datetime(2026, 9, night, 0, 31))
    st = json.loads((tmp_path / "st.json").read_text(encoding="utf-8"))
    assert st["tripped"] is True               # 连续 2 夜失败 → 跳闸
    # 第 3 夜：不提醒不执行
    ch.sent.clear()
    eng.tick(datetime(2026, 9, 13, 0, 20))
    eng.tick(datetime(2026, 9, 13, 0, 31))
    assert ch.sent == []
    # 用户确认恢复
    eng.user_ack()
    st = json.loads((tmp_path / "st.json").read_text(encoding="utf-8"))
    assert st["tripped"] is False


def test_presence_yields(tmp_path):
    ch = FakeChannel()
    calls = []
    eng = DeepReadEngine(state_path=tmp_path / "st.json", channel=ch,
                         reader_fn=lambda g, w: calls.append(1) or {},
                         session_hhmm="00:30")
    eng.tick(datetime(2026, 9, 12, 0, 20))           # 提醒先送达（R13 前提）
    eng.set_presence(datetime(2026, 9, 12, 0, 29))   # 1 分钟内有键鼠
    eng.tick(datetime(2026, 9, 12, 0, 31))
    assert calls == []                          # 让路不执行
    eng.tick(datetime(2026, 9, 12, 0, 45))      # 活跃信息过期（阈值内不跑）
    # 注：presence 5 分钟阈值，0:29 的活跃到 0:45 已过期 → 执行
    assert calls == [1]
