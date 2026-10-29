# -*- coding: utf-8 -*-
"""T19 破壁试验E：.shtm 文档页里挖 PREVIEW_DATA（1 请求）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.parse.inline_var import extract_preview_data

import httpx

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
PATH_DOC = "/html/2022/1214/6115103231005025.shtm"
URL = "https://max.book118.com" + PATH_DOC

facts = {"url": URL}
with httpx.Client(timeout=30.0, headers={"User-Agent": UA}) as c:
    r = c.get(URL)
    facts["status"] = r.status_code
    facts["len"] = len(r.text)
    facts["http_version"] = str(r.http_version)
    html = r.text
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_live.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    facts["has_preview_data"] = "PREVIEW_DATA" in html
    facts["preview_data"] = extract_preview_data(html) if facts["has_preview_data"] else None
    facts["title"] = (html.split("<title>")[1].split("</title>")[0][:100]
                      if "<title>" in html else "")
    facts["has_newview_ref"] = "NewView" in html

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step10.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1))
