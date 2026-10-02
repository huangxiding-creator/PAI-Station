# -*- coding: utf-8 -*-
"""网络诊断 — 浏览器级截图分析 (0924, 用户令: 请自行截图分析).

urllib 探针分不清 SPA 客户端重定向 (/unavailable 是 JS 跳的), 唯一可信
判据 = 真浏览器加载后看 URL/title/#email + 截图留证.
"""
import io
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
import manus_lib as lib

SHOT = Path(__file__).parent / "probe_net_current.png"


def clash_now(group="🚀 手动切换"):
    secret = lib.CLASH_SECRET
    hdr = {"Authorization": "Bearer " + secret}
    for p in (20225, 29069, 11845):
        base = f"http://127.0.0.1:{p}"
        try:
            r = __import__("urllib.request", fromlist=["x"])
            req = r.Request(base + "/proxies/" + quote(group), headers=hdr)
            return json.loads(r.urlopen(req, timeout=4).read()).get("now")
        except Exception:
            continue
    return "?"


def probe(page, url, label, wait=8):
    page.get(url)
    time.sleep(wait)
    url_now = page.url or ""
    title = page.title or ""
    email = bool(page.ele("#email", timeout=4))
    body = ""
    try:
        b = page.ele("tag:body")
        body = (b.text or "")[:400].replace("\n", " | ")
    except Exception:
        pass
    print(f"[{label}] url={url_now}")
    print(f"[{label}] title={title}")
    print(f"[{label}] #email={'在' if email else '缺失'}")
    print(f"[{label}] body前400={body}")
    return url_now, title, email


def main():
    print(f"Clash 🚀手动切换 当前节点: {clash_now()}", flush=True)
    page = lib.make_page()
    try:
        probe(page, "https://manus.im/login?type=signIn", "login")
        page.get_screenshot(str(SOT := SHOT))
        print(f"截图: {SHOT}")
    finally:
        try:
            page.browser.quit()
        except Exception:
            pass


if __name__ == "__main__":
    main()
