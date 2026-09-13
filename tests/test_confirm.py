"""M3.3 确认交互：三模式（notify/question/review）+toast 容错+晨报一键。"""
from paistation.proactive.confirm import ConfirmCenter, RecordingNotifier


def _card(text, ts="2026-09-13T10:00:00"):
    from paistation.proactive.taskcards import extract_task_cards
    return extract_task_cards([{"ts": ts, "type": "voice.transcript",
                                "source": "mic", "text": text,
                                "speaker": "unknown",
                                "evidence": {}, "meta": {}}])[0]


def test_notify_mode_sends_toast_once():
    notifier = RecordingNotifier()
    center = ConfirmCenter(notifier=notifier, daily_immediate_cap=3)
    card = _card("请帮我调研定价策略，今天下午四点前要。")
    mode = center.route(card)
    assert mode == "notify"
    assert len(notifier.sent) == 1
    assert "定价" in notifier.sent[0]["title"]
    center.route(card)                       # 同卡不重复打扰
    assert len(notifier.sent) == 1


def test_review_mode_defers_to_digest():
    notifier = RecordingNotifier()
    center = ConfirmCenter(notifier=notifier)
    card = _card("有空的时候把桌面文件归档一下。")
    mode = center.route(card)
    assert mode == "review"
    assert notifier.sent == []               # 低急迫零打扰


def test_digest_one_click_confirm(tmp_path):
    notifier = RecordingNotifier()
    center = ConfirmCenter(notifier=notifier, store_dir=tmp_path)
    c1 = _card("请帮我调研定价策略，明天上午要结果。")
    c2 = _card("25号前提交季度总结。")
    center.route(c1)
    center.route(c2)
    digest = center.morning_digest()
    assert "定价" in digest and "季度总结" in digest
    center.confirm_by_appearance([c1.card_id])   # 一键确认：只做调研
    assert center.get(c1.card_id).status == "confirmed"
    assert center.get(c2.card_id).status == "proposed"


def test_dismiss_card(tmp_path):
    center = ConfirmCenter(store_dir=tmp_path)
    card = _card("把那份合同扫描件归档。")
    center.route(card)
    center.dismiss(card.card_id)
    assert center.get(card.card_id).status == "dismissed"
    assert center.morning_digest() == ""     # 已拒不再进晨报


def test_broken_toaster_never_raises():
    class Boom:
        def notify(self, title, body):
            raise RuntimeError("toast 系统缺席")

    center = ConfirmCenter(notifier=Boom(), daily_immediate_cap=3)
    card = _card("请帮我调研定价策略，今天下午四点前要。")
    assert center.route(card) == "notify"    # 通知失败不阻塞路由决策
