# -*- coding: utf-8 -*-
"""vpay_probe2.py — 虚拟支付子应用深探：渲染等待+iframe/链接全扫+候选参数页。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

HARVEST = """
function walkDoc(doc, out, depth) {
  if (!doc || depth > 3) return;
  try {
    var as = doc.querySelectorAll('a');
    for (var i = 0; i < as.length; i++) {
      var t = (as[i].innerText || '').trim().replace(/\\s+/g, ' ');
      if (t && t.length < 30) out.push({t: t, h: as[i].getAttribute('href') || '', d: depth});
    }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      out.push({iframe: (frs[j].src || '').slice(0, 150), d: depth});
      walkDoc(frs[j].contentDocument, out, depth + 1);
    }
  } catch (e) {}
  return;
}
var out = [];
walkDoc(document, out, 0);
var txt = (document.body.innerText || '');
return JSON.stringify({links: out.slice(0, 80), text_head: txt.slice(0, 1200),
  has_offer: txt.indexOf('Offer') >= 0 || txt.indexOf('offer') >= 0,
  text_len: txt.length});
"""

CANDIDATES = [
    "/wxamp/subApp/skit/manage/param",
    "/wxamp/subApp/skit/manage/goods",
    "/wxamp/subApp/skit/manage/dev",
    "/wxamp/subApp/skit/manage/payparam",
    "/wxamp/subApp/skit/manage/coin",
]


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    res = {"token": token, "pages": []}
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)
    r = json.loads(tab.run_js(HARVEST) or "{}")
    r["shot"] = shot(tab, "vpay_root")
    res["root"] = r
    for c in CANDIDATES:
        u = f"https://mp.weixin.qq.com{c}?token={token}&lang=zh_CN"
        tab.get(u)
        time.sleep(6)
        txt = (tab.run_js("return (document.body.innerText || '');") or "")
        res["pages"].append({"url": (tab.url or "")[:140], "len": len(txt),
                             "head": txt[:300]})
    res["last_shot"] = shot(tab, "vpay_last")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
