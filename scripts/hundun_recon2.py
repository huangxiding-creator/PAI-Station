"""混沌学园侦察2：抓 course.hundun.cn API 响应体 + 首页课程链接。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

co = ChromiumOptions()
co.headless(True)
co.set_user_data_path(r"E:\AI-Station\data\browser_profile")
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    page.listen.start("course.hundun.cn")
    page.get("https://www.hundun.cn/")
    page.wait.doc_loaded()
    time.sleep(5)
    for packet in page.listen.steps(timeout=8, count=None):
        url = packet.url
        try:
            body = packet.response.body
        except Exception as exc:
            body = f"<body err {exc}>"
        text = body if isinstance(body, str) else json.dumps(body, ensure_ascii=False)
        print(f"\n=== {url[:120]}")
        print(text[:600])
    # 首页里的课程入口链接
    links = page.eles("tag:main")
    hrefs = sorted({e.link for e in page.eles("tag:a") if e.link and
                    ("course" in e.link or "hundun" in e.link)})[:25]
    print("\n=== links ===")
    for h in hrefs:
        print(h)
finally:
    page.quit()
