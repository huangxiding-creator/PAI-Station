# -*- coding: utf-8 -*-
"""T19 破壁试验H：抓 .shtm 初始响应原文+全 XHR，定位 aid/t/view_token 来源（1 页+XHR）。"""
import json
import re

from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
URL = "https://max.book118.com/html/2022/1214/6115103231005025.shtm"

facts = {"all_book118": []}
with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True)
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()

    nav_html = {}

    def on_response(resp):
        url = resp.url
        if "book118.com" not in url or "hm.baidu" in url or "log.gif" in url:
            return
        if url.endswith(".png") or url.endswith(".jpg") or "img.book118" in url:
            return
        try:
            body = resp.text()
        except Exception:
            body = ""
        if url == URL:
            nav_html["raw"] = body
            return
        facts["all_book118"].append({"url": url[:200], "status": resp.status,
                                     "body_head": body[:400]})

    page.on("response", on_response)
    page.goto(URL, timeout=60000, wait_until="domcontentloaded")
    for _ in range(12):
        page.wait_for_timeout(1000)
        if "safeline" not in page.content()[:2000]:
            break
    page.mouse.wheel(0, 2000)
    page.wait_for_timeout(2000)
    ctx.close()
    browser.close()

raw = nav_html.get("raw", "")
facts["nav_raw_len"] = len(raw)
with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_shtm_raw.html",
          "w", encoding="utf-8") as f:
    f.write(raw)
for token in ("517914739", "view_token", "getPreview", "preview_data", "PREVIEW_DATA"):
    facts[f"raw_has_{token}"] = token in raw
# aid/token 周边上下文
m = re.search(r".{80}517914739.{200}", raw)
facts["aid_context"] = m.group(0) if m else ""
m2 = re.search(r".{80}view_token.{250}", raw)
facts["view_token_context"] = m2.group(0) if m2 else ""

with open(r"E:\AI-Station\kb_factory\harvest_engine\tests\fixtures\_probe_t19_step13.json",
          "w", encoding="utf-8") as f:
    json.dump(facts, f, ensure_ascii=False, indent=1)
out = {k: v for k, v in facts.items() if k != "all_book118"}
print(json.dumps(out, ensure_ascii=False, indent=1)[:3000])
print("---- book118 XHR urls ----")
for e in facts["all_book118"]:
    print(e["status"], e["url"][:150])
