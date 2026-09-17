# -*- coding: utf-8 -*-
"""P0 主权卷宗测试：OKF 条目/三源构建/导出自包含/git 版本化（全离线）。"""
import json

import pytest

from paistation.sovereign.dossier import (
    OkfEntry, build_dossier, commit_snapshot, export_dossier, init_repo,
    iter_entries, parse_entry, repo_status, write_entry,
)
from paistation.sovereign.format import manifest_validate


# ── OKF 条目 ────────────────────────────────────────────────────────
def test_entry_render_parse_roundtrip():
    e = OkfEntry(meta={"id": "abc123", "kind": "profile", "layer": "preference",
                      "effective_to": None, "tags": ["工具", "深色"]},
                 body="偏好 VSCode 深色主题")
    text = e.render()
    assert text.startswith("---") and "偏好 VSCode" in text
    back = parse_entry(text)
    assert back.id == "abc123" and back.meta["effective_to"] is None
    assert back.meta["tags"] == ["工具", "深色"] and back.body.endswith("深色主题")


def test_parse_entry_rejects_bad():
    assert parse_entry("无 frontmatter 正文") is None
    assert parse_entry("---\n[broken: yaml\n---\n正文") is None


def test_iter_entries_skips_non_entries(tmp_path):
    write_entry(tmp_path / "a" / "x.md",
                OkfEntry(meta={"id": "i1", "kind": "memory"}, body="hi"))
    (tmp_path / "a" / "plain.md").write_text("# 无 frontmatter", encoding="utf-8")
    found = list(iter_entries(tmp_path))
    assert [e.id for _, e in found] == ["i1"]


# ── 三源构建 ────────────────────────────────────────────────────────
@pytest.fixture()
def data_env(tmp_path):
    """data_dir（profile+sovereign vault）+ 同级 SELF_PROFILE + 金标准。"""
    data = tmp_path / "data"
    (data / "profile").mkdir(parents=True)
    entries = [
        {"id": "e1", "layer": "identity", "key": "职业", "value": "水利工程从业者",
         "confidence": 0.9, "source": "browser", "effective_from": "2026-09-13T10:00",
         "effective_to": None, "created_at": "2026-09-13T10:00"},
        {"id": "e2", "layer": "preference", "key": "主题", "value": "深色模式",
         "confidence": 0.7, "source": "", "effective_from": "2026-09-13T10:00",
         "effective_to": "2026-09-14T10:00", "created_at": "2026-09-13T10:00"},
    ]
    (data / "profile" / "entries.jsonl").write_text(
        "\n".join(json.dumps(e) for e in entries), encoding="utf-8")
    from paistation.sovereign.vault import MemoryVault
    MemoryVault(data / "sovereign").remember("用户偏好串行采集", source="t", tags=("采集",))
    sp = tmp_path / "SELF_PROFILE"
    sp.mkdir()
    (sp / "画像报告.md").write_text("# 画像", encoding="utf-8")
    ev = tmp_path / "golden.jsonl"
    ev.write_text('{"q": 1}\n{"q": 2}\n', encoding="utf-8")
    return data, sp, ev


def test_build_dossier_three_sources(tmp_path, data_env):
    data, sp, ev = data_env
    dest = tmp_path / "dossier"
    report = build_dossier(data, dest, self_profile_dir=sp, eval_sources=[ev])
    assert report["profile"] == 2 and report["memory"] == 1
    assert report["evals"] == 2 and report["evidence"] == 1
    assert (dest / "DOSSIER.md").is_file()
    # 双时间线保留：封口条目 effective_to 有值
    e2 = parse_entry((dest / "profile" / "preference" / "e2.md")
                     .read_text(encoding="utf-8"))
    assert e2.meta["effective_to"] == "2026-09-14T10:00"
    # 记忆转录：正文含原文+tags
    mem_files = list((dest / "memory").glob("*.md"))
    assert len(mem_files) == 1
    assert "串行采集" in mem_files[0].read_text(encoding="utf-8")
    # 金标准复制+索引
    assert (dest / "evals" / "golden.jsonl").is_file()
    assert "golden.jsonl" in (dest / "evals" / "INDEX.md").read_text(encoding="utf-8")


def test_export_selfcontained_and_verifiable(tmp_path, data_env):
    data, sp, ev = data_env
    dest = tmp_path / "export-pkg"
    report = export_dossier(data, dest, self_profile_dir=sp, eval_sources=[ev])
    pkg_vault = dest / "vault"
    # evidence 物化（导出包自包含：编目→全文）
    assert (pkg_vault / "evidence" / "画像报告.md").read_text(
        encoding="utf-8").startswith("# 画像")
    assert (dest / "README.md").is_file() and (dest / "MANIFEST.json").is_file()
    # 验收判据：无 PAI-Station 机器人可读可 grep——纯文本+可验证
    check = manifest_validate(dest)
    assert check["ok"], check
    all_text = "".join(p.read_text(encoding="utf-8")
                       for p in dest.rglob("*") if p.is_file() and p.suffix in (".md", ".jsonl"))
    assert "水利工程从业者" in all_text and "深色模式" in all_text
    with pytest.raises(FileExistsError):
        export_dossier(data, dest, self_profile_dir=sp, eval_sources=[ev])


# ── git 版本化 ──────────────────────────────────────────────────────
def test_repo_init_commit_status(tmp_path):
    d = tmp_path / "dossier"
    d.mkdir()
    assert init_repo(d) is True and init_repo(d) is False  # 幂等
    assert commit_snapshot(d, "empty") == ""               # 无变更零提交
    (d / "DOSSIER.md").write_text("v1", encoding="utf-8")
    sha1 = commit_snapshot(d, "snapshot 1")
    assert sha1
    (d / "DOSSIER.md").write_text("v2", encoding="utf-8")
    st = repo_status(d)
    assert st["initialized"] and st["commits"] == 1 and st["dirty"]
    sha2 = commit_snapshot(d, "snapshot 2")
    assert sha2 != sha1
    assert repo_status(d)["commits"] == 2 and not repo_status(d)["dirty"]
