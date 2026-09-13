"""多账号免费池 TDD（2026-09-13 用户指令：第二智谱账号免费模型纳入免费池）。

契约：
- config.resolve_api_keys：槽位 n 优先级 env PAI_LLM_KEY[_n] > [llm].api_key[_n]
  > llm.secret.ini api_key[_n]；去重保序；全空报错（与单 key 同文案语义）。
- ZhipuClient 接受 str | list[str]；1113 摘链按账号隔离（A 耗尽不连坐 B）；
  A 全链耗尽 → 自动切 B 重试整条免费链；fast/deep/vision 同样跨账号。
- 密钥卫生：任何异常/日志不得泄漏 key 本身。
"""
import json

import pytest

from paistation import config as cfg
from paistation.llm import zhipu_client as zc

K1, K2 = "a" * 32, "b" * 32


@pytest.fixture(autouse=True)
def _reset_account_state():
    zc._ACCOUNT_STATE.clear()
    yield
    zc._ACCOUNT_STATE.clear()


# ---------- 测试脚手架（沿用 test_zhipu_client 的打桩惯例） ----------

def _ini(tmp_path, **llm_over) -> str:
    llm = {"fast_model": "glm-4-flash-250414", "deep_model": "glm-4.7-flash",
           "vision_model": "glm-4.6v-flash", "long_model": "glm-4.7-flash"}
    llm.update(llm_over)
    llm_text = "\n".join(f"{k} = {v}" for k, v in llm.items())
    text = "\n".join([
        f"[llm]\n{llm_text}",
        f"[sense]\nwatch_dirs = {tmp_path}",
        "[channels]\nwecom_enabled = 0\nwechat_mode = vision_readonly\nnotify_webhook =",
        "[privacy]\ndata_dir = \nexport_on_exit = 0",
        "[learn]\ndouble_loop_confirm = 1",
        "[wow]\nwow_first_run = 0", ""])
    p = tmp_path / "pai.ini"
    p.write_text(text, encoding="utf-8")
    return str(p)


def ok(content="hi"):
    body = {"choices": [{"message": {"content": content}, "finish_reason": "stop"}],
            "usage": {"prompt_tokens": 1, "completion_tokens": 1}}
    return (200, json.dumps(body))


def e1113():
    return (429, '{"error":{"code":"1113"}}')


def make_client(scripts, models=("glm-a", "glm-b"), keys=(K1, K2)):
    """scripts: key → 响应序列（缺 key 的调用即 StopIteration=用例写错）。"""
    calls = []
    seqs = {k: iter(list(v)) for k, v in scripts.items()}

    def fake_post(url, headers, payload, timeout=60):
        key = headers["Authorization"][len("Bearer "):]
        calls.append((key, payload))
        r = next(seqs[key])
        return r() if callable(r) else r

    inner = zc.ZhipuClient(list(keys), list(models),
                           vision_model="glm-v", _post=fake_post)
    return inner, calls


# ---------- resolve_api_keys 多槽位 ----------

def test_keys_two_slots_from_secret_ini(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    monkeypatch.delenv("PAI_LLM_KEY_2", raising=False)
    c = cfg.load(_ini(tmp_path))
    secret = tmp_path / "llm.secret.ini"
    secret.write_text(f"[llm]\napi_key = {K1}\napi_key_2 = {K2}\n", encoding="utf-8")
    assert cfg.resolve_api_keys(c, secret_ini=str(secret)) == [K1, K2]


def test_keys_env_slot2_wins_over_secret(tmp_path, monkeypatch):
    monkeypatch.setenv("PAI_LLM_KEY", K1)
    monkeypatch.setenv("PAI_LLM_KEY_2", "env" * 10)
    c = cfg.load(_ini(tmp_path))
    secret = tmp_path / "llm.secret.ini"
    secret.write_text(f"[llm]\napi_key = {K1}\napi_key_2 = {K2}\n", encoding="utf-8")
    assert cfg.resolve_api_keys(c, secret_ini=str(secret)) == [K1, "env" * 10]


def test_keys_dedup_same_key_two_slots(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    monkeypatch.delenv("PAI_LLM_KEY_2", raising=False)
    c = cfg.load(_ini(tmp_path))
    secret = tmp_path / "llm.secret.ini"
    secret.write_text(f"[llm]\napi_key = {K1}\napi_key_2 = {K1}\n", encoding="utf-8")
    assert cfg.resolve_api_keys(c, secret_ini=str(secret)) == [K1]


def test_keys_single_slot_still_works(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    monkeypatch.delenv("PAI_LLM_KEY_2", raising=False)
    c = cfg.load(_ini(tmp_path))
    secret = tmp_path / "llm.secret.ini"
    secret.write_text(f"[llm]\napi_key = {K1}\n", encoding="utf-8")
    assert cfg.resolve_api_keys(c, secret_ini=str(secret)) == [K1]


def test_keys_missing_everywhere_raises(tmp_path, monkeypatch):
    monkeypatch.delenv("PAI_LLM_KEY", raising=False)
    monkeypatch.delenv("PAI_LLM_KEY_2", raising=False)
    c = cfg.load(_ini(tmp_path))
    with pytest.raises(cfg.ConfigError, match="PAI_LLM_KEY"):
        cfg.resolve_api_keys(c, secret_ini=str(tmp_path / "none.secret.ini"))


def test_free_chain_default_appends_glm_45_flash(tmp_path):
    c = cfg.load(_ini(tmp_path))
    assert cfg.free_chain(c) == ["glm-4-flash-250414", "glm-4.7-flash",
                                 "glm-4.5-flash"]


def test_free_chain_dedup_when_extra_overlaps(tmp_path):
    c = cfg.load(_ini(tmp_path, extra_free_models="glm-4.7-flash"))
    assert cfg.free_chain(c) == ["glm-4-flash-250414", "glm-4.7-flash"]


# ---------- 客户端：key 列表与账号轮换 ----------

def test_client_accepts_str_or_list():
    assert zc.ZhipuClient(K1, ["glm-a"])._keys == [K1]
    assert zc.ZhipuClient([K1, K2], ["glm-a"])._keys == [K1, K2]
    assert zc.ZhipuClient([K1, K1], ["glm-a"])._keys == [K1]  # 去重保序
    with pytest.raises(ValueError, match="api_key"):
        zc.ZhipuClient([], ["glm-a"])


def test_chat_rotates_account_when_chain_1113():
    c, calls = make_client({K1: [e1113(), e1113()], K2: [ok("B账号接手")]})
    assert c.chat("sys", "user") == "B账号接手"
    assert [k for k, _ in calls] == [K1, K1, K2]
    # 摘链按账号隔离：K1 两模型死，K2 干净
    assert zc._dead_models(K1) == {"glm-a", "glm-b"}
    assert zc._dead_models(K2) == set()


def test_chat_skips_fully_dead_account_without_network():
    zc._acct(K1)["dead"].update({"glm-a", "glm-b"})  # 预置 A 全链死
    c, calls = make_client({K2: [ok("直接B")]})
    assert c.chat("sys", "user") == "直接B"
    assert [k for k, _ in calls] == [K2]  # A 一个请求都没发


def test_chat_all_accounts_dead_raises_balance_error():
    zc._acct(K1)["dead"].update({"glm-a", "glm-b"})
    zc._acct(K2)["dead"].update({"glm-a", "glm-b"})
    c, calls = make_client({})
    with pytest.raises(zc._GLMError, match="余额耗尽"):
        c.chat("sys", "user")
    assert calls == []


def test_chat_error_never_leaks_key_material():
    c, _ = make_client({K1: [(500, "err"), (500, "err")],
                        K2: [(500, "err"), (500, "err")]})
    with pytest.raises(zc._GLMError) as ei:
        c.chat("sys", "user")
    assert K1 not in str(ei.value) and K2 not in str(ei.value)


def test_alert_fires_once_per_account():
    alerts = []
    calls_holder = {}

    def fake_post(url, headers, payload, timeout=60):
        key = headers["Authorization"][7:]
        calls_holder.setdefault("n", 0)
        calls_holder["n"] += 1
        return e1113() if key == K1 else ok("B")

    inner = zc.ZhipuClient([K1, K2], ["glm-a", "glm-b"], vision_model="glm-v",
                           alert=lambda t, m: alerts.append(t), _post=fake_post)
    inner.chat("sys", "user")
    assert len(alerts) == 1  # K1 首个 1113 告警一次；K2 成功不告警


def test_fast_rotates_keys():
    c, calls = make_client({K1: [e1113()], K2: [ok("快")]})
    assert c.fast("q")["text"] == "快"
    assert [k for k, _ in calls] == [K1, K2]


def test_deep_rotates_keys():
    c, calls = make_client({K1: [(429, "r"), (429, "r")], K2: [ok("深")]})
    r = c.deep("难题")
    assert r["text"] == "深"
    assert [k for k, _ in calls] == [K1, K1, K2]
    assert r["chain"] == ["glm-a", "glm-b", "glm-a"]  # 全轨迹：K1 两棒 → K2 首棒


def test_vision_rotates_keys():
    # K1 视觉链三棒全 1113 → 摘链耗尽 → 切 K2
    c, calls = make_client({K1: [e1113(), e1113(), e1113()],
                            K2: [ok('{"主色": "红"}')]})
    r = c.vision(b"\x89PNG fake", schema={"主色": "str"})
    assert r["json"]["主色"] == "红"
    assert [k for k, _ in calls] == [K1, K1, K1, K2]


def test_vision_fallback_includes_free_thinking_flash():
    assert "glm-4.1v-thinking-flash" in zc._VISION_FALLBACKS


# ---------- 生产装配：三构造点走多账号 ----------

def test_runtime_from_config_builds_multi_key_client(tmp_path, monkeypatch):
    from paistation.runtime import Runtime
    monkeypatch.setenv("PAI_LLM_KEY", K1)
    monkeypatch.setenv("PAI_LLM_KEY_2", K2)
    c = cfg.load(_ini(tmp_path))
    rt = Runtime.from_config(c)
    assert rt._client is not None and rt._client._keys == [K1, K2]
    rt.close()
