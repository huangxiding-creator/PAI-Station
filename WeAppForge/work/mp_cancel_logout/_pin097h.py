# -*- coding: utf-8 -*-
"""_pin097h — 钉 0.9.7 h 版（终版逻辑）：全 JS 链。
已实证活件拼装：①锚点向下定位行内 .arrowBtn（e 版）②JS click 开 ⋯ 菜单（a 版截图
实锤菜单真开过、含「选为体验版本/删除」）③15s 轮询等菜单渲染（a 版死因=1.5s 太早）
④JS click 菜单项 ⑤「切换体验版」确认 ⑥新标签复核。全程 main-doc，零原生点击零 iframe。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

D = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"
VER = "0.9.7"

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

JS_CLICK_ARROW = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i].parentElement;
      for (var d=0; d<6 && row; d++){
        var btns = row.querySelectorAll('.arrowBtn');
        if (btns.length){
          btns[0].scrollIntoView({block: 'center'});
          btns[0].click();
          return 'arrow-js-clicked@depth' + d;
        }
        row = row.parentElement;
      }
      return 'row-no-btn';
    }
  }
  return 'no-anchor';
})();
"""

# 轮询找菜单项：ownText 含「选为」（宽界：任何可见小文本含'选为'即可点其宿主）
JS_PICK_POLL = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  var snap = [];
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    if (o && o.length <= 14 && o.indexOf('选为') >= 0){
      var r = els[i].getBoundingClientRect();
      if (r.width > 0){
        snap.push({inner: o, x: Math.round(r.x), y: Math.round(r.y)});
      }
    }
  }
  if (snap.length){
    // 点最深（最内层）的那个 ownText 宿主：找 y 最小的第一个即可（同文案多嵌套时点哪个都触发）
    return JSON.stringify({hit: snap[0]});
  }
  return JSON.stringify({hit: null});
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

# [1] JS click 行内 arrowBtn
print("arrow:", nt.run_js(JS_CLICK_ARROW))

# [2] 15s 轮询等菜单项出现（出现即 JS click）
picked = False
for attempt in range(15):
    res = json.loads(nt.run_js(JS_PICK_POLL + r"""
// pick 版：找到含「选为」ownText 宿主并 click（上文 poll 只探测，这里直接点）
""") if False else nt.run_js(JS_PICK_POLL))
    if res.get("hit"):
        print(f"pick[{attempt}]:", res["hit"])
        # 直接 JS click 该坐标处的元素（宿主在最深嵌套，click() 冒泡到菜单项 handler）
        clicked = nt.run_js(r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    if (o && o.length <= 14 && o.indexOf('选为') >= 0){
      var r = els[i].getBoundingClientRect();
      if (r.width > 0){ els[i].click(); return 'clicked:' + o; }
    }
  }
  return 'gone';
})();
""")
        print("  click:", clicked)
        if str(clicked).startswith("clicked"):
            picked = True
            break
    time.sleep(1.0)
nt.get_screenshot(path=D + rf"\_pin097h_menu_{time.strftime('%H%M%S')}.png")
if not picked:
    print("PICK_FAILED_15S")
    sys.exit(1)
time.sleep(2.0)

# [3] 确认「切换体验版」
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
for attempt in range(12):
    res = nt.run_js(js_confirm)
    print(f"confirm[{attempt}]:", res)
    if str(res).startswith("confirmed"):
        break
    time.sleep(1.5)
time.sleep(3.5)
nt.get_screenshot(path=D + r"\_pin097h_after.png")

# [4] 全新标签页复核
vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
r1 = json.loads(vt.run_js(JS_READ_TRIAL))
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
