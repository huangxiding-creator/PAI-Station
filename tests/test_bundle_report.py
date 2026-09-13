"""M6.3 交付自检补充项：git 可用+首启向导完成度（doctor 集成）。"""
import json

from paistation.dist.checks import bundle_report


def test_git_and_wizard_checks(tmp_path):
    report = dict(bundle_report(data_dir=tmp_path))
    assert "git 可用" in report          # 本开发机必有 git
    assert report["git 可用"] is True
    assert report["首启向导"] is True     # 未开始=通过（doctor 先于向导跑）

    # 半途状态（写了 done:false）才是病
    (tmp_path / "wizard.json").write_text(
        json.dumps({"done": False}), encoding="utf-8")
    assert dict(bundle_report(data_dir=tmp_path))["首启向导"] is False

    (tmp_path / "wizard.json").write_text(
        json.dumps({"done": True, "tier": "mid"}), encoding="utf-8")
    assert dict(bundle_report(data_dir=tmp_path))["首启向导"] is True
