# -*- coding: utf-8 -*-
"""T19 破壁试验G：过挑战后滚动 .shtm 抓预览分页 XHR（1 页+XHR）。"""
import json

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
URL = "https://max.book118.com/html/2022/1214/6115103231005025.shtm"

facts = {"xhr": []}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    def on_response(resp):
        url = resp.url
        if ("book118.com" in url and "hm.baidu" not in url and "log.gif" not in url
                and "/static/" not in url and "hm.js" not in url):
            entry = {"url": url[:260], "status": resp.status, "method": resp.request.method}
            if any(k in url.lower() for k in ("preview", "view", "page", "ajax", "api")):
                try:
                    body = resp.text()
                    entry["body_head"] = body[:600]
                except Exception as exc:
                    entry["body_err"] = str(exc)[:80]
            facts["xhr"].append(entry)

    page.on("response", on_response)
    page.goto(URL, timeout=60000, wait_until="domcontentloaded")
    for _ in range(12):
        page.wait_for_timeout(1000)
        if "safeline" not in page.content()[:2000]:
            break
    # 滚动触发预览分页
    for _ in range(6):
        page.mouse.wheel(0, 2500)
        page.wait_for_timeout(1500)
    facts["final_len"] = len(page.content())
    facts["data_src_count"] = page.eval_on_selector_all(
        "[data-src]", "els => els.map(e => e.getAttribute('data-src')).length")
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step12.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:5000])
