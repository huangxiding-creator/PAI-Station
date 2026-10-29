# PyInstaller CArchive extractor (py313 target) — writes into empty outdir
import struct, sys, os, zlib

EXE = r"E:\AI-Station\逆向工程\逆向标的\IMA批量下载助手.exe"
OUT = r"E:\AI-Station\逆向工程\IMA下载助手\extracted"
COOKIE_MAGIC = b"MEI\x0c\x0b\x0a\x0b\x0e"

def main():
    data = open(EXE, "rb").read()
    pos = data.rfind(COOKIE_MAGIC)
    if pos < 0:
        sys.exit("no PyInstaller cookie")
    lenPkg, tocOff, tocLen, pyver = struct.unpack("!IIII", data[pos+8:pos+24])
    overlayStart = len(data) - lenPkg
    print(f"pyver={pyver} overlayStart={overlayStart:#x} entries_toc={tocOff:#x}+{tocLen:#x}")
    toc = data[overlayStart+tocOff: overlayStart+tocOff+tocLen]
    i = 0
    entries = []
    while i < len(toc):
        (esize,) = struct.unpack("!I", toc[i:i+4])
        epos, csize, usize, cflag = struct.unpack("!IIIB", toc[i+4:i+17])
        etype = toc[i+17:i+18].decode("latin1")
        name = toc[i+18:i+esize].rstrip(b"\x00").decode("utf-8", "replace")
        entries.append((epos, csize, usize, cflag, etype, name))
        i += esize
    print(f"{len(entries)} TOC entries")
    for epos, csize, usize, cflag, etype, name in entries:
        blob = data[overlayStart+epos: overlayStart+epos+csize]
        if cflag:
            try:
                blob = zlib.decompress(blob)
            except Exception as ex:
                print("  !zlib fail", name, ex)
        safe = name.replace("\\", "/")
        while safe.startswith("/"):
            safe = safe[1:]
        dest = os.path.join(OUT, *safe.split("/"))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "wb") as w:
            w.write(blob)
        tag = {"s": "SCRIPT", "m": "MODULE", "b": "BINARY", "z": "PYZ", "x": "DATA"}.get(etype, etype)
        print(f"  [{tag:6s}] {name}  ({usize} B)")

if __name__ == "__main__":
    main()
