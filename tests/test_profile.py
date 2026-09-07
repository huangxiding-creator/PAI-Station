"""M4 画像层：一级事实直写、二级画像变更走双环确认。"""
import pytest

from paistation.learn.profile import Profile


@pytest.fixture
def db(tmp_path):
    return str(tmp_path / "profile.db")


def test_first_tier_facts_write_directly(db):
    p = Profile(db)
    p.note_fact("常去目录", "E:/AI-Station", source="fs_watcher", confidence=0.9)
    assert p.fact("常去目录")["value"] == "E:/AI-Station"
    assert p.fact("常去目录")["confirmed"] == 1


def test_second_tier_profile_change_needs_confirm(db):
    p = Profile(db)
    pid = p.propose_profile_change("工作风格", "深度工作偏好上午", source="distiller")
    assert p.fact("工作风格") is None            # 未确认不生效
    assert any(x["id"] == pid for x in p.pending())
    p.confirm(pid)
    assert p.fact("工作风格")["value"] == "深度工作偏好上午"


def test_reject_drops_proposal(db):
    p = Profile(db)
    pid = p.propose_profile_change("技能倾向", "数据可视化", source="learn")
    p.reject(pid)
    assert p.pending() == []
    assert p.fact("技能倾向") is None


def test_confirm_idempotent_and_unknown(db):
    p = Profile(db)
    pid = p.propose_profile_change("a", "b", source="t")
    p.confirm(pid)
    p.confirm(pid)                                # 重复确认不炸不重复
    with pytest.raises(KeyError):
        p.confirm(999)


def test_fact_update_major_tier(db):
    """已有画像被改写 = 二级变更（走确认）。"""
    p = Profile(db)
    pid = p.propose_profile_change("作息", "夜猫子", source="learn")
    p.confirm(pid)
    pid2 = p.propose_profile_change("作息", "早起型", source="learn")
    assert p.fact("作息")["value"] == "夜猫子"    # 旧值保留
    p.confirm(pid2)
    assert p.fact("作息")["value"] == "早起型"    # 确认后覆盖


def test_persistence_across_instances(db):
    p = Profile(db)
    p.note_fact("工具链", "Python", source="audit", confidence=0.8)
    pid = p.propose_profile_change("语言", "中文", source="mirror")
    p2 = Profile(db)
    assert p2.fact("工具链")["value"] == "Python"
    p2.confirm(pid)                               # 跨实例确认
    assert Profile(db).fact("语言")["value"] == "中文"


def test_profile_stats(db):
    p = Profile(db)
    p.note_fact("k1", "v1", source="s", confidence=0.5)
    p.propose_profile_change("k2", "v2", source="s")
    st = p.stats()
    assert st["facts"] == 1 and st["pending"] == 1


def test_double_loop_floor_enforced():
    """C.1 红线：double_loop_confirm 不可低于 1。"""
    with pytest.raises(ValueError):
        Profile(":memory:", double_loop_confirm=0)
