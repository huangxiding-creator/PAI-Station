# -*- coding: utf-8 -*-
"""T19 实弹复修2：适配器同形请求对照（Referer 首页 vs .shtm；3 请求，间隔1.2s）。"""
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[4]))
from kb_factory.harvest_engine.adapters.book118 import extract_shtm_config

import httpx
from playwright.sync_api import sync_playwright

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
SHTM = "https://max.book118.com/html/2022/0414/5110103104004213.shtm"

with sync_playwright() as pw:
    browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
    ctx = browser.new_context(user_agent=UA)
    page = ctx.new_page()
    page.goto(SHTM, timeout=60000, wait_until="domcontentloaded")
    html = ""
    for _ in range(15):
        time.sleep(1)
        html = page.content()
        if ".safeline" not in html[:4000]:
            break
    ctx.close()
    browser.close()

cfg = extract_shtm_config(html)
params = {"project_id": 1, "aid": cfg["aid"], "t": cfg["t"],
          "view_token": cfg["view_token"], "page": 1, "callback": "jsonpReturn"}

for label, referer in (("ref_home", "https://max.book118.com/"), ("ref_shtm", SHTM)):
    time.sleep(1.2)
    with httpx.Client(timeout=30.0,  # 与适配器同构造（trust_env 缺省 True）
                      headers={"User-Agent": UA, "Referer": referer}) as c:
        r = c.get("https://openapi.book118.com/getPreview.html", params=params)
        print(label, r.status_code, len(r.text), r.text[:180])
