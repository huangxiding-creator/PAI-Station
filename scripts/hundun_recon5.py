"""混沌学园侦察5：文稿页全域抓包 + DOM 文本提取 + 完整请求 URL。"""
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

OUT = r"E:\AI-Station\data\hundun\_recon"

co = ChromiumOptions()
co.headless(True)
co.set_user_data_path(r"E:\AI-Station\data\browser_profile")
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    page.listen.start("hundun.cn")
    page.get("https://www.hundun.cn/course/manuscript/"
             "0c65743262608bb454bc9c3079a45675")
    page.wait.doc_loaded()
    time.sleep(7)
    for packet in page.listen.steps(timeout=10, count=None):
        host = packet.url.split("/")[2]
        path = packet.url.split("?")[0]
        if host.startswith("ossweb") or "/js/" in path or path.endswith(
                (".png", ".jpg", ".css", ".woff", ".woff2", ".ico", ".js")):
            continue
        print(f"[{packet.method}] {packet.url[:230]}")
        if "get_course_detail" in path:
            print("   ^^^ FULL query 见上")
    # DOM 文本
    body = page.ele("tag:body")
    text = body.text if body else ""
    print("\n===== DOM text length:", len(text))
    with open(os.path.join(OUT, "manuscript_dom.txt"), "w", encoding="utf-8") as fh:
        fh.write(text)
    print(text[:800])
finally:
    page.quit()
