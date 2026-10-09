# -*- coding: utf-8 -*-
"""_pin094_fix — 重钉 0.9.4（根因修复版）：
1) 全新标签页读真态（免疫旧 DOM/bfcache）；2) 菜单项按精确文本点击（上次选择器落空）；
3) 确认键定域在弹窗容器内（上次全局搜索可能误中别处按钮）；4) 钉后新标签页复核。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

D = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"

JS_READ_TRIAL = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    if (o === '体验版本'){
      var node = els[i];
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t = node.innerText || '';
        if (t.indexOf('版本号') >= 0){
          var m = t.match(/版本号\s*([0-9.]+)/);
          if (m) return JSON.stringify({ver: m[1], d: d, ctx: t.slice(0,110).replace(/\n/g,'|')});
        }
      }
    }
  }
  return JSON.stringify({ver: null});
})();
"""


def read_trial_in_new_tab(page, token):
    t = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
    time.sleep(6)
    r = json.loads(t.run_js(JS_READ_TRIAL))
    t.get_screenshot(path=D + rf"\_pin094_fix_read_{time.strftime('%H%M%S')}.png")
    return r, t


page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
m = re.search(r"token=(\d{8,})", tab.url or "")
token = m.group(1)

# [1] 全新标签页读当前真态
r0, nt = read_trial_in_new_tab(page, token)
print("live_pin_before:", json.dumps(r0, ensure_ascii=False))

# [2] 在新标签页上执行钉位（页面即真态）
js_click_arrow = r"""
return (function(){
  var all = document.querySelectorAll('div,section');
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('0.9.4') >= 0 && t.indexOf('版本号') >= 0 && t.length < 500) {
      var row = all[i];
      row.scrollIntoView({block: 'center'});
      var ab = row.querySelector('.arrowBtn');
      if (ab) { ab.click(); return 'arrow-clicked'; }
      return 'no-arrow';
    }
  }
  return 'row-not-found';
})();
"""
print("arrow:", nt.run_js(js_click_arrow))
time.sleep(1.5)

# [3] 菜单项：任意元素 ownText 精确等于「选为体验版本」→ 点击（不猜 class）
js_pick = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '选为体验版本'){
      var r = els[i].getBoundingClientRect();
      if (r.width === 0) continue;
      els[i].click();
      return 'picked@' + Math.round(r.x) + ',' + Math.round(r.y);
    }
  }
  return 'not-found';
})();
"""
print("pick:", nt.run_js(js_pick))
time.sleep(2)
nt.get_screenshot(path=D + r"\_pin094_fix_dialog.png")

# [4] 确认键：定域在含「设为体验版」文案的弹窗容器内找蓝按钮
js_confirm = r"""
return (function(){
  var all = document.querySelectorAll('div,section');
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('设为体验版本') >= 0 && t.indexOf('0.9.4') >= 0 && t.length < 300) {
      var btns = all[i].querySelectorAll('button');
      for (var j = 0; j < btns.length; j++) {
        var own = (btns[j].innerText || '').trim();
        if (own.indexOf('切换体验版') >= 0) { btns[j].click(); return 'confirmed-in-dialog'; }
      }
      return 'dialog-found-no-btn:' + t.slice(0, 80);
    }
  }
  return 'no-dialog';
})();
"""
print("confirm:", nt.run_js(js_confirm))
time.sleep(3.5)
nt.get_screenshot(path=D + r"\_pin094_fix_after.png")

# [5] 再开全新标签页复核终态
r1, nt2 = read_trial_in_new_tab(page, token)
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
