# -*- coding: utf-8 -*-
r"""W4 诊断探针（一次性，≤6 发）：mkdir 主形态真实 errno / 目录落点 / filediff 冷启动变体。"""
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
        s = json.dumps(r, ensure_ascii=False)
        print(f"[{tag}] OK: {s[:400]}")
        return r
    except BdnError as e:
        print(f"[{tag}] {type(e).__name__} errno={getattr(e, 'errno', '?')}: "
              f"{json.dumps(getattr(e, 'payload', None), ensure_ascii=False)[:400] if getattr(e, 'payload', None) else e}")
        return None

# 1 根目录里找测试目录（验证 pcs 兜底建到哪了）
r = show("ls-root", lambda: api.list_dir("/"))
if r:
    names = [(e["name"], e["isdir"]) for e in r.get("entries") or []]
    hit = [n for n in names if "复刻" in n[0] or "API" in n[0]]
    print(f"#  根目录命中: {hit}")
    print(f"#  根目录全部: {[n[0] for n in names]}")

# 2 ls 测试目录本体
show("ls-prefix", lambda: api.list_dir("/API复刻测试_1029"))

# 3 xpan create 建子目录（主形态裸测，不兜底）
show("xpan-create-raw", lambda: sess.post("/rest/2.0/xpan/file",
    params={"method": "create"},
    data={"path": "/API复刻测试_1029/probe_xpan", "isdir": 1, "rtype": 0}))

# 4 filemanager 建名（另一主形态参考：xpan filemanager 无 mkdir opera，跳过）

# 5 filediff 冷启动变体：cursor="0"
show("filediff-cursor0", lambda: api.filediff("0"))

print(f"# 总请求 {sess.requests_sent} 发")
for x in sess.request_log:
    print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} errno={x['errno']} {x['ms']}ms")
