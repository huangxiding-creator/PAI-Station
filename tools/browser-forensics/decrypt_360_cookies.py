r"""360 安全浏览器 Cookies 解密（用户 2026-09-21 令：解除红线，本机自有数据）。

链路（Chromium 标准）：
  Local State → os_crypt.encrypted_key（DPAPI 前缀）→ CryptUnprotectData → 32 字节 AES key
  cookies.encrypted_value → v10/v11：nonce[3:15] + 密文 + tag[-16:]，AES-256-GCM
  旧版：\x01\x00\x00\x00 开头 DPAPI 整块直解

目标库（360se6 User Data/ 下）：
  Default/Network/Cookies        主库（浏览器进程独占锁 → 共享模式直读，失败提示关浏览器重跑）
  Default/Extension Cookies      扩展 cookies（明文 SQLite 可复制）
  chromeshell/Default/Network/Cookies

用法: 系统 Python311（需 pycryptodome + pywin32）
产物: data/secrets/360se/cookies_360.json（gitignore 区）；控制台只打计数+域名样本。
"""

from __future__ import annotations

import base64
import ctypes
import json
import os
import shutil
import sqlite3
import sys
import tempfile
from pathlib import Path

from Crypto.Cipher import AES
from win32crypt import CryptUnprotectData

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

USER_DATA = Path.home() / "AppData/Roaming/360se6/User Data"
OUT = Path(r"E:\AI-Station\data\secrets\360se\cookies_360.json")


def os_crypt_key() -> bytes:
    state = json.loads((USER_DATA / "Local State").read_text(encoding="utf-8"))
    raw = base64.b64decode(state["os_crypt"]["encrypted_key"])
    if raw[:5] == b"DPAPI":
        raw = raw[5:]
    return CryptUnprotectData(raw, None, None, None, 0)[0]


def shared_copy(src: Path, dst: Path) -> bool:
    """普通复制被独占锁挡时，CreateFileW 全共享标志直读（GENERIC_READ + share all）。"""
    kernel32 = ctypes.windll.kernel32
    GENERIC_READ, SHARE_ALL, OPEN_EXISTING = 0x80000000, 0x7, 3
    h = kernel32.CreateFileW(str(src), GENERIC_READ, SHARE_ALL, None,
                             OPEN_EXISTING, 0x80, None)
    if h in (-1, 0xFFFFFFFFFFFFFFFF, ctypes.c_void_p(-1).value):
        return False
    try:
        import msvcrt
        with os.fdopen(msvcrt.open_osfhandle(h, 0), "rb") as fh, open(dst, "wb") as out:
            shutil.copyfileobj(fh, out)
        return True
    except OSError:
        return False


def grab(src: Path) -> Path | None:
    """复制到临时文件（避开运行中浏览器的 SQLite 锁）。"""
    if not src.is_file():
        return None
    fd, tmpname = tempfile.mkstemp(suffix=".db")
    os.close(fd)  # Windows：句柄不关会锁死后续 unlink
    tmp = Path(tmpname)
    try:
        shutil.copyfile(src, tmp)
    except PermissionError:
        if shared_copy(src, tmp):
            print(f"[grab] {src.relative_to(USER_DATA)} 独占锁，共享模式直读成功")
        else:
            print(f"[grab] {src.relative_to(USER_DATA)} 锁死读不了（关 360 浏览器后重跑）")
            try:
                tmp.unlink()
            except OSError:
                pass
            return None
    return tmp


def decrypt_value(blob: bytes, key: bytes) -> tuple[str, str]:
    """返回 (明文, 方式)。v10/v11 GCM / 旧版 DPAPI / 纯文本。"""
    if not blob:
        return "", "empty"
    if blob[:3] in (b"v10", b"v11"):
        try:
            nonce, ct, tag = blob[3:15], blob[15:-16], blob[-16:]
            return AES.new(key, AES.MODE_GCM, nonce=nonce).decrypt_and_verify(ct, tag).decode("utf-8", "replace"), "gcm"
        except ValueError:
            pass  # 落到 DPAPI 兜底
    if blob[:4] == b"\x01\x00\x00\x00":
        try:
            return CryptUnprotectData(blob, None, None, None, 0)[0].decode("utf-8", "replace"), "dpapi"
        except Exception:  # noqa: BLE001
            pass
    return blob.decode("utf-8", "replace"), "plain"


TARGETS = [
    ("main", USER_DATA / "Default/Network/Cookies"),
    ("extension", USER_DATA / "Default/Extension Cookies"),
    ("chromeshell", USER_DATA / "chromeshell/Default/Network/Cookies"),
]


def main() -> int:
    OUT.parent.mkdir(parents=True, exist_ok=True)
    key = os_crypt_key()
    print(f"[key] AES key 就绪 {len(key)} 字节")
    all_rows: list[dict] = []
    for tag, src in TARGETS:
        tmp = grab(src)
        if tmp is None:
            continue
        rows: list[dict] = []
        conn = None
        try:
            conn = sqlite3.connect(str(tmp))
            cur = conn.execute(
                "SELECT host_key, name, encrypted_value, path, expires_utc, is_secure "
                "FROM cookies")
            for host, name, ev, path, exp, sec in cur.fetchall():
                val, how = decrypt_value(ev, key)
                rows.append({"db": tag, "host": host, "name": name, "value": val,
                             "path": path, "expires_utc": exp, "secure": sec,
                             "crypt": how})
        except Exception as exc:  # noqa: BLE001
            print(f"[{tag}] 读库失败: {exc}")
        finally:
            if conn:
                conn.close()
            tmp.unlink(missing_ok=True)
        hosts = sorted({r["host"] for r in rows})
        print(f"[{tag}] {len(rows)} 条 / {len(hosts)} 域（样本: {', '.join(hosts[:5])}）")
        all_rows.extend(rows)
    OUT.write_text(json.dumps(all_rows, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[done] 共 {len(all_rows)} 条 → {OUT}")
    return 0 if all_rows else 1


if __name__ == "__main__":
    raise SystemExit(main())
