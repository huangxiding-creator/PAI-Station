# -*- coding: utf-8 -*-
"""T19 破壁试验C：httpx(HTTP/1.1 缺省) 直打 NewView（1 请求）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.parse.inline_var import extract_preview_data

import httpx

DOC = "5134312044001323"
NEWVIEW = f"https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid={DOC}"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

facts = {}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA,
                                         "Referer": "https://max.book118.com/"}) as c:
    r = c.get(NEWVIEW)
    facts["http_version"] = str(r.http_version)
    facts["status"] = r.status_code
    facts["len"] = len(r.text)
    facts["has_preview_data"] = "PREVIEW_DATA" in r.text
    pd = extract_preview_data(r.text) if facts["has_preview_data"] else None
    facts["preview_data"] = pd
    facts["title"] = (r.text.split("<title>")[1].split("</title>")[0][:80]
                      if "<title>" in r.text else "")

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step8.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:1600])
