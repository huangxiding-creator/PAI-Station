# -*- coding: utf-8 -*-
"""登录监视器：等用户手动登录成功（URL离开account.aliyun.com），
然后自动落位备案主体页并完整侦察（文本+截图+控件清单）。最多等15分钟。"""
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumPage, ChromiumOptions

SHOTS = Path(r"E:\AI-Station\WeAppForge\work\beian_shots")
SHOTS.mkdir(exist_ok=True)
BEIAN_URL = "https://beian.aliyun.com/pcContainer/selfEntity?entityId=9452842"


def attach():
    co = ChromiumOptions()
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    co.set_user_data_path(r"E:\AI-Station\data\state\aliyun_beian_profile")
    co.set_local_port(9335)
    return ChromiumPage(co)


def ctext(c):
    try:
        return c.text or ""
    except Exception:
        try:
            b = c.ele("xpath://body", timeout=2)
            return (b.text or "") if b else ""
        except Exception:
            return ""


def ctxs(page):
    out = [page]
    try:
        for f in page.eles("tag:iframe"):
            try:
                out.append(page.get_frame(f))
            except Exception:
                pass
    except Exception:
        pass
    return out


def dump(page, tag, n=2500):
    print(f"=== {tag} ===")
    print("url=", page.url, "| title=", page.title)
    for i, c in enumerate(ctxs(page)):
        t = ctext(c).replace("\n", " | ")
        if t.strip():
            print(f"ctx{i}:", t[:n])
    try:
        p = SHOTS / f"watch_{tag}_{int(time.time())}.png"
        page.get_screenshot(str(p))
        print("[shot]", p.name)
    except Exception as e:
        print("[shot-fail]", repr(e)[:100])


def main():
    page = attach()
    print("watching from:", page.url, flush=True)
    deadline = time.time() + 900
    logged = False
    while time.time() < deadline:
        try:
            url = page.url
        except Exception:
            url = ""
        if url and "account.aliyun.com/login" not in url and "login.htm" not in url:
            print("LOGIN_LEFT ->", url, flush=True)
            logged = True
            break
        time.sleep(5)
    if not logged:
        print("TIMEOUT_NO_LOGIN")
        return
    time.sleep(6)  # 等回调跳转稳定
    try:
        page.wait.doc_loaded(timeout=30)
    except Exception:
        pass
    if "selfEntity" not in (page.url or ""):
        print("navigating to BEIAN_URL...")
        page.get(BEIAN_URL)
        try:
            page.wait.doc_loaded(timeout=30)
        except Exception:
            pass
        time.sleep(5)
    dump(page, "self_entity")
    print("WATCH_DONE")


if __name__ == "__main__":
    main()
