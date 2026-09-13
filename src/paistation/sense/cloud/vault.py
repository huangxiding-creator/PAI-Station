"""M2.6 云连接器登录态保险库：Windows DPAPI 加密落盘（FR15）。

用户"给账号密码或扫码登录后登录态永久保存"的永久=DPAPI：密文绑定
当前 Windows 用户，复制到别的机器/账号即废。红线：vault 目录永不
进入 git 同步范围（ADR-10 同步白名单不含 cloud_vault/）。
"""
from __future__ import annotations

import ctypes
import json
import os
from ctypes import wintypes
from pathlib import Path

_CRYPTPROTECT_UI_FORBIDDEN = 0x01


class _DATA_BLOB(ctypes.Structure):
    _fields_ = [("cbData", wintypes.DWORD),
                ("pbData", ctypes.POINTER(ctypes.c_char))]


def _dpapi_protect(data: bytes) -> bytes:
    buf = ctypes.create_string_buffer(data, len(data))
    blob_in = _DATA_BLOB(len(data), buf)
    blob_out = _DATA_BLOB()
    ok = ctypes.windll.crypt32.CryptProtectData(
        ctypes.byref(blob_in), None, None, None, None,
        _CRYPTPROTECT_UI_FORBIDDEN, ctypes.byref(blob_out))
    if not ok:
        raise OSError(ctypes.GetLastError(), "CryptProtectData 失败")
    try:
        return ctypes.string_at(blob_out.pbData, blob_out.cbData)
    finally:
        ctypes.windll.kernel32.LocalFree(
            ctypes.cast(blob_out.pbData, ctypes.c_void_p))


def _dpapi_unprotect(data: bytes) -> bytes:
    buf = ctypes.create_string_buffer(data, len(data))
    blob_in = _DATA_BLOB(len(data), buf)
    blob_out = _DATA_BLOB()
    ok = ctypes.windll.crypt32.CryptUnprotectData(
        ctypes.byref(blob_in), None, None, None, None,
        _CRYPTPROTECT_UI_FORBIDDEN, ctypes.byref(blob_out))
    if not ok:
        raise OSError(ctypes.GetLastError(), "CryptUnprotectData 失败")
    try:
        return ctypes.string_at(blob_out.pbData, blob_out.cbData)
    finally:
        ctypes.windll.kernel32.LocalFree(
            ctypes.cast(blob_out.pbData, ctypes.c_void_p))


class SessionVault:
    """name.vault 文件=DPAPI 密文(json(session))；原子写，永不明文。"""

    def __init__(self, dir_path: str | Path):
        self._dir = Path(dir_path)
        self._dir.mkdir(parents=True, exist_ok=True)

    def _path(self, name: str) -> Path:
        return self._dir / f"{name}.vault"

    def save(self, name: str, session: dict) -> None:
        blob = json.dumps(session, ensure_ascii=False).encode("utf-8")
        cipher = _dpapi_protect(blob)
        tmp = self._dir / f"{name}.vault.tmp"
        tmp.write_bytes(cipher)
        os.replace(tmp, self._path(name))  # 原子换名

    def load(self, name: str) -> dict | None:
        p = self._path(name)
        if not p.is_file():
            return None
        try:
            plain = _dpapi_unprotect(p.read_bytes())
            value = json.loads(plain.decode("utf-8"))
            return value if isinstance(value, dict) else None
        except (OSError, ValueError):
            return None  # 密文损坏/跨机器：视为未登录

    def delete(self, name: str) -> None:
        self._path(name).unlink(missing_ok=True)

    def names(self) -> list[str]:
        return sorted(p.stem for p in self._dir.glob("*.vault"))
