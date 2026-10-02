# -*- coding: utf-8 -*-
"""One-off: engine-side zhipu optimize smoke with minted token (run on ECS).
验证 AI优化提问 走真实智谱免费链：改写成功 + 计次正确。"""
import json
import time
import urllib.request

from qianwen_engine import wechat

tok = wechat.issue_token("smoke-zhipu-0929")
req = urllib.request.Request(
    "http://127.0.0.1:8869/api/question/optimize",
    data=json.dumps({"question": "EPC 合同里业主把材料调差条款删了，结算时能主张回来吗"}).encode(),
    headers={"Authorization": "Bearer " + tok,
             "Content-Type": "application/json"},
    method="POST",
)
t0 = time.time()
d = json.load(urllib.request.urlopen(req, timeout=60))
dt = time.time() - t0
opt = d["optimized"]
print("ELAPSED", round(dt, 1), "s")
print("LEN", len(opt))
print("LEFT", d["left"])
print("OPT_HEAD", opt[:80].replace("\n", " / "))
assert len(opt) >= 10 and "?" in opt or "？" in opt, "改写无小问结构"
