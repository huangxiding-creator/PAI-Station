# -*- coding: utf-8 -*-
"""category_check.py — 用活会话查类目审核状态（深度合成>AI问答）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

TOKEN = "91558662"
URL = f"https://mp.weixin.qq.com/wxamp/category/get?token={TOKEN}&lang=zh_CN"


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    tab.get(URL)
    time.sleep(4)
    txt = tab.run_js("return (document.body.innerText || '').slice(0, 3000);")
    s = shot(tab, "category_check")
    print(json.dumps({"url": (tab.url or "")[:130], "text": txt, "shot": s}, ensure_ascii=True))


if __name__ == "__main__":
    main()
