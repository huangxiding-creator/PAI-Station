"""混沌学园侦察：浏览器加载首页 + 网络监听，找 XHR/API 通道。"""
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
    page.listen.start("hundun.cn")
    page.get("https://www.hundun.cn/")
    page.wait.doc_loaded()
    time.sleep(6)
    print("title:", page.title)
    print("url:", page.url)
    seen = {}
    for packet in page.listen.steps(timeout=8, count=None):
        url = packet.url.split("?")[0]
        if url not in seen:
            seen[url] = packet.method
    for url, method in sorted(seen.items()):
        print(f"{method:6s} {url}")
finally:
    page.quit()
