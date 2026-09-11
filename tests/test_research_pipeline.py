"""M9.3 两阶段调研管线编排器 TDD（PROPOSAL_V2.md 5.2 七步）。

编排：①框架提取 ②合成 ③问题清单(≥300 门槛) ④综合调研(问题×渠道)
⑤知识炼金(结论卡) ⑥重构 ⑦验收——断点续传 + 器官凭证落链。
search_fn/llm_fn 全部注入：模型/渠道缺席时全链降级不停摆（V1 底线）。
"""
import json

from paistation.foundry.research_pipeline import ResearchPipeline


def fake_search(query: str) -> list[dict]:
    return [{"title": f"证据-{query[:8]}", "url": "https://example.com/a",
             "snippet": "片段", "source": "测试渠道"}]


def fake_llm(prompt: str) -> str:
    return "结论：测试结论。依据：三条。"


def build_frames_text():
    return "\n".join([
        "第一章 合同风险管理", "1.1 风险识别", "1.2 风险分担", "1.3 风险跟踪", "1.4 风险数据库",
        "第二章 索赔管理", "2.1 索赔程序", "2.2 索赔证据", "2.3 索赔谈判", "2.4 反索赔",
        "第三章 设计变更控制", "3.1 变更分级", "3.2 变更流程", "3.3 变更计价", "3.4 变更档案",
        "第四章 进度管理", "4.1 计划编制", "4.2 关键线路", "4.3 赶工措施", "4.4 进度纠偏",
        "第五章 质量管理", "5.1 质量策划", "5.2 过程控制", "5.3 验收标准", "5.4 缺陷责任",
        "第六章 安全与环境", "6.1 危大工程", "6.2 应急预案", "6.3 环保合规", "6.4 文明施工",
        "第七章 造价与支付", "7.1 清单计价", "7.2 计量支付", "7.3 调价公式", "7.4 结算审计",
        "第八章 争议解决", "8.1 谈判机制", "8.2 调解", "8.3 仲裁", "8.4 诉讼策略",
    ])


def test_pipeline_full_run_and_artifacts(tmp_path):
    pipe = ResearchPipeline(workdir=tmp_path, search_fn=fake_search,
                            llm_fn=fake_llm)
    result = pipe.run("测试课题", frames_texts=[build_frames_text()])
    assert result["questions"] >= 300          # 门槛过
    assert result["evidenced"] >= 300          # 每问至少 1 源（注入源）
    assert result["conclusions"] >= 300        # 每问一张结论卡
    assert result["report_path"].exists()
    manifest = json.loads((tmp_path / "测试课题" / "manifest.json")
                          .read_text(encoding="utf-8"))
    assert manifest["topic"] == "测试课题"
    assert manifest["steps"]["questions"]["done"] is True


def test_pipeline_checkpoint_resume(tmp_path):
    pipe = ResearchPipeline(workdir=tmp_path, search_fn=fake_search,
                            llm_fn=fake_llm)
    pipe.run("课题A", frames_texts=[build_frames_text()])
    calls = {"n": 0}

    def counting_search(q):
        calls["n"] += 1
        return fake_search(q)

    pipe2 = ResearchPipeline(workdir=tmp_path, search_fn=counting_search,
                             llm_fn=fake_llm)
    pipe2.run("课题A", frames_texts=[build_frames_text()])  # 重入
    assert calls["n"] == 0  # 已完成步骤不再重复检索（断点续传）


def test_pipeline_degrades_without_search_and_llm(tmp_path):
    pipe = ResearchPipeline(workdir=tmp_path)  # 无渠道无模型
    result = pipe.run("裸课题", frames_texts=[build_frames_text()])
    assert result["questions"] >= 300
    assert result["evidenced"] == 0     # 无渠道：如实记 0，不崩
    assert result["conclusions"] == 0   # 无模型：如实记 0
    assert result["report_path"] is None or result["report_path"].exists()


def test_pipeline_writes_organ_credentials(tmp_path):
    pipe = ResearchPipeline(workdir=tmp_path, search_fn=fake_search,
                            llm_fn=fake_llm, station_root=tmp_path)
    pipe.run("凭证课题", frames_texts=[build_frames_text()])
    chain = tmp_path / "04 智库" / "_credentials" / "chain.jsonl"
    assert chain.exists()
    rows = [json.loads(x) for x in chain.read_text(encoding="utf-8").splitlines()]
    assert any(r["kind"] == "frames_extracted" for r in rows)
