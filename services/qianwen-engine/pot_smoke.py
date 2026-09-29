# -*- coding: utf-8 -*-
"""One-off: engine-side pot list smoke with minted token (run on ECS)."""
import json
import urllib.request

from qianwen_engine import wechat

tok = wechat.issue_token("smoke-pot-0929")
req = urllib.request.Request(
    "http://127.0.0.1:8869/api/pot/list",
    headers={"Authorization": "Bearer " + tok},
)
d = json.load(urllib.request.urlopen(req, timeout=15))
items = d["items"]
print("COUNT", len(items))
it = items[0]
print("Q1", it["question"][:36])
print("PREVIEW_LEN", len(it["preview"]))
print("LIKES", it["likes"], "FULL_CHARS", it["full_chars"])
print("LAST", items[-1]["question"][:30])
