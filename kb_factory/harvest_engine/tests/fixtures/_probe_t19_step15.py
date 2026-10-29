# -*- coding: utf-8 -*-
"""T19 破壁试验J：search.html?q= 渲染态+tdsearch XHR 形状（1 页+XHR）。"""
import json
import re

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
URL = "https://max.book118.com/search.html?q=%E6%96%BD%E5%B7%A5%E6%96%B9%E6%A1%88"

facts = {"xhr": []}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    def on_response(resp):
        u = resp.url
        if "book118.com" in u and ("search" in u.lower() or "tdsearch" in u):
            try:
                body = resp.text()
            except Exception:
                body = ""
            facts["xhr"].append({"url": u[:240], "status": resp.status,
                                 "body_head": body[:900]})

    page.on("response", on_response)
    page.goto(URL, timeout=60000, wait_until="domcontentloaded")
    for _ in range(15):
        page.wait_for_timeout(1000)
        if "safeline" not in page.content()[:2000]:
            break
    try:
        page.wait_for_load_state("networkidle", timeout=15000)
    except Exception:
        pass
    html = page.content()
    facts["rendered_len"] = len(html)
    links = re.findall(r'href="([^"]+)"', html)
    facts["shtm_doc_links"] = sorted({l for l in links
                                      if re.search(r"/html/\d{4}/\d{4}/\d+\.shtml?", l)})[:20]
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_search_q_rendered.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step15.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print("rendered_len", facts["rendered_len"], "doc_links", len(facts["shtm_doc_links"]))
print(json.dumps(facts["xhr"], ensure_ascii=False, indent=1)[:3500])
print(json.dumps(facts["shtm_doc_links"], ensure_ascii=False, indent=1))
