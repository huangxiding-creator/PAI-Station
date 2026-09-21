r"""360 密码库攻坚 Plan-C：ctypes 借 360 自家 sqlitedb3_64.dll 开 assis2.db。

背景：标准 sqlcipher3（12 组合 compat/page）全败——360se6 的 SQLite 是定制编译
（hayasec 当年就是嵌 360 的 dll 调 sqlite3_key 直开，从不逆向 KDF）。
LoginAssis 无独立 dll，但 ExtYouxi 组件带 360 出品的 sqlitedb3_64.dll——若与
LoginAssis 同源定制，此路直通。C# 调用序列逐行翻译自 ref_3bpass_SQLiteBase.cs。

用法: 系统 Python311（64 位）
  python decrypt_360_assis_dll.py            # MachineGuid 为 key 开库+dump
"""

from __future__ import annotations

import ctypes
import ctypes.wintypes as wt
import json
import shutil
import sys
import tempfile
import winreg
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DLL = Path.home() / "AppData/Roaming/360se6/Application/components/ExtYouxi/sqlitedb3_64.dll"
USER_DATA = Path.home() / "AppData/Roaming/360se6/User Data"
DBS = [
    USER_DATA / "Default/5e5c64cb82ee4f301ad2edc0ea3811b2/assis2.db",
    USER_DATA / "Default/apps/LoginAssis/assis2.db",
]
OUT = Path(r"E:\AI-Station\data\secrets\360se\_assis_raw.json")

SQL_OK, SQL_ROW, SQL_DONE = 0, 100, 101


def get_guid() -> str:
    key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Cryptography",
                         0, winreg.KEY_READ | winreg.KEY_WOW64_64KEY)
    return winreg.QueryValueEx(key, "MachineGuid")[0]


def load_sqlite():
    lib = ctypes.WinDLL(str(DLL))
    lib.sqlite3_open.argtypes = [ctypes.c_char_p, ctypes.POINTER(ctypes.c_void_p)]
    lib.sqlite3_open.restype = ctypes.c_int
    lib.sqlite3_key.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int]
    lib.sqlite3_key.restype = ctypes.c_int
    lib.sqlite3_close.argtypes = [ctypes.c_void_p]
    lib.sqlite3_prepare_v2.argtypes = [ctypes.c_void_p, ctypes.c_char_p, ctypes.c_int,
                                       ctypes.POINTER(ctypes.c_void_p),
                                       ctypes.POINTER(ctypes.c_char_p)]
    lib.sqlite3_prepare_v2.restype = ctypes.c_int
    lib.sqlite3_step.argtypes = [ctypes.c_void_p]
    lib.sqlite3_step.restype = ctypes.c_int
    lib.sqlite3_column_count.argtypes = [ctypes.c_void_p]
    lib.sqlite3_column_count.restype = ctypes.c_int
    lib.sqlite3_column_name.argtypes = [ctypes.c_void_p, ctypes.c_int]
    lib.sqlite3_column_name.restype = ctypes.c_char_p
    lib.sqlite3_column_type.argtypes = [ctypes.c_void_p, ctypes.c_int]
    lib.sqlite3_column_type.restype = ctypes.c_int
    lib.sqlite3_column_text.argtypes = [ctypes.c_void_p, ctypes.c_int]
    lib.sqlite3_column_text.restype = ctypes.c_char_p
    lib.sqlite3_column_blob.argtypes = [ctypes.c_void_p, ctypes.c_int]
    lib.sqlite3_column_blob.restype = ctypes.c_void_p
    lib.sqlite3_column_bytes.argtypes = [ctypes.c_void_p, ctypes.c_int]
    lib.sqlite3_column_bytes.restype = ctypes.c_int
    lib.sqlite3_finalize.argtypes = [ctypes.c_void_p]
    lib.sqlite3_finalize.restype = ctypes.c_int
    lib.sqlite3_errmsg.argtypes = [ctypes.c_void_p]
    lib.sqlite3_errmsg.restype = ctypes.c_char_p
    return lib


def col_value(lib, stmt, i):
    t = lib.sqlite3_column_type(stmt, i)
    if t == 5:  # NULL
        return None
    if t == 3:  # TEXT
        p = lib.sqlite3_column_text(stmt, i)
        return p.decode("utf-8", "replace") if p else ""
    p = lib.sqlite3_column_blob(stmt, i)
    n = lib.sqlite3_column_bytes(stmt, i)
    if not p or n == 0:
        return ""
    return ctypes.string_at(p, n).hex()  # BLOB → hex 保真


def try_db(lib, path: Path, key_bytes: bytes) -> list[dict] | None:
    db = ctypes.c_void_p()
    rc = lib.sqlite3_open(str(path).encode("utf-8"), ctypes.byref(db))
    if rc != SQL_OK:
        print(f"  open rc={rc}")
        return None
    try:
        lib.sqlite3_key(db, key_bytes, len(key_bytes))
        stmt = ctypes.c_void_p()
        sql = b"SELECT name FROM sqlite_master WHERE type='table'"
        rc = lib.sqlite3_prepare_v2(db, sql, len(sql) + 1, ctypes.byref(stmt), None)
        if rc != SQL_OK:
            err = lib.sqlite3_errmsg(db)
            print(f"  prepare rc={rc} err={err and err.decode('utf-8', 'replace')}")
            return None
        tables = []
        while lib.sqlite3_step(stmt) == SQL_ROW:
            p = lib.sqlite3_column_text(stmt, 0)
            if p:
                tables.append(p.decode("utf-8", "replace"))
        lib.sqlite3_finalize(stmt)
        if not tables:
            print(f"  key 校验失败（空表清单）")
            return None
        print(f"  ✓ 开库成功 表={tables}")
        target = next((t for t in tables if "account" in t.lower()), None)
        if not target:
            return []
        stmt = ctypes.c_void_p()
        sql = f"SELECT * FROM {target}".encode()
        rc = lib.sqlite3_prepare_v2(db, sql, len(sql) + 1, ctypes.byref(stmt), None)
        if rc != SQL_OK:
            return []
        ncols = lib.sqlite3_column_count(stmt)
        cols = [(lib.sqlite3_column_name(stmt, i) or b"?").decode("utf-8", "replace")
                for i in range(ncols)]
        rows = []
        while lib.sqlite3_step(stmt) == SQL_ROW:
            rec = {c: col_value(lib, stmt, i) for i, c in enumerate(cols)}
            rec["_table"] = target
            rows.append(rec)
        lib.sqlite3_finalize(stmt)
        return rows
    finally:
        lib.sqlite3_close(db)


def main() -> int:
    lib = load_sqlite()
    print(f"[dll] {DLL.name} 装载 OK")
    guid = get_guid()
    print(f"[key] MachineGuid={guid}")
    key_variants = {
        "guid-utf8": guid.encode("utf-8"),
        "guid-utf16": guid.encode("utf-16-le"),
    }
    all_rows: list[dict] = []
    for db in DBS:
        if not db.is_file():
            continue
        fd, tmpname = tempfile.mkstemp(suffix=".db")
        import os
        os.close(fd)
        tmp = Path(tmpname)
        shutil.copy(db, tmp)
        print(f"[db] {db.parent.name}/{db.name}")
        for kname, kb in key_variants.items():
            print(f"  试 key={kname}")
            rows = try_db(lib, tmp, kb)
            if rows is not None:
                for r in rows:
                    r["_source"] = f"{db.parent.name}/{db.name}"
                all_rows.extend(rows)
                print(f"  → {len(rows)} 行")
                break
        try:
            tmp.unlink()
        except OSError:
            pass
    if all_rows:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_text(json.dumps(all_rows, ensure_ascii=False, indent=1), encoding="utf-8")
        print(f"[done] {len(all_rows)} 行 → {OUT}")
        return 0
    print("[fail] dll 路线未通（ExtYouxi 的定制参数与 LoginAssis 不同源）")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
