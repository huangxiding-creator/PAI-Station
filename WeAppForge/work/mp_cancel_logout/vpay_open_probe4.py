# -*- coding: utf-8 -*-
"""vpay_open_probe4 — 零点击剖首页 HTML：总包科技周边标记 + 账号切换器结构。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p4.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    m = re.search(r"token=(\d{8,})", tab.url or "")
    if not m:
        for t in page.get_tabs():
            mm = re.search(r"token=(\d{8,})", t.url or "")
            if mm:
                m = mm
                break
    if not m:
        log({"state": "NO_TOKEN"})
        return 1
    token = m.group(1)
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3.5)
    html = tab.html or ""
    log({"html_len": len(html)})

    # 1) 总包科技 周边 ±1500
    for m2 in re.finditer("总包科技", html):
        i = m2.start()
        log({"ctx_total_tech": html[max(0, i - 1500):i + 1500]})

    # 2) 所有 appid 出现位置+轻上下文
    for m3 in re.finditer(r"(wx[0-9a-f]{16})", html):
        a = m3.group(1)
        i = m3.start()
        log({"appid": a, "ctx": html[max(0, i - 120):i + 160]})

    # 3) 切换/账号菜单关键词
    for kw in ("切换账号", "切换小程序", "账号切换", "关联的账号", "账号详情", "退出登录"):
        n = html.count(kw)
        if n:
            i = html.find(kw)
            log({"kw": kw, "count": n, "ctx": html[max(0, i - 400):i + 400]})
        else:
            log({"kw": kw, "count": 0})

    # 4) 顶栏 header 区标记（class 名采样）
    for pat in (r'class="[^"]*(?:account|switch|header|user|avatar)[^"]*"'):
        cls = sorted(set(re.findall(pat, html)))[:40]
        log({"classes": cls})
    return 0


if __name__ == "__main__":
    sys.exit(main())
