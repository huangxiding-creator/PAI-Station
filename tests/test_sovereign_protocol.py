"""Phase A2 主权携带协议：export / import / forget / audit 四命令。

验收对齐 PROPOSAL_V4 Phase A：①导出导入实测回放无损 ②遗忘权审计
（双时态可验「已忘且何时忘」；被忘内容不得回流活动视图）③全部动作留痕。
"""
import json

from paistation.profile.model import ProfileModel
from paistation.sovereign.format import vault_validate
from paistation.sovereign.protocol import (
    audit_vault,
    export_vault,
    forget,
    import_markdown_dir,
    import_vault,
)
from paistation.sovereign.vault import DecisionLedger, MemoryVault


def _seed_data(data_dir):
    """造一个有血有肉的数据目录：画像+记忆+决策（含被否方案）+技能。"""
    profile = ProfileModel(data_dir)
    profile.record("identity", "称呼", "宝总", source="user")
    profile.record("preference", "主题", "深色", source="first-scan")
    vault = MemoryVault(data_dir / "sovereign")
    vault.remember("常驻城市：北京", source="first-scan", tags=("身份",))
    vault.remember("周报模板偏好结论先行", source="weekly", tags=("工作",))
    ledger = DecisionLedger(data_dir / "sovereign" / "decisions")
    ledger.decide(topic="周报格式", chosen="结论先行三段式",
                  rationale="上级阅读时间少",
                  alternatives=[{"option": "流水账", "why_rejected": "可读性差"}])
    skill = data_dir / "skills" / "weekly-report"
    skill.mkdir(parents=True)
    (skill / "SKILL.md").write_text(
        "---\nname: weekly-report\ndescription: 周报锻造\n---\n# 周报\n",
        encoding="utf-8")
    return profile, vault, ledger


# ---- export ----

def test_export_produces_complete_bundle(tmp_path):
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    dest = tmp_path / "bundle"
    report = export_vault(data_dir, dest)
    assert (dest / "memory.md").is_file()
    assert list((dest / "decisions").glob("DEC-*.md"))
    assert (dest / "profile.md").is_file()          # 画像渲染视图
    assert "宝总" in (dest / "profile.md").read_text(encoding="utf-8")
    ledger_line = json.loads(
        (dest / "skills-ledger.jsonl").read_text(encoding="utf-8")
        .splitlines()[0])
    assert ledger_line["name"] == "weekly-report"
    assert report["files"] > 0
    assert vault_validate(dest)["ok"] is True       # 导出包完整性自洽


def test_export_excludes_forgotten_decisions(tmp_path):
    data_dir = tmp_path / "data"
    _, _, ledger = _seed_data(data_dir)
    dec = ledger.list_decisions()[0]
    forget(data_dir, "decision", dec.id)
    dest = tmp_path / "bundle"
    export_vault(data_dir, dest)
    assert not list((dest / "decisions").glob("DEC-*.md"))
    assert (dest / "forgotten.jsonl").is_file()     # 遗忘日志随包（可审计）


def test_export_idempotent(tmp_path):
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    first, second = tmp_path / "b1", tmp_path / "b2"
    export_vault(data_dir, first)
    export_vault(data_dir, second)
    assert (first / "memory.md").read_text(encoding="utf-8") == \
           (second / "memory.md").read_text(encoding="utf-8")


# ---- import（roundtrip 无损 + Claude Code markdown） ----

def test_import_roundtrip_lossless(tmp_path):
    src_data = tmp_path / "src"
    _seed_data(src_data)
    bundle = tmp_path / "bundle"
    export_vault(src_data, bundle)

    dst_data = tmp_path / "dst"
    result = import_vault(bundle, dst_data)
    assert result["memories"] == 2
    assert result["decisions"] == 1
    # 记忆逐条等值
    old = MemoryVault(src_data / "sovereign").entries()
    new = MemoryVault(dst_data / "sovereign").entries()
    assert [(e.ts, e.text) for e in new] == [(e.ts, e.text) for e in old]
    # 决策（active）与画像条目数一致
    assert len(DecisionLedger(dst_data / "sovereign" / "decisions")
               .list_decisions()) == 1
    assert len(ProfileModel(dst_data).query()) == 2
    # 导入后的 vault 必须自带有效 MANIFEST（干净房闸 2026-09-13 抓到的回归）
    report = vault_validate(dst_data / "sovereign")
    assert report["ok"], report
    assert not report["missing"] and not report["tampered"]


def test_import_merge_is_idempotent(tmp_path):
    src_data = tmp_path / "src"
    _seed_data(src_data)
    bundle = tmp_path / "bundle"
    export_vault(src_data, bundle)
    dst_data = tmp_path / "dst"
    import_vault(bundle, dst_data)
    again = import_vault(bundle, dst_data)          # 重复导入不翻倍
    assert again["memories"] == 0
    assert len(MemoryVault(dst_data / "sovereign").entries()) == 2


def test_import_claude_code_markdown(tmp_path):
    md_dir = tmp_path / "claude"
    md_dir.mkdir()
    (md_dir / "CLAUDE.md").write_text("# 项目记忆\n用户偏好简洁回复",
                                       encoding="utf-8")
    data_dir = tmp_path / "data"
    n = import_markdown_dir(md_dir, data_dir)
    assert n == 1
    entries = MemoryVault(data_dir / "sovereign").entries()
    assert "用户偏好简洁回复" in entries[0].text
    assert "claude-code" in entries[0].source


# ---- forget（遗忘权：双时态可审计，物理不删红线兼容） ----

def test_forget_memory_records_tombstone(tmp_path):
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    result = forget(data_dir, "memory", "常驻城市")
    assert result["forgotten"] == 1
    texts = [e.text for e in MemoryVault(data_dir / "sovereign").entries()]
    assert not any("常驻城市" in t for t in texts)  # 活动视图剔除
    tombs = json.loads(
        (data_dir / "sovereign" / "forgotten.jsonl").read_text(
            encoding="utf-8").splitlines()[0])
    assert tombs["kind"] == "memory" and tombs["actor"] == "user"
    assert "常驻城市" in tombs["snapshot"]           # 坟墓留全文（审计）


def test_forget_profile_seals_with_timestamp(tmp_path):
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    result = forget(data_dir, "profile", "主题")
    assert result["forgotten"] == 1
    sealed = [e for e in ProfileModel(data_dir).history("主题")]
    assert all(e.effective_to for e in sealed)       # 双时态封死
    assert not ProfileModel(data_dir).query(keyword="主题")


def test_forget_decision_moves_to_forgotten_dir(tmp_path):
    data_dir = tmp_path / "data"
    _, _, ledger = _seed_data(data_dir)
    dec = ledger.list_decisions()[0]
    forget(data_dir, "decision", dec.id)
    assert not ledger.list_decisions(include_superseded=True)
    assert (data_dir / "sovereign" / "decisions" / "forgotten"
            / f"{dec.id}.md").is_file()              # 本地留档不物理删


# ---- audit（遗忘合规 + 完整性 + 可证伪性一页报告） ----

def test_audit_green_when_compliant(tmp_path):
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    forget(data_dir, "memory", "常驻城市")
    report = audit_vault(data_dir, report_path=tmp_path / "audit.md")
    assert report["forget_compliance"]["violations"] == []
    assert report["integrity"]["ok"] is True
    assert report["decisions"]["active"] == 1
    assert report["profile"]["entries_active"] == 2
    assert (tmp_path / "audit.md").is_file()
    assert "常驻城市" in (tmp_path / "audit.md").read_text(encoding="utf-8")


def test_audit_catches_zombie_resurrection(tmp_path):
    """被忘内容若回流活动视图，审计必须报违规（遗忘权的硬保证）。"""
    data_dir = tmp_path / "data"
    _seed_data(data_dir)
    forget(data_dir, "memory", "常驻城市")
    # 人为复活（模拟污染/回滚事故）
    vault = MemoryVault(data_dir / "sovereign")
    vault.remember("常驻城市：北京", source="first-scan", tags=("身份",))
    report = audit_vault(data_dir)
    violated = [v for v in report["forget_compliance"]["violations"]]
    assert violated and violated[0]["kind"] == "memory"
