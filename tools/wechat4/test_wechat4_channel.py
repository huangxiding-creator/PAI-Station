"""wechat4 渠道桥接件单测（合成夹具，零微信依赖）。

照抄上游 test_wechat4_source 的合成夹具模式：monkeypatch discovery 与
加密层，绝不碰真机微信库。跑法:
  python -m pytest tools/wechat4/test_wechat4_channel.py -v
"""

from __future__ import annotations

import importlib.util
import sys
from pathlib import Path

import pytest

_MODULE_PATH = Path(__file__).resolve().parent / "wechat4_channel.py"
_SPEC = importlib.util.spec_from_file_location("wechat4_channel", _MODULE_PATH)


@pytest.fixture()
def channel(monkeypatch, tmp_path):
    """加载桥接件模块并把 SECRETS_DIR 指到临时目录。"""
    module = importlib.util.module_from_spec(_SPEC)
    sys.modules["wechat4_channel"] = module
    _SPEC.loader.exec_module(module)
    monkeypatch.setattr(module, "SECRETS_DIR", tmp_path / "secrets")
    return module


class TestKeyPersistence:
    def test_missing_key_returns_none(self, channel):
        assert channel.load_saved_key("wxid_missing") is None

    def test_valid_hex_roundtrip(self, channel, tmp_path):
        key = bytes(range(32))
        path = channel.SECRETS_DIR / "wechat4_key_acc1.hex"
        channel.SECRETS_DIR.mkdir(parents=True, exist_ok=True)
        path.write_text(key.hex(), encoding="utf-8")
        assert channel.load_saved_key("acc1") == key

    def test_bad_hex_rejected(self, channel):
        channel.SECRETS_DIR.mkdir(parents=True, exist_ok=True)
        (channel.SECRETS_DIR / "wechat4_key_acc2.hex").write_text("zz-not-hex", encoding="utf-8")
        assert channel.load_saved_key("acc2") is None

    def test_wrong_length_hex_rejected(self, channel):
        channel.SECRETS_DIR.mkdir(parents=True, exist_ok=True)
        (channel.SECRETS_DIR / "wechat4_key_acc3.hex").write_text("abcd", encoding="utf-8")
        assert channel.load_saved_key("acc3") is None

    def test_key_path_layout(self, channel):
        assert channel.key_path("wxid_a").name == "wechat4_key_wxid_a.hex"


class TestAccountSelection:
    def test_pick_by_id(self, channel, monkeypatch, tmp_path):
        account = type("A", (), {})()
        account.id = "wxid_target"
        monkeypatch.setattr(channel, "discover_wechat4_accounts", lambda: [account])
        assert channel.pick_account("wxid_target") is account

    def test_pick_unknown_id_exits(self, channel, monkeypatch):
        account = type("A", (), {})()
        account.id = "wxid_known"
        monkeypatch.setattr(channel, "discover_wechat4_accounts", lambda: [account])
        with pytest.raises(SystemExit, match="wxid_known"):
            channel.pick_account("wxid_other")

    def test_pick_default_most_recent(self, channel, monkeypatch):
        # discovery 返回按 mtime 降序，pick_account 无参取第一个
        first, second = object(), object()
        monkeypatch.setattr(channel, "discover_wechat4_accounts", lambda: [first, second])
        assert channel.pick_account(None) is first

    def test_no_accounts_exits(self, channel, monkeypatch):
        monkeypatch.setattr(channel, "discover_wechat4_accounts", lambda: [])
        with pytest.raises(SystemExit, match="未发现"):
            channel.pick_account(None)


class TestVendorBridge:
    def test_vendor_importable_from_channel(self, channel):
        """桥接件的 vendor 注入必须真的可用（ChatSource 生态在位）。"""
        from wechat_context_exporter.models import Conversation, Message
        from wechat_context_exporter.sources.wechat4_discovery import WeChat4Account

        assert Conversation is not None and Message is not None
        assert WeChat4Account is not None

    def test_save_key_writes_and_reports(self, channel, monkeypatch, capsys, tmp_path):
        account = type("A", (), {})()
        account.id = "wxid_save"
        account.db_dir = tmp_path / "db_storage"  # 真 WeChat4Account 有此 property
        monkeypatch.setattr(channel, "pick_account", lambda _id: account)
        monkeypatch.setattr(channel, "verify_account_key", lambda key, page: True)

        class Args:
            hex = bytes(range(32)).hex()
            account = None

        channel.cmd_save_key(Args())
        payload = capsys.readouterr().out
        assert "wxid_save" in payload
        saved = (channel.SECRETS_DIR / "wechat4_key_wxid_save.hex").read_text("utf-8")
        assert saved == bytes(range(32)).hex()

    def test_build_source_without_key_exits_honestly(self, channel, monkeypatch):
        """密钥未就位必须诚实退出，绝不伪造数据源。"""
        account = type("A", (), {})()
        account.id = "wxid_nokey"
        monkeypatch.setattr(channel, "load_saved_key", lambda _id: None)
        with pytest.raises(SystemExit, match="待抓密钥"):
            channel.build_source(account)
