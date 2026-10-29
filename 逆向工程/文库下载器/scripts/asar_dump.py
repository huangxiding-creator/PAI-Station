# -*- coding: utf-8 -*-
r"""通用 ASAR 全量解包。用法: py -3 asar_dump.py <app.asar> <out_dir>
纯 python 静态解包（零执行纪律）。"""
import json, struct, os, sys

P, OUTD = sys.argv[1], sys.argv[2]
os.makedirs(OUTD, exist_ok=True)

raw = open(P, "rb")
# asar 实测布局: [4B pickle=4][4B strSizePad][4B strSize][4B jsonLen][json@16][pad to 4][data]
# data_start = align4(16 + jsonLen) —— 冰点 asar 实测校准 64468
head = raw.read(16)
json_len, = struct.unpack_from("<I", head, 12)
data_start = (16 + json_len + 3) & ~3
obj = json.loads(raw.read(json_len + 8)[:json_len].decode("utf-8", "replace"))
print(f"data_start={data_start} (json_len={json_len})")

count = [0]
def walk(node, prefix):
    files = node.get("files", {})
    for name, ent in files.items():
        path = prefix + "/" + name if prefix else name
        if "files" in ent:
            os.makedirs(os.path.join(OUTD, path), exist_ok=True)
            walk(ent, path)
        elif "offset" in ent:
            raw.seek(data_start + int(ent["offset"]))
            data = raw.read(ent["size"])
            outp = os.path.join(OUTD, path)
            os.makedirs(os.path.dirname(outp), exist_ok=True)
            open(outp, "wb").write(data)
            count[0] += 1
            if ent["size"] > 30000 or name.endswith(".json"):
                print(f"  {ent['size']:>9}  {path}")

walk(obj, "")
print(f"total files extracted: {count[0]}")
