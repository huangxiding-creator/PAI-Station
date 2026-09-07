"""混沌学园侦察4：get_course_detail 完整请求/响应 + 登录弹窗结构。"""
import json
import os
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumOptions, ChromiumPage

OUT = r"E:\AI-Station\data\hundun\_recon"
os.makedirs(OUT, exist_ok=True)

co = ChromiumOptions()
co.headless(True)
co.set_user_data_path(r"E:\AI-Station\data\browser_profile")
co.set_local_port(9333)
co.set_argument("--no-first-run")
co.set_argument("--disable-gpu")

page = ChromiumPage(co)
try:
    # ---- 1. 文稿页：完整抓 get_course_detail ----
    page.listen.start("course.hundun.cn")
    page.get("https://www.hundun.cn/course/manuscript/"
             "0c65743262608bb454bc9c3079a45675")
    page.wait.doc_loaded()
    time.sleep(6)
    for packet in page.listen.steps(timeout=8, count=None):
        name = packet.url.split("?")[0].rsplit("/", 1)[-1]
        try:
            body = packet.response.body
            text = body if isinstance(body, str) else json.dumps(
                body, ensure_ascii=False)
        except Exception as exc:
            text = f"<err {exc}>"
        with open(os.path.join(OUT, f"{name}.json"), "w", encoding="utf-8") as fh:
            fh.write(text)
        req = packet.request
        print(f"[req] {packet.url[:160]}")
        try:
            print(f"      post={req.postData!r}"[:200])
        except Exception:
            pass
    page.listen.stop()
    print("saved:", os.listdir(OUT))

    # ---- 2. 找登录入口 ----
    page.get("https://www.hundun.cn/")
    page.wait.doc_loaded()
    time.sleep(3)
    for kw in ["登录", "登录/注册"]:
        els = page.eles(f"text:{kw}")
        if els:
            print(f"found 登录 entry x{len(els)}: {els[0].tag}.{els[0].attr('class')}")
            els[0].click()
            break
    time.sleep(4)
    page.get_screenshot(os.path.join(OUT, "login_dialog.png"), full_page=True)
    inputs = page.eles("tag:input")
    for i in inputs[:12]:
        print("input:", i.attr("placeholder"), i.attr("type"), i.attr("name"))
    btns = [e.text for e in page.eles("tag:button") if e.text.strip()]
    print("buttons:", btns[:15])
    tabs = [e.text for e in page.eles("tag:span") if e.text.strip() in
            ("密码登录", "验证码登录", "手机号登录", "扫码登录")]
    print("login tabs:", tabs)
finally:
    page.quit()
