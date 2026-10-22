# -*- coding: utf-8 -*-
"""T19 实弹探针 step1：max.book118.com 首页/搜索页找免费文档（探针纪律≤10请求，本步=2）。

只读探测：Playwright 首页 1 次 + 搜索页 1 次；抽 .shtm 文档链接与搜索表单形状。
"""
import json
import re
import sys

from playwright.sync_api import sync_playwright

OUT = r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step1.json"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

facts = {"steps": []}

with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    # 请求1：首页
    page.goto("https://max.book118.com/", timeout=45000)
    home_html = page.content()
    facts["steps"].append({"n": 1, "url": "https://max.book118.com/", "html_len": len(home_html)})
    # 搜索表单形状（action/method/input name）
    forms = re.findall(r"<form[^>]*>", home_html)[:5]
    facts["home_forms"] = forms
    # 文档链接（.shtm 与含 aid 的 NewView 链接）
    shtm = re.findall(r'href="(https?://max\.book118\.com/[^"]*?\.shtm[^"]*)"', home_html)[:15]
    facts["home_shtm_links"] = shtm

    # 请求2：搜索页（先验常见形态 search.html?word=）
    page.goto("https://max.book118.com/search.html?word=%E6%96%BD%E5%B7%A5%E6%96%B9%E6%A1%88",
              timeout=45000)
    search_html = page.content()
    facts["steps"].append({"n": 2, "url": "https://max.book118.com/search.html?word=施工方案",
                           "html_len": len(search_html)})
    facts["search_title"] = page.title()
    shtm2 = re.findall(r'href="(https?://max\.book118\.com/[^"]*?\.shtm[^"]*)"', search_html)[:15]
    facts["search_shtm_links"] = shtm2
    ctx.close()
    browser.close()

with open(OUT, "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1)[:3000])
