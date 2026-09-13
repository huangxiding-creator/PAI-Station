"""Phase A1 主权库：格式规范 + 记忆库 + 决策记忆（含被否方案）。

主权语义（VISION_V4 P0）：markdown 为源、人机双读、append-only 时间线、
决策记忆必含被否方案与理由（obra/episodic-memory 语义）、supersede 链可溯、
复盘可回填（三线复盘之「回头验证」）。时钟可注入；含不注入集成测试
（测试夹具时钟陷阱铁律）。
"""
from pathlib import Path

from paistation.sovereign.format import (
    SOVEREIGN_SPEC_VERSION,
    build_manifest,
    vault_validate,
)
from paistation.sovereign.vault import DecisionLedger, MemoryVault

# ---- MemoryVault：markdown 为源的记忆库 ----

def test_remember_writes_human_readable_markdown(tmp_path):
    vault = MemoryVault(tmp_path)
    entry = vault.remember("用户偏好深色模式", source="first-scan",
                           tags=("偏好",))
    md = (tmp_path / "memory.md").read_text(encoding="utf-8")
    assert entry.text == "用户偏好深色模式"
    assert "用户偏好深色模式" in md          # 人可读
    assert entry.ts in md                    # 时间戳可溯
    assert "#偏好" in md                     # 标签随行


def test_memory_is_append_only(tmp_path):
    vault = MemoryVault(tmp_path)
    vault.remember("第一条", source="t")
    vault.remember("第二条", source="t")
    md = (tmp_path / "memory.md").read_text(encoding="utf-8")
    assert md.index("第一条") < md.index("第二条")  # 时间线单调


def test_remember_identical_is_idempotent(tmp_path):
    vault = MemoryVault(tmp_path)
    first = vault.remember("同一条", source="s")
    again = vault.remember("同一条", source="s")
    assert first.ts == again.ts
    assert len(vault.entries()) == 1


def test_entries_reload_from_disk(tmp_path):
    vault = MemoryVault(tmp_path)
    vault.remember("持久化条目", source="s", tags=("a", "b"))
    reopened = MemoryVault(tmp_path)          # 不注入时钟（陷阱铁律）
    entries = reopened.entries()
    assert len(entries) == 1
    assert entries[0].text == "持久化条目"
    assert set(entries[0].tags) == {"a", "b"}
    assert entries[0].source == "s"


def test_search_by_keyword(tmp_path):
    vault = MemoryVault(tmp_path)
    vault.remember("常驻城市：北京", source="s")
    vault.remember("偏好深色模式", source="s")
    hits = vault.search("北京")
    assert len(hits) == 1 and "北京" in hits[0].text


def test_multiline_text_roundtrip(tmp_path):
    vault = MemoryVault(tmp_path)
    vault.remember("第一行\n第二行", source="s")
    assert MemoryVault(tmp_path).entries()[0].text == "第一行\n第二行"


# ---- DecisionLedger：决策记忆（被否方案是一等公民） ----

def test_decide_creates_file_with_rejected_alternatives(tmp_path):
    ledger = DecisionLedger(tmp_path / "decisions")
    dec = ledger.decide(
        topic="V4 技术底座继续用 Python",
        chosen="延续 V3 Python 单机底座",
        rationale="871 tests 资产复利；单人维护带宽",
        alternatives=[
            {"option": "重写为 Rust", "why_rejected": "开发带宽不支持重铸"},
            {"option": "迁移 Electron", "why_rejected": "违背本地轻量原则"},
        ],
    )
    path = tmp_path / "decisions" / f"{dec.id}.md"
    assert path.is_file()
    body = path.read_text(encoding="utf-8")
    assert dec.id.startswith("DEC-") and dec.id.endswith("-01")
    assert dec.status == "active"
    assert "重写为 Rust" in body and "开发带宽不支持重铸" in body  # 被否方案+理由
    assert "871 tests" in body                                     # 决策理由


def test_decision_ids_increment_per_day(tmp_path):
    ledger = DecisionLedger(tmp_path / "decisions")
    a = ledger.decide(topic="A", chosen="a", rationale="r")
    b = ledger.decide(topic="B", chosen="b", rationale="r")
    assert a.id.endswith("-01") and b.id.endswith("-02")


def test_supersede_chains_decisions(tmp_path):
    ledger = DecisionLedger(tmp_path / "decisions")
    old = ledger.decide(topic="旧路线", chosen="x", rationale="r")
    new = ledger.supersede(old.id, topic="新路线", chosen="y",
                           rationale="证据变化", why="外部证据推翻前提")
    assert new.supersedes == old.id
    assert old.id.endswith("-01") and new.id.endswith("-02")
    # 旧决策文件被标记，链可追溯
    refreshed = ledger.get(old.id)
    assert refreshed.status == "superseded"
    assert refreshed.superseded_by == new.id
    # 新决策正文记录为何推翻前任
    assert "外部证据推翻前提" in (tmp_path / "decisions"
                                / f"{new.id}.md").read_text(encoding="utf-8")


def test_review_backfills_outcome(tmp_path):
    ledger = DecisionLedger(tmp_path / "decisions")
    dec = ledger.decide(topic="试运行任务级进化", chosen="启用",
                        rationale="验证代谢制")
    ledger.review(dec.id, outcome="验证成功：进化周期压到任务级",
                  evidence="RUN_LEDGER 2026-09-13")
    body = (tmp_path / "decisions" / f"{dec.id}.md").read_text(encoding="utf-8")
    assert "验证成功" in body and "RUN_LEDGER" in body


def test_list_filters_active(tmp_path):
    ledger = DecisionLedger(tmp_path / "decisions")
    a = ledger.decide(topic="A", chosen="a", rationale="r")
    ledger.decide(topic="B", chosen="b", rationale="r")
    ledger.supersede(a.id, topic="A2", chosen="a2", rationale="r", why="w")
    active = [d.topic for d in ledger.list_decisions()]
    assert "B" in active and "A" not in active
    assert len(ledger.list_decisions(include_superseded=True)) == 3


# ---- format：规范版本 + MANIFEST 指纹 + 校验 ----

def _seed_vault(root: Path) -> Path:
    vault = MemoryVault(root)
    vault.remember("条目一", source="t")
    ledger = DecisionLedger(root / "decisions")
    ledger.decide(topic="D", chosen="c", rationale="r")
    return root


def test_spec_version_is_declared():
    assert SOVEREIGN_SPEC_VERSION == "1.0"


def test_manifest_fingerprints_all_files(tmp_path):
    root = _seed_vault(tmp_path)
    manifest = build_manifest(root)
    assert manifest["spec"] == SOVEREIGN_SPEC_VERSION
    assert manifest["files"]                    # 非空：memory.md + decisions/*
    assert (root / "MANIFEST.json").is_file()
    assert "memory.md" in manifest["files"]


def test_validate_passes_on_consistent_vault(tmp_path):
    root = _seed_vault(tmp_path)
    build_manifest(root)
    report = vault_validate(root)
    assert report["ok"] is True
    assert report["tampered"] == [] and report["missing"] == []


def test_validate_detects_tampering(tmp_path):
    root = _seed_vault(tmp_path)
    build_manifest(root)
    # 篡改记忆正文（指纹必失配）
    mem = root / "memory.md"
    mem.write_text(mem.read_text(encoding="utf-8") + "\n被篡改的内容",
                   encoding="utf-8")
    report = vault_validate(root)
    assert report["ok"] is False
    assert "memory.md" in report["tampered"]


def test_validate_flags_missing_required_files(tmp_path):
    report = vault_validate(tmp_path)           # 空目录
    assert report["ok"] is False
    assert report["missing"]
