# -*- coding: utf-8 -*-
"""T19 指纹墙诊断：NewView 响应状态/头/终URL/正文形状（1 请求）。"""
import json

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
DOC = "5134312044001323"
NEWVIEW = f"https://max.book118.com/index.php?g=Home&m=NewView&a=index&aid={DOC}"

facts = {"requests": []}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    def on_response(resp):
        if "book118.com" in resp.url and "static" not in resp.url:
            facts["requests"].append({
                "url": resp.url[:160], "status": resp.status,
                "server": resp.headers.get("server", ""),
                "ctype": resp.headers.get("content-type", ""),
                "len": resp.headers.get("content-length", "")})

    page.on("response", on_response)
    resp = page.goto(NEWVIEW, timeout=45000)
    facts["final_url"] = page.url
    facts["goto_status"] = resp.status if resp else None
    body = page.content()
    facts["body_repr"] = repr(body[:200])
    facts["body_len"] = len(body)
    facts["ctx_cookies"] = [c["name"] for c in ctx.cookies()]
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step6.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:2500])
