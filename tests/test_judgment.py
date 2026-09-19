"""judgment 判断层契约测试（零真网：fake transport + tmp config）。"""
import configparser
import json

import pytest

from paistation.judgment import JudgmentClient, make_task_judge, set_switch, switch_status
from paistation.judgment import client as client_mod

NOUL_OK = {"answers": {"noul": {"type": "noul", "noul": 0.9}},
           "usage": {"input_tokens": 10, "output_tokens": 2}}
CHOICE_OK = {"answers": {"choice": {"type": "choice", "choice": "project",
                                    "probabilities": {"project": 0.9},
                                    "confidence": 0.88}},
             "usage": {"input_tokens": 10, "output_tokens": 2}}


def _write_key(cfg, key="k-test"):
    cfg.joinpath("typesafe.secret.ini").write_text(
        f"[typesafe]\napi_key = {key}\n", encoding="utf-8")


class TestContract:
    def test_ask_parses_answers_and_request_shape(self, tmp_path):
        _write_key(tmp_path)
        seen = {}

        def transport(data: bytes) -> dict:
            seen["body"] = json.loads(data.decode("utf-8"))
            return NOUL_OK

        c = JudgmentClient(config_dir=tmp_path, transport=transport)
        assert c.enabled
        answers = c.ask({"text": "句子"}, {"q": {"type": "noul",
                                                 "instructions": "是吗"}})
        assert answers["noul"]["noul"] == 0.9
        body = seen["body"]
        assert body["model"] == client_mod.DEFAULT_MODEL
        assert body["state"] == {"text": "句子"}
        assert body["questions"]["q"]["type"] == "noul"

    def test_ask_noul_and_choice_shells(self, tmp_path):
        _write_key(tmp_path)
        resp = [NOUL_OK, CHOICE_OK]
        c = JudgmentClient(config_dir=tmp_path,
                           transport=lambda data: resp.pop(0))
        assert c.ask_noul("s", "是任务吗") == 0.9
        got = c.ask_choice("s", "哪类", {"project": "编码"})
        assert got == ("project", {"probabilities": {"project": 0.9},
                                   "confidence": 0.88})

    def test_bad_payload_returns_none(self, tmp_path):
        _write_key(tmp_path)
        c = JudgmentClient(config_dir=tmp_path,
                           transport=lambda data: {"answers": {}})
        assert c.ask_noul("s", "是吗") is None

    def test_choice_missing_confidence_returns_none(self, tmp_path):
        _write_key(tmp_path)
        bad = {"answers": {"choice": {"type": "choice", "choice": "x"}}}
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: bad)
        assert c.ask_choice("s", "i", {"x": None}) is None


class TestSwitch:
    def test_missing_key_disables(self, tmp_path):
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK)
        assert not c.enabled
        assert c.ask("s", {}) is None

    def test_ini_off_disables(self, tmp_path):
        _write_key(tmp_path)
        set_switch(False, config_dir=tmp_path)
        calls = []
        c = JudgmentClient(config_dir=tmp_path,
                           transport=lambda d: calls.append(1) or NOUL_OK)
        assert not c.enabled
        assert c.ask_noul("s", "i") is None
        assert calls == []

    def test_env_hard_off_beats_ini_on(self, tmp_path, monkeypatch):
        _write_key(tmp_path)
        monkeypatch.setenv("PAI_JEV", "0")
        st = switch_status(tmp_path)
        assert not st["enabled"] and st["env_off"]
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK)
        assert not c.enabled

    def test_set_switch_roundtrip(self, tmp_path):
        _write_key(tmp_path)
        set_switch(True, config_dir=tmp_path)
        assert switch_status(tmp_path)["enabled"]
        set_switch(False, config_dir=tmp_path)
        assert not switch_status(tmp_path)["enabled"]

    def test_switch_secret_file_not_required_for_status(self, tmp_path):
        st = switch_status(tmp_path)
        assert st == {"enabled": False, "env": None, "env_off": False,
                      "ini_enabled": None, "has_key": False}


class TestTrajectory:
    def _client(self, tmp_path, traj):
        _write_key(tmp_path)
        return JudgmentClient(config_dir=tmp_path,
                              transport=lambda d: NOUL_OK,
                              traj_path=traj)

    def test_records_six_fields_with_hash_not_plaintext(self, tmp_path):
        traj = tmp_path / "t" / "traj.jsonl"
        c = self._client(tmp_path, traj)
        assert c.ask_noul("机密状态文本", "是任务吗") == 0.9
        row = json.loads(traj.read_text(encoding="utf-8").splitlines()[0])
        assert row["ok"] is True and row["latency_s"] >= 0
        assert row["q"] == {"noul": "noul"}
        assert row["a"] == {"noul": {"noul": 0.9}}
        assert row["usage"] == {"input_tokens": 10, "output_tokens": 2}
        assert len(row["state_hash"]) == 16
        assert "机密状态文本" not in traj.read_text(encoding="utf-8")

    def test_failed_call_recorded_ok_false(self, tmp_path):
        traj = tmp_path / "traj.jsonl"

        def boom(data: bytes) -> dict:
            raise OSError("down")

        _write_key(tmp_path)
        import pytest
        with pytest.MonkeyPatch.context() as mp:
            mp.setattr(client_mod.time, "sleep", lambda s: None)
            c = JudgmentClient(config_dir=tmp_path, transport=boom,
                               traj_path=traj)
            assert c.ask_noul("s", "i") is None
        row = json.loads(traj.read_text(encoding="utf-8").splitlines()[0])
        assert row["ok"] is False and row["a"] is None

    def test_none_path_writes_nothing_and_bad_path_never_raises(
            self, tmp_path):
        c = self._client(tmp_path, None)
        assert c.ask_noul("s", "i") == 0.9
        assert not (tmp_path / "traj.jsonl").exists()
        # 不可写路径：审计失败绝不反噬主链
        bad = JudgmentClient(config_dir=tmp_path,
                             transport=lambda d: NOUL_OK,
                             traj_path=tmp_path / "x" / "." / "traj.jsonl")
        assert bad.ask_noul("s", "i") == 0.9


class TestBreaker:
    def _client(self, tmp_path, behavior):
        """behavior() -> dict，可抛异常；由测试在 ask 之间切换模式。"""
        _write_key(tmp_path)
        calls = []

        def transport(data: bytes) -> dict:
            calls.append(1)
            return behavior()

        return JudgmentClient(config_dir=tmp_path, transport=transport), calls

    @staticmethod
    def _fail():
        raise OSError("net down")

    def test_consecutive_failures_open_breaker(self, tmp_path, monkeypatch):
        monkeypatch.setattr(client_mod.time, "sleep", lambda s: None)
        c, calls = self._client(tmp_path, self._fail)
        assert c.ask_noul("s", "i") is None      # 3 发重试全败 → None + 计 1 败
        assert c.ask_noul("s", "i") is None      # 败 2
        assert c.ask_noul("s", "i") is None      # 败 3 → 熔断 open
        before = len(calls)
        assert c.ask_noul("s", "i") is None      # open：不再打 transport
        assert len(calls) == before
        assert c.breaker_open

    def test_half_open_probe_recovers(self, tmp_path, monkeypatch):
        fake_now = [1000.0]
        mode = {"fail": True}
        monkeypatch.setattr(client_mod.time, "sleep", lambda s: None)
        monkeypatch.setattr(client_mod.time, "monotonic",
                            lambda: fake_now[0])

        def behavior():
            if mode["fail"]:
                raise OSError("net down")
            return NOUL_OK

        c, _ = self._client(tmp_path, behavior)
        for _ in range(3):
            c.ask_noul("s", "i")
        assert c.breaker_open
        fake_now[0] += 301                    # 冷却过 → half-open
        mode["fail"] = False
        assert c.ask_noul("s", "i") == 0.9    # 试探成功 → closed
        assert not c.breaker_open
        assert c.ask_noul("s", "i") == 0.9    # 恢复正常服务

    def test_success_resets_failure_count(self, tmp_path, monkeypatch):
        monkeypatch.setattr(client_mod.time, "sleep", lambda s: None)
        mode = {"fail": False}

        def behavior():
            if mode["fail"]:
                raise OSError("flaky")
            return NOUL_OK

        c, _ = self._client(tmp_path, behavior)
        mode["fail"] = True
        assert c.ask_noul("s", "i") is None    # 败 1
        mode["fail"] = False
        assert c.ask_noul("s", "i") == 0.9     # 成功复位
        mode["fail"] = True
        assert c.ask_noul("s", "i") is None    # 败 1（不累计旧账）
        assert not c.breaker_open


class TestTaskJudgeAdapter:
    def test_disabled_returns_none(self, tmp_path):
        judge = make_task_judge(config_dir=tmp_path,
                                transport=lambda d: NOUL_OK)
        assert judge("帮我查一下") is None

    def test_enabled_returns_noul(self, tmp_path):
        _write_key(tmp_path)
        judge = make_task_judge(config_dir=tmp_path,
                                transport=lambda d: NOUL_OK)
        assert judge("小王，纪要今天下班前弄完。") == 0.9


@pytest.mark.parametrize("value,expect", [
    ("0", False), ("false", False), ("off", False), ("", False),
    ("1", True), (None, True)])
def test_env_off_values(tmp_path, monkeypatch, value, expect):
    _write_key(tmp_path)
    if value is None:
        monkeypatch.delenv("PAI_JEV", raising=False)
    else:
        monkeypatch.setenv("PAI_JEV", value)
    assert switch_status(tmp_path)["enabled"] is expect


def test_config_ini_roundtrip_read(tmp_path):
    _write_key(tmp_path)
    ini = tmp_path / "jev.ini"
    ini.write_text("[jev]\nenabled = 0\n", encoding="utf-8")
    cp = configparser.ConfigParser()
    cp.read(ini, encoding="utf-8")
    assert cp.get("jev", "enabled") == "0"


class TestCliSwitch:
    def test_on_off_status_cycle(self, tmp_path, monkeypatch, capsys):
        monkeypatch.delenv("PAI_JEV", raising=False)
        from paistation.main import main
        monkeypatch.setattr(client_mod, "_config_dir", lambda: tmp_path)
        monkeypatch.setattr("paistation.judgment.set_switch",
                            lambda on, config_dir=None: set_switch(
                                on, config_dir=tmp_path))
        monkeypatch.setattr("paistation.judgment.switch_status",
                            lambda config_dir=None: switch_status(tmp_path))
        assert main(["--jev", "on"]) == 0
        assert main(["--jev", "off"]) == 0
        assert switch_status(tmp_path)["enabled"] is False
        assert main(["--jev", "status"]) == 1     # 无 key → disabled → exit 1
        out = capsys.readouterr().out
        assert "enabled=False" in out and "api_key" in out
