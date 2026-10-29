# -*- coding: utf-8 -*-
"""解析 blk108 (app.asar) 头 JSON：全量文件清单 + 关键文件定位。纯 python 只读。"""
import json, struct, os

P = r"E:\AI-Station\kb_rev\nsis_out\blk108_110844922.bin"
OUTD = r"E:\AI-Station\kb_rev"
d = open(P, "rb").read(8_000_000)  # 头部足够
pickle_size, = struct.unpack_from("<I", d, 0)      # 4
json_len, = struct.unpack_from("<I", d, 4)          # 0x0067b448
json_len2, = struct.unpack_from("<I", d, 8)
print(f"pickle_size={pickle_size} json_len={json_len} json_len2={json_len2}")
raw = open(P, "rb")
raw.seek(16)
js = raw.read(json_len)
obj, _ = json.JSONDecoder().raw_decode(js.decode("utf-8", "replace"))
files = obj.get("files", {})
names = list(files.keys())
print(f"asar 顶层条目 {len(names)} 个：")
for n in sorted(names):
    t = files[n]
    kind = "D" if "files" in t else "F"
    size = t.get("size", "")
    print(f"  [{kind}] {n} {size}")

def walk(prefix, node, out):
    for k, v in node.items():
        if "files" in v:
            walk(prefix + "/" + k, v["files"], out)
        else:
            out.append((prefix + "/" + k, v.get("size", 0)))

flat = []
walk("", files, flat)
print(f"\n总文件数 {len(flat)}")
with open(os.path.join(OUTD, "asar_manifest.txt"), "w", encoding="utf-8") as f:
    for p, s in flat:
        f.write(f"{s}\t{p}\n")
print("-> kb_rev/asar_manifest.txt")
# 关键入口线索
for key in ("package.json", "main.js", "app.js", "index.js", "electron-main", "dist", "src", "node_modules"):
    hits = [p for p, _ in flat if key in p][:6]
    if hits:
        print(f"含 '{key}' 前6: {hits}")
