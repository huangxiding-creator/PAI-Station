# -*- coding: utf-8 -*-
"""vpay_probe.py — 控制台虚拟支付状态探针：入口链接 + 页面态。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

FIND = """
var out = {links: [], menu: ''};
var as = document.querySelectorAll('a');
for (var i = 0; i < as.length; i++) {
  var t = (as[i].innerText || '').trim();
  if (t.indexOf('\\u865a\\u62df\\u652f\\u4ed8') >= 0) {
    out.links.push({text: t.slice(0, 40), href: as[i].getAttribute('href') || ''});
  }
}
out.body_has = (document.body.innerText || '').indexOf('\\u865a\\u62df\\u652f\\u4ed8') >= 0;
return JSON.stringify(out);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True, "note": "no-token, 须扫码召唤"},
                         ensure_ascii=False))
        return 1
    idx = f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN"
    if "index/index" not in (tab.url or ""):
        tab.get(idx)
        time.sleep(5)
    r = json.loads(tab.run_js(FIND) or "{}")
    r["token"] = token
    r["idx_shot"] = shot(tab, "vpay_idx")
    dest = None
    for l in r.get("links", []):
        h = l.get("href") or ""
        if h and "javascript" not in h[:16]:
            dest = h if h.startswith("http") else "https://mp.weixin.qq.com" + h
            break
    if dest:
        tab.get(dest if "token=" in dest else dest + ("" if "?" in dest else "?") + f"token={token}&lang=zh_CN")
        time.sleep(5)
        r["vpay_url"] = (tab.url or "")[:150]
        r["vpay_text"] = (tab.run_js("return (document.body.innerText || '').slice(0, 2500);") or "")
        r["vpay_shot"] = shot(tab, "vpay_page")
    print(json.dumps(r, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
