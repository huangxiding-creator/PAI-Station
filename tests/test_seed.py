"""M6.7 成果反推技能（FR16 指令④前半）：全自动形成，激活走晨报确认。

扫 08 成果/ → 反推方法论 → SKILL.md 候选（LLM 升级位，模板兜底）。
"""
from paistation.skills.seed import AchievementSeeder
from paistation.skills.forge import SkillForge
import pytest


def _doc(title, *sections):
    return f"# {title}\n\n" + "\n".join(
        f"## {s}\n内容若干。\n" for s in sections)


def test_scan_and_propose_template_draft(tmp_path):
    ach = tmp_path / "08 成果"
    ach.mkdir()
    (ach / "2026-09-01_EPC索赔报告.md").write_text(
        _doc("EPC 索赔报告", "索赔依据收集", "工期计算", "致函格式"),
        encoding="utf-8")
    (ach / "2026-09-02_周报.md").write_text(
        _doc("周报", "本周进展汇总", "风险提示"), encoding="utf-8")

    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    seeder = AchievementSeeder(forge)
    proposals = seeder.propose(achievements_dir=ach)
    assert len(proposals) == 2
    cand = next(c for c in proposals if "索赔" in c["name"])
    assert cand["approved"] is False                # 永不自批
    assert "索赔依据收集" in cand["draft"]          # 章节→步骤
    assert any("EPC索赔报告" in e for e in cand["evidence"])


def test_llm_slot_upgrades_draft(tmp_path):
    ach = tmp_path / "08 成果"
    ach.mkdir()
    (ach / "doc.md").write_text(_doc("定价调研", "渠道询价"), encoding="utf-8")
    forge = SkillForge(data_dir=tmp_path, repo_dir=tmp_path / "skills")

    calls = []

    def fake_llm(prompt: str) -> str:
        calls.append(prompt)
        return "第一步：锁三家供应商报价表。"

    seeder = AchievementSeeder(forge, llm=fake_llm)
    cand = seeder.propose(achievements_dir=ach)[0]
    assert calls                                    # LLM 被调用
    assert "锁三家供应商" in cand["draft"]           # LLM 产出优先


def test_promote_requires_approval_and_dedupes(tmp_path):
    ach = tmp_path / "08 成果"
    ach.mkdir()
    (ach / "doc.md").write_text(_doc("定价调研", "渠道询价"), encoding="utf-8")
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    seeder = AchievementSeeder(forge)

    cand = seeder.propose(achievements_dir=ach)[0]
    with pytest.raises(PermissionError):
        seeder.promote(cand)                        # 未批准拒绝
    seeder.promote(cand, approved=True)
    assert (repo_dir / cand["name"] / "SKILL.md").is_file()

    # 已入库的不再重复反推
    again = seeder.propose(achievements_dir=ach)
    assert again == []
