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
