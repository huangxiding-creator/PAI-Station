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
                      "ini_enabled": None, "has_key": False,
                      "engine": "typesafe"}


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


class TestEngine:
    """LayaForge 引擎位：laya（本机免费）与 typesafe（云端付费）可切。"""

    def test_default_engine_is_typesafe(self, tmp_path):
        _write_key(tmp_path)
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK)
        assert c.engine == "typesafe" and c.enabled

    def test_ini_laya_enables_without_key(self, tmp_path):
        # laya=本机免鉴权：无 typesafe.key 也必须可用
        (tmp_path / "jev.ini").write_text(
            "[jev]\nengine = laya\nenabled = 1\n", encoding="utf-8")
        c = JudgmentClient(config_dir=tmp_path)   # 不传 transport → 引擎自选
        assert c.engine == "laya" and c.enabled
        assert c._transport == c._laya_http
        assert c._timeout == client_mod.LAYA_TIMEOUT

    def test_env_engine_beats_ini(self, tmp_path, monkeypatch):
        monkeypatch.setenv("PAI_JEV_ENGINE", "laya")
        _write_key(tmp_path)
        assert client_mod.engine_status(tmp_path) == "laya"
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK)
        assert c.engine == "laya"

    def test_invalid_engine_values_fall_back(self, tmp_path):
        (tmp_path / "jev.ini").write_text(
            "[jev]\nengine = bogus\n", encoding="utf-8")
        assert client_mod.engine_status(tmp_path) == "typesafe"

    def test_set_switch_preserves_engine(self, tmp_path):
        set_switch(True, config_dir=tmp_path, engine="laya")
        set_switch(False, config_dir=tmp_path)          # 不带 engine 切开关
        assert client_mod.engine_status(tmp_path) == "laya"
        set_switch(True, config_dir=tmp_path)           # 再切回 on 仍保留
        assert client_mod.engine_status(tmp_path) == "laya"

    def test_laya_off_disables(self, tmp_path):
        set_switch(False, config_dir=tmp_path, engine="laya")
        calls = []
        c = JudgmentClient(config_dir=tmp_path,
                           transport=lambda d: calls.append(1) or NOUL_OK)
        assert c.engine == "laya" and not c.enabled
        assert c.ask_noul("s", "i") is None and calls == []

    def test_laya_transport_posts_without_auth_header(self, tmp_path):
        # 真打本机服务属于集成面（parity_gate 覆盖）；此处固化请求形态：
        # 同款 JSON body、无 Authorization、端点=LAYA_ENDPOINT
        captured = {}

        def fake_urlopen(req, timeout=None):
            captured["url"] = req.full_url
            captured["headers"] = dict(req.header_items())
            captured["timeout"] = timeout
            captured["body"] = req.data.decode("utf-8")

            class R:
                def __enter__(self):
                    return self

                def __exit__(self, *a):
                    return False

                def read(self):
                    return json.dumps(NOUL_OK).encode("utf-8")

            return R()

        set_switch(True, config_dir=tmp_path, engine="laya")
        c = JudgmentClient(config_dir=tmp_path)          # 用真 _laya_http
        orig = client_mod.urllib.request.urlopen
        client_mod.urllib.request.urlopen = fake_urlopen
        try:
            assert c.ask_noul("状态", "是任务吗") == 0.9
        finally:
            client_mod.urllib.request.urlopen = orig
        assert captured["url"] == client_mod.LAYA_ENDPOINT
        assert "Authorization" not in captured["headers"]
        assert json.loads(captured["body"])["state"] == "状态"
        assert captured["timeout"] == client_mod.LAYA_TIMEOUT


@pytest.mark.parametrize("value,expect", [    ("0", False), ("false", False), ("off", False), ("", False),
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


class TestPositionEngines:
    """P1 渐进位：[engines] 按位覆盖全局引擎（未命名位仍走全局）。"""

    def _ini(self, tmp_path, text):
        (tmp_path / "jev.ini").write_text(text, encoding="utf-8")

    def test_position_override_beats_global(self, tmp_path):
        self._ini(tmp_path, "[jev]\nengine = typesafe\nenabled = 1\n"
                  "[engines]\ntaskcards = laya\n")
        assert client_mod.engine_status(tmp_path) == "typesafe"
        assert client_mod.engine_status(tmp_path, "taskcards") == "laya"
        assert client_mod.engine_status(tmp_path, "unknown") == "typesafe"

    def test_env_beats_position_override(self, tmp_path, monkeypatch):
        monkeypatch.setenv("PAI_JEV_ENGINE", "typesafe")
        self._ini(tmp_path, "[jev]\nengine = typesafe\n"
                  "[engines]\ntaskcards = laya\n")
        assert client_mod.engine_status(tmp_path, "taskcards") == "typesafe"

    def test_positioned_client_uses_override_and_default_traj(self, tmp_path):
        _write_key(tmp_path)
        self._ini(tmp_path, "[jev]\nengine = typesafe\nenabled = 1\n"
                  "[engines]\ntaskcards = laya\n")
        calls = []

        def transport(data: bytes) -> dict:
            calls.append(json.loads(data.decode("utf-8")))
            return NOUL_OK

        c = JudgmentClient(config_dir=tmp_path, transport=transport,
                           position="taskcards")
        assert c.engine == "laya"
        assert c._traj_path == (tmp_path.parent / "data" / "traj"
                                / "jev-taskcards.jsonl")
        assert c.ask_noul("s", "i") == 0.9
        assert calls[0]["state"] == "s"

    def test_unpositioned_client_no_traj_default(self, tmp_path):
        _write_key(tmp_path)
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK)
        assert c._traj_path is None

    def test_set_switch_preserves_engines_and_shadow_sections(self, tmp_path):
        set_switch(True, config_dir=tmp_path, engine="typesafe",
                   engines={"taskcards": "laya", "golden": "laya"},
                   shadow={"engine": "laya", "sample": "1.0"})
        set_switch(False, config_dir=tmp_path)          # 老式开关调用
        cp = configparser.ConfigParser()
        cp.read(tmp_path / "jev.ini", encoding="utf-8")
        assert cp.get("jev", "enabled") == "0"
        assert cp.get("engines", "taskcards") == "laya"
        assert cp.get("shadow", "engine") == "laya"
        assert cp.get("shadow", "sample") == "1.0"


class TestShadowDualTrack:
    """双轨影子：主引擎答完后单发第二引擎，traj 记 agree/延迟。
    测试纪律：注入 shadow_transport 与主 transport 同一 fake，零真网。"""

    def _shadow_ini(self, tmp_path):
        (tmp_path / "jev.ini").write_text(
            "[jev]\nengine = typesafe\nenabled = 1\n"
            "[shadow]\nengine = laya\nsample = 1.0\n", encoding="utf-8")

    def test_agree_helper_semantics(self):
        p = {"noul": {"type": "noul", "noul": 0.9}}
        assert client_mod._answers_agree(p, {"noul": {"type": "noul",
                                                      "noul": 0.85}}) is True
        assert client_mod._answers_agree(p, {"noul": {"type": "noul",
                                                      "noul": 0.3}}) is False
        assert client_mod._answers_agree(None, p) is None
        pc = {"c": {"type": "choice", "choice": "a", "confidence": 0.8}}
        sc = {"c": {"type": "choice", "choice": "b", "confidence": 0.7}}
        assert client_mod._answers_agree(pc, sc) is False
        assert client_mod._answers_agree(pc, {"c": {"type": "choice",
                                                    "choice": "a"}}) is True

    def test_shadow_records_dual_row_and_never_breaks_primary(self, tmp_path):
        traj = tmp_path / "traj.jsonl"
        _write_key(tmp_path)
        self._shadow_ini(tmp_path)
        queue = [{"answers": {"noul": {"type": "noul", "noul": 0.9}}},
                 {"answers": {"noul": {"type": "noul", "noul": 0.88}}}]

        def transport(data: bytes) -> dict:
            return queue.pop(0)

        c = JudgmentClient(config_dir=tmp_path, transport=transport,
                           shadow_transport=transport, traj_path=traj)
        assert c._shadow_engine == "laya"
        assert c.ask_noul("状态", "是吗") == 0.9          # 主答不受影子影响
        row = json.loads(traj.read_text(encoding="utf-8").splitlines()[0])
        assert row["ok"] is True and row["engine"] == "typesafe"
        assert row["dual"]["engine"] == "laya"
        assert row["dual"]["agree"] is True
        assert row["dual"]["latency_s"] >= 0

    def test_shadow_same_engine_disables(self, tmp_path):
        _write_key(tmp_path)
        (tmp_path / "jev.ini").write_text(
            "[jev]\nengine = laya\nenabled = 1\n"
            "[shadow]\nengine = laya\n", encoding="utf-8")
        c = JudgmentClient(config_dir=tmp_path, traj_path=tmp_path / "t.jsonl")
        assert c._shadow_engine == ""                    # 同引擎=无影子

    def test_shadow_off_without_traj(self, tmp_path):
        _write_key(tmp_path)
        self._shadow_ini(tmp_path)
        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK,
                           traj_path=None)
        assert c._shadow_engine == "laya"
        assert c._shadow_run("s", {}, None) is None      # 无 traj 不烧影子

    def test_shadow_three_failures_trip_local_off(self, tmp_path):
        traj = tmp_path / "traj.jsonl"
        _write_key(tmp_path)
        self._shadow_ini(tmp_path)

        def dead(data: bytes) -> dict:
            raise OSError("laya down")

        c = JudgmentClient(config_dir=tmp_path, transport=lambda d: NOUL_OK,
                           shadow_transport=dead, traj_path=traj)
        for _ in range(3):
            dual = c._shadow_run("s", {}, None)
            assert dual is not None and dual["error"] is True
        assert c._shadow_off is True
        assert c._shadow_run("s", {}, None) is None      # 停摆后零调用

    def test_shadow_primary_fail_still_records_dual(self, tmp_path,
                                                     monkeypatch):
        traj = tmp_path / "traj.jsonl"
        _write_key(tmp_path)
        self._shadow_ini(tmp_path)
        n = {"i": 0}

        def transport(data: bytes) -> dict:
            n["i"] += 1
            if n["i"] <= 3:                               # 主 3 发重试全败
                raise OSError("typesafe down")
            return NOUL_OK                                # 第 4 发=影子成功

        monkeypatch.setattr(client_mod.time, "sleep", lambda s: None)
        c = JudgmentClient(config_dir=tmp_path, transport=transport,
                           shadow_transport=transport, traj_path=traj)
        assert c.ask_noul("s", "i") is None
        row = json.loads(traj.read_text(encoding="utf-8").splitlines()[0])
        assert row["ok"] is False and row["a"] is None
        assert row["dual"]["engine"] == "laya"
        assert row["dual"]["agree"] is None               # 主缺席=不计分母
