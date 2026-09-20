# -*- coding: utf-8 -*-
"""P0-J1 信源筛契约测试（零真网：fake jev_ask）。

J1 定位（提案 §2）：survey 后置过滤器——采集洪流中「仅提及企业名/纯行业
泛谈」的噪声文件按 noul@0.5 滤除。fail-soft 契约与 J4 相反方向：Jev 缺席
时**全部保留**（过滤器绝不误杀信源，宁可多打包噪声）。
"""
import pytest

from paistation.cx.source_filter import (
    build_question,
    filter_batch,
    screen,
)


def _fake_ask(noul_value):
    def ask(state, questions):
        return {"hit": {"type": "noul", "noul": noul_value}}
    return ask


class TestScreen:
    def test_keep_when_noul_high(self):
        """片段含企业项目/业绩事实 → 保留。"""
        keep, n = screen("中车四方所中标青岛地铁EPC项目，金额12.4亿", "中车四方所",
                         _fake_ask(0.9))
        assert keep is True and n == 0.9

    def test_drop_when_noul_low(self):
        """纯行业泛谈（无该企业事实）→ 滤除。"""
        keep, n = screen("工程总承包模式近年快速发展，行业迎来新机遇", "中车四方所",
                         _fake_ask(0.15))
        assert keep is False and n == 0.15

    def test_threshold_at_05(self):
        keep, _ = screen("t", "企业X", _fake_ask(0.5))
        assert keep is True

    @pytest.mark.parametrize("jev_result", [None, {}, {"hit": {}}])
    def test_fail_soft_jev_absent_keeps_all(self, jev_result):
        """Jev 缺席/坏载荷 → keep=True（过滤器不误杀信源）。"""
        def ask(state, questions):
            return jev_result
        keep, n = screen("纯泛谈文本", "企业X", ask)
        assert keep is True and n is None

    def test_fail_soft_jev_raises_keeps(self):
        def boom(state, questions):
            raise OSError("net down")
        keep, n = screen("t", "企业X", boom)
        assert keep is True and n is None

    def test_state_carries_enterprise_and_text(self):
        seen = {}

        def ask(state, questions):
            seen.update(state)
            return {"hit": {"type": "noul", "noul": 0.9}}
        screen("某文正文摘要", "中车四方所", ask)
        assert seen["目标企业"] == "中车四方所"
        assert "文章开头" in seen and "某文正文摘要" in seen["文章开头"]


class TestQuestionShape:
    def test_build_question_wording(self):
        """J1 问句：可引用事实判据具体化（企业名下项目/业绩/人物/观点/数据）。"""
        q = build_question()
        assert q["type"] == "noul"
        assert "可引用事实" in q["instructions"]
        assert "项目" in q["criteria"]["true"] and "业绩" in q["criteria"]["true"]
        assert "仅提及" in q["criteria"]["false"]


class TestBatch:
    def test_filter_batch_summary(self):
        rows = [
            {"file": "a.md", "text": "含事实A"},
            {"file": "b.md", "text": "泛谈"},
            {"file": "c.md", "text": "含事实C"},
        ]
        nouls = iter([0.9, 0.1, None])  # 第三题 Jev 缺席 → 保留

        def ask(state, questions):
            v = next(nouls)
            return {"hit": {"type": "noul", "noul": v}} if v is not None else None
        kept, m = filter_batch(rows, "企业X", ask)
        assert [r["file"] for r in kept] == ["a.md", "c.md"]
        assert m == {"total": 3, "kept": 2, "dropped": 1, "jev_screened": 2}
