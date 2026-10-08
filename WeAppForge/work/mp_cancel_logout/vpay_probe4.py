# -*- coding: utf-8 -*-
"""vpay_probe4.py — 点「道具配置」页：现有道具清单/product_id/价格。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CLICK = """
function findItem(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('a,span,div,li,p'); } catch (e) { return null; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    if (own.trim() === word) return {el: el, d: depth};
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var hit = findItem(frs[j].contentDocument, depth + 1, word);
      if (hit) return hit;
    }
  } catch (e) {}
  return null;
}
var hit = findItem(document, 0, '\\u9053\\u5177\\u914d\\u7f6e');
if (!hit) return JSON.stringify({found: false});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d});
"""

SCAN_ALL = """
function walk(doc, out, depth) {
  if (!doc || depth > 4) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) out.push({d: depth, len: txt.length, txt: txt.slice(0, 1800)});
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) walk(frs[j].contentDocument, out, depth + 1);
  } catch (e) {}
}
var out = [];
walk(document, out, 0);
return JSON.stringify({docs: out});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)
    c = tab.run_js(CLICK)
    time.sleep(6)
    s = json.loads(tab.run_js(SCAN_ALL) or "{}")
    res = {"token": token, "click": c, "docs": s.get("docs", []),
           "shot": shot(tab, "vpay_goods")}
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
