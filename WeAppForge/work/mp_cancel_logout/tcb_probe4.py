# -*- coding: utf-8 -*-
"""tcb_probe4.py — mp 首页全树找「云开发/云托管」菜单项，点击并看落点。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

FIND_CONTAIN = """
function findContains(doc, depth, needle) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('a,span,div,li,p,button,em,i'); } catch (e) { return null; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    if (own.trim().indexOf(needle) >= 0) return {el: el, d: depth, t: own.trim().slice(0, 30)};
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var hit = findContains(frs[j].contentDocument, depth + 1, needle);
      if (hit) return hit;
    }
  } catch (e) {}
  return null;
}
var hit = findContains(document, 0, NEEDLE);
if (!hit) return JSON.stringify({found: false});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d, text: hit.t});
"""

DUMP = """
function walk(doc, parts, depth) {
  if (!doc || depth > 3) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) parts.push({d: depth, txt: txt.slice(0, 1500)});
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) walk(frs[j].contentDocument, parts, depth + 1);
  } catch (e) {}
}
var parts = [];
walk(document, parts, 0);
return JSON.stringify(parts);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    tab.get(f"https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token={token}")
    time.sleep(12)
    res = {"url0": tab.url}
    for needle in ("云开发", "云托管"):
        r = tab.run_js(FIND_CONTAIN.replace("NEEDLE", f"'{needle}'"))
        res[f"click_{needle}"] = r
        time.sleep(8)
        urls = [t.url for t in page.get_tabs()]
        res[f"tabs_after_{needle}"] = urls
        if r and "true" in (r or ""):
            break
    res["docs"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot"] = shot(tab, "tcb_mp_cloud_click")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
