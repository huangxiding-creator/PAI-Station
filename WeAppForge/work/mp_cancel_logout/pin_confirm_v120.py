# -*- coding: utf-8 -*-
"""pin_confirm_v120.py — 体验版设置弹窗: 填页面路径 + 点切换体验版 + 终验。"""
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

# 1) 找到可见的「体验版设置」弹窗，填页面路径（原生 setter），点切换体验版
r = tab.run_js(r"""
return (function(){
  var dlgs = document.querySelectorAll('.weui-desktop-dialog');
  var dlg = null;
  for (var i = 0; i < dlgs.length; i++) {
    if (dlgs[i].offsetParent !== null && dlgs[i].textContent.indexOf('体验版设置') >= 0) { dlg = dlgs[i]; break; }
  }
  if (!dlg) return JSON.stringify({step: 'no_dialog'});
  var filled = null;
  var inputs = dlg.querySelectorAll('input');
  for (var j = 0; j < inputs.length; j++) {
    if (inputs[j].offsetParent !== null) {
      var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
      setter.call(inputs[j], 'pages/index/index');
      inputs[j].dispatchEvent(new Event('input', {bubbles: true}));
      inputs[j].dispatchEvent(new Event('change', {bubbles: true}));
      filled = inputs[j].value;
      break;
    }
  }
  var clicked = null;
  var btns = dlg.querySelectorAll('button, a');
  for (var k = 0; k < btns.length; k++) {
    var t = (btns[k].innerText || '').trim();
    if (t.indexOf('切换体验版') >= 0 && btns[k].offsetParent !== null) {
      btns[k].scrollIntoView({block: 'center'});
      btns[k].click();
      clicked = t;
      break;
    }
  }
  return JSON.stringify({step: 'done', path_filled: filled, clicked: clicked});
})()
""")
print("confirm:", r)
time.sleep(5)
shot(tab, "pin_confirmed")

# 2) 终验: 1.2.0 行带 取消体验/修改页面路径 = 已是体验版; toast
r2 = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var trial120 = false; var trial_other = [];
  for (var i = 0; i < blocks.length; i++) {
    var t = blocks[i].textContent;
    var ver = (t.match(/1\.\d\.\d/) || ['?'])[0];
    if (t.indexOf('取消体验') >= 0 || t.indexOf('修改页面路径') >= 0) {
      if (t.indexOf('1.2.0') >= 0) trial120 = true; else trial_other.push(ver);
    }
  }
  var text = document.body.innerText || '';
  return JSON.stringify({trial120: trial120, trial_other: trial_other,
    toast: text.indexOf('切换成功') >= 0});
})()
""")
print("verify:", r2)
