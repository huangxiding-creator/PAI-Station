# -*- coding: utf-8 -*-
"""P0-J4 金标准 Jev 语义复核腿契约测试（零真网：fake jev_ask）。"""
import pytest

from paistation.cx.jev_screen import (
    build_question,
    screen,
    verdict_matrix,
)


def _fake_ask(noul_value):
    """造 fake jev_ask：返回 E3 应答形态 {qid: {type,noul}}。"""
    def ask(state, questions):
        return {"hit": {"type": "noul", "noul": noul_value}}
    return ask


class TestScreen:
    def test_confirmed_lexical_hit_jev_high(self):
        v, n = screen("q", ["片段含答案事实"], True, _fake_ask(0.9))
        assert v == "confirmed" and n == 0.9

    def test_hollow_lexical_hit_jev_low(self):
        """E3 实测 17 题形态：词面撞词但语义不答 → 悬空（假阳候选）。"""
        v, n = screen("q", ["片段只有主题相关词"], True, _fake_ask(0.31))
        assert v == "hollow" and n == 0.31

    def test_semantic_lexical_miss_jev_high(self):
        """E3 实测 3 题形态：同义表述词面漏判 → 语义等价命中。"""
        v, n = screen("q", ["片段同义转述了答案"], False, _fake_ask(0.58))
        assert v == "semantic" and n == 0.58

    def test_lexical_only_when_jev_absent(self):
        v, n = screen("q", ["片段"], False, _fake_ask(0.2))
        assert v == "lexical_only" and n == 0.2

    @pytest.mark.parametrize("jev_result", [None, {}, {"hit": {}}])
    def test_fail_soft_jev_none_keeps_lexical(self, jev_result):
        """Jev 缺席/坏载荷 → 零影响回退词面口径（用户开关契约）。"""
        def ask(state, questions):
            return jev_result
        v, n = screen("q", ["片段"], True, ask)
        assert v == "lexical_only" and n is None

    def test_fail_soft_jev_raises_keeps_lexical(self):
        def boom(state, questions):
            raise OSError("net down")
        v, n = screen("q", ["片段"], True, boom)
        assert v == "lexical_only" and n is None

    def test_threshold_at_05(self):
        v, _ = screen("q", ["片段"], True, _fake_ask(0.5))
        assert v == "confirmed"

    def test_state_carries_question_and_snippets(self):
        seen = {}

        def ask(state, questions):
            seen.update(state)
            return {"hit": {"type": "noul", "noul": 0.9}}
        screen("問題X", ["片段甲", "片段乙"], True, ask)
        assert seen["问题"] == "問題X"
        assert seen["检索片段top8"] == ["片段甲", "片段乙"]


class TestQuestionShape:
    def test_build_question_matches_e3_wording(self):
        """问句措辞=E3 实测措辞（分离缝 0.5 正切的那版），不改字。"""
        q = build_question()
        assert q["type"] == "noul"
        assert "是否包含能直接回答问题的内容" in q["instructions"]
        assert "同义表述" in q["criteria"]["true"]
        assert "不含答案事实本身" in q["criteria"]["false"]


class TestMatrix:
    def test_verdict_matrix_counts(self):
        rows = [
            {"verdict": "confirmed", "noul": 0.9},
            {"verdict": "confirmed", "noul": 0.8},
            {"verdict": "hollow", "noul": 0.31},
            {"verdict": "semantic", "noul": 0.58},
            {"verdict": "lexical_only", "noul": None},
        ]
        m = verdict_matrix(rows)
        assert m["confirmed"] == 2 and m["hollow"] == 1
        assert m["semantic"] == 1 and m["lexical_only"] == 1
        assert m["total"] == 5
        assert m["jev_screened"] == 4  # lexical_only(none) 不计入筛查面
