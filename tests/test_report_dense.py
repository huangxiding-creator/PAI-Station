"""M9.5b 节级综合 TDD：解析/组装/报告（纯函数，不碰 GLM）。"""
import re

from paistation.foundry.report_dense import (
    assemble_report_md,
    build_dense_doc,
    keyword_components,
    merge_components,
    parse_synthesis,
)

_SYNTH = """综合：EPC 模式下工程变更是责任与风险分配的核心机制，各方须依流程处置。
标准：FIDIC 银皮书 4.1 条与国内合同范本对变更程序有明确约定。
流程：变更识别→影响评估→指令签发→计价调整四步。
数据：变更占比与工期影响须以量化指标追踪。
沉淀：建议建变更案例库并纳入季度复盘。
案例：某项目业主口头指令变更引发索赔争议。
组件：case, flowchart"""


def test_parse_synthesis_fields_and_components():
    out = parse_synthesis(_SYNTH)
    assert out["components"] == ["case", "flowchart"]
    assert "综合：EPC 模式下" in out["content"]
    assert "案例：某项目" in out["content"]
    # 四前提标记词随内容落地（密度计可检）
    for marker in ("标准", "流程", "指标", "沉淀"):
        assert marker in out["content"]


def test_parse_synthesis_invalid_components_dropped():
    out = parse_synthesis("综合：x\n组件：nonsense, case, case")
    assert out["components"] == ["case"]


def test_parse_synthesis_garbage_falls_back_to_raw():
    out = parse_synthesis("完全无格式的模型输出")
    assert out["content"] == "完全无格式的模型输出"
    assert out["components"] == []


def test_keyword_and_merge_components():
    assert "case" in keyword_components("本节含案例与流程")
    assert merge_components(["case"], ["flowchart", "case", "wbs"]) == \
        ["case", "flowchart"]


def _master():
    return [
        {"id": "1", "level": "章", "title": "第一章 概述"},
        {"id": "1.1", "level": "节", "title": "1.1 合同风险"},
        {"id": "1.2", "level": "节", "title": "1.2 索赔管理"},
    ]


def test_build_dense_doc_marks_missing_as_pending():
    doc = build_dense_doc("课题", _master(), {"1.1": parse_synthesis(_SYNTH)})
    secs = doc["chapters"][0]["sections"]
    assert secs[0]["content"].startswith("综合：")
    assert secs[0]["components"] == ["case", "flowchart"]
    assert "待证" in secs[1]["content"] and secs[1]["components"] == []


def test_assemble_report_md_has_three_level_structure():
    doc = build_dense_doc("课题", _master(), {"1.1": parse_synthesis(_SYNTH)})
    md = assemble_report_md(doc, {"nodes": 3, "questions": 600,
                                  "evidenced": 599, "conclusions": 600})
    assert len(re.findall(r"^## ", md, re.M)) == 1
    assert len(re.findall(r"^### ", md, re.M)) == 2
    assert "问题：600" in md
