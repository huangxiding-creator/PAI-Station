"""Phase A3 遗产模式：公司死了 AI 还活着（Moxie/Dot 尸检律）。"""
from paistation.sovereign.heritage import heritage_bundle
from paistation.sovereign.protocol import import_vault
from paistation.sovereign.vault import MemoryVault


def _seed(data_dir):
    from tests.test_sovereign_protocol import _seed_data
    _seed_data(data_dir)


def test_bundle_contains_vault_offline_and_heirloom(tmp_path):
    data_dir = tmp_path / "data"
    _seed(data_dir)
    bundle = tmp_path / "heritage"
    report = heritage_bundle(data_dir, bundle, heir="张三")
    assert (bundle / "vault" / "memory.md").is_file()
    assert (bundle / "OFFLINE.md").is_file()
    assert (bundle / "HEIRLOOM.md").is_file()
    assert report["files"] > 0


def test_offline_manifest_separates_local_from_cloud(tmp_path):
    data_dir = tmp_path / "data"
    _seed(data_dir)
    bundle = tmp_path / "heritage"
    heritage_bundle(data_dir, bundle)
    md = (bundle / "OFFLINE.md").read_text(encoding="utf-8")
    assert "离线可用" in md and "记忆检索" in md
    assert "需要联网" in md and "LLM" in md


def test_bundle_can_resurrect_into_fresh_install(tmp_path):
    """遗产包在全新安装上复活：资产 100% 可带走（10× 判据核心）。"""
    data_dir = tmp_path / "data"
    _seed(data_dir)
    bundle = tmp_path / "heritage"
    heritage_bundle(data_dir, bundle)
    fresh = tmp_path / "fresh"
    result = import_vault(bundle / "vault", fresh)
    assert result["memories"] == 2
    texts = [e.text for e in MemoryVault(fresh / "sovereign").entries()]
    assert any("北京" in t for t in texts)


def test_heirloom_records_inheritor(tmp_path):
    data_dir = tmp_path / "data"
    _seed(data_dir)
    bundle = tmp_path / "heritage"
    heritage_bundle(data_dir, bundle, heir="张三")
    md = (bundle / "HEIRLOOM.md").read_text(encoding="utf-8")
    assert "张三" in md
    assert "继承" in md
