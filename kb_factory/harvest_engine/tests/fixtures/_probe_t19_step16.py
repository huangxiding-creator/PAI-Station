# -*- coding: utf-8 -*-
"""T19 破壁试验K：>6 预览页文档的新方言 6页/批验证（1 页+2 openapi）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.parse.jsonp import strip_jsonp
from kb_factory.harvest_engine.envelope import judge_book118

import httpx
from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
URL = "https://max.book118.com/html/2022/0414/5110103104004213.shtm"

facts = {"url": URL}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto(URL, timeout=60000, wait_until="domcontentloaded")
    for _ in range(12):
        page.wait_for_timeout(1000)
        if "safeline" not in page.content()[:2000]:
            break
    html = page.content()
    facts["len"] = len(html)
    facts["title"] = page.title()[:90]
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_5110103104004213.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    ctx.close()
    browser.close()

import re
m = re.search(r"aid\s*:\s*(\d+)\s*,\s*//[^\n]*\n\s*actual_page\s*:\s*(\d+)", html)
facts["internal_aid"] = m.group(1) if m else None
facts["actual_page"] = m.group(2) if m else None
m2 = re.search(r"preview_page\s*:\s*(\d+)", html)
facts["preview_page"] = m2.group(1) if m2 else None
m3 = re.search(r"view_token\s*:\s*'([^']+)'", html)
facts["view_token"] = m3.group(1) if m3 else None
m4 = re.search(r"senddate\s*:\s*'([0-9a-f]{32})'", html)
facts["senddate"] = m4.group(1) if m4 else None

if facts["view_token"] and int(facts["preview_page"] or 0) > 6:
    import time
    with httpx.Client(timeout=30.0, headers={"User-Agent": UA,
                                             "Referer": URL}) as c:
        for pg in (1, 7):
            r = c.get("https://openapi.book118.com/getPreview.html", params={
                "project_id": 1, "aid": facts["internal_aid"], "t": facts["senddate"],
                "view_token": facts["view_token"], "page": pg})
            v = judge_book118(strip_jsonp(r.text), expect_first_page=pg)
            entry = {"page": pg, "http": r.status_code, "state": v.state}
            if v.state == "ok":
                entry["keys"] = sorted(v.facts["page_urls"])
                entry["preview"] = v.facts["pages_preview"]
                entry["actual"] = v.facts["pages_actual"]
                entry["filetype"] = v.facts["filetype"]
            else:
                entry["kind"] = v.kind
                entry["detail"] = v.detail
            facts[f"openapi_p{pg}"] = entry
            time.sleep(1.1)

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step16.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1))
