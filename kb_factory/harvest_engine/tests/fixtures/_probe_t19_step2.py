# -*- coding: utf-8 -*-
"""T19 实弹探针 step2：搜索页全文落盘供离线解析（请求3；累计3/10）。"""
from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto("https://max.book118.com/search.html?word=%E6%96%BD%E5%B7%A5%E6%96%B9%E6%A1%88",
              timeout=45000)
    html = page.content()
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_search.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    print("saved", len(html))
    ctx.close()
    browser.close()
