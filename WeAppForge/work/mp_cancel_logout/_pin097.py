# -*- coding: utf-8 -*-
"""_pin097 — 钉 0.9.7 为体验版（_pin094_fix 同款四防线）：
1) 全新标签页读真态（免疫旧 DOM/bfcache）；2) 菜单项按精确文本点击；
3) 确认键定域在弹窗容器内；4) 钉后新标签页复核。红线：不碰提交审核。"""
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
  // 1009 实页面：开发版本列表行内绿标 ownText='体验版'（非'体验版本'，那只是左侧导航词）
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '体验版'){
      var node = els[i];
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t = node.innerText || '';
        // 行级容器（<600字）：从中提第一个 0.x.y 版本号=持标行
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
    t.get_screenshot(path=D + rf"\_pin097_read_{time.strftime('%H%M%S')}.png")
    return r, t


page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
if tab is None:
    print("NO_LOGGED_IN_TAB")
    sys.exit(1)
m = re.search(r"token=(\d{8,})", tab.url or "")
token = m.group(1)

# [1] 全新标签页读当前真态
r0, nt = read_trial_in_new_tab(page, token)
print("live_pin_before:", json.dumps(r0, ensure_ascii=False))
if r0.get("ver") == VER:
    print("ALREADY_PINNED:", VER)
    sys.exit(0)

# [2] 钉位入口：从每个 .arrowBtn 向上找版本块（含0.9.7不含0.9.5=本尊块），只点它
js_click_arrow = r"""
return (function(){
  var btns = document.querySelectorAll('.arrowBtn');
  for (var i = 0; i < btns.length; i++) {
    var node = btns[i];
    for (var d = 0; d < 10 && node; d++) {
      node = node.parentElement;
      if (!node) break;
      var t = node.innerText || '';
      if (t.indexOf('""" + VER + r"""') >= 0 && t.indexOf('0.9.5') < 0 && t.length > 20 && t.length < 500) {
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
time.sleep(1.5)

# [3] 菜单项：ownText 精确「选为体验版本」优先，退而含「选为体验」的可见元素
js_pick = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  var fallback = null;
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    if (o === '选为体验版本' || (o.indexOf('选为体验') >= 0 && o.length < 12)) {
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
nt.get_screenshot(path=D + r"\_pin097_dialog.png")

# [4] 确认键：直接找按钮文本「切换体验版」（弹窗容器未必含版本字面量，1009 实证）
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
for attempt in range(8):
    res = nt.run_js(js_confirm)
    print(f"confirm[{attempt}]:", res)
    if str(res).startswith("confirmed"):
        break
    time.sleep(1.5)
time.sleep(3.5)
nt.get_screenshot(path=D + r"\_pin097_after.png")

# [5] 再开全新标签页复核终态
r1, nt2 = read_trial_in_new_tab(page, token)
print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")
