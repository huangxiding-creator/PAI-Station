# -*- coding: utf-8 -*-
"""tcb_probe1.py — 9336 浏览器探腾讯云控制台登录态。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402


def main():
    page = attach_or_launch()
    tab = page.new_tab("https://console.cloud.tencent.com/tcb")
    time.sleep(12)
    res = {"url": tab.url, "title": tab.title}
    try:
        txt = tab.run_js("return (document.body && document.body.innerText || '').slice(0, 1500);")
    except Exception as e:
        txt = f"js_err:{str(e)[:80]}"
    res["text"] = txt
    res["shot"] = shot(tab, "tcb_console_probe")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
