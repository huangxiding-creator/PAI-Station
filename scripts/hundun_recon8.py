"""混沌学园侦察8：收集页面 JS 清单，供 Sign V3 算法逆向。"""
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun", "_recon")

co = ChromiumOptions()
co.headless(True)
co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    page.get("https://www.hundun.cn/course/manuscript/"
             "0c65743262608bb454bc9c3079a45675")
    page.wait.doc_loaded()
    time.sleep(5)
    srcs = sorted({e.attr("src") for e in page.eles("tag:script") if e.attr("src")})
    with open(os.path.join(OUT, "js_list.txt"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(srcs))
    for s in srcs:
        print(s)
finally:
    page.quit()
