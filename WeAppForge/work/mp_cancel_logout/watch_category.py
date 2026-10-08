# -*- coding: utf-8 -*-
"""watch_category.py — 类目盯哨轮：复用 9336 专属浏览器活会话查深度合成>AI问答状态.

1006 修: token 不再硬编码 (会话重登即陈旧=本轮盯哨失效根因)——先从活标签
URL 提取, 提不到则回控制台首页刷新一次再提; 仍无则如实报 login_wall。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402


def live_token(tab) -> str:
    """从活会话提取 token: 当前 URL → 回首页后的 URL/页面源。"""
    for attempt in range(2):
        m = re.search(r"token=(\d{8,})", (tab.url or ""))
        if m:
            return m.group(1)
        if attempt == 0:
            tab.get("https://mp.weixin.qq.com/")
            time.sleep(5)
            m = re.search(r"token=(\d{8,})", (tab.url or "") + (tab.html or "")[:30000])
            if m:
                return m.group(1)
    return ""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        txt = "no-token: 会话未登录或页面异常, 须扫码召唤 (勿自动重发企微, 12h 一条)"
        print(json.dumps({"url": (tab.url or "")[:130], "login_wall": True,
                          "text": txt, "shot": shot(tab, "watch_category")},
                         ensure_ascii=False))
        return 1
    tab.get(f"https://mp.weixin.qq.com/wxamp/category/get?token={token}&lang=zh_CN")
    time.sleep(4)
    txt = tab.run_js("return (document.body.innerText || '').slice(0, 3000);")
    s = shot(tab, "watch_category")
    print(json.dumps({"url": (tab.url or "")[:130], "token": token,
                      "login_wall": ("扫码" in (txt or "")) or ("登录" in (txt or "")[:80]),
                      "text": txt, "shot": s}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
