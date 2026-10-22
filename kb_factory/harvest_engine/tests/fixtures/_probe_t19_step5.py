# -*- coding: utf-8 -*-
"""T19 机制验证：NewView 首跳→PREVIEW_DATA→openapi p1（主链 2 请求，非选档探针）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.parse.inline_var import extract_preview_data
from kb_factory.harvest_engine.parse.jsonp import strip_jsonp
from kb_factory.harvest_engine.envelope import judge_book118

import httpx
from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
DOC = "5134312044001323"
NEWVIEW = f"https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid={DOC}"

facts = {}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto(NEWVIEW, timeout=45000)
    html = page.content()
    facts["newview_len"] = len(html)
    facts["title"] = page.title()
    facts["preview_data"] = extract_preview_data(html)
    ctx.close()
    browser.close()

pd = facts["preview_data"]
if pd:
    r = httpx.get("https://openapi.book118.com/getPreview.html",
                  params={"project_id": pd["project_id"], "aid": pd["aid"],
                          "view_token": pd["view_token"], "aid_encode": pd["aid_encode"],
                          "page": 1}, timeout=30.0,
                  headers={"User-Agent": UA, "Referer": NEWVIEW})
    facts["openapi_status_http"] = r.status_code
    facts["openapi_len"] = len(r.text)
    try:
        payload = strip_jsonp(r.text)
        v = judge_book118(payload)
        facts["envelope_state"] = v.state
        facts["envelope_kind"] = getattr(v, "kind", "")
        if v.state == "ok":
            facts["pages_n"] = len(v.facts["page_urls"])
            facts["pages_preview"] = v.facts["pages_preview"]
            facts["pages_actual"] = v.facts["pages_actual"]
            facts["filetype"] = v.facts["filetype"]
            facts["first_url"] = v.facts["page_urls"].get(1, "")[:90]
        else:
            facts["fail_detail"] = getattr(v, "detail", "")
    except Exception as exc:
        facts["jsonp_err"] = f"{type(exc).__name__}: {exc}"

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step5.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1))
