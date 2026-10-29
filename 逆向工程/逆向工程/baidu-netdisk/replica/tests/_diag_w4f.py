# -*- coding: utf-8 -*-
r"""W4 诊断六号（控制面≤8 发）：服务端指纹收割+秒传V4 / move 变体带 payload。"""
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
LOCAL = os.path.join(TMP, "bdnw4_10m.bin")
size = os.path.getsize(LOCAL)
content_md5 = md5_file(LOCAL)
slice_md5 = slice_md5_file(LOCAL)
digests = block_md5s(LOCAL, block_ranges(size, 4 * 1024 * 1024))
FENCE = "/API复刻测试_1029"
REMOTE10 = f"{FENCE}/bdnw4_10m.bin"

def dump(tag, e):
    p = getattr(e, "payload", None)
    print(f"[{tag}] errno={getattr(e, 'errno', '?')} "
          f"payload={json.dumps(p, ensure_ascii=False)[:300] if p else '(无)'}")

# 1 服务端指纹：metas 裸响应全 dump（找 md5/block_list/dlink 字段形态）
try:
    r = sess.get("/api/filemetas", params={
        "fsids": json.dumps([0], separators=(",", ":")),  # 占位，先看形状会报错
        "dlink": 1, "clienttype": 8})
    print(f"[metas占位] {json.dumps(r, ensure_ascii=False)[:200]}")
except BdnError as e:
    dump("metas占位", e)

# 1b 真 fsid（ls 定位）
try:
    lr = api.list_dir(FENCE)
    fsid = None
    for en in lr.get("entries") or []:
        if en["name"] == "bdnw4_10m.bin":
            fsid = en["fs_id"]
    print(f"# fsid={fsid}")
    if fsid:
        mr = sess.get("/api/filemetas", params={
            "fsids": json.dumps([fsid], separators=(",", ":")),
            "dlink": 1, "clienttype": 8})
        info = (mr.get("info") or [{}])[0]
        keep = {k: info.get(k) for k in
                ("md5", "block_list", "dlink", "size", "fs_id", "category")}
        print(f"[metas指纹] {json.dumps(keep, ensure_ascii=False)[:400]}")
        srv_md5 = (info.get("md5") or "").lower()
        srv_blocks = info.get("block_list")
except BdnError as e:
    dump("metas真fsid", e)
    srv_md5, srv_blocks = None, None

# 2 秒传V4：服务端 md5 + （若有）服务端 block_list
try:
    bl = srv_blocks if isinstance(srv_blocks, list) and srv_blocks else digests
    r = sess.post("/api/precreate",
                  params={"clienttype": 8, "app_id": 250528, "web": 1},
                  data={"path": f"{FENCE}/diag6_v4.bin", "size": size,
                        "isdir": 0, "autoinit": 1, "rtype": 3,
                        "block_list": json.dumps(bl, separators=(",", ":")),
                        "content-md5": srv_md5 or content_md5,
                        "slice-md5": slice_md5,
                        "local_ctime": int(time.time()),
                        "local_mtime": int(time.time())})
    print(f"[V4 服务端指纹秒传] return_type={r.get('return_type')} "
          f"待传={len(r.get('block_list') or []) if isinstance(r.get('block_list'), list) else '-'}")
except BdnError as e:
    dump("V4", e)

# 3 move 变体（src=围栏内 bdnw4_1k_renamed.bin → sub_dir_1029）
SRC = f"{FENCE}/bdnw4_1k_renamed.bin"
DST = f"{FENCE}/sub_dir_1029"
import urllib.parse
def mv(tag, filelist, ondup="newcopy", async_=0, clienttype=8):
    try:
        r = sess.post("/api/filemanager",
                      params={"clienttype": clienttype, "app_id": 250528, "web": 1,
                              "opera": "move", "async": async_, "ondup": ondup},
                      data={"filelist": json.dumps(filelist, ensure_ascii=False,
                                                   separators=(",", ":"))})
        print(f"[{tag}] errno=0 info={json.dumps(r.get('info'), ensure_ascii=False)[:200]}")
        return True
    except BdnError as e:
        dump(tag, e)
        return False

ok = mv("M1 ondup=fail", [{"from": SRC, "to": f"{DST}/bdnw4_1k_renamed.bin"}],
        ondup="fail")
if not ok:
    ok = mv("M2 async=2", [{"from": SRC, "to": f"{DST}/bdnw4_1k_renamed.bin"}],
            async_=2)
if not ok:
    ok = mv("M3 to=目录+newname", [{"from": SRC, "to": DST,
                                    "newname": "bdnw4_1k_renamed.bin"}])
if not ok:
    ok = mv("M4 clienttype=0", [{"from": SRC, "to": f"{DST}/bdnw4_1k_renamed.bin"}],
            clienttype=0)

if ok:
    r = api.list_dir(DST)
    names = [e["name"] for e in r.get("entries") or []]
    print(f"[move核对] sub={names}")

print(f"# 控制面 {sess.requests_sent} 发")
for x in sess.request_log:
    print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} errno={x['errno']} {x['ms']}ms")
