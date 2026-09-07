"""混沌学园侦察3：课程列表页 + 文稿页的 API 调用链。"""
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
    targets = ["https://www.hundun.cn/course",
               "https://www.hundun.cn/course/manuscript/0c65743262608bb454bc9c3079a45675"]
    for tgt in targets:
        page.listen.start("course.hundun.cn")
        print(f"\n########## {tgt}")
        page.get(tgt)
        page.wait.doc_loaded()
        time.sleep(6)
        for packet in page.listen.steps(timeout=8, count=None):
            url = packet.url.split("?")[0]
            try:
                body = packet.response.body
                text = body if isinstance(body, str) else json.dumps(
                    body, ensure_ascii=False)
            except Exception as exc:
                text = f"<err {exc}>"
            print(f"\n=== {url}")
            print(text[:500])
        page.listen.stop()
finally:
    page.quit()
