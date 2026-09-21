r"""360History（4f99fac8 加密容器）开库试探：书签派生链 key 变体 × 剥头偏移 × sqlcipher3。

背景（2026-09-21 攻坚记录）：
- 360se6 的 360History = 自家加密容器（head magic 4f99fac8 + 固定 12 字节），非明文 SQLite
- 开源界无人公开破过（Pillager/GodInfo 只做明文 360Chrome；hayasec 只做 assis2.db 密码库）
- 本脚本 = 最后一轮廉价试探：书签六步链 key 的各形态作 SQLCipher key
- 红线：仅试探历史库（行为数据）；assis2.db 密码库/Cookies 绝不碰

用法（hub venv 有 sqlcipher3）:
  E:\AI-Station\vendor\wechat-intelligence-hub\.venv\Scripts\python.exe probe_360_history.py
"""

from __future__ import annotations

import binascii
import hashlib
import shutil
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
import decrypt_360 as d  # noqa: E402

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SRC = Path.home() / "AppData/Roaming/360se6/User Data/Default" / \
    "5e5c64cb82ee4f301ad2edc0ea3811b2" / "360History"


def key_variants() -> dict[str, tuple[str, str]]:
    """(名, (key材料, pragma形态))：'pass'=%q 字符串 / 'raw'=x'HEX' 裸key。"""
    key_bs = d.derive_key()
    guid = d.get_machine_guid()
    sid = d.get_sid() or ""
    return {
        "hex(key_bs)": (binascii.b2a_hex(key_bs).decode(), "pass"),
        "key_bs_raw32pad": (binascii.b2a_hex(key_bs + b"\x00" * 16).decode(), "raw"),
        "md5(hex(key_bs))": (hashlib.md5(binascii.b2a_hex(key_bs)).hexdigest(), "pass"),
        "key_bs_hex_as_raw": (binascii.b2a_hex(key_bs).decode(), "raw"),
        "MachineGuid": (guid, "pass"),
        "MachineGuid_raw": (guid.encode().hex(), "raw"),
        "MachineGuid_u16": (guid.encode("utf-16-le").hex(), "raw"),
        "md5(guid)": (hashlib.md5(guid.encode()).hexdigest(), "pass"),
        "md5(guid+sid)": (hashlib.md5((guid + sid).encode()).hexdigest(), "pass"),
        "key_bs(u16hash链)": (
            hashlib.md5(key_bs + sid.encode("utf-16-le") + guid.encode("utf-16-le")).hexdigest(), "pass"),
    }


def try_open(data: bytes, key: str, form: str) -> str | None:
    import sqlcipher3
    tmp = Path(tempfile.mkstemp(suffix=".db")[1])
    try:
        tmp.write_bytes(data)
        conn = sqlcipher3.connect(str(tmp))
        pragma = f"x'{key}'" if form == "raw" else f"'{key}'"
        conn.execute(f"PRAGMA key={pragma}")
        for page in ("4096", "1024"):
            conn.execute(f"PRAGMA cipher_page_size={page}")
            try:
                row = conn.execute("SELECT name FROM sqlite_master LIMIT 1").fetchone()
                if row:
                    conn.close()
                    return f"page_size={page} first_table={row[0]}"
            except Exception:
                continue
        conn.close()
        return None
    except Exception:
        return None
    finally:
        try:
            tmp.unlink()
        except OSError:
            pass


def main() -> int:
    raw = SRC.read_bytes()
    print(f"库: {SRC.name} {len(raw):,}B head={raw[:16].hex()}")
    # 偏移：0=全文件（密头一起给）/ 16=剥固定头 / 4=剥 magic
    offsets = {"full": 0, "skip16": 16, "skip4": 4}
    variants = key_variants()
    hits = []
    for off_name, off in offsets.items():
        data = raw[off:]
        for name, (key, form) in variants.items():
            result = try_open(data, key, form)
            tag = f"[{off_name}] {name}"
            if result:
                print(f"✓ 命中 {tag} -> {result}")
                hits.append(tag)
            else:
                print(f"· {tag}")
    if not hits:
        print("\n结论：30 变体全败——4f99fac8 非 SQLCipher 默认参数容器，或为 360 自家格式。挂上游工单。")
    return 0 if hits else 1


if __name__ == "__main__":
    raise SystemExit(main())
