# M7.5 AIResearch 融合：统一收集器 + NotebookLM 外脑（默认关）+ 七步管线（提案 M7 §6）
import json
import os

import pytest

from paistation.foundry.collector import collect_corpus, merge_corpus
from paistation.foundry.nblm import NotebookBrain, is_enabled
from paistation.foundry.pipeline import Pipeline, generate_keywords


def _make_pools(tmp_path):
    hundun = tmp_path / "hundun" / "_mining"
    hundun.mkdir(parents=True)
    (hundun / "c1.json").write_text(json.dumps({
        "course_id": "x", "title": "工程总承包实战课程", "teacher": "张三",
        "folder": "f", "score": 50, "items": [
            {"name": "EPC 模式", "core": "设计采购施工一体化", "ai_application": "AI进度管控",
             "quote": "", "src": "", "type": ""}]}, ensure_ascii=False), encoding="utf-8")
    (hundun / "c2.json").write_text(json.dumps({
        "course_id": "y", "title": "品牌营销课", "teacher": "白鸦",
        "folder": "f", "score": 52, "items": [
            {"name": "GEO", "core": "消费重塑", "ai_application": "问答优化",
             "quote": "", "src": "", "type": ""}]}, ensure_ascii=False), encoding="utf-8")
    weread = tmp_path / "weread"
    weread.mkdir()
    (weread / "EPC书.md").write_text("# EPC 工程总承包全书\n\n总承包管理要点。", encoding="utf-8")
    return {"hundun": str(hundun), "weread": str(weread)}


class TestCollector:
    def test_collect_by_keyword_filters(self, tmp_path):
        pools = _make_pools(tmp_path)
        r = collect_corpus("工程总承包 AI 转型", pools=pools, keywords=("工程总承包", "EPC"))
        assert r["stats"]["matched_files"] >= 2
        texts = " ".join(r["chunks"])
        assert "设计采购施工一体化" in texts  # 混沌命中
        assert "总承包管理要点" in texts  # 微信读书命中
        assert "消费重塑" not in texts  # 无关课被滤除

    def test_missing_pool_tolerated(self, tmp_path):
        r = collect_corpus("主题", pools={"hundun": str(tmp_path / "nope")})
        assert r["chunks"] == [] and r["stats"]["matched_files"] == 0

    def test_merge_corpus(self, tmp_path):
        pools = _make_pools(tmp_path)
        r = collect_corpus("工程", pools=pools, keywords=("工程",))
        merged = merge_corpus(r["chunks"])
        assert "==== 来源 1" in merged and "==== 来源 2" in merged


class TestNblm:
    def test_disabled_by_default(self):
        assert is_enabled({}) is False
        assert is_enabled({"foundry": {"nblm": "off"}}) is False

    def test_enabled_flag(self):
        assert is_enabled({"foundry": {"nblm": "on"}}) is True

    def test_synthesize_without_config_raises_chinese(self):
        brain = NotebookBrain({})
        with pytest.raises(RuntimeError, match="NotebookLM"):
            brain.synthesize("语料")


class TestKeywords:
    def test_llm_keywords_parsed(self):
        def fake_fast(prompt, context=""):
            return {"text": '```json\n["工程总承包", "EPC", "项目管理"]\n```'}

        assert generate_keywords("工程总承包 AI 转型", fast_fn=fake_fast) == \
            ["工程总承包", "EPC", "项目管理"]

    def test_fallback_keywords_without_llm(self):
        kws = generate_keywords("智能商业 时代 传统企业 转型")
        assert kws and all(isinstance(k, str) for k in kws)
        assert "智能商业" in kws


def _sec_json(i):
    return json.dumps({
        "framework": "SCQA", "components": ["key_points", "wbs", "case"],
        "content": (f"【关键点】第{i}节。标准化 SOP。\n【WBS 任务分解】步骤。流程化泳道。\n"
                     "【小案例】案例。数据化看板；知识化知识库沉淀。"),
    }, ensure_ascii=False)


def _toc_json():
    return json.dumps({
        "title": "管线试点方案", "chapters": [
            {"title": "第1章 诊断", "framework": "OODA 循环",
             "sections": [{"title": "1.1 现状", "framework": "SCQA"},
                          {"title": "1.2 机会", "framework": "MECE"}]}]},
        ensure_ascii=False)


class _FakeDeep:
    def __init__(self, replies):
        self.replies = list(replies)
        self.calls = []

    def __call__(self, prompt, reasoning=True):
        self.calls.append(prompt)
        return {"text": self.replies.pop(0)}


class TestPipeline:
    def test_seven_steps_end_to_end(self, tmp_path):
        pools = _make_pools(tmp_path)
        deep = _FakeDeep([_toc_json(), _sec_json(1), _sec_json(2)])

        def fast(prompt, context=""):
            return {"text": '["工程总承包", "EPC"]'}

        pipe = Pipeline(deep_fn=deep, fast_fn=fast, workdir=str(tmp_path / "work"))
        result = pipe.run("工程总承包 AI 转型 FDE 方案", pools=pools, n_chapters=1)
        assert result["plan"]["title"] == "管线试点方案"
        assert result["plan"]["passed"] is True
        assert os.path.exists(os.path.join(result["outdir"], "plan.md"))
        assert os.path.exists(os.path.join(result["outdir"], "promo.md"))
        state = json.loads(open(os.path.join(str(tmp_path / "work"), "pipeline_state.json"),
                                encoding="utf-8").read())
        assert state["step"] == "done"  # 七步走完
        assert set(state["keywords"]) == {"工程总承包", "EPC"}

    def test_resume_skips_keyword_step(self, tmp_path):
        pools = _make_pools(tmp_path)
        kw_calls = []

        def fast(prompt, context=""):
            kw_calls.append(prompt)
            return {"text": '["工程总承包"]'}

        work = str(tmp_path / "work")
        os.makedirs(work)
        # 预置关键词已完成的 state
        state = {"step": "keywords", "theme": "工程总承包 AI 转型 FDE 方案",
                 "keywords": ["工程总承包"], "chunks": ["语料A"], "n_chapters": 1}
        json.dump(state, open(os.path.join(work, "pipeline_state.json"), "w",
                              encoding="utf-8"), ensure_ascii=False)
        deep = _FakeDeep([_toc_json(), _sec_json(1), _sec_json(2)])
        pipe = Pipeline(deep_fn=deep, fast_fn=fast, workdir=work)
        result = pipe.run("工程总承包 AI 转型 FDE 方案", pools=pools, n_chapters=1)
        assert result["plan"]["title"] == "管线试点方案"
        assert kw_calls == []  # 关键词步骤被断点跳过
