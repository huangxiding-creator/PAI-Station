"""M4.2 交付：成果落 08 成果/+回执 jsonl+通知容错。"""
import json

from paistation.execute.deliver import Deliverer, RecordingNotifier
from paistation.proactive.taskcards import extract_task_cards


def _card():
    return extract_task_cards([{"ts": "2026-09-13T10:00:00",
                                "type": "voice.transcript", "source": "mic",
                                "text": "请帮我调研一下腾讯办公助手的定价策略。",
                                "speaker": "user", "evidence": {},
                                "meta": {}}])[0]


def test_deliver_writes_dated_artifact_and_receipt(tmp_path):
    notifier = RecordingNotifier()
    d = Deliverer(root=tmp_path, notifier=notifier)
    path = d.deliver(_card(), "# 调研报告\n\n腾讯会议企业版每账号每年 680 元。")
    assert path.exists() and path.parent.name == "08 成果"
    assert path.name.startswith("2026-") or path.parent.name == "08 成果"
    body = path.read_text(encoding="utf-8")
    assert "680" in body and "定价" in body          # 成果正文完整
    receipts = [json.loads(line) for line in
                (tmp_path / "deliveries" / "receipts.jsonl")
                .read_text(encoding="utf-8").splitlines() if line.strip()]
    assert len(receipts) == 1
    assert receipts[0]["artifact"].endswith(path.name)
    assert notifier.sent and "交付" in notifier.sent[0]["title"]


def test_deliver_sanitizes_filename(tmp_path):
    d = Deliverer(root=tmp_path)
    path = d.deliver(_card(), "内容")
    bad = set('<>:"/\\|?*')
    assert not (set(path.name) & bad)


def test_deliver_notifier_failure_never_raises(tmp_path):
    class Boom:
        def notify(self, title, body):
            raise RuntimeError("企微不可达")

    d = Deliverer(root=tmp_path, notifier=Boom())
    assert d.deliver(_card(), "内容").exists()
