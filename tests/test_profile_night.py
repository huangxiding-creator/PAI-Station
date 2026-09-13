"""M5.2 夜间整理：频次→知识/流程提案+陈旧失效提案+晨报闸后 apply。"""
from datetime import datetime, timedelta

from paistation.profile.model import ProfileModel
from paistation.profile.night import NightConsolidator


def _clk(now):
    return lambda: now


def _events(texts, day="2026-09-13"):
    return [{"ts": f"{day}T1{i:02d}:00:00", "type": "voice.transcript",
             "source": "mic", "text": t, "speaker": "user",
             "evidence": {}, "meta": {}}
            for i, t in enumerate(texts)]


def test_should_run_night_window_only():
    night = NightConsolidator(profile=None)
    assert night.should_run(datetime(2026, 9, 13, 23, 0)) is True
    assert night.should_run(datetime(2026, 9, 13, 5, 0)) is True
    assert night.should_run(datetime(2026, 9, 13, 12, 0)) is False
    assert night.should_run(datetime(2026, 9, 13, 21, 0)) is False


def test_topic_frequency_becomes_knowledge_proposal(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk(datetime(2026, 9, 13, 23, 30)))
    night = NightConsolidator(profile=p)
    events = _events(["西峰山水库工程的初步设计评审通过了。",
                      "西峰山水库工程下个月进场。",
                      "西峰山水库工程的预算还要再核一遍。"])
    proposals = night.run(events)
    kn = [x for x in proposals if x["kind"] == "knowledge"]
    assert kn and any("西峰山水库" in x["key"] for x in kn)
    assert kn[0]["evidence"]                     # 证据指针随行
    assert all(x.get("approved") is False for x in proposals)  # 不自批


def test_action_frequency_becomes_workflow_proposal(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk(datetime(2026, 9, 13, 23, 30)))
    night = NightConsolidator(profile=p)
    events = _events(["帮我调研一下A。", "调研一下B的定价。", "再调研下C。"])
    proposals = night.run(events)
    wf = [x for x in proposals if x["kind"] == "workflow"]
    assert wf and "调研" in wf[0]["key"]


def test_stale_entry_proposes_expiry(tmp_path):
    now = datetime(2026, 9, 13, 23, 30)
    old_time = now - timedelta(days=45)
    p = ProfileModel(tmp_path, clock=_clk(old_time))
    p.record("knowledge", "旧项目", "三年前跟进的老项目")
    p2 = ProfileModel(tmp_path, clock=_clk(now))
    night = NightConsolidator(profile=p2, stale_days=30)
    proposals = night.run([])
    exp = [x for x in proposals if x["kind"] == "expire"]
    assert exp and exp[0]["key"] == "旧项目"


def test_apply_only_approved(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk(datetime(2026, 9, 13, 23, 30)))
    night = NightConsolidator(profile=p)
    proposals = night.run(_events(["西峰山水库工程评审通过。",
                                   "西峰山水库工程进场。",
                                   "西峰山水库工程预算核对。"]))
    night.apply(proposals)                       # 未批准：全不落库
    assert p.query(keyword="西峰山水库") == []
    for x in proposals:
        x["approved"] = True                     # 晨报一键确认
    night.apply(proposals)
    assert any("西峰山水库" in e.key
               for e in p.query(keyword="西峰山水库"))
