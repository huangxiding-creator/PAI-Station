"""M7c L2 慢通道：银甲虫 prompt 移植 + UItron 三档复杂度路由。"""
from paistation.intent.l2_slow import (
    build_messages,
    parse_llm_json,
    route,
    summarize_block,
)

_LLM_JSON = ('{"activity": "在写 PAI 意图层测试", "project": "PAI-Station",'
             ' "category": "project", "summary": "为意图层补 L2 测试",'
             ' "evidence": ["main.py"], "confidence": 0.85,'
             ' "next_action": "继续写金标准"}')


class _FakeGateway:
    def __init__(self, reply=None, error=None):
        self.reply = reply or _LLM_JSON
        self.error = error
        self.calls = []

    def chat(self, messages, **kw):
        self.calls.append((messages, kw))
        if self.error:
            raise self.error
        return self.reply, "fake"


def _block(**kw):
    b = {"start": "2026-09-15T10:00:00", "end": "2026-09-15T10:30:00",
         "duration_min": 30.0, "samples": 10, "process": "Code.exe",
         "titles": ["main.py - pai"], "domains": ["github.com"],
         "category": "project", "label": "做项目",
         "category_counts": {"project": 10}, "coverage": 1.0,
         "confidence": 0.8, "related_files": ["main.py"],
         "related_clipboard": ["text"]}
    b.update(kw)
    return b


def test_route_simple_high_confidence():
    assert route(_block()) == "simple"


def test_route_complex_moderate():
    assert route(_block(confidence=0.6, coverage=0.55)) == "complex"


def test_route_hardest_unknown_or_mixed():
    assert route(_block(category="unknown", confidence=0.3)) == "hardest"
    assert route(_block(coverage=0.4)) == "hardest"


def test_summarize_simple_skips_llm():
    gw = _FakeGateway()
    r = summarize_block(_block(), gw)
    assert r["llm"] is False and r["tier"] == "simple"
    assert gw.calls == []                       # 高置信直判不烧 token


def test_summarize_complex_uses_llm():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.6, coverage=0.55), gw)
    assert r["llm"] is True and r["provider"] == "fake"
    assert r["activity"] == "在写 PAI 意图层测试"
    assert r["confidence"] == 0.85
    assert gw.calls[0][1].get("temperature") == 0.2   # 银甲虫标定


def test_summarize_gateway_failure_degrades():
    r = summarize_block(_block(coverage=0.5),
                        _FakeGateway(error=RuntimeError("全供应商死")))
    assert r["llm"] is False and r["degraded"] == "gateway"
    assert r["confidence"] == 0.3               # 降级 L1 直判低置信


def test_summarize_parse_failure_degrades():
    r = summarize_block(_block(coverage=0.5),
                        _FakeGateway(reply="我觉得用户在写代码啦"))
    assert r["llm"] is False and r["degraded"] == "parse"
    assert r["confidence"] == 0.3


def test_parse_llm_json_fences_and_plain():
    assert parse_llm_json(_LLM_JSON)["project"] == "PAI-Station"
    assert parse_llm_json(f"```json\n{_LLM_JSON}\n```") is not None
    assert parse_llm_json("垃圾输出") is None


def test_build_messages_injects_icl():
    msgs = build_messages(_block(), icl="[历史修正示例]\n正确判读: 修代码")
    assert msgs[0]["role"] == "system"
    assert "历史修正示例" in msgs[1]["content"]
    assert "main.py - pai" in msgs[1]["content"]          # 块证据入 prompt
    assert "只输出 JSON" in msgs[1]["content"]


def test_needs_screen_flag_on_hardest():
    r = summarize_block(_block(category="unknown", confidence=0.3),
                        _FakeGateway())
    assert r["tier"] == "hardest"
    assert r.get("needs_screen") is True          # M8 感知升级件接入位


# ---------- M8 屏幕观察接缝 ----------

def test_screen_observer_only_called_on_hardest():
    calls = []

    def screen():
        calls.append(1)
        return {"tier": "hardest", "text": "微信读书页面"}

    gw = _FakeGateway()
    r = summarize_block(_block(category="unknown", confidence=0.3),
                        gw, screen=screen)
    assert r["screen_used"] is True
    assert calls == [1]                        # hardest 档才观察
    assert "微信读书页面" in gw.calls[0][0][1]["content"]


def test_screen_not_called_on_simple_and_complex():
    calls = []

    def screen():
        calls.append(1)
        return "屏幕内容"

    summarize_block(_block(), _FakeGateway(), screen=screen)          # simple
    summarize_block(_block(confidence=0.6, coverage=0.55),
                    _FakeGateway(), screen=screen)                    # complex
    assert calls == []                         # 省资源：非 hardest 零观察
    r = summarize_block(_block(confidence=0.6, coverage=0.55),
                        _FakeGateway(), screen=screen)
    assert r["screen_used"] is False


def test_screen_failsoft_exception_and_forms():
    def boom():
        raise RuntimeError("截图死")

    r = summarize_block(_block(category="unknown", confidence=0.3),
                        _FakeGateway(), screen=boom)
    assert r["llm"] is True and r["screen_used"] is False   # fail-soft 不崩
    r2 = summarize_block(_block(category="unknown", confidence=0.3),
                         _FakeGateway(), screen=lambda: "纯字符串观察")
    assert r2["screen_used"] is True
    r3 = summarize_block(_block(category="unknown", confidence=0.3),
                         _FakeGateway(), screen=lambda: {"text": ""})
    assert r3["screen_used"] is False              # 空文本=未使用


def test_build_messages_screen_section():
    msgs = build_messages(_block(), screen_text="浏览器在看招标公告")
    assert "[屏幕观察]" in msgs[1]["content"]
    assert "招标公告" in msgs[1]["content"]


# ---- Jev 判断层快路径（09-19 深度融合）----

def _jev_answers(choice="research", conf=0.85, noul=0.9, probs=None):
    return {"category": {"type": "choice", "choice": choice,
                         "probabilities": probs or {choice: conf},
                         "confidence": conf},
            "needs_screen": {"type": "noul", "noul": noul}}


def test_jev_fast_path_skips_llm():
    gw = _FakeGateway()
    called = []
    gw.chat = lambda *a, **k: called.append(1) or ("{}", "fake")
    r = summarize_block(_block(confidence=0.4), gw,
                        jev=lambda s, q: _jev_answers())
    assert r["engine"] == "jev" and r["llm"] is False
    assert r["category"] == "research" and r["confidence"] == 0.85
    assert called == []                               # LLM 零调用


def test_jev_low_confidence_falls_back_to_llm():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.4), gw,
                        jev=lambda s, q: _jev_answers(conf=0.60))
    assert r.get("llm") is True                      # 回退 LLM 原路径


def test_jev_needs_screen_falls_back():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.4), gw,
                        jev=lambda s, q: _jev_answers(noul=0.3))
    assert r.get("llm") is True


def test_jev_failure_falls_back():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.4), gw,
                        jev=lambda s, q: (_ for _ in ()).throw(OSError()))
    assert r.get("llm") is True or r.get("degraded") == "gateway"


def test_jev_none_falls_back():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.4), gw, jev=lambda s, q: None)
    assert r.get("llm") is True


def test_jev_invalid_choice_rejected():
    gw = _FakeGateway()
    r = summarize_block(_block(confidence=0.4), gw,
                        jev=lambda s, q: _jev_answers(choice="乱造类"))
    assert r.get("llm") is True
