# -*- coding: utf-8 -*-
"""vpay_probe3.py — 进 iframe 点「基本配置」，全 doc 扫 OfferID/沙箱/道具。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CLICK_CFG = """
function findCfg(doc, depth) {
  if (!doc || depth > 3) return null;
  var as = null;
  try { as = doc.querySelectorAll('a,span,div,li'); } catch (e) { return null; }
  for (var i = 0; i < as.length; i++) {
    var el = as[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    own = own.trim();
    if (own === '\\u57fa\\u672c\\u914d\\u7f6e') { return {el: el, d: depth}; }
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var hit = findCfg(frs[j].contentDocument, depth + 1);
      if (hit) return hit;
    }
  } catch (e) {}
  return null;
}
var hit = findCfg(document, 0);
if (!hit) return JSON.stringify({found: false});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d});
"""

SCAN_ALL = """
function walk(doc, out, depth) {
  if (!doc || depth > 4) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) out.push({d: depth, len: txt.length, txt: txt.slice(0, 1500)});
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
    c = tab.run_js(CLICK_CFG)
    time.sleep(6)
    s = json.loads(tab.run_js(SCAN_ALL) or "{}")
    res = {"token": token, "click": c, "docs": s.get("docs", []),
           "shot": shot(tab, "vpay_cfg")}
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
