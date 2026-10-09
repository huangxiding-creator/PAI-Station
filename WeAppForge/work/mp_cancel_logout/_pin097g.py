# -*- coding: utf-8 -*-
"""_pin097g — 钉 0.9.7 g 版：e/f 版实锤菜单不进主文档 DOM 扫描视野（截图有、querySelectorAll 无）
→ 菜单在 iframe。跨文档递归扫描（主文档+全部 iframe，iframe 内坐标+iframe 自身 rect
换算成顶层视口坐标），找「选为/体验版本」元素 → 原生坐标点击 → 确认 → 复核。"""
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

# 跨文档扫描：doc 递归（主文档+iframe），ox/oy=该 doc 视口原点在顶层视口的偏移
JS_XDOC = r"""
return (function(){
  var hits = [], frames = [];
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  function scan(doc, ox, oy, where){
    try{
      var els = doc.querySelectorAll('*');
      for (var i=0;i<els.length;i++){
        var it = (els[i].innerText || '').trim();
        if (!it || it.length > 14 || it.indexOf('\n') >= 0) continue;
        var own = ownText(els[i]);
        if (own !== it) continue;
        if (it.indexOf('选为') >= 0 || it.indexOf('体验版本') >= 0 || it === '删除' || it.indexOf('提交审核') >= 0){
          var r = els[i].getBoundingClientRect();
          if (r.width > 0) hits.push({where: where, inner: it, x: Math.round(r.x+ox), y: Math.round(r.y+oy), w: Math.round(r.width), h: Math.round(r.height)});
        }
      }
      var frs = doc.querySelectorAll('iframe');
      for (var k=0;k<frs.length;k++){
        var fr = frs[k].getBoundingClientRect();
        frames.push({where: where + '>iframe' + k, x: Math.round(fr.x+ox), y: Math.round(fr.y+oy), w: Math.round(fr.width), h: Math.round(fr.height)});
        if (frs[k].contentDocument) scan(frs[k].contentDocument, ox+fr.x, oy+fr.y, where + '>iframe' + k);
      }
    }catch(e){ frames.push({where: where, err: String(e).slice(0,60)}); }
  }
  scan(document, 0, 0, 'main');
  return JSON.stringify({hits: hits.slice(0,20), frames: frames.slice(0,10)});
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

# [1] 锚点向下定位 0.9.7 行 arrowBtn（e 版实证活）+ 原生点击
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
          return JSON.stringify({found: true});
        }
        row = row.parentElement;
      }
    }
  }
  return JSON.stringify({found: false});
})();
"""
if not json.loads(nt.run_js(js_locate)).get("found"):
    print("NO_ANCHOR")
    sys.exit(1)
time.sleep(1.0)

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
          return JSON.stringify({x: r.x + r.width/2, y: r.y + r.height/2, row_y: Math.round(rr.y)});
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

nt.actions.move_to((int(rc["x"]), int(rc["y"])), duration=.2)
nt.actions.wait(.6)
nt.actions.click()
time.sleep(2.5)

# [2] 跨文档扫描菜单项
xd = json.loads(nt.run_js(JS_XDOC))
print("XDOC:", json.dumps(xd, ensure_ascii=False))
nt.get_screenshot(path=D + r"\_pin097g_menu.png")

target = None
for e in xd.get("hits", []):
    if "选为" in e.get("inner", ""):
        target = e; break
if target is None:
    print("NO_TARGET_XDOC")
    sys.exit(1)

# [3] 原生点击「选为体验版本」（坐标已换算顶层视口）
cx = target["x"] + target["w"] // 2
cy = target["y"] + target["h"] // 2
print("menu item:", target, "-> click @", cx, cy)
nt.actions.move_to((cx, cy), duration=.2)
nt.actions.wait(.3)
nt.actions.click()
time.sleep(2.5)
nt.get_screenshot(path=D + r"\_pin097g_dialog.png")

# [4] 确认「切换体验版」（主文档按钮，v096 实证 JS click 活）
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
nt.get_screenshot(path=D + r"\_pin097g_after.png")

# [5] 全新标签页复核
vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
r1 = json.loads(vt.run_js(JS_READ_TRIAL))
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
