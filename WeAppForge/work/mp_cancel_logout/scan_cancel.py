# -*- coding: utf-8 -*-
"""scan_cancel.py — 定位渲染态注销横幅(weui-desktop-msg)与其「取消注销」链接。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

JS = """
var res = [];
var els = document.querySelectorAll('.weui-desktop-msg, .weui-desktop-msg__desc-wrp, .weui-desktop-msg__desc');
for (var i = 0; i < els.length; i++) {
  var el = els[i];
  var t = (el.innerText || '').trim();
  if (!t) continue;
  var r = el.getBoundingClientRect();
  var links = [];
  var as = el.querySelectorAll('a');
  for (var j = 0; j < as.length; j++) {
    var ra = as[j].getBoundingClientRect();
    links.push({text: (as[j].innerText || '').trim().slice(0, 24),
                x: Math.round(ra.x), y: Math.round(ra.y), w: Math.round(ra.width), h: Math.round(ra.height),
                href: (as[j].getAttribute('href') || '').slice(0, 30)});
  }
  res.push({tag: el.tagName, cls: el.className.toString().slice(0, 70),
            text: t.split('\\n').join('|').slice(0, 110),
            x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height),
            links: links.slice(0, 6)});
}
return JSON.stringify(res.slice(0, 15));
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    raw = tab.run_js(JS)
    print(json.dumps({"url": (tab.url or "")[:110], "msgs": json.loads(raw)}, ensure_ascii=True))
    shot(tab, "scan_cancel")


if __name__ == "__main__":
    main()
