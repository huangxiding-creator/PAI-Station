"""M1 N 路自洽（第 26 章兵器一）：多数票 + 一致率置信度 + 验证环。"""
import pytest

from paistation.llm.ensemble import EnsembleRunner


class StubClient:
    """按序吐答案；answers 循环消耗。"""

    def __init__(self, answers, fail_on=None):
        self.answers = list(answers)
        self.fail_on = set(fail_on or ())
        self.calls = 0

    def fast(self, prompt, context=""):
        self.calls += 1
        if self.calls in self.fail_on:
            raise RuntimeError("限流")
        return {"text": self.answers[(self.calls - 1) % len(self.answers)],
                "confidence": 0.9, "usage": {}}


def test_majority_vote_wins():
    c = StubClient(["甲", "甲", "甲", "乙", "乙", "丙", "甲", "乙"])
    r = EnsembleRunner(c, n=8, min_agreement=0.4).answer("问题")
    assert r["answer"] == "甲"
    assert r["agreement"] == pytest.approx(4 / 8)
    assert r["calls"] == 8


def test_unanimous_agreement_one():
    c = StubClient(["同"])
    r = EnsembleRunner(c, n=5).answer("问题")
    assert r["answer"] == "同"
    assert r["agreement"] == 1.0


def test_low_agreement_triggers_verify_round():
    # 首轮各说各话（一致率 2/8），验证环第二轮收敛到"戊"
    seq = ["甲", "乙", "丙", "丁", "戊", "戊", "己", "庚",
           "戊", "戊", "戊", "戊", "戊", "戊", "戊", "戊"]
    c = StubClient(seq)
    r = EnsembleRunner(c, n=8, min_agreement=0.6, verify_rounds=1).answer("问题")
    assert r["answer"] == "戊"
    assert r["agreement"] == 1.0
    assert r["calls"] == 16  # 8 + 验证 8


def test_verify_rounds_exhausted_returns_best():
    seq = [f"答{i}" for i in range(32)]  # 全不同
    c = StubClient(seq)
    r = EnsembleRunner(c, n=4, min_agreement=0.9, verify_rounds=1).answer("问题")
    assert r["agreement"] == pytest.approx(0.25)
    assert r["calls"] == 8


def test_partial_failures_survive():
    c = StubClient(["甲"] * 8, fail_on={1, 3})
    r = EnsembleRunner(c, n=8).answer("问题")
    assert r["answer"] == "甲"
    assert r["successes"] == 6


def test_all_fail_raises():
    c = StubClient(["甲"], fail_on=set(range(1, 20)))
    with pytest.raises(Exception, match="全部失败"):
        EnsembleRunner(c, n=4).answer("问题")


def test_whitespace_normalized_in_vote():
    c = StubClient([" 甲 ", "甲", "甲"])
    r = EnsembleRunner(c, n=3).answer("问题")
    assert r["answer"] == "甲"
    assert r["agreement"] == 1.0
