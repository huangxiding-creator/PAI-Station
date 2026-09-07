"""混沌学园侦察9：登录态导航结构 + 我的课程入口。"""
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
    page.listen.start("course.hundun.cn")
    page.get("https://www.hundun.cn/")
    page.wait.doc_loaded()
    time.sleep(4)
    hrefs = {e.link for e in page.eles("tag:a") if e.link}
    for h in sorted(hrefs):
        if any(k in h for k in ("user", "study", "my", "learn", "course")):
            print("LINK:", h)
    # 登录后的用户菜单
    for kw in ("学习中心", "我的课程", "我的学习", "个人中心"):
        els = page.eles(f"text:{kw}")
        if els:
            print(f"ELE [{kw}]:", els[0].tag, els[0].attr("class"))
    # /course 页全部 API（含登录态专属）
    page.get("https://www.hundun.cn/course")
    page.wait.doc_loaded()
    time.sleep(6)
    seen = set()
    for packet in page.listen.steps(timeout=8, count=None):
        u = packet.url.split("?")[0]
        if u not in seen and "sensor" not in u:
            seen.add(u)
            print("API:", u)
finally:
    page.quit()
