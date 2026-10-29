# -*- coding: utf-8 -*-
"""Judge one-off probe (3 requests total, all fence-contained / non-landing):
A) xpan write create isdir=1 -> claim: errno 9019 need verify (refused, nothing created)
B) precreate(1KB) + superfile2 with NATIVE UA -> claim: error_code 31023 param error
   (no /api/create call => no file lands; uploadid session only)
"""
import hashlib, json, os, sys
REPLICA = r"E:\AI-Station\逆向工程\baidu-netdisk\replica"
sys.path.insert(0, REPLICA)
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")
from bdncore import BdnApi, BdnError, BdnSession

sess = BdnSession()
api = BdnApi(sess)
F = "/API复刻测试_1029"

# --- A: xpan write channel (claim: 9019) ---
try:
    r = sess.post("/rest/2.0/xpan/file",
                  params={"method": "create"},
                  data={"path": F + "/judge_xpan_probe", "isdir": 1, "rtype": 0})
    print(f"[A xpan-create] errno={r.get('errno')} errmsg={r.get('errmsg') or r.get('show_msg')}")
except BdnError as e:
    print(f"[A xpan-create] REFUSED errno={e.errno} payload={json.dumps(getattr(e,'payload',None), ensure_ascii=False)[:200]}")

# --- B: superfile2 native UA (claim: 31023 param error) ---
DATA = os.urandom(1024)
c_md5 = hashlib.md5(DATA).hexdigest()
pre = api.precreate(F + "/judge_sf2.bin", len(DATA), [c_md5], c_md5, c_md5, rtype=3)
up = pre.get("uploadid")
print(f"[B precreate] return_type={pre.get('return_type')} uploadid={'yes' if up else 'NO'}")
if up:
    import requests
    host = "https://d.pcs.baidu.com"
    try:
        loc = api.locate_upload()
        if loc.get("servers"):
            host = loc["servers"][0]
    except BdnError:
        pass
    url = host + "/rest/2.0/pcs/superfile2"
    params = {"method": "upload", "type": "tmpfile", "uploadid": up,
              "partseq": 0, "vip": 2, "web": 1, "app_id": 250528, "path": F + "/judge_sf2.bin"}
    rr = requests.post(url, params=params, data={"path": F + "/judge_sf2.bin"},
                       files={"file": ("judge_sf2.bin", DATA)},
                       headers={"Cookie": sess.cookie_header(), "User-Agent": sess.ua},
                       timeout=(10, 60))
    body = rr.text[:200]
    print(f"[B superfile2 NATIVE-UA] HTTP {rr.status_code} body={body}")

# verify probe A left nothing (read-back, 1 req)
try:
    r = api.list_dir(F)
    names = [e["name"] for e in r.get("entries") or []]
    print(f"[post] judge_xpan_probe created? {'judge_xpan_probe' in names} | judge_sf2 landed? {'judge_sf2.bin' in names}")
except BdnError as e:
    print(f"[post] ls fail {e}")
print(f"# total control requests: {sess.requests_sent}")
