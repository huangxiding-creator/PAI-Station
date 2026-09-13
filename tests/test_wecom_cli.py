"""企微自建 CLI（tools/wecom_cli.py）：封装 channels/wecom.py 通道。

官方/社区均无企微 CLI（2026-09-13 探测），按用户指令自建。
webhook 是 secret：绝不硬编码，三来源 --webhook > $WECOM_WEBHOOK > ~/.wecom_webhook。
"""
import json

from tools.wecom_cli import main


class FakeOpener:
    def __init__(self, responses=None):
        self.requests = []
        self._responses = responses or [{"errcode": 0, "errmsg": "ok"}]

    def open(self, req, timeout=None):
        self.requests.append(json.loads(req.data.decode("utf-8")))
        body = self._responses.pop(0)

        class R:
            def read(self):
                return json.dumps(body).encode("utf-8")

            def __enter__(self):
                return self

            def __exit__(self, *exc):
                return False
        return R()


WEBHOOK = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=test-key"


def test_send_with_args(tmp_path, capsys, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    op = FakeOpener()
    rc = main(["send", "--webhook", WEBHOOK, "--title", "构建完成",
               "--body", "全部通过"], opener=op)
    assert rc == 0
    assert op.requests[0]["markdown"]["content"].startswith("**构建完成**")
    out = capsys.readouterr().out
    assert "已发送" in out


def test_send_stdin_body(tmp_path, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    monkeypatch.setattr("sys.stdin", _FakeStdin("来自管道的正文"))
    op = FakeOpener()
    rc = main(["send", "--webhook", WEBHOOK, "--title", "报告"],
              opener=op)
    assert rc == 0
    assert "来自管道的正文" in op.requests[0]["markdown"]["content"]


def test_webhook_from_env(tmp_path, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    monkeypatch.setenv("WECOM_WEBHOOK", WEBHOOK)
    op = FakeOpener()
    assert main(["send", "--title", "t", "--body", "b"], opener=op) == 0
    assert len(op.requests) == 1


def test_webhook_from_home_file(tmp_path, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    (home / ".wecom_webhook").write_text(WEBHOOK + "\n", encoding="utf-8")
    monkeypatch.setenv("USERPROFILE", str(home))
    monkeypatch.delenv("WECOM_WEBHOOK", raising=False)
    op = FakeOpener()
    assert main(["send", "--title", "t", "--body", "b"], opener=op) == 0


def test_missing_webhook_exits_2(tmp_path, capsys, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    monkeypatch.delenv("WECOM_WEBHOOK", raising=False)
    rc = main(["send", "--title", "t", "--body", "b"], opener=FakeOpener())
    assert rc == 2
    assert "--webhook" in capsys.readouterr().err


def test_api_failure_exits_1(tmp_path, capsys, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    op = FakeOpener(responses=[{"errcode": 93000, "errmsg": "invalid"}])
    rc = main(["send", "--webhook", WEBHOOK, "--title", "t", "--body", "b"],
              opener=op)
    assert rc == 1
    assert "93000" in capsys.readouterr().err


def test_test_command_sends_preset(tmp_path, monkeypatch):
    home = tmp_path / "home"
    home.mkdir()
    monkeypatch.setenv("USERPROFILE", str(home))
    monkeypatch.setenv("WECOM_WEBHOOK", WEBHOOK)
    op = FakeOpener()
    assert main(["test"], opener=op) == 0
    assert "测试消息" in op.requests[0]["markdown"]["content"]


class _FakeStdin:
    def __init__(self, text):
        self._text = text

    def read(self):
        return self._text


def test_importable_from_repo_root():
    import subprocess
    import sys
    r = subprocess.run([sys.executable, "-X", "utf8", "tools/wecom_cli.py",
                        "--help"], capture_output=True, text=True,
                       encoding="utf-8", errors="replace")
    assert r.returncode == 0
    assert "send" in r.stdout
