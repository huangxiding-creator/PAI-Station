"""R3 主动引擎：triggers(JTBD 事件触发) + quadrant(Eisenhower) + timing(Fogg B=MAP)。"""
from paistation.proactive.quadrant import classify
from paistation.proactive.timing import FoggScorer, should_interrupt
from paistation.proactive.triggers import TriggerEngine


# ---- triggers：事件 → JTBD 候选 ----

def test_file_trigger_produces_job_with_evidence():
    eng = TriggerEngine()
    jobs = eng.on_file({"path": "C:/docs/周报v2.docx", "op": "modified"})
    assert jobs and jobs[0]["job"].startswith("跟进")
    assert jobs[0]["source"] == "file"
    assert "周报v2.docx" in jobs[0]["evidence"]


def test_file_trigger_ignores_noise():
    eng = TriggerEngine(ignore_patterns=("desktop.ini",))
    assert eng.on_file({"path": "C:/Users/x/Desktop/desktop.ini", "op": "modified"}) == []


def test_periodic_trigger_daily_digest():
    eng = TriggerEngine()
    jobs = eng.on_periodic(kind="daily", hour=9)
    assert any(j["job"].startswith("回顾") for j in jobs)


def test_im_trigger_mentions_task():
    eng = TriggerEngine()
    jobs = eng.on_im({"channel": "wecom", "text": "客户问投标文件几点能好"})
    assert jobs and jobs[0]["source"] == "im"
    assert "投标" in jobs[0]["evidence"]


def test_calendar_trigger_interface():
    eng = TriggerEngine()
    jobs = eng.on_calendar({"event": "项目评审会", "in_minutes": 30})
    assert jobs and jobs[0]["urgency_hint"] >= 0.8  # 30 分钟内高紧急


# ---- quadrant：Eisenhower ----

def test_q1_important_urgent():
    q = classify({"importance": 0.9, "urgency": 0.9})
    assert q["quadrant"] == 1 and q["action"] == "立即做"


def test_q2_important_not_urgent():
    q = classify({"importance": 0.8, "urgency": 0.2})
    assert q["quadrant"] == 2 and q["action"] == "排期做"


def test_q3_urgent_not_important():
    q = classify({"importance": 0.2, "urgency": 0.9})
    assert q["quadrant"] == 3 and q["action"] == "批量处理"


def test_q4_neither():
    q = classify({"importance": 0.1, "urgency": 0.1})
    assert q["quadrant"] == 4 and q["action"] == "丢弃"


def test_boundary_uses_strict_thresholds():
    """0.5 边界：重要=≥0.6，紧急=≥0.6（避免边界抖动）。"""
    assert classify({"importance": 0.6, "urgency": 0.3})["quadrant"] == 2
    assert classify({"importance": 0.5, "urgency": 0.6})["quadrant"] == 3


# ---- timing：Fogg B=MAP ----

def test_deepwork_blocks_interruption():
    """深工作状态：除 Q1 外一律不打扰（能力 A≈0 → B≈0）。"""
    d = should_interrupt({"importance": 0.7, "urgency": 0.5},
                         attention="deepwork")
    assert d["interrupt"] is False and "深工作" in d["reason"]


def test_deepwork_q1_still_interrupts():
    d = should_interrupt({"importance": 0.95, "urgency": 0.95},
                         attention="deepwork")
    assert d["interrupt"] is True


def test_focus_state_interrupts_for_important_urgent():
    """Q1（重要+紧急）在 focus 态 B=MAP 达标 → 打扰。"""
    d = should_interrupt({"importance": 0.9, "urgency": 0.9}, attention="focus")
    assert d["interrupt"] is True and 0 <= d["score"] <= 1


def test_focus_state_defers_important_not_urgent():
    """Q2（重要不紧急）不达成打扰——走排期/抽屉，符合 Eisenhower。"""
    d = should_interrupt({"importance": 0.8, "urgency": 0.4}, attention="focus")
    assert d["interrupt"] is False


def test_low_value_never_interrupts():
    d = should_interrupt({"importance": 0.2, "urgency": 0.2}, attention="focus")
    assert d["interrupt"] is False


def test_fogg_score_components():
    s = FoggScorer()
    score = s.score(motivation=0.8, ability=0.6, prompt=0.9)
    assert 0 <= score <= 1
    # 三元都高 > 只有一元高
    assert s.score(0.9, 0.9, 0.9) > s.score(0.9, 0.1, 0.1)


def test_idle_state_allows_more():
    d_idle = should_interrupt({"importance": 0.55, "urgency": 0.3},
                              attention="idle")
    d_focus = should_interrupt({"importance": 0.55, "urgency": 0.3},
                               attention="focus")
    assert d_idle["score"] >= d_focus["score"]
