# -*- coding: utf-8 -*-
import io, json, struct, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
PATH = r"E:\AI-Station\逆向工程\work\shiflow_unpack\resources\app.asar"
f = open(PATH, "rb")
assert f.read(4) == bytes.fromhex("04000000")
struct.unpack("<I", f.read(4)); struct.unpack("<I", f.read(4))
n = struct.unpack("<I", f.read(4))[0]
hdr = json.loads(f.read(n).decode("utf-8"))
files = []
def walk(node, prefix):
    for name, child in (node.get("files") or {}).items():
        p = prefix + "/" + name
        if "files" in child: walk(child, p)
        else: files.append((p.lstrip("/"), child.get("size",0)))
walk(hdr, "")
top = {}
for p, size in files:
    seg = "/".join(p.split("/")[:2])
    top.setdefault(seg, [0,0]); top[seg][0]+=1; top[seg][1]+=size
for seg,(c,s) in sorted(top.items(), key=lambda kv:-kv[1][1])[:35]:
    print(f"{seg:55s} {c:6d}f {s/1e6:9.2f}MB")
print("== out/ == ")
for p,size in files:
    if p.startswith("out/"): print(f"{size/1e3:9.1f}KB {p}")
