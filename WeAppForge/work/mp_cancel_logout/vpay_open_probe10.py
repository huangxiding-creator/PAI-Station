# -*- coding: utf-8 -*-
"""vpay_open_probe10 — wxfdb 虚拟支付现状探针（只读零点击）：
1) 身份再验 2) /wxamp/subApp/skit 页态（已开通面 or 6步向导 or 类目墙）3) 截屏留档
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p10.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p10_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


def live_token(tab, page):
    m = re.search(r"token=(\d{8,})", tab.url or "")
    if m:
        return m.group(1)
    for t in page.get_tabs():
        mm = re.search(r"token=(\d{8,})", t.url or "")
        if mm:
            return mm.group(1)
    return ""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab, page)
    if not token:
        log({"state": "NO_TOKEN"})
        return 1
    # 1) 身份再验
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3)
    html = tab.html or ""
    am = re.findall(r"(wx[0-9a-f]{16})", html)
    log({"identity": {"appids": sorted(set(am))[:4], "科技": html.count("总包科技"),
                      "AI顾问": html.count("总包AI顾问")}})

    # 2) skit 虚拟支付页
    tab.get(f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN")
    time.sleep(5)
    html2 = tab.html or ""
    kws = ["虚拟支付", "开通", "协议", "商户", "类目", "offer", "道具", "基本配置",
           "不支持", "门槛", "签约", "打款", "营业执照"]
    log({"skit": {"url": (tab.url or "")[:140], "title": (tab.title or "")[:50],
                  "kw": {k: html2.count(k) for k in kws},
                  "appid_seen": sorted(set(re.findall(r'(wx[0-9a-f]{16})', html2)))[:4],
                  "shot": shot(tab, "skit")}})

    # iframe 清单（wujie 微前端时内容在 iframe 里）
    try:
        ifs = tab.run_js(r'return (function(){return JSON.stringify(Array.from(document.querySelectorAll("iframe")).map(function(f){return {src:(f.src||"").slice(0,120), w:f.getBoundingClientRect().width, h:f.getBoundingClientRect().height};}));})();')
        log({"iframes": json.loads(ifs)})
    except Exception as e:
        log({"iframes_err": str(e)[:200]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
