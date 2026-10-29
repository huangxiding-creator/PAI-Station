# -*- coding: utf-8 -*-
r"""W4 诊断五号（控制面≤7 发）：秒传变体矩阵 + move 全目标路径修复复核。
四号结论：move 的 to 要全路径；秒传 return_type=1 miss 待解。"""
import hashlib
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, block_md5s, block_ranges, md5_file, slice_md5_file

sess = BdnSession()
api = BdnApi(sess)
UK = 587408217
TMP = os.environ.get("TEMP", r"C:\Windows\Temp")
LOCAL = os.path.join(TMP, "bdnw4_10m.bin")          # 四跑 c1 同款内容（已在云端）
size = os.path.getsize(LOCAL)
content_md5 = md5_file(LOCAL)
slice_md5 = slice_md5_file(LOCAL)
digests = block_md5s(LOCAL, block_ranges(size, 4 * 1024 * 1024))
print(f"# size={size} content_md5={content_md5} 块数={len(digests)}")

def pre(tag, path, **over):
    try:
        r = api.precreate(path, size, digests, content_md5, slice_md5, **over)
        print(f"[{tag}] errno=0 return_type={r.get('return_type')} "
              f"uploadid={'有' if r.get('uploadid') else '无'} "
              f"待传={len(r.get('block_list') or []) if isinstance(r.get('block_list'), list) else r.get('block_list')}")
        return r
    except BdnError as e:
        print(f"[{tag}] errno={getattr(e, 'errno', '?')}: {e}")
        return None

# V1 基线（四跑 e 同形态）
pre("V1 rtype3", "/API复刻测试_1029/diag5_v1.bin", rtype=3)
# V2 rtype 变体
pre("V2 rtype0", "/API复刻测试_1029/diag5_v2.bin", rtype=0)
# V3 V2秒传腿：data=md5(uk+content_md5+ts)+data_offset/length/content（蓝本公式）
ts = int(time.time())
mixed = hashlib.md5(f"{UK}{content_md5}{ts}".encode()).hexdigest()
sub = 256 * 1024
offset = int(mixed[:8], 16) % (size - sub + 1)
with open(LOCAL, "rb") as f:
    f.seek(offset)
    content_blob = f.read(sub)
try:
    r = sess.post("/api/precreate",
                  params={"clienttype": 8, "app_id": 250528, "web": 1},
                  data={"path": "/API复刻测试_1029/diag5_v3.bin", "size": size,
                        "isdir": 0, "autoinit": 1, "rtype": 3,
                        "block_list": json.dumps(digests, separators=(",", ":")),
                        "content-md5": content_md5, "slice-md5": slice_md5,
                        "data": mixed, "data_offset": offset, "data_length": sub,
                        "content": content_blob,
                        "local_ctime": ts, "local_mtime": ts})
    print(f"[V3 秒传V2腿] errno=0 return_type={r.get('return_type')}")
except BdnError as e:
    print(f"[V3 秒传V2腿] errno={getattr(e, 'errno', '?')}: "
          f"{json.dumps(getattr(e, 'payload', None), ensure_ascii=False)[:200]}")

# move 全目标路径修复复核（围栏内：diag4.bin → sub_dir_1029）
try:
    r = api.move("/API复刻测试_1029/diag4.bin", "/API复刻测试_1029/sub_dir_1029")
    print(f"[move修复] errno=0 info={json.dumps(r.get('info'), ensure_ascii=False)[:200]}")
    r2 = api.list_dir("/API复刻测试_1029/sub_dir_1029")
    names = [e["name"] for e in r2.get("entries") or []]
    print(f"[move核对] sub_dir={names} 命中={('diag4.bin' in names)}")
except BdnError as e:
    print(f"[move修复] errno={getattr(e, 'errno', '?')}: {e}")

print(f"# 控制面 {sess.requests_sent} 发")
for x in sess.request_log:
    print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} errno={x['errno']} {x['ms']}ms")
