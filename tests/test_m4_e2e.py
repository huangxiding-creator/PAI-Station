"""M4.3 端到端：语音→任务卡→确认→执行→交付（假网关，全链不断链）。"""
import json

from paistation.execute.agent import AgentRunner
from paistation.execute.service import ExecutionService
from paistation.proactive.confirm import ConfirmCenter, RecordingNotifier
from paistation.proactive.taskcards import extract_task_cards


class FakeGateway:
    def __init__(self, text):
        self._text = text

    def chat(self, messages, **kw):
        return self._text, "fake"


VOICE_EVENT = {"ts": "2026-09-13T09:10:00", "type": "voice.transcript",
               "source": "mic",
               "text": "请帮我调研一下腾讯办公助手的定价策略，明天上午要结果。",
               "speaker": "user",
               "evidence": {"segment_ms": [0, 3200], "audio_hash": "ab12cd"},
               "meta": {"events": ["intent.research"]}}


def test_voice_to_delivery_e2e(tmp_path):
    # 1) 感知→任务卡
    cards = extract_task_cards([VOICE_EVENT])
    assert len(cards) == 1
    card = cards[0]
    assert "定价" in card.title and card.deadline is not None

    # 2) 确认（review 进晨报→用户一键确认）
    center = ConfirmCenter(notifier=RecordingNotifier(), store_dir=tmp_path)
    mode = center.route(card)
    assert mode in ("notify", "review")
    center.confirm_by_appearance([card.card_id])

    # 3) 执行+交付
    report = ("# 腾讯办公助手定价调研\n\n"
              "腾讯会议企业版 680 元/账号/年，商业版 380 元/账号/年。\n"
              "结论：谈判空间在 500 账号以上框架折扣。")
    runner = AgentRunner(gateway=FakeGateway(report), runs_dir=tmp_path / "runs")
    svc = ExecutionService(store=center._store, runner=runner,
                           deliverer_root=tmp_path / "data")
    svc.tick(paused=False)

    loaded = center.get(card.card_id)
    assert loaded.status == "done"
    artifacts = list((tmp_path / "data" / "08 成果").glob("*.md"))
    assert len(artifacts) == 1
    assert "680" in artifacts[0].read_text(encoding="utf-8")
    receipts = [json.loads(l) for l in
                (tmp_path / "data" / "deliveries" / "receipts.jsonl")
                .read_text(encoding="utf-8").splitlines() if l.strip()]
    assert receipts[0]["card_id"] == card.card_id

    # 4) 晨报清空：已完成的不再出现
    assert center.morning_digest() == ""


def test_execution_paused_blocks(tmp_path):
    center = ConfirmCenter(notifier=RecordingNotifier(), store_dir=tmp_path)
    card = extract_task_cards([VOICE_EVENT])[0]
    center.route(card)
    center.confirm_by_appearance([card.card_id])
    runner = AgentRunner(gateway=FakeGateway("报告"), runs_dir=tmp_path / "runs")
    svc = ExecutionService(store=center._store, runner=runner,
                           deliverer_root=tmp_path / "data")
    svc.tick(paused=True)                    # 一键全局暂停：不执行
    assert center.get(card.card_id).status == "confirmed"
    assert not (tmp_path / "data" / "08 成果").exists()


def test_execution_failure_leaves_card_confirmed_for_retry(tmp_path):
    class BoomGateway:
        def chat(self, messages, **kw):
            raise RuntimeError("网关全断")

    center = ConfirmCenter(notifier=RecordingNotifier(), store_dir=tmp_path)
    card = extract_task_cards([VOICE_EVENT])[0]
    center.route(card)
    center.confirm_by_appearance([card.card_id])
    runner = AgentRunner(gateway=BoomGateway(), runs_dir=tmp_path / "runs")
    svc = ExecutionService(store=center._store, runner=runner,
                           deliverer_root=tmp_path / "data")
    svc.tick(paused=False)                   # 执行失败不误标 done
    assert center.get(card.card_id).status == "confirmed"
    assert not (tmp_path / "data" / "08 成果").exists()
