# -*- coding: utf-8 -*-
r"""W4 诊断三号（≤8 发）：上传三段逐步裸测+原始响应全打印。
二号结论：api 写面通（create/filemanager）；b 段 /api/create 收尾 errno=404 待解。"""
import hashlib
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

import requests

from bdncore import BdnApi, BdnError, BdnSession, mask, md5_file

sess = BdnSession()
api = BdnApi(sess)
print(f"# 凭据 ok: bduss={mask(sess.bduss)}")

TMP = os.environ.get("TEMP", r"C:\Windows\Temp")
LOCAL = os.path.join(TMP, "bdnw4_diag3.bin")
DATA = os.urandom(1024)
with open(LOCAL, "wb") as f:
    f.write(DATA)
REMOTE = "/API复刻测试_1029/diag3.bin"
content_md5 = hashlib.md5(DATA).hexdigest()
slice_md5 = hashlib.md5(DATA).hexdigest()      # <256KB → 全量
block_list = [content_md5]

def head(tag, resp_or_dict, raw=None):
    if isinstance(resp_or_dict, dict):
        print(f"[{tag}] {json.dumps(resp_or_dict, ensure_ascii=False)[:500]}")
    else:
        print(f"[{tag}] HTTP {resp_or_dict.status_code} {str(raw or resp_or_dict.text)[:500]}")

# 1 precreate（库通道，注意 payload 在异常里也能拿到）
try:
    pre = api.precreate(REMOTE, len(DATA), block_list, content_md5, slice_md5,
                        rtype=3)
    head("1 precreate", pre)
except BdnError as e:
    pre = getattr(e, "payload", None) or {}
    head("1 precreate FAIL", pre)
uploadid = pre.get("uploadid") or ""
print(f"# uploadid={uploadid!r} return_type={pre.get('return_type')} "
      f"block_list(待传)={pre.get('block_list')}")

# 2 locateupload 原始响应
r = requests.get("https://d.pcs.baidu.com/rest/2.0/pcs/file",
                 params={"method": "locateupload", "upload_version": "2.0",
                         "app_id": 250528, "clienttype": 8, "web": 1},
                 headers={"Cookie": sess.cookie_header(),
                          "User-Agent": sess.ua}, timeout=(10, 30))
head("2 locateupload", r)

host = None
try:
    servers = (r.json().get("servers") or [])
    for x in servers:
        u = x if isinstance(x, str) else (x.get("server") or x.get("url") or "")
        if str(u).startswith("http"):
            host = str(u).rstrip("/")
            break
except ValueError:
    pass
host = host or "https://d.pcs.baidu.com"
print(f"# 选 host={host}")

# 3 superfile2 单片原始响应
t0 = int(time.time())
partseq = 0
try:
    r3 = requests.post(
        host + "/rest/2.0/pcs/superfile2",
        params={"method": "upload", "type": "tmpfile", "uploadid": uploadid,
                "partseq": partseq, "app_id": 250528, "web": 1, "clienttype": 8},
        data={"path": REMOTE},
        files={"file": (os.path.basename(LOCAL), DATA)},
        headers={"Cookie": sess.cookie_header(), "User-Agent": sess.ua},
        timeout=(10, 120))
    head("3 superfile2", r3)
except Exception as e:
    print(f"[3 superfile2] EXC {type(e).__name__}: {e}")

# 4 create（当前库形态：clienttype+app_id，无 web）
try:
    cr = sess.post("/api/create",
                   params={"clienttype": 8, "app_id": 250528},
                   data={"path": REMOTE, "size": len(DATA), "isdir": 0,
                         "rtype": 3, "uploadid": uploadid,
                         "block_list": json.dumps(block_list, separators=(",", ":"))})
    head("4 create", cr)
except BdnError as e:
    head("4 create FAIL", getattr(e, "payload", None) or {})

# 5 create 变体：加 web=1 + isdir=0 显式
try:
    cr = sess.post("/api/create",
                   params={"clienttype": 8, "app_id": 250528, "web": 1},
                   data={"path": REMOTE, "size": len(DATA), "isdir": 0,
                         "rtype": 3, "uploadid": uploadid,
                         "block_list": json.dumps(block_list, separators=(",", ":"))})
    head("5 create+web", cr)
except BdnError as e:
    head("5 create+web FAIL", getattr(e, "payload", None) or {})

# 6 是否已落盘
try:
    m = api.meta_by_path(REMOTE)
    print(f"[6 metas] size={m.get('size')} md5={m.get('md5')}")
except BdnError as e:
    print(f"[6 metas] {type(e).__name__} errno={getattr(e, 'errno', '?')}")

print(f"# 总控制面请求 {sess.requests_sent} 发")
for x in sess.request_log:
    print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} errno={x['errno']} {x['ms']}ms")
