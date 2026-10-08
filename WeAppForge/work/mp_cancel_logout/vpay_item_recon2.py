# -*- coding: utf-8 -*-
"""vpay_item_recon2.py — 进「基本配置」页侦察：道具管理区 + 道具列表 XHR（找 export_once 建项入口）."""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CLICK_WORD = """
function findItem(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('a,span,div,li,p,button'); } catch (e) { return null; }
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
var hit = findItem(document, 0, WORD);
if (!hit) return JSON.stringify({found: false, word: WORD});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d, word: WORD});
"""

DUMP_TEXT = """
function text(doc, depth) {
  var parts = [];
  if (!doc || depth > 3) return parts;
  try { parts.push(doc.body ? doc.body.innerText.slice(0, 4500) : ''); } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) parts = parts.concat(text(frs[j].contentDocument, depth + 1));
  } catch (e) {}
  return parts;
}
return JSON.stringify(text(document, 0));
"""


def grab_apis(tab, seconds=8):
    urls = []
    tab.listen.start(True)
    deadline = time.time() + seconds
    while time.time() < deadline:
        try:
            p = tab.listen.wait(timeout=1.0)
        except Exception:
            break
        if not p:
            continue
        u = p.url or ""
        if "aegis" in u:
            continue
        if "weixin.qq.com" in u:
            body = ""
            try:
                body = (p.response.body or "")[:1200]
            except Exception:
                pass
            urls.append({"url": u[:170], "body": body if isinstance(body, str) else ""})
    tab.listen.stop()
    return urls


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(9)
    r = tab.run_js(CLICK_WORD.replace("WORD", "'基本配置'"))
    time.sleep(8)
    txt = tab.run_js(DUMP_TEXT)
    s1 = shot(tab, "recon2_basecfg")
    apis = grab_apis(tab, seconds=8)   # 基本配置页自身 XHR（含道具列表）
    s2 = shot(tab, "recon2_settled")
    print(json.dumps({
        "token": token,
        "click": r,
        "texts": txt,
        "apis": apis[:25],
        "shot1": s1,
        "shot2": s2,
    }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
