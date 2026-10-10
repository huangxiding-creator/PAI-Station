# -*- coding: utf-8 -*-
"""trial_qr_trigger.py — 定位「扫描访问体验版」元素, 触发浮层, 抓二维码。"""
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

# 1) 找到「扫描访问体验版」宿主元素及其 HTML 上下文
r = tab.run_js(r"""
return (function(){
  var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  var node;
  while (node = walker.nextNode()) {
    if ((node.textContent || '').indexOf('扫描访问体验版') >= 0) {
      var el = node.parentElement;
      var chain = [];
      var cur = el;
      for (var i = 0; i < 5 && cur; i++) {
        chain.push({tag: cur.tagName, cls: (cur.className||'').toString().slice(0, 70), vis: cur.offsetParent !== null});
        cur = cur.parentElement;
      }
      return JSON.stringify({chain: chain, html: el.outerHTML.slice(0, 500)});
    }
  }
  return JSON.stringify({found: false});
})()
""")
print("host:", r[:1500])

# 2) 触发它（mouseenter/click）
r2 = tab.run_js(r"""
return (function(){
  var walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT);
  var node;
  while (node = walker.nextNode()) {
    if ((node.textContent || '').indexOf('扫描访问体验版') >= 0) {
      var el = node.parentElement;
      for (var i = 0; i < 4 && el; i++) {
        el.dispatchEvent(new MouseEvent('mouseenter', {bubbles: true}));
        el.dispatchEvent(new MouseEvent('mouseover', {bubbles: true}));
        el = el.parentElement;
      }
      var target = node.parentElement;
      for (var i = 0; i < 3 && target; i++) {
        if (target.click) { try { target.click(); } catch (e) {} }
        target = target.parentElement;
      }
      return JSON.stringify({triggered: true});
    }
  }
  return JSON.stringify({triggered: false});
})()
""")
print("trigger:", r2)
time.sleep(4)
shot(tab, "trial_qr_popover")

# 3) 浮层 QR：img / canvas 盘点
r3 = tab.run_js(r"""
return (function(){
  var imgs = [];
  var els = document.querySelectorAll('img');
  for (var i = 0; i < els.length; i++) {
    var src = els[i].src || '';
    if (src && els[i].offsetParent !== null && src.indexOf('svg') < 0) {
      imgs.push(src.slice(0, 160));
    }
  }
  var canvases = document.querySelectorAll('canvas');
  var cv = [];
  for (var i = 0; i < canvases.length; i++) {
    if (canvases[i].offsetParent !== null) cv.push({w: canvases[i].width, h: canvases[i].height});
  }
  var dl = [];
  var links = document.querySelectorAll('a');
  for (var i = 0; i < links.length; i++) {
    var t = (links[i].innerText || '').trim();
    if (t.indexOf('下载') >= 0 && links[i].offsetParent !== null) dl.push(t);
  }
  return JSON.stringify({imgs: imgs.slice(0, 10), canvases: cv, downloads: dl});
})()
""")
print("qr_candidates:", r3[:2000])
