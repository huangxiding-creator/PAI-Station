# -*- coding: utf-8 -*-
"""从 blk108(app.asar) 抽指定文件（package.json + build/树 + baidu系 SDK 采样）。纯 python。"""
import json, struct, os

P = r"E:\AI-Station\kb_rev\nsis_out\blk108_110844922.bin"
OUTD = r"E:\AI-Station\kb_rev\asar_files"
os.makedirs(OUTD, exist_ok=True)
raw = open(P, "rb")
head = raw.read(16)
json_len, = struct.unpack_from("<I", head, 4)  # 含pad
js = raw.read(json_len)
obj, _ = json.JSONDecoder().raw_decode(js.decode("utf-8", "replace"))
data_start = 16 + json_len
print(f"data_start={data_start}")

def find(path):
    node = obj["files"]
    for part in [p for p in path.split("/") if p]:
        if part not in node:
            return None
        node = node[part]
    return node

def extract(path, save_as=None):
    ent = find(path)
    if not ent or "offset" not in ent:
        return None
    raw.seek(data_start + int(ent["offset"]))
    data = raw.read(ent["size"])
    out = os.path.join(OUTD, save_as or path.replace("/", "__"))
    open(out, "wb").write(data)
    return out, ent["size"]

# package.json 全文（按 manifest 尺寸截断，去 pad）
r = extract("package.json")
print("== package.json ==")
print(open(r[0], "rb").read()[:978].decode("utf-8", "replace"))
# build/ 与 winBuild/、static/ 树
for topdir in ("build", "winBuild", "static"):
    node = obj["files"].get(topdir)
    if node and "files" in node:
        subs = list(node["files"].keys())
        print(f"\n== {topdir}/ ({len(subs)} 项) ==")
        for s in sorted(subs)[:40]:
            v = node["files"][s]
            print(f"   {'D' if 'files' in v else 'F'} {s} {v.get('size','')}")
