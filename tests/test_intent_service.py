"""M8 意图常驻服务：事件流 → 段 → 拒识门 → L2 → 画像（增量断点）。"""
from datetime import datetime, timedelta

from paistation.intent.service import IntentService
from paistation.profile.model import ProfileModel
from paistation.sense.voice_events import validate_event

_T0 = datetime(2026, 9, 15, 10, 0, 0)


def _ev(ts, ev_type, text="", meta=None):
    ev = {"ts": ts.isoformat(timespec="milliseconds"), "type": ev_type,
          "source": "sense", "text": text, "speaker": "",
          "evidence": {}, "meta": meta or {}}
    assert validate_event(ev)
    return ev


def _coding_events(t0, n=4):
    """一段混合活动块（code/知乎交替 → coverage 0.5 → complex 档烧 LLM）。"""
    evs = []
    for i in range(n):
        ts = t0 + timedelta(minutes=5 * i)
        if i % 2 == 0:
            evs.append(_ev(ts, "window.focus", f"main{i}.py - pai",
                           meta={"process": "Code.exe"}))
        else:
            evs.append(_ev(ts, "window.focus", "知乎问题页",
                           meta={"process": "chrome.exe"}))
    return evs


class _Clock:
    def __init__(self):
        self.t = 0.0

    def __call__(self):
        return self.t


class _FakeGateway:
    def __init__(self):
        self.calls = 0

    def chat(self, messages, **kw):
        self.calls += 1
        return ('{"activity": "在写 PAI 意图层", "project": "PAI-Station",'
                ' "category": "project", "summary": "编码", "evidence": [],'
                ' "confidence": 0.9, "next_action": ""}'), "fake"


def test_service_contract_and_first_tick(tmp_path):
    profile = ProfileModel(tmp_path)
    gw = _FakeGateway()
    events = list(_coding_events(_T0))
    svc = IntentService(events_fn=lambda: events, profile=profile,
                        gateway=gw, now_fn=lambda: _T0 + timedelta(hours=1))
    assert svc.name == "intent"
    svc.tick()                            # 未 start → 静默
    assert svc.intents == [] and gw.calls == 0
    svc.start()
    svc.tick(paused=True)                 # PAUSE 熔断
    assert svc.intents == []
    svc.tick()
    assert len(svc.intents) == 1
    row = svc.intents[0]
    assert row["decision"] == "accept"
    assert row["intent"]["llm"] is True   # complex 档烧了 LLM
    assert row["block"]["category"] == "project"


def test_incremental_no_duplicate(tmp_path):
    """同批事件重复 tick 不重复产出（按块 end 增量）。"""
    events = list(_coding_events(_T0))
    svc = IntentService(events_fn=lambda: events, now_fn=lambda: _T0,
                        interval=0)
    svc.start()
    svc.tick()
    svc.tick()
    assert len(svc.intents) == 1


def test_new_block_processed_on_next_tick(tmp_path):
    holder = {"evs": list(_coding_events(_T0))}
    svc = IntentService(events_fn=lambda: holder["evs"], interval=0,
                        now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    holder["evs"] += _coding_events(_T0 + timedelta(hours=2))
    svc.tick()
    assert len(svc.intents) == 2


def test_rejected_blocks_not_recorded(tmp_path):
    """一眼扫过的短消息块被拒识门拦下，不进意图列表。"""
    t = _T0
    evs = [_ev(t, "window.focus", "微信", meta={"process": "WeChat.exe"})]
    svc = IntentService(events_fn=lambda: evs, interval=0,
                        now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    assert svc.intents == []              # 0 分钟块 → 过短拒绝


def test_profile_records_accepted_intent(tmp_path):
    profile = ProfileModel(tmp_path)
    gw = _FakeGateway()
    svc = IntentService(events_fn=lambda: list(_coding_events(_T0)),
                        profile=profile, gateway=gw, interval=0,
                        now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    rows = profile.query(layer="workflow")
    assert len(rows) == 1
    assert rows[0].value == "在写 PAI 意图层"


def test_gateway_absent_degrades_to_l1(tmp_path):
    """无 LLM 网关：L1 直判照常出意图（conf 0.3 由门内 simple/门后处理）。"""
    svc = IntentService(events_fn=lambda: list(_coding_events(_T0)),
                        interval=0, now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    assert len(svc.intents) == 1
    assert svc.intents[0]["intent"]["llm"] is False


def test_latest_helper_capped(tmp_path):
    events = list(_coding_events(_T0)) + _coding_events(_T0 + timedelta(
        hours=2)) + _coding_events(_T0 + timedelta(hours=4))
    svc = IntentService(events_fn=lambda: events, interval=0,
                        now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    assert len(svc.intents) == 3
    assert len(svc.latest(2)) == 2        # 最新两条


def test_corrupt_events_fail_soft(tmp_path):
    svc = IntentService(events_fn=lambda: [{"坏事件": 1}], interval=0,
                        now_fn=lambda: _T0)
    svc.start()
    svc.tick()                            # 不炸，零产出
    assert svc.intents == []


def test_interval_throttle(tmp_path):
    clock = _Clock()
    calls = {"n": 0}

    def events_fn():
        calls["n"] += 1
        return []

    svc = IntentService(events_fn=events_fn, interval=60.0,
                        mono_fn=clock, now_fn=lambda: _T0)
    svc.start()
    svc.tick()
    assert calls["n"] == 1
    clock.t += 30.0
    svc.tick()
    assert calls["n"] == 1                # 未到期
    clock.t += 31.0
    svc.tick()
    assert calls["n"] == 2
