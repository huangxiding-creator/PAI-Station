# -*- coding: utf-8 -*-
"""Minimal read-only ASAR directory lister (Chromium archive format)."""
import io, json, struct, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

PATH = r"e:\AI-Station\逆向工程\extracted\app64\resources\app.asar"
f = open(PATH, "rb")
magic = f.read(4)
assert magic == bytes.fromhex("04000000"), magic
hdr_size = struct.unpack("<I", f.read(4))[0]
hdr_obj_size = struct.unpack("<I", f.read(4))[0]
hdr_str_size = struct.unpack("<I", f.read(4))[0]
hdr = json.loads(f.read(hdr_str_size).decode("utf-8"))
base = 16 + hdr_str_size

files = []
def walk(node, prefix):
    for name, child in (node.get("files") or {}).items():
        p = prefix + "/" + name
        if "files" in child:
            walk(child, p)
        else:
            files.append((p.lstrip("/"), child.get("size", 0), child.get("offset")))

walk(hdr, "")
print("total files:", len(files))
top = {}
for p, size, off in files:
    seg = p.split("/")[0]
    top.setdefault(seg, [0, 0])
    top[seg][0] += 1
    top[seg][1] += size
for seg, (cnt, sz) in sorted(top.items(), key=lambda kv: -kv[1][1]):
    print(f"{seg:50s} {cnt:5d} files {sz/1e6:10.2f} MB")

print("\n== non-node_modules files ==")
for p, size, off in files:
    if not p.startswith("node_modules"):
        print(f"{size/1e3:9.1f} KB  {p}")
