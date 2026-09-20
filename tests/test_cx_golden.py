

class TestDropExamChunks:
    """考卷泄漏修复（09-20 用户裁决：查询侧排除）——金标准跑分检索
    不得命中考卷自身（题面/答案/旧报告进索引=词面满分带泄漏成分）。"""

    def test_drops_exam_path_hits(self):
        from paistation.cx.golden import drop_exam_chunks
        from types import SimpleNamespace as NS
        hits = [NS(path="E:/x/SELF_PROFILE/golden_set/score_1.md", text="a"),
                NS(path="E:/x/知识库/正常文档.md", text="b")]
        kept = drop_exam_chunks(hits)
        assert [h.path for h in kept] == ["E:/x/知识库/正常文档.md"]

    def test_default_markers_cover_question_and_report(self):
        from paistation.cx.golden import drop_exam_chunks
        from types import SimpleNamespace as NS
        # 题面/报告/jsonl 全家族
        for p in ("golden_set/golden_100_v1.jsonl", "golden_set/score_2026.md"):
            assert drop_exam_chunks([NS(path=f"E:/{p}", text="")]) == []

    def test_empty_and_all_exam(self):
        from paistation.cx.golden import drop_exam_chunks
        assert drop_exam_chunks([]) == []
