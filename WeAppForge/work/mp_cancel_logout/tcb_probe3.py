# -*- coding: utf-8 -*-
"""tcb_probe3.py — mp 首页抓「云开发/云托管」真实链接与菜单全貌。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

LINKS = """
var out = [];
var as = document.querySelectorAll('a');
for (var i = 0; i < as.length; i++) {
  var a = as[i];
  var t = (a.innerText || '').trim().replace(/\\s+/g, ' ');
  var h = a.getAttribute('href') || '';
  if (t && t.length < 25 && h) out.push({t: t, h: h.slice(0, 110)});
}
return JSON.stringify(out.slice(0, 120));
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    home = f"https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token={token}"
    tab.get(home)
    time.sleep(10)
    res = {"url": tab.url}
    res["links"] = json.loads(tab.run_js(LINKS) or "[]")
    res["shot"] = shot(tab, "tcb_mp_home")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
