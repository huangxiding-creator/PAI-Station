#!/usr/bin/env python
"""把 huohuoer/wechat-cli 提取的密钥迁入 Rion 引擎（schema-2 salt_keys 格式）。

直写 ~/.config/rion-wechat-reader/{keys,config}.json：
- 引擎的 import-access/setup 在 Windows 上被 POSIX safe_mode 闸（chmod 600 语义，
  Windows stat 恒 0o666/0o444 过不了）卡死，而 DatabaseSet 查询构造器无此闸；
- 查询侧 key_spec_for 走 salt_keys 分支：64 位 enc_key 自动拼 salt 成 96 位。
用法：python import-keys-rion.py [--force]
"""
import json
import os
import sys
import tempfile
from pathlib import Path

SRC = Path.home() / ".wechat-cli" / "all_keys.json"
KEYS = Path.home() / ".config" / "rion-wechat-reader" / "keys.json"
CONF = Path.home() / ".config" / "rion-wechat-reader" / "config.json"
DB_ROOT = Path(r"C:\Users\91216\xwechat_files\wxid_ui29wkg2ug6922_66f7\db_storage")
SELF_USERNAME = "wxid_ui29wkg2ug6922"  # 账号目录名前段；仅影响 from_me 归属


def atomic_write(path: Path, value: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(prefix=path.name + ".", dir=path.parent)
    with os.fdopen(fd, "w", encoding="utf-8") as handle:
        json.dump(value, handle, ensure_ascii=False, indent=2)
        handle.write("\n")
    os.replace(tmp, path)


def main() -> int:
    if not SRC.is_file():
        print(f"[!] 源密钥不存在：{SRC}（先跑 wechat-cli init）")
        return 1
    if CONF.exists() and "--force" not in sys.argv:
        print(f"[!] 配置已存在：{CONF}（--force 覆盖）")
        return 1

    raw = json.loads(SRC.read_text(encoding="utf-8"))
    salt_keys = {spec["salt"].casefold(): spec["enc_key"].lower() for spec in raw.values()}
    atomic_write(KEYS, {
        "schema_version": 2,
        "database_root": str(DB_ROOT),
        "salt_keys": salt_keys,
    })

    config = {
        "session_db": str(DB_ROOT / "session" / "session.db"),
        "contact_db": str(DB_ROOT / "contact" / "contact.db"),
        "message_dbs": [str(DB_ROOT / "message" / f"message_{i}.db") for i in (0, 1, 2)],
        "favorite_db": str(DB_ROOT / "favorite" / "favorite.db"),
        "sns_db": str(DB_ROOT / "sns" / "sns.db"),
        "hardlink_db": str(DB_ROOT / "hardlink" / "hardlink.db"),
        "keys_file": str(KEYS),
        "self_username": SELF_USERNAME,
    }
    atomic_write(CONF, config)
    print(f"[+] {len(salt_keys)} 个 salt 密钥 -> {KEYS}")
    print(f"[+] 配置 -> {CONF}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
