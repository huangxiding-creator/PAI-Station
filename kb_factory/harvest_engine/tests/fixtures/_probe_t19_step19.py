# -*- coding: utf-8 -*-
"""T19 破壁试验M：httpx 首页暖场(cookie jar)→NewView 是否吐正文（2 请求）。"""
import json

import httpx

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
DOC = "5110103104004213"
NEWVIEW = f"https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid={DOC}"

facts = {}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA,
                                         "Referer": "https://max.book118.com/"}) as c:
    r0 = c.get("https://max.book118.com/")
    facts["home"] = {"status": r0.status_code, "len": len(r0.text)}
    facts["cookies_after_home"] = [k for k in c.cookies.keys()]
    r = c.get(NEWVIEW, headers={"Referer": "https://max.book118.com/"})
    facts["newview"] = {"status": r.status_code, "len": len(r.text),
                        "has_preview_data": "PREVIEW_DATA" in r.text,
                        "has_view_token": "view_token" in r.text,
                        "head": r.text[:160]}

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step19.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1))
