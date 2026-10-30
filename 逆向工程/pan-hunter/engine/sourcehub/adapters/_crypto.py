# -*- coding: utf-8 -*-
"""十盘 adapter 共用密码学件（W1 · 2026-10-31）

出处纪律（零猜测）：
  acw_sc__v2   ← refs_nfd parser/src/main/java/cn/qaiu/util/AcwScV2Generator.java（MIT，逐行直译）
  aes_hex      ← refs_nfd util/AESUtils.java（MIT）：AES/ECB/PKCS5 + hex 输出；
                 密钥 = AESUtils.CIPHER_AES2_IZ / CIPHER_AES2 以 "AES/ECB/PKCS5Pad" 为钥解出
                 （iz=lanZouY-disk-app 蓝奏优享; fj=dingHao-disk-app 小飞机），2026-10-31 本机解密实证
  encode123    ← refs_nfd parser/impl/Ye2Tool.java encode123()（MIT，逐行直译）
"""
from __future__ import annotations

import binascii
import random
import time
import zlib
from base64 import b64decode

from cryptography.hazmat.primitives import padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes


def _aes_ecb_dec(b64: str, key: str) -> str:
    c = Cipher(algorithms.AES(key.encode()[:16]), modes.ECB()).decryptor()
    raw = c.update(b64decode(b64)) + c.finalize()
    p = padding.PKCS7(128).unpadder()
    return (p.update(raw) + p.finalize()).decode()


# nfd AESUtils 静态块还原（解密钥 = "AES/ECB/PKCS5Padding" 截 16 位）
_KEY_IZ = _aes_ecb_dec("1uQFS3sNeHd/bCrmrQpflXREAxt0Hn0Ob9v317QirZM=", "AES/ECB/PKCS5Pad")  # lanZouY-disk-app
_KEY_FJ = _aes_ecb_dec("YbQHZqK/PdQql2+7ATcPQHREAxt0Hn0Ob9v317QirZM=", "AES/ECB/PKCS5Pad")  # dingHao-disk-app


def _aes_ecb_enc_hex(plain: str, key: str) -> str:
    p = padding.PKCS7(128).padder()
    data = p.update(plain.encode()) + p.finalize()
    c = Cipher(algorithms.AES(key.encode()[:16]), modes.ECB()).encryptor()
    return binascii.hexlify(c.update(data) + c.finalize()).decode()


def iz_hex(plain: str) -> str:
    """蓝奏优享 encrypt2HexIz：时间戳/下载参数 AES-hex 签名。"""
    return _aes_ecb_enc_hex(plain, _KEY_IZ)


def fj_hex(plain: str) -> str:
    """小飞机 encrypt2Hex。"""
    return _aes_ecb_enc_hex(plain, _KEY_FJ)


def acw_sc_v2(arg1: str) -> str:
    """蓝奏系 ESA 反爬挑战 cookie 计算（AcwScV2Generator.acwScV2Simple 直译）。"""
    pos_list = [15, 35, 29, 24, 33, 16, 1, 38, 10, 9, 19, 31, 40, 27, 22, 23, 25,
                13, 6, 11, 39, 18, 20, 8, 14, 21, 32, 26, 2, 30, 7, 4, 17, 5, 3,
                28, 34, 37, 12, 36]
    mask = "3000176000856006061501533003690027800375"
    out = [""] * 40
    for i, ch in enumerate(arg1):
        for j, pos in enumerate(pos_list):
            if pos == i + 1:
                out[j] = ch
    arg2 = "".join(out)
    res = []
    for i in range(0, min(len(arg2), len(mask)), 2):
        res.append("%02x" % (int(arg2[i:i + 2], 16) ^ int(mask[i:i + 2], 16)))
    return "".join(res)


_CHAR_MAP = "adefghlmyijnopkqrstubcvwsz"


def _crc32_hex(s: str) -> str:
    return "%08x" % (zlib.crc32(s.encode()) & 0xFFFFFFFF)


def encode123(url_path: str, way: str = "web", version: str = "3", ts_ms: int | None = None) -> str:
    """123盘直链签名：?{y}={timeLong}-{a}-{finalCrc}（Ye2Tool.encode123 直译）。

    y = 十进制(HEX转DEC(crc32(时间置换串)))；a = 随机因子。
    """
    if ts_ms is None:
        ts_ms = int(time.time() * 1000)
    a = (10000000 * (random.randint(1, 10000000))) // 10000
    time_long = ts_ms // 1000
    tm = time.localtime(time_long)
    time_str = time.strftime("%Y%m%d%H%M", tm)
    g = "".join(_CHAR_MAP[0] if int(c) == 0 else _CHAR_MAP[int(c) - 1] for c in time_str)
    y = str(int(_crc32_hex(g), 16))
    final_crc_input = "%d|%d|%s|%s|%s|%s" % (time_long, a, url_path, way, version, y)
    final_crc = str(int(_crc32_hex(final_crc_input), 16))
    return "?%s=%d-%d-%s" % (y, time_long, a, final_crc)
