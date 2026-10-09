# -*- coding: utf-8 -*-
"""_pin097f — 钉 0.9.7 e 版：d 版实锤原生点击活但点错卡（线上版本菜单=版本回退/暂停服务）。
根因=从 arrowBtn 向上找含版本号的块会命中跨区祖先容器。反转：ownText=='0.9.7'
版本号锚点 → 行容器内向下找 .arrowBtn（同一行内，零歧义）→ 原生点击 → 菜单
「选为体验版本」原生点击 →「切换体验版」确认 → 新标签复核。"""
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

# [1] 锚点向下：ownText=='0.9.7' → 行容器 → 行内 .arrowBtn，滚动并报坐标
js_locate = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i].parentElement;
      for (var d=0; d<6 && row; d++){
        var btns = row.querySelectorAll('.arrowBtn');
        if (btns.length){
          row.scrollIntoView({block: 'center'});
          return JSON.stringify({found: true, depth: d, n_btn: btns.length});
        }
        row = row.parentElement;
      }
      return JSON.stringify({found: true, no_btn: true});
    }
  }
  return JSON.stringify({found: false});
})();
"""
loc = json.loads(nt.run_js(js_locate))
print("locate:", loc)
if not loc.get("found"):
    print("NO_0.9.7_ANCHOR")
    sys.exit(1)
time.sleep(1.0)

# [2] 重测行内 arrowBtn 坐标（滚动后真值）
js_rect = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i].parentElement;
      for (var d=0; d<6 && row; d++){
        var btns = row.querySelectorAll('.arrowBtn');
        if (btns.length){
          var r = btns[0].getBoundingClientRect();
          var rr = row.getBoundingClientRect();
          return JSON.stringify({x: r.x + r.width/2, y: r.y + r.height/2, row_text: (row.innerText||'').slice(0,60).replace(/\n/g,'|'), row_y: Math.round(rr.y)});
        }
        row = row.parentElement;
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

# [3] 原生点击行内 arrowBtn
nt.actions.move_to((int(rc["x"]), int(rc["y"])), duration=.2)
nt.actions.wait(.6)
nt.actions.click()
time.sleep(2.5)

# [4] 区域全量 dump：行附近所有可见小文本元素（不猜 class——f 版教训：菜单组件
#     非 li/[class*=menu]，class 筛选必漏；全量收数据再挑）
_row_y = int(rc.get("row_y") or 0)
js_dump = r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('*');
  var y0 = """ + str(_row_y - 80) + r""", y1 = """ + str(_row_y + 340) + r""";
  for (var i=0;i<els.length;i++){
    var it = (els[i].innerText || '').trim();
    if (it && it.length >= 2 && it.length <= 16 && it.indexOf('\n') < 0){
      var r = els[i].getBoundingClientRect();
      if (r.width > 0 && r.x > 700 && r.y >= y0 && r.y <= y1){
        var own = Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');
        if (own === it) out.push({inner: it, tag: els[i].tagName, cls: (els[i].className||'').toString().slice(0,40), x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)});
      }
    }
  }
  return JSON.stringify(out.slice(0, 30));
})();
"""
dump = json.loads(nt.run_js(js_dump))
print("REGION_DUMP:", json.dumps(dump, ensure_ascii=False))
nt.get_screenshot(path=D + r"\_pin097f_menu.png")

target = None
for e in dump:
    if "选为体验" in e.get("inner", ""):
        target = e; break
if target is None:
    print("NO_TARGET")
    sys.exit(1)

# [5] 原生点击「选为体验版本」
cx = target["x"] + target["w"] // 2
cy = target["y"] + target["h"] // 2
print("menu item:", target, "-> click @", cx, cy)
nt.actions.move_to((cx, cy), duration=.2)
nt.actions.wait(.3)
nt.actions.click()
time.sleep(2.5)
nt.get_screenshot(path=D + r"\_pin097f_dialog.png")

# [6] 确认「切换体验版」
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
nt.get_screenshot(path=D + r"\_pin097f_after.png")

# [7] 全新标签页复核
vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
r1 = json.loads(vt.run_js(JS_READ_TRIAL))
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
