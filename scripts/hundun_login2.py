"""混沌学园登录 V2：切密码模式 + 滑块拖动 + 抓登录 API。"""
import configparser
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "hundun", "_recon")

cred = configparser.ConfigParser()
cred.read(os.path.join(ROOT, "config", "hundun.secret.ini"), encoding="utf-8")
PHONE = cred.get("hundun", "phone")
PWD = cred.get("hundun", "password")

co = ChromiumOptions()
co.headless(False)
co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
co.set_local_port(9333)
co.set_argument("--no-first-run")

page = ChromiumPage(co)
try:
    page.listen.start("hundun.cn")
    page.get("https://www.hundun.cn/")
    page.wait.doc_loaded()
    time.sleep(3)
    page.ele("text:登录").click()
    time.sleep(2)
    # 切到密码登录
    link = page.ele("text:密码登录")
    if link:
        link.click()
        time.sleep(1)
        print("[mode] switched to 密码登录")
    page.ele("@placeholder=请输入手机号").input(PHONE)
    time.sleep(0.4)
    page.ele("@placeholder=请输入密码").input(PWD)
    time.sleep(0.4)
    page.get_screenshot(os.path.join(OUT, "pwd_mode.png"), full_page=False)

    # 滑块：拖动把手到最右（重试 3 次）
    def drag_slider() -> bool:
        for handle_kw in ("tag:div@@class:slider", "@@class:slider-btn",
                          "@@class:slider handler"):
            handles = page.eles(handle_kw)
            for h in handles:
                try:
                    track = h.parent()
                    w = track.rect.size[0]
                    h.drag(offset_x=int(w * 0.9), duration=1.2)
                    print(f"[slider] dragged {handle_kw} w={w}")
                    return True
                except Exception as exc:
                    print(f"[slider] {handle_kw} fail: {exc}")
        return False

    for attempt in range(3):
        if drag_slider():
            time.sleep(2)
            page.get_screenshot(os.path.join(OUT, f"slider_{attempt}.png"),
                                full_page=False)
            break
    # 提交
    btns = [e for e in page.eles("tag:button") if e.text.strip() == "登录"]
    btns[-1].click(by_js=True)
    print("[login] submitted")

    login_calls = []
    for packet in page.listen.steps(timeout=20, count=None):
        url = packet.url
        if any(k in url for k in ("login", "passport", "account", "user",
                                  "token")) and "sensor" not in url:
            try:
                req = packet.request
                info = {"url": url, "method": packet.method,
                        "post": getattr(req, "postData", None),
                        "headers": dict(req.headers)}
                body = packet.response.body
                info["resp"] = body if isinstance(body, str) else json.dumps(
                    body, ensure_ascii=False)[:2000]
            except Exception as exc:
                info = {"url": url, "err": str(exc)}
            login_calls.append(info)
            print(f"[api] {packet.method} {url[:150]} -> "
                  f"{info.get('resp', '')[:120]}")
    with open(os.path.join(OUT, "login_api.json"), "w", encoding="utf-8") as fh:
        json.dump(login_calls, fh, ensure_ascii=False, indent=1)
    time.sleep(3)
    page.get_screenshot(os.path.join(OUT, "after_login2.png"), full_page=False)
    with open(os.path.join(OUT, "cookies.json"), "w", encoding="utf-8") as fh:
        json.dump(page.cookies(), fh, ensure_ascii=False, indent=1)
    print("[cookies]", len(page.cookies()), "saved")
finally:
    page.quit()
