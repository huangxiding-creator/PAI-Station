# -*- coding: utf-8 -*-
"""_pin097d — 钉 0.9.7 d 版：c 版 dump 实锤 arrowBtn JS click=假点击（菜单从未开）。
全原生链：箭头 hover+click 原生坐标 → dump 菜单项 → 原生坐标点「选为体验版本」
→ 弹窗「切换体验版」JS 文本直配（v096 实证活）→ 新标签复核。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

D = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"
VER = "0.9.7"
EXCL = "0.9.5"

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

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
if tab is None:
    print("NO_LOGGED_IN_TAB")
    sys.exit(1)
token = re.search(r"token=(\d{8,})", tab.url or "").group(1)

nt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
print("live_pin_before:", nt.run_js(JS_READ_TRIAL))

# [1] 定位 0.9.7 行 arrowBtn 坐标（只定位不点击）
js_locate = r"""
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
        return JSON.stringify({found: true, x: 0, y: 0});
      }
    }
  }
  return JSON.stringify({found: false});
})();
"""
loc = json.loads(nt.run_js(js_locate))
print("locate:", loc)
if not loc.get("found"):
    print("NO_ARROW")
    sys.exit(1)
time.sleep(1.0)

# scrollIntoView 后重测真实坐标
js_rect = r"""
return (function(){
  var btns = document.querySelectorAll('.arrowBtn');
  for (var i = 0; i < btns.length; i++) {
    var node = btns[i];
    for (var d = 0; d < 10 && node; d++) {
      node = node.parentElement;
      if (!node) break;
      var t = node.innerText || '';
      if (t.indexOf('""" + VER + r"""') >= 0 && t.indexOf('""" + EXCL + r"""') < 0 && t.length > 20 && t.length < 500) {
        var r = btns[i].getBoundingClientRect();
        return JSON.stringify({x: r.x + r.width/2, y: r.y + r.height/2});
      }
    }
  }
  return JSON.stringify({x: null});
})();
"""
rc = json.loads(nt.run_js(js_rect))
print("arrow rect:", rc)
if rc.get("x") is None:
    print("NO_RECT")
    sys.exit(1)

# [2] 原生 hover + click 箭头（真鼠标事件链）
nt.actions.move_to((int(rc["x"]), int(rc["y"])), duration=.2)
nt.actions.wait(.8)
nt.actions.click()
print("native arrow click done")
time.sleep(2.5)

# [3] dump 菜单（含「选为」或菜单容器内元素）
js_dump = r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('li, .weui-desktop-dropdown__menu-item, [class*=menu] *, [class*=dropdown] *');
  for (var i=0;i<els.length;i++){
    var it = (els[i].innerText || '').trim();
    if (it && it.length < 25){
      var r = els[i].getBoundingClientRect();
      if (r.width > 0) out.push({tag: els[i].tagName, inner: it.slice(0,20), x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)});
    }
  }
  return JSON.stringify(out.slice(0, 30));
})();
"""
dump = json.loads(nt.run_js(js_dump))
print("MENU:", json.dumps(dump, ensure_ascii=False))
nt.get_screenshot(path=D + r"\_pin097d_menu.png")

target = None
for e in dump:
    if "选为体验" in e.get("inner", "") or "体验版本" == e.get("inner", ""):
        target = e; break
if target is None:
    print("NO_TARGET")
    sys.exit(1)

# [4] 原生点击菜单项
cx = target["x"] + target["w"] // 2
cy = target["y"] + target["h"] // 2
print("menu item:", target, "-> native click @", cx, cy)
nt.actions.move_to((cx, cy), duration=.2)
nt.actions.wait(.3)
nt.actions.click()
time.sleep(2.5)
nt.get_screenshot(path=D + r"\_pin097d_dialog.png")

# [5] 确认「切换体验版」
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
nt.get_screenshot(path=D + r"\_pin097d_after.png")

# [6] 全新标签页复核
vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
r1 = json.loads(vt.run_js(JS_READ_TRIAL))
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
