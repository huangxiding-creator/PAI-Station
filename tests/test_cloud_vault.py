"""M2.6 云连接器登录态保险库：DPAPI 加密+落盘密文+可删除。"""

from paistation.sense.cloud.vault import SessionVault


def test_vault_roundtrip(tmp_path):
    vault = SessionVault(tmp_path / "cloud_vault")
    vault.save("feishu", {"user_access_token": "u-AT123",
                          "refresh_token": "u-RT456"})
    loaded = vault.load("feishu")
    assert loaded["user_access_token"] == "u-AT123"
    assert loaded["refresh_token"] == "u-RT456"


def test_vault_ciphertext_on_disk(tmp_path):
    vault = SessionVault(tmp_path / "cloud_vault")
    vault.save("feishu", {"user_access_token": "SECRET-PLAINTEXT"})
    raw = (tmp_path / "cloud_vault" / "feishu.vault").read_bytes()
    assert b"SECRET-PLAINTEXT" not in raw   # 明文绝不落盘
    assert len(raw) > 16                    # 确有密文而非空文件


def test_vault_load_missing_returns_none(tmp_path):
    vault = SessionVault(tmp_path / "cloud_vault")
    assert vault.load("不存在") is None


def test_vault_delete(tmp_path):
    vault = SessionVault(tmp_path / "cloud_vault")
    vault.save("feishu", {"t": "x"})
    vault.delete("feishu")
    assert vault.load("feishu") is None


def test_vault_names(tmp_path):
    vault = SessionVault(tmp_path / "cloud_vault")
    vault.save("feishu", {"t": "x"})
    vault.save("bardisk", {"t": "y"})
    assert sorted(vault.names()) == ["bardisk", "feishu"]
