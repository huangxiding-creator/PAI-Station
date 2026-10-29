# -*- coding: utf-8 -*-
r"""W4 诊断七号（控制面≤6 发）：官方 path+dest+newname 形态 move/copy + delete 预验。
六号结论：from/to 全形态 errno 2；官方文档口径 path+dest+newname / 纯路径数组。"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession

sess = BdnSession()
api = BdnApi(sess)
FENCE = "/API复刻测试_1029"
SUB = f"{FENCE}/sub_dir_1029"

def show(tag, fn):
    try:
        r = fn()
        print(f"[{tag}] errno=0 info={json.dumps(r.get('info'), ensure_ascii=False)[:240]}")
        return r
    except BdnError as e:
        p = getattr(e, "payload", None)
        print(f"[{tag}] errno={getattr(e, 'errno', '?')} "
              f"payload={json.dumps(p, ensure_ascii=False)[:240] if p else e}")
        return None

# 1 move：diag4.bin → sub（六号全部失败的同一动作，换官方形态）
show("move官方形态", lambda: api.move(f"{FENCE}/diag4.bin", SUB))

# 2 copy：bdnw4_1k_renamed.bin → sub
show("copy官方形态", lambda: api.copy(f"{FENCE}/bdnw4_1k_renamed.bin", SUB))

# 3 ls sub 核对
r = show("ls sub", lambda: api.list_dir(SUB))
if r:
    print(f"#  sub 内容: {[e['name'] for e in r.get('entries') or []]}")

# 4 delete：sub/diag4.bin（围栏内自有诊断件）
show("delete官方形态", lambda: api.delete([f"{SUB}/diag4.bin"]))

# 5 ls sub + recycle 复核
r = show("ls sub 二次", lambda: api.list_dir(SUB))
if r:
    names = [e["name"] for e in r.get("entries") or []]
    print(f"#  删除后 sub: {names} 消失={('diag4.bin' not in names)}")
rr = show("recycle", lambda: api.recycle_list(page=1, num=100))
if rr:
    hit = "diag4.bin" in json.dumps(rr.get("entries") or [], ensure_ascii=False)
    print(f"#  回收站含 diag4.bin: {hit}")

print(f"# 控制面 {sess.requests_sent} 发")
