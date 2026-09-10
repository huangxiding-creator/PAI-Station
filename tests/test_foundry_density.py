# M7.0 思想密度计：三层标注×九件套×四前提×三级目录（提案 M7 §3.4）
from paistation.foundry.density import (
    NINE_COMPONENTS,
    PREMISES,
    density_score,
    four_premises,
    toc_depth_ok,
)


def _section(title="1.1 现状诊断", framework="SCQA", components=("case", "pitfall_checklist"),
             content="标准化流程 SOP 表格；数据化看板指标；知识库沉淀。"):
    return {"title": title, "framework": framework,
            "components": list(components), "content": content}


def _chapter(title="第1章 行业诊断", framework="OODA 循环", sections=None):
    return {"title": title, "framework": framework,
            "sections": sections or [_section(), _section("1.2 机会识别", "MECE",
                                                          ("wbs", "infographic"))]}


def _doc():
    return {"title": "试点方案", "chapters": [_chapter(),
            _chapter("第2章 落地路线", "精益创业循环")]}


class TestPremises:
    def test_four_premises_all_pass(self):
        r = four_premises(_doc())
        assert set(r) == {"标准化", "流程化", "数据化", "知识化"}
        assert all(r.values())

    def test_missing_premise_detected(self):
        doc = _doc()
        doc["chapters"][0]["sections"][0]["content"] = "只有流程图和清单。"
        r = four_premises(doc)
        assert r["数据化"] is False or r["知识化"] is False

    def test_premise_markers_defined(self):
        assert all(len(v) >= 2 for v in PREMISES.values())


class TestTocDepth:
    def test_three_levels_ok(self):
        assert toc_depth_ok(_doc())

    def test_fourth_level_rejected(self):
        doc = _doc()
        doc["chapters"][0]["sections"][0]["subsections"] = [_section()]
        assert not toc_depth_ok(doc)


class TestDensityScore:
    def test_full_score_passes(self):
        r = density_score(_doc())
        assert r["passed"] is True
        assert r["score"] >= 60
        assert r["failures"] == []
        assert 0 <= r["score"] <= 100

    def test_thin_doc_fails_with_reasons(self):
        doc = {"title": "薄方案", "chapters": [{
            "title": "第1章", "framework": "",
            "sections": [{"title": "1.1", "framework": "",
                          "components": [], "content": "泛泛而谈"}]}]}
        r = density_score(doc)
        assert r["passed"] is False
        assert r["score"] < 60
        assert any("章模型" in f or "节模型" in f or "九件套" in f for f in r["failures"])

    def test_component_shortfall_scores_partial(self):
        doc = _doc()
        doc["chapters"][0]["sections"][0]["components"] = ["case"]  # 仅 1 件
        r = density_score(doc)
        assert 0 < r["score"] < 100
        assert r["passed"] is (r["score"] >= 60)

    def test_custom_threshold(self):
        r = density_score(_doc(), threshold=100)
        assert r["passed"] is False or r["score"] == 100

    def test_nine_components_constant(self):
        assert len(NINE_COMPONENTS) == 9
        assert "wbs" in NINE_COMPONENTS and "case" in NINE_COMPONENTS

    def test_empty_doc_safe(self):
        r = density_score({"title": "空", "chapters": []})
        assert r["passed"] is False and r["score"] == 0
