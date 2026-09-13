"""M3.4 金标：会议语音样本→抽取→晨报含正确待办（三件齐、闲聊零误报）。"""
from paistation.proactive.confirm import ConfirmCenter, RecordingNotifier
from paistation.proactive.taskcards import extract_task_cards

MEETING = [
    ("09:02:00", "好，咱们开始周会吧，先过一下上周的进度。", "chatter"),
    ("09:03:00", "上周西峰山水库的初步设计方案评审通过了，大家辛苦。", "chatter"),
    ("09:05:00", "小王，会议纪要今天下班前整理好发给大家。", "todo:纪要"),
    ("09:08:00", "这个周末天气预报不错，可以去钓钓鱼。", "chatter"),
    ("09:10:00", "对了，请帮我调研一下腾讯办公助手的定价策略，明天上午要结果。",
     "todo:调研"),
    ("09:12:00", "现在人工成本涨得厉害，预算得再压一压。", "chatter"),
    ("09:15:00", "季度总结别忘了，本月25号之前提交。", "todo:总结"),
    ("09:18:00", "中午想吃火锅，谁一起？", "chatter"),
    ("09:20:00", "那就这样，散会。", "chatter"),
]


def _events():
    return [{"ts": f"2026-09-13T{t}", "type": "voice.transcript",
             "source": "mic", "text": text, "speaker": "unknown",
             "evidence": {"segment_ms": [0, 100], "audio_hash": "h" + t},
             "meta": {"events": []}}
            for t, text, _ in MEETING]


def test_meeting_extraction_precision():
    cards = extract_task_cards(_events())
    titles = " ".join(c.title for c in cards)
    assert len(cards) == 3                    # 三件待办，零闲聊误报
    assert "纪要" in titles and "定价" in titles and "季度总结" in titles
    for card in cards:
        chatter_words = ("火锅", "钓鱼", "天气", "散会", "预算")
        assert not any(w in card.title for w in chatter_words)


def test_meeting_deadlines_and_owners():
    cards = {c.title: c for c in extract_task_cards(_events())}
    research = next(c for c in cards.values() if "定价" in c.title)
    minutes = next(c for c in cards.values() if "纪要" in c.title)
    summary = next(c for c in cards.values() if "总结" in c.title)
    assert research.deadline is not None and research.deadline.day == 14
    assert minutes.owner == "小王"
    assert summary.deadline is not None and summary.deadline.day == 25


def test_morning_digest_contains_all_three():
    center = ConfirmCenter(notifier=RecordingNotifier())
    for card in extract_task_cards(_events()):
        center.route(card)
    digest = center.morning_digest()
    for word in ("纪要", "定价", "季度总结"):
        assert word in digest, f"晨报缺待办: {word}"
