"""混沌学园侦察7：video_subtitles_effects 完整请求细节。"""
import json
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
    page.listen.start("capi.hundun.cn")
    page.get("https://www.hundun.cn/course/manuscript/"
             "0c65743262608bb454bc9c3079a45675")
    page.wait.doc_loaded()
    time.sleep(8)
    out = []
    for packet in page.listen.steps(timeout=8, count=None):
        try:
            req = packet.request
            out.append({"url": packet.url, "method": packet.method,
                        "post": getattr(req, "postData", None),
                        "headers": dict(req.headers)})
            print("URL:", packet.url)
            print("post:", getattr(req, "postData", None))
            h = dict(req.headers)
            for k in ("sid", "sign", "signversion", "cookie", "content-type"):
                for hk in h:
                    if hk.lower() == k:
                        print(f"  {hk}: {str(h[hk])[:150]}")
        except Exception as exc:
            print("err", exc)
    with open(os.path.join(OUT, "subtitles_req.json"), "w", encoding="utf-8") as fh:
        json.dump(out, fh, ensure_ascii=False, indent=1)
finally:
    page.quit()
