"""M6.5 效果跟踪+回滚（FR10b 指令①）：批准≠终点。

滚动成功率 vs 基线 → 劣化出回滚建议任务卡 → 一键回滚+基线重置。
"""
import pytest

from paistation.skills.effects import EffectTracker
from paistation.skills.forge import SkillForge


def _mk_skill_v2(tmp_path):
    """升格两版技能，返回 (forge, name)。"""
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    for i in range(3):
        forge.record_case({"ts": f"2026-09-13T1{i}:00:00",
                           "task_title": f"归档合同{i}", "skill": None,
                           "approach": "手工", "outcome": "success",
                           "duration_s": 60, "artifacts": []})
    cand = forge.propose()[0]
    forge.promote(cand, approved=True)
    cand2 = dict(cand, draft=cand["draft"] + "\n## v2\n激进批量模式。\n")
    forge.promote(cand2, approved=True)
    return forge, cand["name"]


def test_healthy_skill_no_suggestion(tmp_path):
    forge, name = _mk_skill_v2(tmp_path)
    tracker = EffectTracker(data_dir=tmp_path, repo=forge.repo)
    tracker.record(name, True, "任务A")
    tracker.set_baseline(name, 0.8)
    for i in range(5):                    # 4/5 = 0.8，不劣化
        tracker.record(name, i > 0, f"任务{i}")
    assert tracker.suggest_rollbacks() == []


def test_degraded_skill_suggests_rollback(tmp_path):
    forge, name = _mk_skill_v2(tmp_path)
    tracker = EffectTracker(data_dir=tmp_path, repo=forge.repo)
    tracker.set_baseline(name, 0.8)
    for i in range(5):                    # 0/5 = 0.0，重度劣化
        tracker.record(name, False, f"任务{i}")
    suggestions = tracker.suggest_rollbacks()
    assert len(suggestions) == 1
    s = suggestions[0]
    assert s["skill"] == name
    assert s["rate"] == 0.0
    assert s["baseline"] == 0.8
    assert s["previous_tag"].endswith("/v1")     # 回退目标=上一版
    assert "回滚" in s["title"]


def test_rollback_resets_baseline_and_restores_v1(tmp_path):
    forge, name = _mk_skill_v2(tmp_path)
    tracker = EffectTracker(data_dir=tmp_path, repo=forge.repo)
    v1 = (tmp_path / "skills" / name / "SKILL.md").read_text(encoding="utf-8")
    forge.promote(dict(name=name, kind="repetition",
                       draft=v1 + "\n## v3\n更糟。\n", evidence=["e"]),
                  approved=True)
    v3 = (tmp_path / "skills" / name / "SKILL.md").read_text(encoding="utf-8")
    assert v3 != v1

    tracker.set_baseline(name, 0.9)
    for i in range(5):
        tracker.record(name, False, f"任务{i}")

    assert tracker.rollback(name) is True
    now = (tmp_path / "skills" / name / "SKILL.md").read_text(encoding="utf-8")
    assert now == v1                              # 内容回 v1
    assert tracker.suggest_rollbacks() == []      # 基线已重置不再刷屏


def test_insufficient_samples_no_suggestion(tmp_path):
    forge, name = _mk_skill_v2(tmp_path)
    tracker = EffectTracker(data_dir=tmp_path, repo=forge.repo)
    tracker.set_baseline(name, 0.9)
    tracker.record(name, False, "仅一次")
    assert tracker.suggest_rollbacks() == []      # 样本不足不武断
