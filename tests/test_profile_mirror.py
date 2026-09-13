"""M5.3 Obsidian 镜像：画像双向同步——可编辑、可回写、删行即失效。"""
from datetime import datetime

from paistation.profile.mirror import ObsidianMirror
from paistation.profile.model import ProfileModel


def _clk(fixed="2026-09-13T12:00:00"):
    now = datetime.fromisoformat(fixed)
    return lambda: now


def _profile(tmp_path):
    p = ProfileModel(tmp_path, clock=_clk())
    p.record("identity", "姓名", "宗宝")
    p.record("preference", "作息", "早睡早起")
    return p


def test_mirror_writes_layer_files(tmp_path):
    p = _profile(tmp_path)
    mirror = ObsidianMirror(profile=p, root=tmp_path / "obsidian")
    mirror.write()
    ident = tmp_path / "obsidian" / "PAI-Profile" / "identity.md"
    assert "姓名" in ident.read_text(encoding="utf-8")
    assert "宗宝" in ident.read_text(encoding="utf-8")
    pref = tmp_path / "obsidian" / "PAI-Profile" / "preference.md"
    assert "早睡早起" in pref.read_text(encoding="utf-8")


def test_mirror_edit_value_syncs_back(tmp_path):
    p = _profile(tmp_path)
    mirror = ObsidianMirror(profile=p, root=tmp_path / "obsidian")
    mirror.write()
    pref = tmp_path / "obsidian" / "PAI-Profile" / "preference.md"
    pref.write_text(pref.read_text(encoding="utf-8")
                    .replace("早睡早起", "晚睡晚起"), encoding="utf-8")
    stats = mirror.sync_back()
    assert stats["updated"] >= 1
    assert [e.value for e in p.query(keyword="作息")] == ["晚睡晚起"]
    assert len(p.history("作息", layer="preference")) == 2  # 旧值留痕


def test_mirror_delete_line_expires_entry(tmp_path):
    p = _profile(tmp_path)
    mirror = ObsidianMirror(profile=p, root=tmp_path / "obsidian")
    mirror.write()
    pref = tmp_path / "obsidian" / "PAI-Profile" / "preference.md"
    lines = [l for l in pref.read_text(encoding="utf-8").splitlines()
             if "作息" not in l]
    pref.write_text("\n".join(lines) + "\n", encoding="utf-8")
    stats = mirror.sync_back()
    assert stats["expired"] >= 1
    assert p.query(keyword="作息") == []


def test_mirror_new_line_records_entry(tmp_path):
    p = _profile(tmp_path)
    mirror = ObsidianMirror(profile=p, root=tmp_path / "obsidian")
    mirror.write()
    ident = tmp_path / "obsidian" / "PAI-Profile" / "identity.md"
    with open(ident, "a", encoding="utf-8") as fh:
        fh.write("- [new] 岗位：EPC 项目经理（置信0.8）\n")
    stats = mirror.sync_back()
    assert stats["recorded"] >= 1
    assert any(e.value == "EPC 项目经理" for e in p.query(layer="identity"))
