"""Phase A4 三向适配器：主权资产直通 Claude Code / OpenClaw / AstrBot。

判据（VISION_V4 P0 10×）：换任意 agent 资产 100% 带走、导入即用——
适配器产物必须符合目标 agent 的既有消费习惯，不要求对方装任何插件。
"""
import pytest

from paistation.sovereign.adapters import (
    astrbot,
    claude_code,
    openclaw,
)


@pytest.fixture()
def seeded(tmp_path):
    from tests.test_sovereign_protocol import _seed_data
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    return data_dir


# ---- Claude Code：CLAUDE.md + memory/*.md ----

def test_claude_code_export(seeded, tmp_path):
    dest = tmp_path / "cc"
    report = claude_code.export(seeded, dest)
    main_md = dest / "CLAUDE.md"
    assert main_md.is_file()
    body = main_md.read_text(encoding="utf-8")
    assert "宝总" in body                    # 画像进 CLAUDE.md
    assert "周报格式" in body                # 关键决策进 CLAUDE.md
    memories = list((dest / "memory").glob("*.md"))
    assert len(memories) == 2                # 每条记忆一文件
    assert report["memories"] == 2
    assert claude_code.validate(dest) is True


def test_claude_code_memory_file_carries_text(seeded, tmp_path):
    dest = tmp_path / "cc"
    claude_code.export(seeded, dest)
    joined = "\n".join(p.read_text(encoding="utf-8")
                       for p in (dest / "memory").glob("*.md"))
    assert "常驻城市：北京" in joined and "结论先行" in joined


# ---- OpenClaw：skills/ 兼容复制 + AGENTS.md ----

def test_openclaw_export(seeded, tmp_path):
    dest = tmp_path / "oc"
    report = openclaw.export(seeded, dest)
    skill_md = dest / "skills" / "weekly-report" / "SKILL.md"
    assert skill_md.is_file()
    body = skill_md.read_text(encoding="utf-8")
    assert "name: weekly-report" in body
    assert "version:" in body                # OpenClaw 兼容字段补全
    agents = dest / "AGENTS.md"
    assert agents.is_file()
    assert "宝总" in agents.read_text(encoding="utf-8")
    assert report["skills"] == 1
    assert openclaw.validate(dest) is True


# ---- AstrBot：persona_prompt.md + memories.md ----

def test_astrbot_export(seeded, tmp_path):
    dest = tmp_path / "ab"
    report = astrbot.export(seeded, dest)
    persona = dest / "persona_prompt.md"
    assert persona.is_file()
    body = persona.read_text(encoding="utf-8")
    assert "宝总" in body and "深色" in body   # 人设含身份+偏好
    memories = dest / "memories.md"
    assert "常驻城市" in memories.read_text(encoding="utf-8")
    assert report["memories"] == 2
    assert astrbot.validate(dest) is True


def test_all_adapters_validate_fail_on_empty(tmp_path):
    empty = tmp_path / "nothing"
    empty.mkdir()
    assert claude_code.validate(empty) is False
    assert openclaw.validate(empty) is False
    assert astrbot.validate(empty) is False
