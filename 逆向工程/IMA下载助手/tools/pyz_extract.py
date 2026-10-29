# Unpack PyInstaller PYZ archive + marshal-load every module; dump .pyc files (with header)
import struct, sys, os, zlib, marshal, importlib.util

ROOT = r"E:\AI-Station\逆向工程\IMA下载助手\extracted"
PYZ = os.path.join(ROOT, "PYZ.pyz")
OUTDIR = os.path.join(ROOT, "_pyz")

MAGIC = importlib.util.MAGIC_NUMBER  # local py313 == target py313

def load_pyz_toc():
    with open(PYZ, "rb") as f:
        data = f.read()
    assert data[:4] == b"PYZ\0", data[:4]
    pyc_magic = data[4:8]
    toc_off = struct.unpack("!I", data[8:12])[0]
    toc = marshal.loads(data[toc_off:])  # marshaled dict self-terminates
    return data, pyc_magic, toc

def main():
    data, pyc_magic, toc = load_pyz_toc()
    print(f"PYZ pyc_magic={pyc_magic.hex()} local={MAGIC.hex()} entries={len(toc)}")
    same = pyc_magic == MAGIC
    names = []
    fails = []
    for name, (typ, pos, length) in toc:
        try:
            blob = zlib.decompress(data[pos:pos+length])
        except Exception as ex:
            fails.append((name, typ, pos, length, str(ex)))
            continue
        safe = name.replace(".", "/")
        pyc_path = os.path.join(OUTDIR, safe + ".pyc")
        os.makedirs(os.path.dirname(pyc_path), exist_ok=True)
        # write proper pyc: magic(4) + flags(4) + timestamp(4)+size(4) then marshal
        with open(pyc_path, "wb") as w:
            w.write(pyc_magic + b"\x00"*12 + blob)
        names.append((name, typ, len(blob)))
    # summary: show non-stdlib-looking top-level packages
    top = {}
    for name, typ, size in names:
        t = name.split(".")[0]
        top[t] = top.get(t, 0) + 1
    print("top-level modules:", sorted(top.items()))

if __name__ == "__main__":
    main()
