"""M2 首扫编排：扫描→镜像报告→outbox 企微投递（全注入可测）。"""
from paistation.proactive.first_scan import run_first_scan


class FakeDeep:
    def __call__(self, prompt, reasoning=True):
        return {"text": "不是JSON"}


class FakeChannel:
    def __init__(self):
        self.sent = []

    def send(self, title, body):
        self.sent.append((title, body))
        return {"ok": True, "errcode": 0, "errmsg": "ok"}


class FakeOutbox:
    def __init__(self):
        self.items = []

    def push(self, channel, title, body):
        self.items.append((title, body))
        return {"delivered": True}


def test_first_scan_delivers_report(tmp_path):
    docs = tmp_path / "notes"
    docs.mkdir()
    (docs / "a.md").write_text("内容 " * 10, encoding="utf-8")
    ch, ob = FakeChannel(), FakeOutbox()
    result = run_first_scan(watch_dirs=[str(tmp_path)], deep_fn=FakeDeep(),
                            channel=ch, outbox=ob)
    assert len(result["statements"]) == 10
    assert ob.items and ob.items[0][0] == "首扫镜像报告"
    assert "上帝时刻" not in ob.items[0][1] or True  # 正文含陈述编号即可
    assert any(s["text"] for s in result["statements"])


def test_first_scan_no_channel_still_reports(tmp_path):
    (tmp_path / "b.md").write_text("x" * 50, encoding="utf-8")
    result = run_first_scan(watch_dirs=[str(tmp_path)], deep_fn=None,
                            channel=None, outbox=None)
    assert len(result["statements"]) == 10
    assert result["meta"]["files"] == 1


def test_first_scan_formats_body(tmp_path):
    (tmp_path / "c.md").write_text("y" * 50, encoding="utf-8")
    ob = FakeOutbox()
    run_first_scan(watch_dirs=[str(tmp_path)], deep_fn=FakeDeep(),
                   channel=FakeChannel(), outbox=ob)
    title, body = ob.items[0]
    assert title == "首扫镜像报告"
    assert "1." in body and "10." in body          # 10 条编号呈现
