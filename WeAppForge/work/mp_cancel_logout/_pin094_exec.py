# -*- coding: utf-8 -*-
"""_pin094_exec — 0.9.4 钉为体验版（arrowBtn→选为体验版本→切换确认）。红线：不碰提交审核。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

TAGDIR = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    u = t.url or ""
    if "mp.weixin.qq.com" in u and "token=" in u:
        tab = t
        break

def dump_menu():
    JS = r"""
return (function(){
  var out = [];
  document.querySelectorAll('.weui-desktop-dropdown-menu__item, [class*="dropdown-menu"] *, li, .weui-desktop-menu__item').forEach(function(e){
    var own = Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ').trim();
    var r = e.getBoundingClientRect();
    if (own && r.width > 0 && own.length < 20) out.push({txt: own, x: Math.round(r.x), y: Math.round(r.y), cls: (e.className||'').toString().slice(0,40)});
  });
  return JSON.stringify(out.slice(0, 20));
})();
"""
    return tab.run_js(JS)

# 1) 定位 0.9.4 行的 arrowBtn 并点开下拉
JS_OPEN = r"""
return (function(){
  var all = document.querySelectorAll('div,section');
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('0.9.4') >= 0 && t.length < 400) {
      var row = all[i];
      row.scrollIntoView({block: 'center'});
      var ab = row.querySelector('.arrowBtn');
      if (ab) { ab.click(); return 'arrowBtn-clicked'; }
      return 'no-arrowBtn-in-row';
    }
  }
  return 'row-not-found';
})();
"""
print("open:", tab.run_js(JS_OPEN))
time.sleep(1.5)
print("menu:", dump_menu())
tab.get_screenshot(path=TAGDIR + r"\_pin094_menu.png")

# 2) 点「选为体验版本」
JS_PICK = r"""
return (function(){
  var items = document.querySelectorAll('.weui-desktop-dropdown-menu__item, [class*="dropdown-menu__item"], .weui-desktop-menu__item');
  for (var i = 0; i < items.length; i++) {
    var own = (items[i].innerText || '').trim();
    if (own.indexOf('体验版') >= 0) { items[i].click(); return 'picked:' + own; }
  }
  return 'no-trial-item';
})();
"""
print("pick:", tab.run_js(JS_PICK))
time.sleep(2)
tab.get_screenshot(path=TAGDIR + r"\_pin094_dialog.png")

# 3) 确认弹窗里的「切换体验版」按钮
JS_CONFIRM = r"""
return (function(){
  var btns = document.querySelectorAll('button, .weui-desktop-btn');
  for (var i = 0; i < btns.length; i++) {
    var own = (btns[i].innerText || '').trim();
    if (own.indexOf('切换体验版') >= 0) { btns[i].click(); return 'confirmed:' + own; }
  }
  return 'no-confirm-btn';
})();
"""
print("confirm:", tab.run_js(JS_CONFIRM))
time.sleep(3)
tab.get_screenshot(path=TAGDIR + r"\_pin094_after.png")

# 4) 证据：页面 0.9.4 是否已成为体验版（体验版卡片区含 0.9.4）
JS_CHECK = r"""
return (function(){
  var html = document.body.innerText || '';
  var i = html.indexOf('体验版');
  return JSON.stringify({
    trial_mention: html.indexOf('体验版') >= 0,
    ctx: html.indexOf('0.9.4') >= 0 ? html.slice(Math.max(0, html.indexOf('0.9.4') - 60), html.indexOf('0.9.4') + 120).replace(/\s+/g, ' ') : ''
  });
})();
"""
print("check:", tab.run_js(JS_CHECK))
