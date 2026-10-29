# -*- coding: utf-8 -*-
"""T19 实弹探针 step4：抓搜索页 XHR（tdsearch）请求/响应形状（1页+XHR，累计~8/10）。"""
import json

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

events = []
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    def on_response(resp):
        url = resp.url
        if "book118.com" in url and not url.startswith("https://static"):
            entry = {"url": url[:200], "status": resp.status,
                     "method": resp.request.method,
                     "post": resp.request.post_data[:300] if resp.request.post_data else None,
                     "ctype": resp.headers.get("content-type", "")[:60]}
            try:
                if "search" in url.lower() or "api" in url.lower():
                    body = resp.text()
                    entry["body_head"] = body[:1200]
            except Exception as exc:
                entry["body_err"] = str(exc)[:120]
            events.append(entry)

    page.on("response", on_response)
    page.goto("https://max.book118.com/search.html?word=%E6%96%BD%E5%B7%A5%E6%96%B9%E6%A1%88",
              timeout=45000, wait_until="domcontentloaded")
    try:
        page.wait_for_load_state("networkidle", timeout=15000)
    except Exception:
        pass
    page.wait_for_timeout(3000)
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step4.json",
          "w", encoding="utf-8") as f:
    json.dump(events, f, ensure_ascii=False, indent=1)
print(json.dumps(events, ensure_ascii=False, indent=1)[:4000])
