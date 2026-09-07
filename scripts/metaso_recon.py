"""metaso 专题管理页侦察：登录态 + 页面结构 + API。"""
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun", "_recon")

URL = ("https://metaso.cn/subject-v2/8673582927558737920/manage"
       "?cfid=2096794656849395712")

co = ChromiumOptions()
co.headless(True)
co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    page.listen.start("metaso.cn")
    page.get(URL)
    page.wait.doc_loaded()
    time.sleep(8)
    print("title:", page.title)
    print("url:", page.url)
    for packet in page.listen.steps(timeout=8, count=None):
        u = packet.url.split("?")[0]
        if any(u.endswith(s) for s in (".js", ".css", ".png", ".woff",
                                       ".woff2", ".svg", ".ico")):
            continue
        print(f"[{packet.method}] {u[:150]}")
    page.get_screenshot(os.path.join(OUT, "metaso_manage.png"), full_page=True)
    body = page.ele("tag:body")
    text = (body.text if body else "")[:1200]
    print("\n===== DOM =====\n", text)
finally:
    page.quit()
