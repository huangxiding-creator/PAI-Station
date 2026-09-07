"""metaso 登录引导：弹出可见窗口等用户登录，轮询 my-info 直到成功。

登录态存 browser_profile，之后所有 metaso 自动化无头复用。
用法: python scripts/metaso_login.py [超时秒数，默认300]
"""
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
URL = ("https://metaso.cn/subject-v2/8673582927558737920/manage"
       "?cfid=2096794656849395712")
STATE = os.path.join(ROOT, "data", "hundun", "_recon", "metaso_login.json")

co = ChromiumOptions()
co.headless(False)  # 可见窗口：用户扫码/输码
co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--window-size=1280,900")
co.set_argument("--window-position=100,60")

page = ChromiumPage(co)
try:
    page.get(URL)
    page.wait.doc_loaded()
    time.sleep(3)
    # 点右上角登录（若有）
    for kw in ("登录", "登录/注册"):
        els = page.eles(f"text:{kw}")
        if els:
            try:
                els[0].click()
                print(f"[login] clicked {kw}")
            except Exception as exc:
                print(f"[login] click {kw} fail: {exc}")
            break
    time.sleep(2)
    os.makedirs(os.path.dirname(STATE), exist_ok=True)
    timeout = int(sys.argv[1]) if len(sys.argv) > 1 else 300
    deadline = time.time() + timeout
    ok = False
    while time.time() < deadline:
        try:
            r = page.run_js(
                "fetch('/api/my-info').then(r => r.json())"
                ".then(d => JSON.stringify(d)).catch(e => 'ERR')", as_expr=True)
            if r and '"errCode":0' in str(r):
                ok = True
                break
        except Exception:
            pass
        time.sleep(3)
    with open(STATE, "w", encoding="utf-8") as fh:
        json.dump({"ok": ok, "at": time.time()}, fh)
    print(f"[login] {'SUCCESS' if ok else 'TIMEOUT'}")
finally:
    page.quit()
