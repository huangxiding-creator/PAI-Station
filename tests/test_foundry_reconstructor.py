# M7.1 重构引擎：三层九件套提示词 + 重生成环 + 降级不假完成（提案 M7 §3）
import json

import pytest

from paistation.foundry.methodology import suggest_cards
from paistation.foundry.prompts import section_prompt, toc_prompt
from paistation.foundry.reconstructor import Reconstructor, _loads_json


def _good_section_json():
    return json.dumps({
        "framework": "SCQA",
        "components": ["key_points", "wbs", "case"],
        "content": ("【关键点】本节用 SCQA 展开。标准化：先建 SOP。\n"
                    "【WBS 任务分解】任务A→任务B。流程化：泳道图定流程。\n"
                    "【小案例】某公司照做三周见效。数据化：看板指标；知识化：知识库沉淀。"),
    }, ensure_ascii=False)


def _thin_section_json():
    return json.dumps({"framework": "", "components": [], "content": "泛泛而谈"},
                      ensure_ascii=False)


class TestPrompts:
    def test_section_prompt_embeds_contract(self):
        p = section_prompt("第1章 诊断", {"title": "1.1 现状", "framework": "SCQA"},
                           corpus="语料片段", cards_l2l3=[], immune_rules=["禁止空话"])
        for must in ("SCQA", "九件套", "四前提", "标准化", "流程化", "数据化", "知识化",
                     "JSON", "禁止空话"):
            assert must in p, f"提示词缺要素: {must}"

    def test_section_prompt_injects_cards(self):
        p = section_prompt("章", {"title": "节", "framework": "SWOT"},
                           corpus="", cards_l2l3=[("SWOT 分析", "四象限定位")],
                           immune_rules=[])
        assert "SWOT 分析" in p and "四象限定位" in p

    def test_toc_prompt_embeds_l1_cards(self):
        p = toc_prompt("工程总承包 AI 转型", corpus="",
                       cards_l1=[("OODA 循环", "观察→判断→决策→行动")], n_chapters=8)
        for must in ("OODA 循环", "三级", "JSON", "framework"):
            assert must in p, f"目录提示词缺要素: {must}"


class TestJsonParsing:
    def test_plain_json(self):
        assert _loads_json('{"a": 1}') == {"a": 1}

    def test_fenced_json(self):
        assert _loads_json('```json\n{"a": 2}\n```') == {"a": 2}

    def test_garbage_returns_none(self):
        assert _loads_json("这不是JSON") is None


class TestSuggestCards:
    def test_suggest_by_keyword(self):
        cards = suggest_cards("风险与规避", level="L2", k=3)
        assert cards and all(c["level"] == "L2" for c in cards)
        assert any("风险" in c["name"] for c in cards)

    def test_suggest_fallback_when_no_hit(self):
        cards = suggest_cards("量子涨落场论", level="L3", k=4)
        assert len(cards) == 4  # 无命中时回退前 k 张，保证弹药不断供

    def test_suggest_two_levels(self):
        cards = suggest_cards("分析", level="L2L3", k=8)
        assert cards and all(c["level"] in ("L2", "L3") for c in cards)


class _FakeDeep:
    """按调用序吐出预设回复的假主脑。"""

    def __init__(self, replies):
        self.replies = list(replies)
        self.calls = []

    def __call__(self, prompt, reasoning=True):
        self.calls.append(prompt)
        return {"text": self.replies.pop(0)}


class TestReconstructSection:
    def _chapter(self):
        return {"title": "第1章 行业诊断", "framework": "OODA 循环",
                "sections": [{"title": "1.1 现状", "framework": "SCQA"}]}

    def test_good_first_shot(self):
        r = Reconstructor(_FakeDeep([_good_section_json()]))
        out = r.reconstruct_section(self._chapter(), "1.1 现状", corpus="语料")
        assert out["framework"] == "SCQA"
        assert out["passed"] is True
        assert out["degraded"] is False
        assert len(out["components"]) == 3
        assert out["score"] >= 60

    def test_regen_loop_rescues_thin_first_shot(self):
        fake = _FakeDeep([_thin_section_json(), _good_section_json()])
        r = Reconstructor(fake)
        out = r.reconstruct_section(self._chapter(), "1.1 现状", corpus="语料")
        assert out["passed"] is True and out["degraded"] is False
        assert len(fake.calls) == 2  # 初次 1 + 重生成 1

    def test_degrade_honestly_after_max_regens(self):
        fake = _FakeDeep([_thin_section_json()] * 4)
        r = Reconstructor(fake)
        out = r.reconstruct_section(self._chapter(), "1.1 现状", corpus="语料")
        assert out["degraded"] is True
        assert out["passed"] is False
        assert len(fake.calls) == 3  # 初次 + 重生成上限 2（宪法：不假完成）
        assert "降级" in out["degrade_note"]

    def test_immune_rules_reach_prompt(self):
        fake = _FakeDeep([_good_section_json()])
        Reconstructor(fake).reconstruct_section(self._chapter(), "1.1 现状",
                                                corpus="语料", immune_rules=["禁止编造数据"])
        assert "禁止编造数据" in fake.calls[0]

    def test_best_of_n_picks_higher_density(self):
        fake = _FakeDeep([_thin_section_json(), _good_section_json()])
        r = Reconstructor(fake)
        out = r.reconstruct_section(self._chapter(), "1.1 现状", corpus="语料", n_candidates=2)
        assert out["framework"] == "SCQA"  # 择优而非取先

    def test_embedded_marker_detected_when_undeclared(self):
        """正文嵌了组件但漏报 components：反查补全，密度计丈量真实嵌入。"""
        payload = json.dumps({"framework": "SCQA", "components": ["key_points"],
                              "content": "【关键点】要点。避坑清单：1.别抄。小案例：见效。"
                                         "标准化 SOP；流程化泳道；数据化看板；知识化沉淀。"},
                             ensure_ascii=False)
        out = Reconstructor(_FakeDeep([payload])).reconstruct_section(
            self._chapter(), "1.1 现状", corpus="语料")
        for comp in ("key_points", "pitfall_checklist", "case"):
            assert comp in out["components"], f"反查未补全: {comp}"


class TestReconstructToc:
    def test_toc_roundtrip(self):
        toc = {"title": "方案", "chapters": [
            {"title": "第1章", "framework": "OODA 循环",
             "sections": [{"title": "1.1", "framework": "SCQA"}]}]}
        fake = _FakeDeep([json.dumps(toc, ensure_ascii=False)])
        out = Reconstructor(fake).reconstruct_toc("主题", corpus="语料", n_chapters=1)
        assert out["title"] == "方案"
        assert out["chapters"][0]["sections"][0]["framework"] == "SCQA"

    def test_toc_retries_on_garbage(self):
        toc = {"title": "方案", "chapters": [
            {"title": "第1章", "framework": "MECE", "sections": [
                {"title": "1.1", "framework": "五力模型"}]}]}
        fake = _FakeDeep(["garbage", json.dumps(toc, ensure_ascii=False)])
        out = Reconstructor(fake).reconstruct_toc("主题", corpus="", n_chapters=1)
        assert out["chapters"][0]["framework"] == "MECE"
        assert len(fake.calls) == 2

    def test_toc_gives_up_honestly(self):
        fake = _FakeDeep(["garbage"] * 5)
        with pytest.raises(RuntimeError, match="目录"):
            Reconstructor(fake).reconstruct_toc("主题", corpus="", n_chapters=1)
