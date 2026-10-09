# -*- coding: utf-8 -*-
"""_pin097c — 钉 0.9.7 c 版：b 版死象=下拉未开（JS click 假点击，1004 同款）。
路数：dump 菜单真 DOM（数据先行不猜）→ .actions 原生坐标点击菜单项 → 弹窗确认
按钮仍 JS 文本直配（v096 实证该按钮 JS click 活）。四防线不变。"""
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

# [1] 点 0.9.7 行 arrowBtn（v096 同款 JS，实证能开菜单入口）
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
        var r = btns[i].getBoundingClientRect();
        return JSON.stringify({arrow: 'ok', x: r.x + r.width/2, y: r.y + r.height/2});
      }
    }
  }
  return JSON.stringify({arrow: 'no'});
})();
"""
a = json.loads(nt.run_js(js_click_arrow))
print("arrow:", a)
time.sleep(3)

# [2] dump：所有含「体验版」的元素（tag/own/inner/rect）——数据先行
js_dump = r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var it = (els[i].innerText || '');
    if (it.indexOf('体验版') >= 0 || it.indexOf('选为') >= 0){
      var own = Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');
      if (it.length < 30 || own.length < 30){
        var r = els[i].getBoundingClientRect();
        if (r.width > 0) out.push({tag: els[i].tagName, own: own.slice(0,20), inner: it.trim().slice(0,20), x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)});
      }
    }
  }
  return JSON.stringify(out.slice(0, 25));
})();
"""
dump = json.loads(nt.run_js(js_dump))
print("DUMP:", json.dumps(dump, ensure_ascii=False))
nt.get_screenshot(path=D + r"\_pin097c_dump.png")

# [3] 目标=own/inner 含「选为体验版本」的元素（dump 数据判），原生坐标点击
target = None
for e in dump:
    txt = (e.get("own") or "") + "|" + (e.get("inner") or "")
    if "选为体验" in txt:
        target = e; break
if target is None:
    print("NO_TARGET_IN_DUMP")
    sys.exit(1)
cx = target["x"] + target["w"] // 2
cy = target["y"] + target["h"] // 2
print("target:", target, "-> native click @", cx, cy)
try:
    nt.actions.move_to(cx, cy).click().perform()
    print("native-click: ok")
except Exception as exc:  # noqa: BLE001
    print("native-click fallback (ele.click):", exc)
    nt.ele(f"x:{cx},{cy}").click()
time.sleep(2.5)
nt.get_screenshot(path=D + r"\_pin097c_dialog.png")

# [4] 确认键：文本直配「切换体验版」（v096 实证 JS click 活）
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
nt.get_screenshot(path=D + r"\_pin097c_after.png")

# [5] 全新标签页复核
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
vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)
r1 = json.loads(vt.run_js(JS_READ_TRIAL))
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
