# -*- coding: utf-8 -*-
"""T19 破壁试验F：Playwright 过 SafeLine 挑战开 .shtm → 挖 PREVIEW_DATA（1 请求）。"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.parse.inline_var import extract_preview_data

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
URL = "https://max.book118.com/html/2022/1214/6115103231005025.shtm"

facts = {"url": URL}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto(URL, timeout=60000, wait_until="domcontentloaded")
    # SafeLine 挑战：等待自动跳转/重载（最多 15s）
    for _ in range(15):
        page.wait_for_timeout(1000)
        if "safeline" not in page.content()[:2000] and "slg" not in page.title().lower():
            break
    try:
        page.wait_for_load_state("load", timeout=20000)
    except Exception:
        pass
    html = page.content()
    facts["status_probe"] = page.url
    facts["len"] = len(html)
    facts["title"] = page.title()[:100]
    facts["has_preview_data"] = "PREVIEW_DATA" in html
    facts["preview_data"] = extract_preview_data(html) if facts["has_preview_data"] else None
    facts["cookies"] = [c["name"] for c in ctx.cookies()]
    with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_playwright.html",
              "w", encoding="utf-8") as f:
        f.write(html)
    ctx.close()
    browser.close()

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step11.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
print(json.dumps(facts, ensure_ascii=False, indent=1))
