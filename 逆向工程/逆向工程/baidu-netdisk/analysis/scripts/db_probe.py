# -*- coding: utf-8 -*-
"""Read-only SQLite schema probe + UTF16 key-name probe. Copies DBs to analysis/tmp first
(running client holds locks). Prints schemas/counts/key names only - never row values.
Usage: python -I db_probe.py <db1> [db2 ...] --u16 <utf16file>
"""
import sys, os, shutil, sqlite3, json, re, tempfile

def probe_db(src, tmpdir):
    base = os.path.basename(src)
    dst = os.path.join(tmpdir, base)
    try:
        shutil.copy(src, dst)
        for ext in ("-wal", "-shm"):
            if os.path.exists(src + ext):
                shutil.copy(src + ext, dst + ext)
    except OSError as e:
        return {"db": src, "copy_error": str(e)}
    out = {"db": src, "tables": []}
    try:
        con = sqlite3.connect("file:%s?mode=ro" % dst.replace("\\", "/"), uri=True)
        cur = con.cursor()
        rows = cur.execute("SELECT name, sql FROM sqlite_master WHERE type='table'").fetchall()
        for name, sql in rows:
            t = {"name": name, "sql": (sql or "")[:400]}
            try:
                t["rows"] = cur.execute('SELECT COUNT(*) FROM "%s"' % name).fetchone()[0]
            except Exception:
                pass
            out["tables"].append(t)
        con.close()
    except Exception as e:
        out["open_error"] = repr(e)
    return out

def probe_u16(path):
    data = open(path, "rb").read()
    try:
        txt = data.decode("utf-16-le", "ignore")
    except Exception:
        return {"file": path, "error": "decode"}
    keys = set()
    for m in re.finditer(r"([\w\-]{2,40})\s*[=:]\s*(\S{4,})", txt):
        keys.add(m.group(1))
    return {"file": path, "utf16_keys": sorted(keys)[:60], "head": txt[:80]}

if __name__ == "__main__":
    tmpdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "tmp")
    os.makedirs(tmpdir, exist_ok=True)
    args = sys.argv[1:]
    u16 = None
    if "--u16" in args:
        i = args.index("--u16")
        u16 = args[i + 1]
        args = args[:i] + args[i + 2:]
    res = [probe_db(p, tmpdir) for p in args]
    if u16:
        res.append(probe_u16(u16))
    print(json.dumps(res, ensure_ascii=True, indent=1))
