"""M3.1 任务卡抽取：规则引擎默认+LLM 升级位+证据指针+去重。"""
from datetime import datetime

from paistation.proactive.taskcards import TaskCardStore, extract_task_cards, parse_deadline


def _ev(text, ts="2026-09-13T10:00:00", ev_type="voice.transcript"):
    return {"ts": ts, "type": ev_type, "source": "mic", "text": text,
            "speaker": "unknown",
            "evidence": {"segment_ms": [0, 100], "audio_hash": "abc123"},
            "meta": {"events": []}}


# ---- 截止时间解析 ----

def test_parse_deadline_relative_days():
    now = datetime(2026, 9, 13, 15, 0)      # 周日
    assert parse_deadline("明天上午要结果", now).day == 14
    assert parse_deadline("后天交", now).day == 15
    assert parse_deadline("今晚八点前", now).hour == 20
    assert parse_deadline("明天上午要结果", now).hour == 9


def test_parse_deadline_weekday_and_date():
    now = datetime(2026, 9, 13, 15, 0)      # 周日
    assert parse_deadline("下周三给结论", now).weekday() == 2
    assert parse_deadline("9月15号前提交", now).day == 15
    assert parse_deadline("25号之前发我", now).day == 25
    assert parse_deadline("没有期限就算了", now) is None


# ---- 任务卡抽取 ----

def test_extract_research_request_with_deadline():
    cards = extract_task_cards([_ev("你好，请帮我调研一下腾讯办公助手的定价策略，"
                                    "明天上午要结果。")],
                               now=datetime(2026, 9, 13, 10, 0))
    assert len(cards) == 1
    card = cards[0]
    assert "定价策略" in card.title or "调研" in card.title
    assert card.deadline is not None and card.deadline.day == 14
    assert card.owner == "user"
    assert card.evidence["ts"] == "2026-09-13T10:00:00"
    assert card.confidence >= 0.6
    assert card.status == "proposed"


def test_extract_delegation_to_other_person():
    cards = extract_task_cards([_ev("让小王把会议纪要整理好发给大家。")])
    assert len(cards) == 1
    assert cards[0].owner == "小王"


def test_extract_ignores_chatter():
    events = [_ev("今天天气真不错啊。"),
              _ev("哈哈哈哈这个好笑。"),
              _ev("中午吃什么？")]
    assert extract_task_cards(events) == []


def test_extract_dedup_repeated_request():
    events = [_ev("请帮我调研一下腾讯办公助手的定价策略。", ts="2026-09-13T10:00:00"),
              _ev("对了，刚才说的腾讯办公助手定价策略调研别忘了。",
                  ts="2026-09-13T10:05:00")]
    cards = extract_task_cards(events)
    assert len(cards) == 1
    assert cards[0].mentions == 2           # 重提=置信度证据


def test_extract_multiple_distinct_tasks():
    events = [
        _ev("请帮我调研一下腾讯办公助手的定价策略，明天上午要结果。"),
        _ev("本月25号前提交季度总结。"),
        _ev("把那份EPC合同的扫描件归档一下。"),
    ]
    cards = extract_task_cards(events)
    assert len(cards) == 3
    titles = " ".join(c.title for c in cards)
    assert "定价" in titles and "季度总结" in titles and "归档" in titles


# ---- 任务卡存储 ----

def test_store_roundtrip_and_status(tmp_path):
    store = TaskCardStore(tmp_path)
    card = extract_task_cards([_ev("请帮我调研定价策略。")])[0]
    store.add(card)
    store.confirm(card.card_id)
    reopened = TaskCardStore(tmp_path)
    loaded = reopened.get(card.card_id)
    assert loaded.status == "confirmed"
    assert "定价" in loaded.title
    assert reopened.proposed() == []


# ---- Jev 判断层接线（09-19 深度融合：veto 清误报 + recruit 补召回）----

def _mk_events(*texts):
    return [{"ts": "2026-09-13T09:10:00", "type": "voice.transcript",
             "source": "mic", "text": t, "speaker": "unknown",
             "evidence": {"segment_ms": [0, 100], "audio_hash": "h"},
             "meta": {}} for t in texts]


class TestJevJudge:
    def test_judge_none_keeps_original_behavior(self):
        events = _mk_events("小王，会议纪要今天下班前整理好发给大家。",
                            "中午想吃火锅，谁一起？")
        assert len(extract_task_cards(events)) == 1   # 原规则行为

    def test_veto_clears_marker_chatter_false_positive(self):
        judge = lambda t: 0.02   # noqa: E731 - Jev 判非任务
        events = _mk_events("我记得去年团建也是在这家店吃的火锅。")
        assert extract_task_cards(events, judge=judge) == []

    def test_veto_keeps_marker_todo(self):
        judge = lambda t: 0.95   # noqa: E731
        events = _mk_events("小王，会议纪要今天下班前整理好发给大家。")
        cards = extract_task_cards(events, judge=judge)
        assert len(cards) == 1 and "纪要" in cards[0].title

    def test_recruit_builds_card_without_markers(self):
        judge = lambda t: 0.90   # noqa: E731
        events = _mk_events("李工，下周三的评审材料您那边出一下。")
        cards = extract_task_cards(events, judge=judge)
        assert len(cards) == 1
        assert cards[0].confidence == 0.45            # 低于即时打扰阈值→晨报
        assert cards[0].deadline is not None          # 截止解析照常
        assert cards[0].evidence["jev_noul"] == 0.90

    def test_recruit_below_threshold_skips(self):
        judge = lambda t: 0.30   # noqa: E731
        events = _mk_events("那家店的奶茶要排队四十分钟，太夸张了。")
        assert extract_task_cards(events, judge=judge) == []

    def test_judge_exception_degrades_silently(self):
        def boom(_):
            raise RuntimeError("jev down")
        events = _mk_events("小王，会议纪要今天下班前整理好发给大家。",
                            "李工，评审材料您那边出一下。")
        cards = extract_task_cards(events, judge=boom)
        assert len(cards) == 1 and "纪要" in cards[0].title  # 退回纯规则

    def test_judge_none_return_treated_as_absent(self):
        judge = lambda t: None   # noqa: E731 - 判断层不可用
        events = _mk_events("李工，评审材料您那边出一下。")
        assert extract_task_cards(events, judge=judge) == []
