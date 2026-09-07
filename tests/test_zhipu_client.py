"""M0.3 模型日 TDD：zhipu_client 移植自 We-AIPO（mock 打桩，不打真 API）。

覆盖实战修复语义：1113 摘链（FIX-0816e）/429 冷却（FIX-0816g）/
限流即切链不睡眠（FIX-0819i）/内容审核立即跳过/全链限流才睡一次。
"""
import json

import pytest

from paistation.llm import zhipu_client as zc


@pytest.fixture(autouse=True)
def _reset_chain_state():
    """摘链/冷却是模块级全局态——测试间必须隔离，否则 120s 真实冷却跨测试泄漏。"""
    zc._DEAD_MODELS.clear()
    zc._MODEL_COOLDOWN.clear()
    yield
    zc._DEAD_MODELS.clear()
    zc._MODEL_COOLDOWN.clear()


def ok(content="hi", usage=None, finish="stop"):
    body = {"choices": [{"message": {"content": content},
                         "finish_reason": finish}],
            "usage": usage or {"prompt_tokens": 1, "completion_tokens": 1}}
    return (200, json.dumps(body))


class Client:
    """便捷构造：注入 fake post，固定模型链。"""

    def __init__(self, responses):
        calls = []
        seq = iter(responses)

        def fake_post(url, headers, payload, timeout=60):
            calls.append(payload)
            r = next(seq)
            return r() if callable(r) else r

        self.calls = calls
        self.inner = zc.ZhipuClient("k" * 32, ["glm-a", "glm-b"],
                                    vision_model="glm-v", _post=fake_post)

    def __getattr__(self, name):
        return getattr(self.inner, name)


# ---------- 构造与限速器 ----------

def test_empty_key_rejected():
    with pytest.raises(ValueError, match="api_key"):
        zc.ZhipuClient("", ["glm-a"])


def test_pacer_backoff_and_recovery(monkeypatch):
    monkeypatch.setattr(zc.time, "sleep", lambda s: None)  # 打桩：不真睡
    p = zc._AdaptivePacer(start=5.0, cap=40.0)
    p.on_rate_limited()
    assert p.interval == 10.0
    p.on_rate_limited()
    assert p.interval == 20.0
    p.on_success()
    assert p.interval == 14.0  # 20 * 0.7，缓慢回落


def test_note_rate_limited_does_not_sleep(monkeypatch):
    slept = []
    monkeypatch.setattr(zc.time, "sleep", lambda s: slept.append(s))
    p = zc._AdaptivePacer()
    p.note_rate_limited()
    assert slept == []  # FIX-0819i：记账不睡眠


# ---------- extract_json ----------

def test_extract_json_plain():
    assert zc.extract_json('{"a": 1}') == {"a": 1}


def test_extract_json_fence():
    assert zc.extract_json('```json\n{"a": 2}\n```') == {"a": 2}


def test_extract_json_embedded():
    assert zc.extract_json('结果是 {"a": 3} 请查收') == {"a": 3}


def test_extract_json_failure():
    with pytest.raises(ValueError, match="无法从输出中提取"):
        zc.extract_json("没有 JSON")


# ---------- chat 链语义 ----------

def test_chat_first_model_ok():
    c = Client([ok("答案")])
    assert c.chat("sys", "user") == "答案"
    assert c.calls[0]["model"] == "glm-a"


def test_chat_429_falls_to_next():
    c = Client([(429, "rate"), ok("第二棒")])
    assert c.chat("sys", "user") == "第二棒"
    assert [p["model"] for p in c.calls] == ["glm-a", "glm-b"]


def test_chat_1113_marks_dead_and_skips_without_call():
    c = Client([(429, '{"error":{"code":"1113"}}'), ok("活了")])
    assert c.chat("sys", "user") == "活了"
    # 第二次 chat：死模型 glm-a 不发请求直接从 glm-b 开始
    c2 = Client([ok("直连B")])
    zc._DEAD_MODELS.clear()
    zc._DEAD_MODELS.add("glm-a")
    assert c2.chat("sys", "user") == "直连B"
    assert [p["model"] for p in c2.calls] == ["glm-b"]


def test_chat_content_filter_raises_immediately():
    c = Client([(400, '{"error":{"code":"1301"}}'), ok("不该被调用")])
    with pytest.raises(zc._ContentFilterError):
        c.chat("sys", "user")
    assert len(c.calls) == 1  # 同内容所有模型都会拒绝，不浪费调用


def test_chat_429_registers_cooldown():
    c = Client([(429, "overload"), ok("B接手")])
    assert c.chat("sys", "user") == "B接手"
    assert zc._cooled_out("glm-a")  # FIX-0816g：120s 冷却登记
    zc._MODEL_COOLDOWN.clear()


def test_chat_all_fail_raises_with_chain():
    c = Client([(500, "err"), (500, "err")])
    with pytest.raises(zc._GLMError, match="glm-a"):
        c.chat("sys", "user")


def test_chat_all_rate_limited_sleeps_once(monkeypatch):
    slept = []
    monkeypatch.setattr(zc.time, "sleep", lambda s: slept.append(s))
    c = Client([(429, "a"), (429, "b")])
    with pytest.raises(zc._GLMError):
        c.chat("sys", "user")
    assert len(slept) == 1  # FIX-0819i：仅全链限流时睡一次
    zc._MODEL_COOLDOWN.clear()


# ---------- 三契约方法（4.2） ----------

def test_fast_contract():
    c = Client([ok("快答", usage={"prompt_tokens": 3, "completion_tokens": 5})])
    r = c.fast("问题")
    assert r["text"] == "快答"
    assert r["usage"]["completion_tokens"] == 5
    assert r["confidence"] == 1.0


def test_fast_truncated_lowers_confidence():
    c = Client([ok("截断", finish="length")])
    assert c.fast("问题")["confidence"] < 1.0


def test_deep_contract_enables_thinking():
    c = Client([ok("深思")])
    r = c.deep("难题")
    assert r["text"] == "深思"
    assert r["chain"] == ["glm-a"]
    assert c.calls[0]["thinking"] == {"type": "enabled"}


def test_deep_chain_records_fallback():
    c = Client([(429, "x"), ok("B深思")])
    r = c.deep("难题")
    assert r["chain"] == ["glm-a", "glm-b"]
    assert r["text"] == "B深思"
    zc._MODEL_COOLDOWN.clear()


def test_vision_contract(tmp_path):
    img = tmp_path / "shot.png"
    img.write_bytes(b"\x89PNG fake")
    c = Client([ok('{"event": "写文档", "app": "Word"}')])
    r = c.vision(str(img), schema={"event": "str", "app": "str"})
    assert r["json"] == {"event": "写文档", "app": "Word"}
    msg = c.calls[0]["messages"][0]
    parts = [p for p in msg["content"] if isinstance(p, dict)]
    assert any(p.get("type") == "image_url" for p in parts)
    assert any(p.get("type") == "text" for p in parts)
