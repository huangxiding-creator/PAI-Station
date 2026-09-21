r"""360 安全浏览器 360Bookmarks 解密器（算法源自 djh-sudo/Dcry-Browser _360Safe.py，六步派生链复现）。

密钥派生：stub+SID+GUID → 360Hash(mtea 家族) → RandEnc → TEA360 → MD5 → AES-CBC
仅做本机个人数据导出（书签=行为数据，非凭据；密码库 assis2.db/Cookies 不碰——自画像红线）。

用法: python decrypt_360.py bookmarks [--out 书签.json]
"""

from __future__ import annotations

import argparse
import base64
import binascii
import hashlib
import json
import sys
import winreg
from ctypes import c_uint32
from pathlib import Path

try:  # probe 类脚本只用密钥派生，AES 惰性导入避免环境依赖
    from Crypto.Cipher import AES  # noqa: F401
except ImportError:  # pragma: no cover
    AES = None


def pad_x923(data: bytes, size: int) -> bytes:
    """x923 填充（补零+末字节长度），替代 pycryptodome 的 pad(…, 'x923')。"""
    n = size - (len(data) % size) or size
    return data + b"\x00" * (n - 1) + bytes([n])

DWORD = 0xFFFFFFFF
STUB = bytes([
    0x1f, 0x7d, 0x14, 0x89, 0x4d, 0xb8, 0x8b, 0x4d, 0x18, 0x89, 0x45, 0xbc, 0x89, 0x7d, 0xb0, 0x89,
    0x4d, 0xac, 0x89, 0x5d, 0xd0, 0x89, 0x5d, 0xc8, 0x88, 0x5d, 0xd7, 0x88, 0x5d, 0xc0, 0x3b, 0xfb,
    0x0f, 0x84, 0x77, 0x93, 0x03, 0x00, 0x89, 0x90, 0x8b, 0x4e, 0x10, 0xf7, 0x41, 0x08, 0x00, 0x40,
    0x00, 0x00, 0x0f, 0x84, 0x6f, 0x93, 0x03, 0x00, 0xf7, 0x46, 0x68, 0x00, 0x01, 0x00, 0x00, 0x0f,
    0x85, 0x58, 0xcc, 0x03, 0x00, 0xf6, 0x05, 0xa0, 0x03, 0xfe, 0x7f, 0x01, 0xbf, 0x00, 0x01, 0x00,
    0x02, 0x0f, 0x85, 0x4f, 0x96, 0x03, 0x00, 0x89, 0x5d, 0xd8, 0x85, 0x7e, 0x68, 0x0f, 0x85, 0x8b,
    0x96, 0x03, 0x00, 0x38, 0x5e, 0x02, 0x0f, 0x85, 0xea, 0x96, 0xcc, 0x00, 0xeb, 0x1d, 0x39, 0x5d,
    0xc8, 0x0f, 0x85, 0x3b, 0x97, 0x03, 0x00, 0x8b, 0x45, 0xd8, 0x8b, 0x4d, 0xfc, 0x5f, 0x5e, 0x33,
    0x10, 0x00, 0x00, 0x00, 0x57, 0x00, 0x44, 0x00, 0x4c, 0x00, 0x32, 0x00, 0x30, 0x00, 0x31, 0x00,
    0x36, 0x00, 0x00, 0x00,
])

BOOKMARK_PATH = Path.home() / "AppData" / "Roaming" / "360se6" / "User Data" / "Default" / "360Bookmarks"


def _zimu(d1: int, d2: int) -> int:
    return (d1 * d2) & DWORD


def _zoo3(d1: int, d2: int) -> int:
    return _zimu(d2, d1 >> 16) & DWORD


def _zoo1(d1: int, d2: int, d3: int) -> int:
    return (_zimu(d2, d1) - _zoo3(d1, d3)) & DWORD


def _zoo2(d1: int, d2: int, d3: int) -> int:
    return (_zimu(d2, d1) + _zoo3(d1, d3)) & DWORD


def cs64_word_swap(src: bytes, i_ch_num: int, i_md5: list) -> bytes:
    dw_md50 = ((i_md5[0] | 1) + 0x69FB0000) & DWORD
    dw_md51 = ((i_md5[1] | 1) + 0x13DB0000) & DWORD
    dw_ret0 = dw_ret1 = 0
    i = 0
    while i < i_ch_num:
        dw_temp00 = (dw_ret0 + int.from_bytes(src[i * 4:(i + 1) * 4], "little")) & DWORD
        dw_temp01 = _zoo1(dw_temp00, dw_md50, 0x10FA9605)
        dw_temp02 = _zoo2(dw_temp01, 0x79F8A395, 0x689B6B9F)
        dw_temp03 = _zoo1(dw_temp02, 0xEA970001, 0x3C101569)
        i += 1
        dw_temp04 = (dw_temp03 + int.from_bytes(src[i * 4:(i + 1) * 4], "little")) & DWORD
        dw_temp05 = _zoo1(dw_temp04, dw_md51, 0x3CE8EC25)
        dw_temp06 = _zoo1(dw_temp05, 0x59C3AF2D, 0x2232E0F1)
        dw_temp07 = _zoo2(dw_temp06, 0x1EC90001, 0x35BD1EC9)
        i += 1
        dw_ret0 = dw_temp07
        dw_ret1 = (dw_temp03 + dw_ret0 + dw_ret1) & DWORD
    return dw_ret0.to_bytes(4, "little") + dw_ret1.to_bytes(4, "little")


def cs64_reversible(src: bytes, i_ch_num: int, i_md5: list) -> bytes:
    dw_md50 = i_md5[0] | 1
    dw_md51 = i_md5[1] | 1
    dw_ret0 = dw_ret1 = 0
    i = 0
    while i < i_ch_num:
        dw_temp00 = (dw_ret0 + int.from_bytes(src[i * 4:(i + 1) * 4], "little")) & DWORD
        dw_temp01 = (dw_md50 * dw_temp00) & DWORD
        dw_temp02 = _zoo1(dw_temp01, 0xB1110000, 0x30674EEF)
        dw_temp03 = _zoo1(dw_temp02, 0x5B9F0000, 0x78F7A461)
        dw_temp04 = _zoo2(dw_temp03, 0xB96D0000, 0x12CEB96D)
        dw_temp05 = _zoo2(dw_temp04, 0x1D830000, 0x257E1D83)
        i += 1
        dw_temp06 = (dw_temp05 + int.from_bytes(src[i * 4:(i + 1) * 4], "little")) & DWORD
        dw_temp07 = (dw_md51 * dw_temp06) & DWORD
        dw_temp08 = _zoo1(dw_temp07, 0x16F50000, 0x5D8BE90B)
        dw_temp09 = _zoo1(dw_temp08, 0x96FF0000, 0x2C7C6901)
        dw_temp10 = _zoo2(dw_temp09, 0x2B890000, 0x7C932B89)
        dw_temp11 = _zoo1(dw_temp10, 0x9F690000, 0x405B6097)
        i += 1
        dw_ret0 = dw_temp11
        dw_ret1 = (dw_temp05 + dw_ret0 + dw_ret1) & DWORD
    return dw_ret0.to_bytes(4, "little") + dw_ret1.to_bytes(4, "little")


def hash_360(src: bytes, dw_ws_len: int, i_md5: list) -> bytes:
    dw_count = dw_ws_len // 4
    if dw_count & 1:
        dw_count -= 1
    r1 = cs64_word_swap(src, dw_count, i_md5)
    r2 = cs64_reversible(src, dw_count, i_md5)
    return bytes(a ^ b for a, b in zip(r1, r2))


def rand(seed: int) -> int:
    return (0x343FD * seed + 0x269EC3) & DWORD


def rand_enc(data: bytes, mseed: int = 0x8000402B) -> bytes:
    tmp = mseed.to_bytes(4, "little")
    total = len(data)
    words, count, seed = total >> 2, 0, mseed
    while words > 0:
        seed = rand(seed)
        s4 = seed.to_bytes(4, "little")
        tmp += bytes((data[count + i] ^ s4[i]) for i in range(4))
        count += 4
        words -= 1
    s4 = rand(seed).to_bytes(4, "little")
    tmp += bytes((data[count + i] ^ s4[i]) for i in range(total & 3))
    return tmp


def tea_encrypt(block8: bytes, key16: bytes):
    seed = 0x9E3779B9
    v4 = c_uint32(int.from_bytes(block8[0:4], "little"))
    v5 = c_uint32(int.from_bytes(block8[4:8], "little"))
    k0 = int.from_bytes(key16[0:4], "little")
    k1 = int.from_bytes(key16[4:8], "little")
    k2 = int.from_bytes(key16[8:12], "little")
    k3 = int.from_bytes(key16[12:16], "little")
    for _ in range(8):
        v4.value += ((k0 + 0x10 * v5.value) ^ (v5.value + seed) ^ (k1 + (v5.value >> 5)))
        v5.value += ((k2 + 0x10 * v4.value) ^ (v4.value + seed) ^ (k3 + (v4.value >> 5)))
        seed = (seed - 0x61C88647) & DWORD
    return v4.value, v5.value


def tea360(pb_data: bytes, size: int = 0x80) -> bytes:
    if size > len(pb_data):
        pb_data = pb_data + b"\x00" * (size - len(pb_data))
    keys = pb_data[:16]
    datas = pb_data
    out = b""
    for j in range(0, len(datas), 8):
        x, y = tea_encrypt(datas[j:j + 8], keys)
        out += x.to_bytes(4, "little") + y.to_bytes(4, "little")
    return out


def encode_wchar(text: str) -> bytes:
    return text.encode("utf-16-le")


def urlenc_b64(raw: bytes) -> bytes:
    """原版 Urlenc 逐字符复现：字母数字与 -.:/ 保留，其余 %%xx 小写 hex（大小写敏感！）。"""
    reserved = set("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-.:/")
    out = b""
    for byte in raw:
        if chr(byte) in reserved:
            out += byte.to_bytes(1, "little")
        elif byte == 32:
            out += b"+"
        else:
            out += b"%%%02x" % byte
    return out


def get_machine_guid() -> str:
    key = winreg.OpenKey(
        winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Cryptography",
        0, winreg.KEY_READ | winreg.KEY_WOW64_64KEY,
    )
    return winreg.QueryValueEx(key, "MachineGuid")[0]


def get_sid() -> str | None:
    """注册表直读（原参考用 wmi，免依赖）：ProfileImagePath 反查用户 SID。"""
    try:
        root = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE,
                              r"SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList")
    except OSError:
        return None
    import os
    profile = Path.home()
    for i in range(winreg.QueryInfoKey(root)[0]):
        sub = winreg.EnumKey(root, i)
        with winreg.OpenKey(root, sub) as k:
            try:
                path = winreg.QueryValueEx(k, "ProfileImagePath")[0]
            except OSError:
                continue
            if Path(path).resolve() == profile.resolve() and sub.startswith("S-1-5-21"):
                return sub
    return None


def derive_key() -> bytes:
    sid = get_sid()
    guid = get_machine_guid()
    print(f"[key] SID={sid}")
    print(f"[key] MachineGuid={guid}")
    payload_one = STUB + encode_wchar(sid) + encode_wchar("/?") + encode_wchar(guid)
    md5_one = hashlib.md5(payload_one).digest()
    a = int.from_bytes(md5_one[0:4], "little")
    b = int.from_bytes(md5_one[4:8], "little")
    mhashbs = hash_360(payload_one, len(payload_one), [a, b])
    mhash_encbs = urlenc_b64(base64.b64encode(mhashbs))
    payload_two = (
        (1).to_bytes(4, "little") + len(STUB).to_bytes(4, "little") + STUB
        + (2).to_bytes(4, "little") + len(mhash_encbs).to_bytes(4, "little") + mhash_encbs
    )
    tmp = hashlib.md5(rand_enc(payload_two)).digest()
    tmp = tea360(binascii.b2a_hex(tmp))
    tmp = pad_x923(tmp, 0xC0 + 1)[:-1]
    return hashlib.md5(tmp).digest()


def decrypt_bookmarks() -> str:
    raw = BOOKMARK_PATH.read_bytes()
    key = derive_key()
    aes = AES.new(key=binascii.b2a_hex(key), iv=b"33mhsq0uwgzblwdo", mode=AES.MODE_CBC)
    plain = aes.decrypt(base64.b64decode(raw)[4:])
    pad_len = plain[-1]  # PKCS#7 去填充（尾部残 \n\n\x0f*15 实证）
    if 0 < pad_len <= 16 and plain[-pad_len:] == bytes([pad_len]) * pad_len:
        plain = plain[:-pad_len]
    return plain.decode("utf-8", errors="replace")


def main() -> None:
    parser = argparse.ArgumentParser(description="360 安全浏览器书签解密（本机个人数据导出）")
    parser.add_argument("--out", default=None, help="输出 JSON 路径（默认打印头 500 字）")
    args = parser.parse_args()
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    text = decrypt_bookmarks()
    if args.out:
        Path(args.out).write_text(text, encoding="utf-8")
        print(f"[ok] {len(text)} chars -> {args.out}")
    else:
        print(text[:500])
        print(f"... (total {len(text)} chars; --out 落盘看全量)")


if __name__ == "__main__":
    main()
