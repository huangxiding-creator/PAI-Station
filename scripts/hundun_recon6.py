"""混沌学园侦察6：已登录会话下文稿页的 API + DOM。"""
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun", "_recon")

co = ChromiumOptions()
co.headless(True)  # 会话已在 profile，试试无头
co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    page.listen.start("hundun.cn")
    page.get("https://www.hundun.cn/course/manuscript/"
             "0c65743262608bb454bc9c3079a45675")
    page.wait.doc_loaded()
    time.sleep(8)
    api = {}
    for packet in page.listen.steps(timeout=10, count=None):
        url = packet.url.split("?")[0]
        if "sensor" in url or url.endswith((".png", ".jpg", ".css", ".js",
                                             ".woff", ".woff2")):
            continue
        try:
            body = packet.response.body
            text = body if isinstance(body, str) else json.dumps(
                body, ensure_ascii=False)
        except Exception:
            text = "<err>"
        api.setdefault(url, text)
        print(f"[{packet.method}] {url}")
        if "manuscript" not in url and "get_course_detail" not in url:
            print("   ", text[:200].replace("\n", " "))
    # 存全部响应
    with open(os.path.join(OUT, "manuscript_apis.json"), "w",
              encoding="utf-8") as fh:
        json.dump(api, fh, ensure_ascii=False, indent=1)
    body = page.ele("tag:body")
    text = body.text if body else ""
    print("\nDOM len:", len(text))
    print("登录后查看" in text and "STILL LOCKED" or "CONTENT UNLOCKED")
    with open(os.path.join(OUT, "manuscript_dom2.txt"), "w", encoding="utf-8") as fh:
        fh.write(text)
finally:
    page.quit()
