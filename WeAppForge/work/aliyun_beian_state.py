# -*- coding: utf-8 -*-
"""阿里云登录状态侦察（只读）：当前URL/标题/可见文本/输入框按钮清单/截图。"""
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from DrissionPage import ChromiumPage, ChromiumOptions

SHOTS = Path(r"E:\AI-Station\WeAppForge\work\beian_shots")
SHOTS.mkdir(exist_ok=True)


def attach():
    co = ChromiumOptions()
    co.set_browser_path(r"C:\Program Files\Google\Chrome\Application\chrome.exe")
    co.set_user_data_path(r"E:\AI-Station\data\state\aliyun_beian_profile")
    co.set_local_port(9335)
    return ChromiumPage(co)


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


def ctext(c):
    try:
        return c.text or ""
    except Exception:
        try:
            b = c.ele("xpath://body", timeout=2)
            return (b.text or "") if b else ""
        except Exception:
            return ""


def main():
    page = attach()
    print("URL:", page.url)
    print("TITLE:", page.title)
    for i, c in enumerate(ctxs(page)):
        t = ctext(c).replace("\n", " | ")
        if t.strip():
            print(f"--ctx{i} text[:900]:", t[:900])
    print("=== inputs/buttons ===")
    for i, c in enumerate(ctxs(page)):
        try:
            for e in c.eles("tag:input")[:10]:
                v = (e.attr("value") or "")
                print(f" ctx{i} input:", e.attr("id"), "| ph=", (e.attr("placeholder") or "")[:20],
                      "| type=", e.attr("type"), "| val=", v[:18])
        except Exception:
            pass
        try:
            for e in c.eles("tag:button")[:12]:
                txt = (e.text or "").strip().replace("\n", " ")[:24]
                if txt:
                    print(f" ctx{i} button:", txt)
        except Exception:
            pass
    p = SHOTS / f"state_{int(time.time())}.png"
    try:
        page.get_screenshot(str(p))
        print("[shot]", p.name)
    except Exception as e:
        print("[shot-fail]", repr(e)[:100])


if __name__ == "__main__":
    main()
