"""M0.4 路由：Kahneman 双系统升级边界（0.69/0.71，锚点 0.4）。"""
from paistation.llm.router import Router


class StubClient:
    def __init__(self, fast_conf):
        self.fast_conf = fast_conf
        self.deep_calls = 0

    def fast(self, prompt, context=""):
        return {"text": "快答", "confidence": self.fast_conf,
                "usage": {"completion_tokens": 2}}

    def deep(self, prompt, reasoning=True):
        self.deep_calls += 1
        return {"text": "深答", "chain": ["m1"], "confidence": 0.95}


def test_low_confidence_upgrades_to_deep():
    c = StubClient(0.69)
    r = Router(c, upgrade_confidence=0.7).route("难题")
    assert r["path"] == ["fast", "deep"]
    assert r["text"] == "深答"
    assert r["upgraded"] is True
    assert c.deep_calls == 1


def test_high_confidence_stays_fast():
    c = StubClient(0.71)
    r = Router(c, upgrade_confidence=0.7).route("易题")
    assert r["path"] == ["fast"]
    assert r["text"] == "快答"
    assert r["upgraded"] is False
    assert c.deep_calls == 0


def test_boundary_exact_threshold_stays_fast():
    c = StubClient(0.70)
    r = Router(c, upgrade_confidence=0.7).route("边界题")
    assert r["upgraded"] is False  # 严格小于才升级


def test_result_carries_usage_and_confidence():
    r = Router(StubClient(0.71), 0.7).route("题")
    assert r["usage"]["completion_tokens"] == 2
    assert r["confidence"] == 0.71
