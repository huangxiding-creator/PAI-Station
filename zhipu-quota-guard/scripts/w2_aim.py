# -*- coding: utf-8 -*-
"""W2 视觉瞄准：填表点登录→截验证码区域+坐标上报→浏览器保持存活等 drag。
用法: python w2_aim.py [--fresh]   # --fresh=重新走登录表单; 默认复用当前页面状态"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

SEC = json.loads((ROOT / "secrets" / "zhipu_secrets.json").read_text(encoding="utf-8"))
BM = SEC["bigmodel"]
LOGIN_URL = BM["login_url"]


def rect_of(el):
    try:
        return {"location": tuple(el.rect.location), "size": tuple(el.rect.size)}
    except Exception as e:  # noqa: BLE001
        return {"err": repr(e)[:80]}


def main() -> int:
    fresh = "--fresh" in sys.argv
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(ROOT / ".chrome-profile"))
    page = ChromiumPage(co)  # 已运行则接管
    if fresh:
        page.get(LOGIN_URL)
        time.sleep(3)
        tab = page.ele("text:账号登录", timeout=3)
        if tab:
            tab.click()
            time.sleep(1.2)
        acct = page.ele("css:input[placeholder='请输入用户名/邮箱/手机号']", timeout=4)
        acct.clear().input(BM["phone"])
        pwd = page.ele("css:input[placeholder='请输入密码']", timeout=3)
        pwd.clear().input(BM["password"])
        try:
            for cb in page.eles("css:input[type=checkbox]"):
                if cb.states.is_displayed and not cb.states.is_checked:
                    cb.click()
                    time.sleep(0.3)
        except Exception:  # noqa: BLE001
            pass
        btn = page.ele("xpath://button[normalize-space()='登录']", timeout=3)
        btn.click()
        time.sleep(3)
    # 定位验证码容器与滑块
    info = {"url": page.url, "captcha": None, "handle": None, "toasts": []}
    cont_sels = ["css:[class*=captcha]", "css:[class*=verify]", "css:[class*=slide]",
                 "css:[class*=Slider]", "css:[class*=nc-container]"]
    for sel in cont_sels:
        try:
            c = page.ele(sel, timeout=1.5)
            if c and c.states.is_displayed and c.rect.size[0] > 120:
                info["captcha"] = {"sel": sel, **rect_of(c)}
                try:
                    c.get_screenshot(path=str(STATE / "w2_captcha.png"))
                    print(f"[aim] 容器 {sel} 已截图")
                except Exception:  # noqa: BLE001
                    page.get_screenshot(path=str(STATE / "w2_captcha_full.png"), full_page=False)
                break
        except Exception:  # noqa: BLE001
            continue
    for sel in ["css:[class*=slider] [class*=handle]", "css:[class*=slider-btn]",
                "css:[class*=btn_slide]", "css:span[class*=slide][class*=icon]",
                "css:[class*=handler]"]:
        try:
            h = page.ele(sel, timeout=1.5)
            if h and h.states.is_displayed:
                info["handle"] = {"sel": sel, **rect_of(h)}
                break
        except Exception:  # noqa: BLE001
            continue
    for sel in ["css:[class*=toast]", "css:[class*=error]"]:
        try:
            for el in page.eles(sel):
                t = (el.text or "").strip()
                if t and len(t) < 60:
                    info["toasts"].append(t)
        except Exception:  # noqa: BLE001
            pass
    page.get_screenshot(path=str(STATE / "w2_aim_full.png"), full_page=False)
    print("[aim]", json.dumps(info, ensure_ascii=False))
    print("[aim] READY (浏览器保活，等 w2_drag)")
    return 0  # 不 quit


if __name__ == "__main__":
    raise SystemExit(main())
