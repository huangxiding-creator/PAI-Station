# -*- coding: utf-8 -*-
"""T19 实弹探针 step3：搜索页等渲染完拿结果链接（请求4；累计4/10）。"""
import json
import re

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

facts = {}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto("https://max.book118.com/search.html?word=%E6%96%BD%E5%B7%A5%E6%96%B9%E6%A1%88",
              timeout=45000, wait_until="domcontentloaded")
    try:
        page.wait_for_load_state("networkidle", timeout=20000)
    except Exception:
        pass
    html = page.content()
    facts["rendered_len"] = len(html)
    facts["title"] = page.title()
    # 渲染后全部本站文档链接形态（shtm/NewView/其他）
    links = re.findall(r'href="([^"]+)"', html)
    doc_like = [l for l in links if re.search(r"\d{10,}", l) and "help" not in l]
    facts["doc_like"] = sorted(set(doc_like))[:25]
    # 结果列表区文本形态
    m = re.search(r'(search-(result|list)|result-list|list-box).{0,200}', html, re.S)
    facts["result_area_hint"] = m.group(0)[:220] if m else ""
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_search_rendered.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step3.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print("rendered_len", facts["rendered_len"], "title", facts["title"])
print(json.dumps(facts["doc_like"], ensure_ascii=False, indent=1)[:1800])
