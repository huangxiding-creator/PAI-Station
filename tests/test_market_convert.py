"""Phase D3 跨标准适配器（E4）：Anthropic skills / MCP / agents.md /
OpenClaw 双向转换（导入为主，一键导入=市场分发第一站）。"""
import json

import pytest

from paistation.market.convert import (
    from_openclaw,
    import_anthropic_skill,
    to_agents_md,
    to_mcp_manifest,
)


@pytest.fixture()
def anthropic_skill(tmp_path):
    d = tmp_path / "anthropic" / "pdf-report"
    d.mkdir(parents=True)
    (d / "SKILL.md").write_text(
        "---\nname: pdf-report\ndescription: PDF 报告生成\n---\n"
        "# 用法\n调 report_to_docx", encoding="utf-8")
    (d / "reference.md").write_text("# 参考", encoding="utf-8")
    return d


def test_import_anthropic_skill(anthropic_skill, tmp_path):
    data_dir = tmp_path / "data"
    r = import_anthropic_skill(anthropic_skill, data_dir)
    assert r["imported"] is True
    target = data_dir / "skills" / "pdf-report" / "SKILL.md"
    assert target.is_file()
    assert (data_dir / "skills" / "pdf-report" / "reference.md").is_file()
    assert r["eval_passed"] is True          # 一键导入且 eval 通过（验收判据）


def test_import_rejects_empty_skill(tmp_path):
    d = tmp_path / "bad"
    d.mkdir()
    (d / "SKILL.md").write_text("---\nname: x\n---\n", encoding="utf-8")
    r = import_anthropic_skill(d, tmp_path / "data")
    assert r["imported"] is False
    assert "eval" in r["reason"] or "空" in r["reason"]


def test_to_mcp_manifest(anthropic_skill):
    m = to_mcp_manifest(anthropic_skill)
    assert m["name"] == "pdf-report"
    assert "tools" in m
    assert any(t["name"] == "pdf-report" for t in m["tools"])


def test_to_agents_md(tmp_path):
    data_dir = tmp_path / "data"
    skills = data_dir / "skills"
    (skills / "a").mkdir(parents=True)
    (skills / "a" / "SKILL.md").write_text(
        "---\nname: a\ndescription: 技能甲\n---\n", encoding="utf-8")
    (skills / "b").mkdir(parents=True)
    (skills / "b" / "SKILL.md").write_text(
        "---\nname: b\ndescription: 技能乙\n---\n", encoding="utf-8")
    md = to_agents_md(skills)
    assert "技能甲" in md and "技能乙" in md
    assert "a" in md and "b" in md


def test_from_openclaw(tmp_path):
    """OpenClaw skill（无 version frontmatter）→ 本项目（补 version）。"""
    src = tmp_path / "openclaw" / "ocr-skill"
    src.mkdir(parents=True)
    (src / "SKILL.md").write_text(
        "---\nname: ocr-skill\ndescription: OCR\n---\n# OCR\n对图片做文字识别，输出纯文本。\n",
        encoding="utf-8")
    r = from_openclaw(src, tmp_path / "data")
    assert r["imported"] is True
    text = (tmp_path / "data" / "skills" / "ocr-skill" / "SKILL.md"
            ).read_text(encoding="utf-8")
    assert "version:" in text                 # 补齐 version 字段


def test_roundtrip_anthropic_to_mcp_json_serializable(anthropic_skill):
    m = to_mcp_manifest(anthropic_skill)
    json.dumps(m, ensure_ascii=False)         # 不炸即过
