"""Phase D2 git-native 市场协议：发布=push / 安装=add+版本缓存+依赖白名单。

签名 skill card（发布者可验）；依赖白名单=安装闸（不认识的依赖不装）。
"""
import pytest

from paistation.market.protocol import install, list_installed, publish, verify_bundle


@pytest.fixture()
def skill_dir(tmp_path):
    d = tmp_path / "skill-src" / "weekly-report"
    d.mkdir(parents=True)
    (d / "SKILL.md").write_text(
        "---\nname: weekly-report\ndescription: 周报锻造\nversion: 1.2\n---\n"
        "# 周报\n结论先行", encoding="utf-8")
    return d


def _publish(skill_dir, tmp_path, depends=None, signer=b"market-key"):
    dest = tmp_path / "market"
    return publish(skill_dir, dest, signer=signer,
                   depends=depends or [], eval_result={"hit": 40, "miss": 0})


def test_publish_creates_signed_bundle(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path)
    assert (bundle / "SKILL.md").is_file()
    card = bundle / "card.json"
    assert card.is_file()
    import json

    meta = json.loads(card.read_text(encoding="utf-8"))
    assert meta["name"] == "weekly-report"
    assert meta["version"] == "1.2"
    assert meta["eval_result"]["hit"] == 40
    assert meta["signature"].startswith("hmac-sha256:")


def test_verify_bundle_ok(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path)
    assert verify_bundle(bundle, secret=b"market-key") is True


def test_verify_bundle_tamper_fails(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path)
    target = bundle / "SKILL.md"
    target.write_text(target.read_text(encoding="utf-8") + "\n篡改", encoding="utf-8")
    assert verify_bundle(bundle, secret=b"market-key") is False


def test_install_to_skills_with_cache(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path)
    data_dir = tmp_path / "data"
    report = install(bundle, data_dir, secret=b"market-key", allowed_deps=[])
    assert report["installed"] is True
    installed = data_dir / "skills" / "weekly-report" / "SKILL.md"
    assert installed.is_file()
    # 版本缓存（更新=pull 的基础）
    cache = data_dir / "skills-cache" / "weekly-report" / "1.2" / "SKILL.md"
    assert cache.is_file()
    assert list_installed(data_dir) == [("weekly-report", "1.2")]


def test_install_blocked_by_dependency_whitelist(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path, depends=["unknown-lib"])
    data_dir = tmp_path / "data"
    report = install(bundle, data_dir, secret=b"market-key", allowed_deps=[])
    assert report["installed"] is False
    assert "依赖" in report["reason"]
    assert not (data_dir / "skills" / "weekly-report").exists()


def test_install_allows_whitelisted_dependency(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path, depends=["safe-lib"])
    report = install(bundle, tmp_path / "data", secret=b"market-key", allowed_deps=["safe-lib"])
    assert report["installed"] is True


def test_install_rejects_bad_signature(skill_dir, tmp_path):
    bundle = _publish(skill_dir, tmp_path)
    (bundle / "card.json").write_text(
        (bundle / "card.json").read_text(encoding="utf-8").replace("1.2", "9.9"),
        encoding="utf-8")
    report = install(bundle, tmp_path / "data", secret=b"market-key", allowed_deps=[])
    assert report["installed"] is False
    assert "签名" in report["reason"]
