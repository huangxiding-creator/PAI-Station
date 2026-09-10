# M7.2 双产品生成器：整案编排/断点续传/渲染/DOCX（提案 M7 §4）
import json
import os

import pytest

from paistation.foundry.export_docx import plan_to_docx
from paistation.foundry.fde import (
    FDE_COVERAGE,
    compose_plan,
    digest_markdown,
    render_markdown,
    save_plan,
)
from paistation.foundry.prompts import toc_prompt
from paistation.foundry.reconstructor import Reconstructor
from paistation.foundry.report import REPORT_COVERAGE, generate_report


def _sec_json(marker):
    return json.dumps({
        "framework": "SCQA",
        "components": ["key_points", "wbs", "case"],
        "content": (f"【关键点】{marker}。标准化 SOP。\n【WBS 任务分解】步骤一二三。流程化泳道。\n"
                     "【小案例】某公司照做见效。数据化看板；知识化知识库沉淀。"),
    }, ensure_ascii=False)


def _toc_json():
    return json.dumps({
        "title": "试点方案",
        "chapters": [{"title": "第1章 诊断", "framework": "OODA 循环",
                      "sections": [{"title": "1.1 现状", "framework": "SCQA"},
                                   {"title": "1.2 机会", "framework": "MECE"}]}],
    }, ensure_ascii=False)


class _FakeDeep:
    def __init__(self, replies):
        self.replies = list(replies)
        self.calls = []

    def __call__(self, prompt, reasoning=True):
        self.calls.append(prompt)
        return {"text": self.replies.pop(0)}


class TestDigest:
    def test_digest_keeps_headings_and_leads(self):
        md = ("# 书名\n\n引言段落。\n\n更多引言。\n\n## 第一章\n\n"
              "第一章第一段很重要。\n\n第一章第二段应被略去。\n\n## 第二章\n\n第二章要点。")
        d = digest_markdown(md)
        assert "# 书名" in d and "## 第一章" in d
        assert "引言段落" in d and "第一章第一段" in d
        assert "第一章第二段" not in d

    def test_digest_truncates(self):
        md = "\n\n".join(f"## 章{i}\n\n{'很长的段落' * 50}" for i in range(200))
        assert len(digest_markdown(md, max_chars=5000)) <= 6000


class TestComposePlan:
    def test_happy_path(self, tmp_path):
        fake = _FakeDeep([_toc_json(), _sec_json("甲"), _sec_json("乙")])
        ckpt = tmp_path / "plan.ckpt.json"
        plan = compose_plan(Reconstructor(fake), "主题", corpus="语料",
                            checkpoint_path=str(ckpt))
        assert plan["title"] == "试点方案"
        secs = plan["chapters"][0]["sections"]
        assert secs[0]["content"] and secs[1]["content"]
        assert "score" in plan and "passed" in plan and "failures" in plan
        assert fake.calls and len(fake.calls) == 3  # 目录1 + 节2
        assert not ckpt.exists()  # 完工清除断点

    def test_checkpoint_resume_skips_done(self, tmp_path):
        ckpt = tmp_path / "plan.ckpt.json"
        done_sec = {"title": "1.1 现状", "framework": "SCQA",
                    "components": ["case"], "content": "断点里的完成节。标准化SOP。",
                    "degraded": False, "degrade_note": ""}
        ckpt.write_text(json.dumps({"第1章 诊断||1.1 现状": done_sec}, ensure_ascii=False),
                        encoding="utf-8")
        fake = _FakeDeep([_toc_json(), _sec_json("乙")])
        plan = compose_plan(Reconstructor(fake), "主题", corpus="语料",
                            checkpoint_path=str(ckpt))
        assert len(fake.calls) == 2  # 只补未完成的 1.2
        assert plan["chapters"][0]["sections"][0]["content"] == "断点里的完成节。标准化SOP。"

    def test_checkpoint_written_midway(self, tmp_path):
        ckpt = tmp_path / "plan.ckpt.json"

        class _Boom(_FakeDeep):
            def __call__(self, prompt, reasoning=True):
                if len(self.calls) == 2:  # 第二节生成时崩，验证第一节已落盘
                    raise RuntimeError("模拟中断")
                return super().__call__(prompt, reasoning)

        fake = _Boom([_toc_json(), _sec_json("甲"), _sec_json("乙")])
        with pytest.raises(RuntimeError, match="模拟中断"):
            compose_plan(Reconstructor(fake), "主题", corpus="语料",
                         checkpoint_path=str(ckpt))
        saved = json.loads(ckpt.read_text(encoding="utf-8"))
        assert "第1章 诊断||1.1 现状" in saved["sections"]
        assert saved["toc"]["title"] == "试点方案"  # 目录随断点保存

    def test_resume_with_saved_toc_skips_toc_call(self, tmp_path):
        """续跑不重掷目录：章题漂移会让已完成的节 key 失配（实跑教训）。"""
        ckpt = tmp_path / "plan.ckpt.json"
        done_sec = {"title": "1.1 现状", "framework": "SCQA",
                    "components": ["case"], "content": "完成节。标准化SOP。",
                    "degraded": False, "degrade_note": ""}
        state = {"theme": "主题", "toc": json.loads(_toc_json()),
                 "sections": {"第1章 诊断||1.1 现状": done_sec}}
        ckpt.write_text(json.dumps(state, ensure_ascii=False), encoding="utf-8")
        fake = _FakeDeep([_sec_json("乙")])  # 只该有 1 次节调用，无目录调用
        plan = compose_plan(Reconstructor(fake), "主题", corpus="语料",
                            checkpoint_path=str(ckpt))
        assert len(fake.calls) == 1
        assert plan["title"] == "试点方案"  # 复用断点目录，非重掷


class TestRender:
    def _plan(self):
        fake = _FakeDeep([_toc_json(), _sec_json("甲"),
                          _sec_json("乙")])
        return compose_plan(Reconstructor(fake), "主题", corpus="语料")

    def test_markdown_structure(self):
        md = render_markdown(self._plan())
        assert "# 试点方案" in md
        assert "章框架：OODA 循环" in md
        assert "### 1.1 现状" in md and "【关键点】" in md

    def test_degrade_note_visible(self):
        plan = self._plan()
        plan["chapters"][0]["sections"][1]["degraded"] = True
        plan["chapters"][0]["sections"][1]["degrade_note"] = "降级：本节未达密度阈值"
        md = render_markdown(plan)
        assert "降级：本节未达密度阈值" in md  # 不假完成，明示读者

    def test_save_plan(self, tmp_path):
        plan = self._plan()
        jp, mp = save_plan(plan, str(tmp_path))
        assert os.path.exists(jp) and os.path.exists(mp)
        assert json.loads(open(jp, encoding="utf-8").read())["title"] == "试点方案"

    def test_plan_to_docx(self, tmp_path):
        out = str(tmp_path / "plan.docx")
        plan_to_docx(self._plan(), out)
        assert os.path.getsize(out) > 5000


class TestCoverage:
    def test_custom_coverage_reaches_toc_prompt(self):
        p = toc_prompt("主题", corpus="", cards_l1=[], n_chapters=5,
                       coverage="议题定义 → 调研全景 → 逻辑重构")
        assert "调研全景" in p

    def test_fde_and_report_coverage_differ(self):
        assert FDE_COVERAGE != REPORT_COVERAGE
        assert "机会" in FDE_COVERAGE and "调研全景" in REPORT_COVERAGE

    def test_report_generate_uses_report_coverage(self):
        fake = _FakeDeep([_toc_json(), _sec_json("甲"), _sec_json("乙")])
        plan = generate_report(Reconstructor(fake), "主题", corpus="语料")
        assert "调研全景" in fake.calls[0]  # 目录提示词带研究报告覆盖线
        assert plan["chapters"]  # 其余编排与 FDE 同内核
