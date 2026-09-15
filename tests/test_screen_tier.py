"""M8 感知升级件：屏幕观察档位制（tier 0 无 / 1 OCR / 2 VLM）。"""
from paistation.intent.screen_tier import ScreenObserver, detect_tier
from paistation.intent.l2_slow import summarize_block

_LLM_JSON = ('{"activity": "在改一个复杂 bug", "project": "X", '
             '"category": "project", "summary": "混杂段细判", '
             '"evidence": [], "confidence": 0.7, "next_action": ""}')


class _FakeGateway:
    def __init__(self):
        self.messages = []

    def chat(self, messages, **kw):
        self.messages = messages
        return _LLM_JSON, "fake"


def _hardest_block():
    return {"start": "2026-09-15T10:00:00", "end": "2026-09-15T10:20:00",
            "duration_min": 20.0, "samples": 6, "process": "chrome.exe",
            "titles": ["???"], "domains": [], "category": "unknown",
            "label": "未识别", "category_counts": {"unknown": 6},
            "coverage": 1.0, "confidence": 0.3,
            "related_files": [], "related_clipboard": []}


def test_detect_tier_ladder():
    assert detect_tier() == 0
    assert detect_tier(ocr_fn=lambda: "文本") == 1
    assert detect_tier(vlm_fn=lambda: "描述") == 2
    assert detect_tier(ocr_fn=lambda: "t", vlm_fn=lambda: "d") == 2


def test_observer_ocr_text():
    ob = ScreenObserver(ocr_fn=lambda: " 屏幕上的文字 ")
    assert ob.tier == 1
    assert ob.observe() == {"tier": 1, "text": "屏幕上的文字"}


def test_observer_provider_failure_none():
    def boom():
        raise RuntimeError("OCR 死")

    assert ScreenObserver(ocr_fn=boom).observe() is None
    assert ScreenObserver(ocr_fn=lambda: "").observe() is None   # 空文本
    assert ScreenObserver().observe() is None                    # tier 0


def test_observer_blacklisted_window_zero_capture():
    """隐私红线：前台黑名单窗口 → 零截屏零观察。"""
    calls = {"ocr": 0}

    def ocr():
        calls["ocr"] += 1
        return "秘密内容"

    ob = ScreenObserver(ocr_fn=ocr, allowed_fn=lambda: False)
    assert ob.observe() is None
    assert calls["ocr"] == 0                 # 提供方根本没被调用


def test_summarize_hardest_uses_screen():
    gw = _FakeGateway()
    ob = ScreenObserver(ocr_fn=lambda: "IDE 报错堆栈 Traceback")
    r = summarize_block(_hardest_block(), gw, screen=ob.observe)
    assert r["screen_used"] is True
    assert "屏幕观察" in gw.messages[1]["content"]
    assert "Traceback" in gw.messages[1]["content"]


def test_summarize_screen_absent_still_works():
    gw = _FakeGateway()
    r = summarize_block(_hardest_block(), gw)
    assert "屏幕观察" not in gw.messages[1]["content"]
    assert r.get("screen_used") is False


def test_simple_tier_never_touches_screen():
    """simple 档直判——屏幕观察提供方零调用（省资源）。"""
    calls = {"n": 0}

    def screen():
        calls["n"] += 1
        return {"tier": 1, "text": "x"}

    good = {"category": "project", "confidence": 0.8, "coverage": 1.0,
            "samples": 6, "duration_min": 10.0, "process": "Code.exe",
            "titles": ["m.py"], "domains": [], "start": "s", "end": "e",
            "label": "做项目", "category_counts": {"project": 6},
            "related_files": [], "related_clipboard": []}
    gw = _FakeGateway()
    r = summarize_block(good, gw, screen=screen)
    assert r["llm"] is False
    assert calls["n"] == 0
