# -*- coding: utf-8 -*-
"""trial_qr_extract.py — 版本管理页找 1.2.0 体验版行,触发/抓取二维码图。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "mp.weixin.qq.com" in (t.url or "") and "getcodepage" in (t.url or ""):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

# 1) 全页 img 盘点（找二维码类图）
r = tab.run_js(r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('img');
  for (var i = 0; i < els.length; i++) {
    var src = els[i].src || '';
    if (src && (src.indexOf('qrcode') >= 0 || src.indexOf('qr') >= 0 || src.indexOf('wxa') >= 0 || els[i].offsetParent !== null)) {
      out.push({src: src.slice(0, 140), vis: els[i].offsetParent !== null,
        w: els[i].naturalWidth || 0, h: els[i].naturalHeight || 0});
    }
  }
  var t = (document.body.innerText || '');
  return JSON.stringify({imgs: out.slice(0, 20), has_scan_trial: t.indexOf('扫描访问体验版') >= 0,
    has_trial: t.indexOf('体验版') >= 0});
})()
""")
print("probe:", r[:2000])

# 2) hover/点击「扫描访问体验版」触发二维码浮层
r2 = tab.run_js(r"""
return (function(){
  var links = document.querySelectorAll('a, span, div, button');
  var hit = null;
  for (var i = 0; i < links.length; i++) {
    var t = (links[i].innerText || '').trim();
    if (t === '扫描访问体验版' && links[i].offsetParent !== null) {
      var ev = new MouseEvent('mouseenter', {bubbles: true});
      links[i].dispatchEvent(ev);
      ev = new MouseEvent('mouseover', {bubbles: true});
      links[i].dispatchEvent(ev);
      links[i].click();
      hit = t;
      break;
    }
  }
  return JSON.stringify({triggered: hit});
})()
""")
print("trigger:", r2)
time.sleep(3)
shot(tab, "trial_qr_shown")

# 3) 浮层里的二维码图 src
r3 = tab.run_js(r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('img');
  for (var i = 0; i < els.length; i++) {
    var src = els[i].src || '';
    if (src && els[i].offsetParent !== null && (els[i].naturalWidth || 0) >= 80) {
      out.push(src.slice(0, 200));
    }
  }
  return JSON.stringify({vis_imgs: out.slice(0, 15)});
})()
""")
print("imgs_after:", r3[:2000])
