# Decrypt imahelper DPAPI login credentials from the copied download.db (same user, known entropy)
import sqlite3, base64, ctypes, ctypes.wintypes as wt, sys

DB = r"E:\AI-Station\逆向工程\IMA下载助手\localstate\download.db"
PREFIX = "dpapi:v1:"
ENTROPY = b"ima-helper-login-credentials-v1"

class DATA_BLOB(ctypes.Structure):
    _fields_ = [("cbData", wt.DWORD), ("pbData", ctypes.POINTER(ctypes.c_ubyte))]

def to_blob(data: bytes) -> DATA_BLOB:
    buf = ctypes.create_string_buffer(data, len(data))
    return DATA_BLOB(len(data), ctypes.cast(buf, ctypes.POINTER(ctypes.c_ubyte))), buf

def dpapi_unprotect(data: bytes) -> bytes:
    blob, keep = to_blob(data)
    out = DATA_BLOB()
    if not ctypes.windll.crypt32.CryptUnprotectData(
        ctypes.byref(blob), None, None, None, None, 0, ctypes.byref(out)
    ):
        # with entropy
        ent, keep2 = to_blob(ENTROPY)
        if not ctypes.windll.crypt32.CryptUnprotectData(
            ctypes.byref(blob), None, ctypes.byref(ent), None, None, 0, ctypes.byref(out)
        ):
            raise OSError("CryptUnprotectData failed both plain and entropy")
    try:
        return ctypes.string_at(out.pbData, out.cbData)
    finally:
        ctypes.windll.kernel32.LocalFree(out.pbData)

def unprotect_cell(v: str) -> str:
    if not v.startswith(PREFIX):
        return v
    return dpapi_unprotect(base64.b64decode(v[len(PREFIX):])).decode("utf-8")

def main():
    con = sqlite3.connect(f"file:{DB}?mode=ro", uri=True)
    row = con.execute(
        "SELECT user_id, token, refresh_token, bkn, cookie, token_expire_time,"
        " refresh_token_expire_time, timestamp FROM login_credentials WHERE id=1"
    ).fetchone()
    cols = ["user_id", "token", "refresh_token", "bkn", "cookie",
            "token_expire_time", "refresh_token_expire_time", "timestamp"]
    for name, val in zip(cols, row):
        if name.endswith("_time"):
            print(f"{name} = {val}")
        else:
            try:
                dec = unprotect_cell(val)
                # print with secrets partially visible; this stays local in dump dir
                print(f"{name} = {dec[:120]}{'...' if len(dec) > 120 else ''} (len={len(dec)})")
                with open(rf"E:\AI-Station\逆向工程\IMA下载助手\localstate\cred_{name}.txt", "w", encoding="utf-8") as f:
                    f.write(dec)
            except Exception as ex:
                print(f"{name} FAILED: {ex}")

if __name__ == "__main__":
    main()
