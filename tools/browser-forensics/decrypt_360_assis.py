r"""360 安全浏览器密码库 assis2.db 解密（用户 2026-09-21 令：解除红线，本机自有数据）。

链路（参考 hayasec/360SafeBrowsergetpass，原件 _recon/browser-forensics-refs/）：
  外层 SQLCipher：key = MachineGuid 字符串（UTF-8 口令路径）
  内层字段：strip "(4B01F200ED01)" → base64 → AES-ECB(key='cf66fb58f5ca3485', 无填充)
            → 首字节 \x02 取 b[1::2]，否则 b[2::2]（UTF-16 抽字节）→ 明文口令

两阶段跨运行时（hub venv 有 sqlcipher3 无 AES 库；系统 Python311 反之）：
  sql: vendor/wechat-intelligence-hub/.venv/Scripts/python.exe decrypt_360_assis.py sql
  aes: C:\\...\\Python311\\python.exe decrypt_360_assis.py aes

产物：data/secrets/360se/assis_creds.json（gitignore 区）；控制台密码打码。
"""

from __future__ import annotations

import argparse
import base64
import json
import re
import shutil
import sys
import tempfile
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(r"E:\AI-Station")
OUT_DIR = STATION / "data" / "secrets" / "360se"
RAW_JSON = OUT_DIR / "_assis_raw.json"
CREDS_JSON = OUT_DIR / "assis_creds.json"
USER_DATA = Path.home() / "AppData/Roaming/360se6/User Data"
DBS = [
    USER_DATA / "Default/5e5c64cb82ee4f301ad2edc0ea3811b2/assis2.db",
    USER_DATA / "Default/apps/LoginAssis/assis2.db",
]
INNER_KEY = b"cf66fb58f5ca3485"
MARKER = "(4B01F200ED01)"


def get_guid() -> str:
    import winreg
    key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Cryptography",
                         0, winreg.KEY_READ | winreg.KEY_WOW64_64KEY)
    return winreg.QueryValueEx(key, "MachineGuid")[0]


def mask(s: str) -> str:
    return (s[:2] + "***" + s[-1:]) if s and len(s) > 4 else ("***" if s else "(空)")


# ---------------------------------------------------------------- 阶段1：SQLCipher 开库
def phase_sql() -> int:
    import sqlcipher3
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    guid = get_guid()
    print(f"[sql] MachineGuid={guid}")
    rows_out: list[dict] = []
    for db in DBS:
        if not db.is_file():
            print(f"[sql] 缺文件: {db}")
            continue
        tmp = Path(tempfile.mkstemp(suffix=".db")[1])
        shutil.copy(db, tmp)
        opened = None
        for compat in (None, 3, 4):
            for page in (1024, 4096):
                conn = None
                try:
                    conn = sqlcipher3.connect(str(tmp))
                    conn.execute(f"PRAGMA key='{guid}'")
                    if compat:
                        conn.execute(f"PRAGMA cipher_compatibility={compat}")
                    conn.execute(f"PRAGMA cipher_page_size={page}")
                    n = conn.execute("SELECT count(*) FROM sqlite_master").fetchone()
                    if n and n[0] and n[0] > 0:
                        opened = conn
                        print(f"[sql] 开库成功 {db.name}({db.parent.name}) "
                              f"compat={compat} page={page}")
                        break
                except Exception:
                    pass
                finally:
                    if conn is not None and conn is not opened:
                        try:
                            conn.close()
                        except Exception:
                            pass
            if opened:
                break
        if not opened:
            print(f"[sql] 开库失败: {db.parent.name}/{db.name}")
            try:
                tmp.unlink()
            except OSError:
                pass
            continue
        try:
            tables = [r[0] for r in opened.execute(
                "SELECT name FROM sqlite_master WHERE type='table'").fetchall()]
            print(f"[sql] 表: {tables}")
            target = next((t for t in tables if "account" in t.lower()), None)
            if not target:
                print(f"[sql] 无账号表，跳过")
                continue
            opened.row_factory = None
            cur = opened.execute(f"SELECT * FROM {target}")
            cols = [d[0] for d in cur.description]
            for row in cur.fetchall():
                rec = {"file": f"{db.parent.name}/{db.name}", "table": target}
                for c, v in zip(cols, row):
                    if isinstance(v, bytes):
                        v = v.hex()
                    rec[c] = v
                rows_out.append(rec)
            print(f"[sql] {target}: {len(rows_out)} 行累计")
        finally:
            opened.close()
            try:
                tmp.unlink()
            except OSError:
                pass
    RAW_JSON.write_text(json.dumps(rows_out, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    print(f"[sql] 落盘 {RAW_JSON}（{len(rows_out)} 行）→ 跑 aes 阶段")
    return 0 if rows_out else 1


# ---------------------------------------------------------------- 阶段2：内层（新版格式未破，诚实降级）
def phase_aes() -> int:
    """新版格式 (51637587F6BB463a92D17DD7903A1F6F)+base64+AES（2026-09-21 实测）：
    前缀=chrome.dll 硬编码版本常量（16.3.1008.64 偏移 214727684；旁有 GUID
    8DE6E635-D3C3-41e1-9A76-4BAE64E58695），静态矩阵 ~60 组合（key/IV/剥头×ECB/CBC）
    全败，全网无公开解法 → 工单：chrome.dll 引用该常量的函数逆向。
    本阶段产出=账号清单（domain/username/时间），密文留档供破后补解。"""
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    rows = json.loads(RAW_JSON.read_text(encoding="utf-8"))
    out: list[dict] = []
    seen: set = set()
    for r in rows:
        domain, username = r.get("domain"), r.get("username")
        if domain is None:
            continue
        key = (domain, username)
        if key in seen:
            continue
        seen.add(key)
        ts = ""
        try:
            ts_hex = str(r.get("last_modify_time") or "")
            if ts_hex:
                import datetime as dt
                ts = dt.datetime.fromtimestamp(int(bytes.fromhex(ts_hex))).strftime("%Y-%m-%d")
        except Exception:  # noqa: BLE001
            ts = ""
        out.append({"domain": domain, "username": username,
                    "password_encrypted": str(r.get("password") or "")[:80],
                    "modified": ts, "source": r.get("_source")})
    CREDS_JSON.write_text(json.dumps(out, ensure_ascii=False, indent=1),
                          encoding="utf-8")
    print(f"[aes] 内层新版格式未破（工单：chrome.dll 逆向）——账号清单 {len(out)} 条 → {CREDS_JSON}")
    for o in out[:15]:
        print(f"  {str(o['domain'])[:40]:<42} {str(o['username'])[:26]:<26} {o['modified']}")
    if len(out) > 15:
        print(f"  … 共 {len(out)} 条")
    return 0 if out else 1


def main() -> int:
    parser = argparse.ArgumentParser(description="360 密码库 assis2.db 两阶段解密")
    parser.add_argument("phase", choices=["sql", "aes"])
    args = parser.parse_args()
    return phase_sql() if args.phase == "sql" else phase_aes()


if __name__ == "__main__":
    raise SystemExit(main())
