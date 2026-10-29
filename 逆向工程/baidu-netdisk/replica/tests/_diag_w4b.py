# -*- coding: utf-8 -*-
r"""W4 诊断二号（≤8 发）：/api 家族写面（api/create + api/filemanager）。
一号结论：xpan 写面 9019 need verify；pcs mkdir 假成功（目录未建出）。"""
import json
import sys, os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, mask

sess = BdnSession()
api = BdnApi(sess)
print(f"# 凭据 ok: bduss={mask(sess.bduss)}")

def show(tag, fn):
    try:
        r = fn()
        print(f"[{tag}] OK: {json.dumps(r, ensure_ascii=False)[:300]}")
        return r
    except BdnError as e:
        p = getattr(e, "payload", None)
        print(f"[{tag}] {type(e).__name__} errno={getattr(e, 'errno', '?')}: "
              f"{json.dumps(p, ensure_ascii=False)[:300] if p else e}")
        return None

# 0 收割 bdstoken（loginStatus 明文发放，PROTOCOL G1）
r = show("loginStatus", lambda: api.login_status())
bdstoken = ((r or {}).get("login_info") or {}).get("bdstoken") or ""
print(f"# bdstoken len={len(bdstoken)}")

Q = {"clienttype": 8, "app_id": 250528, "web": 1}

# A: api/create 建目录（web 客户端同款）
show("A api/create", lambda: sess.post("/api/create", params=Q,
    data={"path": "/API复刻测试_1029", "isdir": 1, "rtype": 0}))

# B: 加 bdstoken 重试（若 A 失败）
show("B api/create+bdstoken", lambda: sess.post("/api/create",
    params={**Q, "bdstoken": bdstoken},
    data={"path": "/API复刻测试_1029", "isdir": 1, "rtype": 0}))

# C: ls 验证落点
show("C ls prefix", lambda: api.list_dir("/API复刻测试_1029"))

# D: api/filemanager rename（目录改名，围栏内）
show("D filemanager rename", lambda: sess.post("/api/filemanager",
    params={**Q, "opera": "rename", "async": 0, "ondup": "newcopy"},
    data={"filelist": json.dumps([{"path": "/API复刻测试_1029",
                                   "newname": "renamed_1029"}],
                                 ensure_ascii=False, separators=(",", ":"))}))

# E: ls / 验证改名
r = show("E ls /", lambda: api.list_dir("/"))
if r:
    names = [e["name"] for e in r.get("entries") or []]
    print(f"#  根目录: {names}")

print(f"# 总请求 {sess.requests_sent} 发")
for x in sess.request_log:
    print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} errno={x['errno']} {x['ms']}ms")
