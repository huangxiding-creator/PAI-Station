# -*- coding: utf-8 -*-
import io, json, struct, sys, os, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
PATH = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\app.asar"
OUT = r"E:\AI-Station\逆向工程\work\shiflow_asar_js"
os.makedirs(OUT, exist_ok=True)
f = open(PATH, "rb")
assert f.read(4) == bytes.fromhex("04000000")
struct.unpack("<I", f.read(4)); struct.unpack("<I", f.read(4))
hdr_str_size = struct.unpack("<I", f.read(4))[0]
hdr = json.loads(f.read(hdr_str_size).decode("utf-8"))
base = 16 + hdr_str_size
files = []
def walk(node, prefix):
    for name, child in (node.get("files") or {}).items():
        p = prefix + "/" + name
        if "files" in child: walk(child, p)
        else: files.append((p.lstrip("/"), child.get("size",0), child.get("offset")))
walk(hdr, "")
print("total files:", len(files))
cands = [x for x in files if not x[0].startswith("node_modules") and x[0].endswith((".js",".html",".json")) and x[1] > 5000]
print("candidates:", len(cands))
for p, size, off in sorted(cands, key=lambda x:-x[1])[:40]:
    print(f"{size/1e3:9.1f} KB  {p}")
# extract all non-node_modules js
for p, size, off in cands:
    f.seek(base + int(off)); data = f.read(size)
    safe = p.replace("/","__")
    open(os.path.join(OUT, safe), "wb").write(data)
print("extracted to", OUT)
