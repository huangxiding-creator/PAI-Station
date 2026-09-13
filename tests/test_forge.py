"""M6.4 技能锻造：案例层+四信号+提案（永不自批）+git 版本化+回滚。

技能库本体=git 仓库（ADR-10）：升格=commit+tag，回滚=checkout。
"""
import pytest

from paistation.skills.forge import CaseLog, SkillForge, SkillRepo


def _case(title, outcome, ts="2026-09-13T10:00:00"):
    return {"ts": ts, "task_title": title, "skill": None,
            "approach": "手工完成", "outcome": outcome,
            "duration_s": 120, "artifacts": []}


# ---- 案例层 ----

def test_caselog_append_and_recent(tmp_path):
    log = CaseLog(tmp_path)
    log.append(_case("调研A", "success"))
    log.append(_case("调研B", "failure"))
    recent = log.recent(limit=10)
    assert len(recent) == 2
    assert recent[0]["outcome"] == "success"


# ---- 信号 ----

def test_repetition_signal_fires_on_third_similar(tmp_path):
    forge = SkillForge(data_dir=tmp_path, repo_dir=tmp_path / "skills")
    for i in range(3):
        forge.record_case(_case(f"调研一下腾讯会议定价{i}", "success",
                                ts=f"2026-09-13T1{i}:00:00"))
    signals = forge.signals()
    rep = [s for s in signals if s["kind"] == "repetition"]
    assert rep and rep[0]["count"] == 3


def test_failure_then_success_signal(tmp_path):
    forge = SkillForge(data_dir=tmp_path, repo_dir=tmp_path / "skills")
    forge.record_case(_case("整理发票", "failure", ts="2026-09-13T10:00:00"))
    forge.record_case(_case("整理发票", "success", ts="2026-09-13T11:00:00"))
    signals = forge.signals()
    fix = [s for s in signals if s["kind"] == "failure_to_success"]
    assert fix and "整理发票" in fix[0]["title"]


# ---- 提案与升格闸 ----

def test_propose_returns_unapproved_candidate(tmp_path):
    forge = SkillForge(data_dir=tmp_path, repo_dir=tmp_path / "skills")
    for i in range(3):
        forge.record_case(_case(f"归档合同扫描件{i}", "success"))
    proposals = forge.propose()
    assert proposals
    cand = proposals[0]
    assert cand["approved"] is False            # 永不自批（R15）
    assert "SKILL.md" in cand["draft"] or "skill" in cand["draft"].lower()
    assert cand["evidence"]


def test_promote_without_approval_refused(tmp_path):
    forge = SkillForge(data_dir=tmp_path, repo_dir=tmp_path / "skills")
    for i in range(3):
        forge.record_case(_case(f"归档合同{i}", "success"))
    cand = forge.propose()[0]
    with pytest.raises(PermissionError):
        forge.promote(cand)                     # 未批准直接拒


def test_promote_with_approval_versions_and_rolls_back(tmp_path):
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    for i in range(3):
        forge.record_case(_case(f"归档合同{i}", "success"))
    cand = forge.propose()[0]
    forge.promote(cand, approved=True)          # v1
    skill_md = repo_dir / cand["name"] / "SKILL.md"
    v1 = skill_md.read_text(encoding="utf-8")
    assert "归档" in v1

    # 升级 v2：内容变了
    cand2 = dict(cand, draft=v1 + "\n## v2 补充\n批量模式注意事项。\n")
    forge.promote(cand2, approved=True)
    assert "v2 补充" in skill_md.read_text(encoding="utf-8")
    tags = forge.repo.tags(cand["name"])
    assert len(tags) >= 2

    # 回滚到 v1（FR10b）
    forge.repo.rollback(cand["name"], tags[-2])
    assert skill_md.read_text(encoding="utf-8") == v1
