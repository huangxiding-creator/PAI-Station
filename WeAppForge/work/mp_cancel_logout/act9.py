# -*- coding: utf-8 -*-
"""act9.py — 进入 wujie shadow root：定位活的注销弹窗，强制可见后 CDP 物理点击。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

# 在影子域找取消注销锚点，必要时掀可见；返回坐标
SHADOW_ANCHOR = """
var hosts = [];
var all = document.querySelectorAll('*');
for (var i = 0; i < all.length; i++) { if (all[i].shadowRoot) hosts.push(all[i].shadowRoot); }
if (!hosts.length) return JSON.stringify({err: 'no_shadow_host', n: 0});
var res = {n: hosts.length, hosts: []};
function scanRoot(root, label) {
  var hits = [];
  var els = root.querySelectorAll('a, span, button');
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var t = (el.innerText || '').trim();
    if (t !== '\\u53d6\\u6d88\\u6ce8\\u9500') continue;
    var r = el.getBoundingClientRect();
    hits.push({el: el, x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)});
  }
  return hits;
}
var target = null;
for (var h = 0; h < hosts.length; h++) {
  var html = hosts[h].innerHTML || '';
  var info = {len: html.length, hasCancel: html.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500') >= 0,
    hasFreeze: html.indexOf('\\u51bb\\u7ed3') >= 0, hits: []};
  if (info.hasCancel) {
    var hits = scanRoot(hosts[h]);
    // 没有可见的 → 掀开祖先
    if (!hits.length || !hits.some(function (t) { return t.w > 0; })) {
      var els = hosts[h].querySelectorAll('a, span, button');
      for (var i2 = 0; i2 < els.length; i2++) {
        if ((els[i2].innerText || '').trim() === '\\u53d6\\u6d88\\u6ce8\\u9500') {
          var chain = [], n = els[i2];
          while (n && n !== hosts[h]) { chain.push(n); n = n.parentElement; }
          for (var j = 0; j < chain.length; j++) {
            var st = chain[j].style;
            st.setProperty('display', 'block', 'important');
            st.setProperty('visibility', 'visible', 'important');
            st.setProperty('opacity', '1', 'important');
            st.setProperty('position', 'fixed', 'important');
            st.setProperty('left', '300px', 'important');
            st.setProperty('top', '200px', 'important');
            st.setProperty('z-index', '2147483000', 'important');
            st.setProperty('pointer-events', 'auto', 'important');
          }
        }
      }
      hits = scanRoot(hosts[h]);
    }
    info.hits = hits;
    if (hits.length) target = hits[0];
  }
  res.hosts.push(info);
}
if (target) res.target = target;
return JSON.stringify(res);
"""

CONFIRM_SCAN = """
var sels = ['.weui-desktop-dialog__ft a', '.weui-desktop-dialog__ft button', 'a.weui-desktop-btn', 'button.weui-desktop-btn', 'a', 'button'];
var roots = [document];
var all = document.querySelectorAll('*');
for (var i = 0; i < all.length; i++) { if (all[i].shadowRoot) roots.push(all[i].shadowRoot); }
var out2 = [];
for (var s = 0; s < sels.length && out2.length < 4; s++) {
  for (var r0 = 0; r0 < roots.length && out2.length < 4; r0++) {
    var els;
    try { els = roots[r0].querySelectorAll(sels[s]); } catch (e) { continue; }
    for (var k = 0; k < els.length && out2.length < 4; k++) {
      var el = els[k];
      var t = (el.innerText || '').trim();
      if (t !== '\\u786e\\u5b9a' && t !== '\\u786e\\u8ba4' && t !== '\\u662f') continue;
      var rc = el.getBoundingClientRect();
      if (rc.width <= 0 || rc.height <= 0) continue;
      out2.push({text: t, x: Math.round(rc.x), y: Math.round(rc.y), w: Math.round(rc.width), h: Math.round(rc.height)});
    }
  }
}
return JSON.stringify(out2);
"""

VERIFY = """
var all = document.querySelectorAll('*');
var live = false, texts = [];
for (var i = 0; i < all.length; i++) {
  var sr = all[i].shadowRoot;
  if (!sr) continue;
  var h = sr.innerHTML || '';
  if (h.indexOf('\\u5269\\u4f59\\u51bb\\u7ed3\\u671f') >= 0 || h.indexOf('\\u81ea\\u4e3b\\u6ce8\\u9500\\u6d41\\u7a0b') >= 0) {
    live = true;
    var els = sr.querySelectorAll('p[data-msgid]');
    for (var k = 0; k < els.length; k++) {
      var t = (els[k].textContent || '').trim();
      if (t.indexOf('\\u51bb\\u7ed3\\u671f') >= 0) texts.push(t.slice(0, 40));
    }
  }
}
return JSON.stringify({shadowLive: live, texts: texts.slice(0, 3)});
"""


def cdp_click(tab, x, y):
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseMoved", x=x, y=y)
    time.sleep(0.15)
    tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y,
                button="left", clickCount=1)
    time.sleep(0.08)
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y,
                button="left", clickCount=1)


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    tab.get(INDEX)
    time.sleep(4)

    r = json.loads(tab.run_js(SHADOW_ANCHOR) or "{}")
    out("ACT9_shadow", r=r, shot=shot(tab, "act9_shadow"))
    t = r.get("target")
    if not t or t.get("w", 0) <= 0:
        return 1

    cx = t["x"] + t["w"] // 2
    cy = t["y"] + t["h"] // 2
    cdp_click(tab, cx, cy)
    time.sleep(3)
    out("ACT9_clicked", xy=[cx, cy], shot=shot(tab, "act9_clicked"))

    for rnd in (1, 2, 3):
        btns = json.loads(tab.run_js(CONFIRM_SCAN) or "[]")
        if not btns:
            break
        b = btns[0]
        cdp_click(tab, b["x"] + b["w"] // 2, b["y"] + b["h"] // 2)
        time.sleep(2.5)
        out(f"ACT9_confirm{rnd}", btn=b, shot=shot(tab, f"act9_c{rnd}"))

    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(VERIFY) or "{}")
    gone = not v.get("shadowLive")
    out("RESTORED" if gone else "ACT9_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act9_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
