# -*- coding: utf-8 -*-
"""文件级 cookie 收割：解密 .chrome-profile 的 Cookies 库，找 zhipu 系登录态。
只读，不开浏览器；先拷副本防锁库。v20(app-bound) 跳过并计数。"""
import base64
import json
import shutil
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
PROFILE = ROOT / ".chrome-profile"
COOKIES = PROFILE / "Default" / "Network" / "Cookies"
TMP = ROOT / "state" / "w2_cookies_copy.db"


def aes_key():
    ls = json.loads((PROFILE / "Local State").read_text(encoding="utf-8"))
    enc = base64.b64decode(ls["os_crypt"]["encrypted_key"])
    assert enc[:5] == b"DPAPI", enc[:5]
    import win32crypt
    _, key = win32crypt.CryptUnprotectData(enc[5:], None, None, None, 0)
    return key


def decrypt(ev: bytes, key: bytes):
    if ev[:3] in (b"v10", b"v11"):
        from Crypto.Cipher import AES
        nonce, body = ev[3:15], ev[15:]
        pt = AES.new(key, AES.MODE_GCM, nonce=nonce).decrypt(body[:-16])
        try:
            return pt.decode("utf-8")
        except UnicodeDecodeError:
            return pt[: pt.rfind(b"}") + 1].decode("utf-8", "replace")  # 去尾部\x16对齐
    return f"<prefix {ev[:3]!r} unsupported>"


def main() -> int:
    if not COOKIES.exists():
        print("no cookies db")
        return 1
    TMP.write_bytes(COOKIES.read_bytes())
    key = aes_key()
    con = sqlite3.connect(str(TMP))
    rows = con.execute(
        "SELECT host_key, name, length(encrypted_value), value FROM cookies "
        "WHERE host_key LIKE '%bigmodel%' OR host_key LIKE '%z.ai%' OR host_key LIKE '%zhipu%'"
    ).fetchall()
    print(f"zhipu 系 cookie 共 {len(rows)} 条")
    v20 = 0
    for host, name, elen, plain in rows:
        if elen == 0:
            val = plain or "<empty>"
        else:
            raw = con.execute(
                "SELECT encrypted_value FROM cookies WHERE host_key=? AND name=?", (host, name)
            ).fetchone()[0]
            if raw[:3] == b"v20":
                v20 += 1
                val = f"<v20 app-bound, len={elen}>"
            else:
                d = decrypt(raw, key)
                val = d if len(d) < 60 else f"{d[:20]}...(len={len(d)})"
        print(f"  {host:30s} {name:32s} {val}")
    print(f"v20(app-bound不可解): {v20}")
    con.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
