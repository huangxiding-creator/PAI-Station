# -*- coding: utf-8 -*-
"""T19 指纹墙破壁试验：curl_cffi chrome 伪装 / shtm referer（≤4 请求）。"""
import json

from curl_cffi import requests as cffi_requests

DOC = "5134312044001323"
NEWVIEW = f"https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid={DOC}"
SHTM = f"https://max.book118.com/html/2023/1010/{DOC}.shtm"  # 形态先验（日路径或不对，仅作 referer 值）

facts = {}

# 试验A：curl_cffi chrome124 直打 NewView
r = cffi_requests.get(NEWVIEW, impersonate="chrome124", timeout=30)
facts["A_cffi_direct"] = {"status": r.status_code, "len": len(r.text),
                          "has_preview_data": "PREVIEW_DATA" in r.text,
                          "head": r.text[:120]}
print(json.dumps(facts, ensure_ascii=False, indent=1))

# 试验B：A 失败时 curl_cffi 先开 shtm（种 cookie）再 NewView（带 referer，同一 session）
if not facts["A_cffi_direct"]["has_preview_data"]:
    s = cffi_requests.Session(impersonate="chrome124", timeout=30)
    r1 = s.get(f"https://max.book118.com/", timeout=30)  # 首页种 PHPSESSID
    r2 = s.get(NEWVIEW, headers={"Referer": "https://max.book118.com/"})
    facts["B_home_then_newview"] = {
        "home_status": r1.status_code, "home_len": len(r1.text),
        "newview_status": r2.status_code, "newview_len": len(r2.text),
        "has_preview_data": "PREVIEW_DATA" in r2.text}
    print(json.dumps(facts, ensure_ascii=False, indent=1))

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step7.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
