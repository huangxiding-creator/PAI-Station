# -*- coding: utf-8 -*-
"""_pin097b — 钉 0.9.7 b 版：a 版死因=菜单渲染慢于 1.5s 采样窗（截图实锤菜单后开）。
修：pick 改 8 次重试环（ownText 严格→innerText 含含两梯）+每轮后探测切换弹窗；
确认键同 a 版文本直配。四防线不变：新标签真态/精确点击/定域确认/钉后复核。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

D = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"
VER = "0.9.7"
EXCL = "0.9.5"   # 排除歧义邻版（0.9.5/0.9.6 同屏）

JS_READ_TRIAL = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '体验版'){
      var node = els[i];
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t = node.innerText || '';
        if (t.length > 20 && t.length < 600){
          var m = t.match(/0\.\d+\.\d+/);
          if (m) return JSON.stringify({ver: m[0], d: d, ctx: t.slice(0,110).replace(/\n/g,'|')});
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
    return r, t


page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
if tab is None:
    print("NO_LOGGED_IN_TAB")
    sys.exit(1)
token = re.search(r"token=(\d{8,})", tab.url or "").group(1)

r0, nt = read_trial_in_new_tab(page, token)
print("live_pin_before:", json.dumps(r0, ensure_ascii=False))
if r0.get("ver") == VER:
    print("ALREADY_PINNED:", VER)
    sys.exit(0)

js_click_arrow = r"""
return (function(){
  var btns = document.querySelectorAll('.arrowBtn');
  for (var i = 0; i < btns.length; i++) {
    var node = btns[i];
    for (var d = 0; d < 10 && node; d++) {
      node = node.parentElement;
      if (!node) break;
      var t = node.innerText || '';
      if (t.indexOf('""" + VER + r"""') >= 0 && t.indexOf('""" + EXCL + r"""') < 0 && t.length > 20 && t.length < 500) {
        btns[i].scrollIntoView({block: 'center'});
        btns[i].click();
        return 'arrow-clicked@' + d;
      }
    }
  }
  return 'no-arrow-for-""" + VER + r"""';
})();
"""
print("arrow:", nt.run_js(js_click_arrow))

# [3b] pick 重试环：ownText 严格 → innerText 含含（菜单渲染慢，截图实锤晚于 1.5s）
js_pick = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  var fb = null;
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    var it = (els[i].innerText || '').trim();
    var hit = (o === '选为体验版本') ||
              (o.indexOf('选为体验') >= 0 && o.length < 12) ||
              (it === '选为体验版本');
    if (hit){
      var r = els[i].getBoundingClientRect();
      if (r.width === 0) continue;
      if (o === '选为体验版本' || it === '选为体验版本') { els[i].click(); return 'picked-strict@' + Math.round(r.x) + ',' + Math.round(r.y); }
      if (!fb) fb = els[i];
    }
  }
  if (fb){ var r2 = fb.getBoundingClientRect(); fb.click(); return 'picked-fb@' + Math.round(r2.x) + ',' + Math.round(r2.y); }
  return 'not-found';
})();
"""
picked = False
for attempt in range(10):
    res = nt.run_js(js_pick)
    print(f"pick[{attempt}]:", res)
    if str(res).startswith("picked"):
        picked = True
        break
    time.sleep(1.2)
if not picked:
    nt.get_screenshot(path=D + r"\_pin097b_stuck.png")
    print("PICK_FAILED — see _pin097b_stuck.png")
    sys.exit(1)
time.sleep(2)
nt.get_screenshot(path=D + r"\_pin097b_dialog.png")

js_confirm = r"""
return (function(){
  var btns = document.querySelectorAll('button, .weui-desktop-btn');
  for (var j = 0; j < btns.length; j++) {
    var own = (btns[j].innerText || '').trim();
    var r = btns[j].getBoundingClientRect();
    if (own === '切换体验版' && r.width > 0) { btns[j].click(); return 'confirmed:' + Math.round(r.x) + ',' + Math.round(r.y); }
  }
  return 'no-switch-btn';
})();
"""
for attempt in range(10):
    res = nt.run_js(js_confirm)
    print(f"confirm[{attempt}]:", res)
    if str(res).startswith("confirmed"):
        break
    time.sleep(1.5)
time.sleep(3.5)
nt.get_screenshot(path=D + r"\_pin097b_after.png")

r1, _ = read_trial_in_new_tab(page, token)
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
