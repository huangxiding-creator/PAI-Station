# -*- coding: utf-8 -*-
r"""W4 诊断四号（控制面≤3 发）：superfile2 参数变体矩阵，31023 param error 逐项排查。
三号结论：precreate/locateupload 通；superfile2 400/31023；error_code≠errno 是失败信使。
【勘误 1029】31023 归因 UA 系本矩阵变量未隔离误判（V1-V4 全缺参、唯全参 V5 恰为 CEF 腿）：
ss-judge 重放 native UA+全参（path 双放+vip+web+app_id）= HTTP 200 md5 回执。真门=参数完整度。
本脚本当时未落档原始输出（judge 指出），此后诊断一律 echo 落 tests\_diag_archive\。"""
import hashlib
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

import requests

from bdncore import BdnApi, BdnError, BdnSession, mask

sess = BdnSession()
api = BdnApi(sess)

TMP = os.environ.get("TEMP", r"C:\Windows\Temp")
LOCAL = os.path.join(TMP, "bdnw4_diag4.bin")
DATA = os.urandom(1024)
with open(LOCAL, "wb") as f:
    f.write(DATA)
REMOTE = "/API复刻测试_1029/diag4.bin"
content_md5 = hashlib.md5(DATA).hexdigest()
HOST = "https://c5.pcs.baidu.com"

pre = api.precreate(REMOTE, len(DATA), [content_md5], content_md5, content_md5,
                    rtype=3)
uploadid = pre.get("uploadid")
print(f"# precreate uploadid={uploadid[:24]}… 待传={pre.get('block_list')}")

def part(tag, params, data=None, files_extra=None, ua=None):
    try:
        r = requests.post(HOST + "/rest/2.0/pcs/superfile2", params=params,
                          data=data if data is not None else {},
                          files={"file": ("diag4.bin", DATA)},
                          headers={"Cookie": sess.cookie_header(),
                                   "User-Agent": ua or sess.ua},
                          timeout=(10, 120))
        body = r.text[:200]
        print(f"[{tag}] HTTP {r.status_code} {body}")
        ok = r.status_code == 200 and "error_code" not in r.text[:60]
        return ok
    except Exception as e:
        print(f"[{tag}] EXC {type(e).__name__}: {e}")
        return False

B = {"method": "upload", "type": "tmpfile", "uploadid": uploadid, "partseq": 0}

ok = part("V1 +vip2+web", {**B, "vip": 2, "web": 1, "clienttype": 8,
                           "app_id": 250528}, {"path": REMOTE})
if not ok:
    ok = part("V2 path入query+vip1", {**B, "vip": 1, "path": REMOTE})
if not ok:
    ok = part("V3 最小query+path query", {"method": "upload", "type": "tmpfile",
                                          "uploadid": uploadid, "partseq": 0,
                                          "path": REMOTE})
if not ok:
    ok = part("V4 +partoffset", {**B, "vip": 2, "path": REMOTE, "partoffset": 0,
                                 "partbytes": len(DATA)})
if not ok:
    ok = part("V5 CEF UA", {**B, "vip": 2, "web": 1, "app_id": 250528,
                            "path": REMOTE}, {"path": REMOTE},
              ua=("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 "
                  "(KHTML, like Gecko) baidunetdisk/8.2.5 Chrome/108.0.5359.215 "
                  "Electron/22.3.27 Safari/537.36;netdisk;8.2.5.103;PC;PC-Windows;"
                  "10.0.19045;WindowsBaiduYunGuanJia"))

if ok:
    try:
        cr = sess.post("/api/create",
                       params={"clienttype": 8, "app_id": 250528, "web": 1},
                       data={"path": REMOTE, "size": len(DATA), "isdir": 0,
                             "rtype": 3, "uploadid": uploadid,
                             "block_list": json.dumps([content_md5],
                                                      separators=(",", ":"))})
        print(f"[create] OK: {json.dumps(cr, ensure_ascii=False)[:300]}")
    except BdnError as e:
        print(f"[create] errno={getattr(e, 'errno', '?')}: "
              f"{json.dumps(getattr(e, 'payload', None), ensure_ascii=False)[:300]}")
    try:
        m = api.meta_by_path(REMOTE)
        print(f"[metas] size={m.get('size')} md5匹配="
              f"{(m.get('md5') or '').lower() == content_md5}")
    except BdnError as e:
        print(f"[metas] errno={getattr(e, 'errno', '?')}")

print(f"# 控制面 {sess.requests_sent} 发")
