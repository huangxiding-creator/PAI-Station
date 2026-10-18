# -*- coding: utf-8 -*-
"""pin_trial_v120_tech_b.py — 重钉 1.2.0 体验版：菜单项与确认弹窗双重可见性+文本校验。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

TARGET = "1.2.0"

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

tab.get(tab.url)
time.sleep(6)
html = tab.html or ""
if "wxfdb55b184756e89e" not in html and "gh_5ebe2155780f" not in html:
    print(json.dumps({"guard": "APPID_MISMATCH"}))
    raise SystemExit(1)

# 1) 点 1.2.0 块的下拉箭头
r1 = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var target = null;
  for (var i = 0; i < blocks.length; i++) {
    var t = blocks[i].textContent;
    if (t.indexOf('""" + TARGET + r"""') >= 0 && t.indexOf('取消体验') < 0) { target = blocks[i]; break; }
  }
  if (!target) return JSON.stringify({step: 'find_block', ok: false});
  var arrow = target.querySelector('.weui-desktop-btn_wrp.arrowBtn');
  if (!arrow) return JSON.stringify({step: 'find_arrow', ok: false});
  arrow.click();
  return JSON.stringify({step: 'arrow_clicked'});
})()
""")
print("step1:", r1)
time.sleep(2)

# 2) 只点「可见的」选为体验版本菜单项，并回读其所属下拉的行文本证据
r2 = tab.run_js(r"""
return (function(){
  var items = document.querySelectorAll('.weui-desktop-dropdown__list-ele__text');
  var vis = [];
  for (var i = 0; i < items.length; i++) {
    var el = items[i];
    var t = (el.innerText || '').trim();
    var visible = !!(el.offsetParent !== null || el.getClientRects().length);
    vis.push({t: t, visible: visible});
    if (visible && t.indexOf('选为体验版') >= 0) {
      el.click();
      return JSON.stringify({step: 'menu_clicked', t: t, all: vis});
    }
  }
  return JSON.stringify({step: 'no_visible_match', all: vis.slice(0, 12)});
})()
""")
print("step2:", r2)
time.sleep(2)

# 3) 确认弹窗必须同时含「1.2.0」与「设为体验版本」才许点
r3 = tab.run_js(r"""
return (function(){
  var dlg = null;
  var cands = document.querySelectorAll('.weui-desktop-dialog, .weui-dialog, [class*="dialog"]');
  for (var i = 0; i < cands.length; i++) {
    if (cands[i].offsetParent !== null && cands[i].textContent.indexOf('设为体验版本') >= 0) { dlg = cands[i]; break; }
  }
  if (!dlg) {
    var bt = document.body.innerText || '';
    if (bt.indexOf('设为体验版本') >= 0) dlg = document.body;
  }
  if (!dlg) return JSON.stringify({step: 'no_dialog'});
  var txt = dlg.textContent || '';
  var right = txt.indexOf('""" + TARGET + r"""') >= 0;
  if (!right) return JSON.stringify({step: 'WRONG_VERSION_DIALOG', txt: txt.replace(/\s+/g, ' ').slice(0, 160)});
  var btns = dlg.querySelectorAll('button, a');
  for (var j = 0; j < btns.length; j++) {
    var t = (btns[j].innerText || '').trim();
    if (t.indexOf('切换体验版') >= 0 && btns[j].offsetParent !== null) {
      btns[j].click();
      return JSON.stringify({step: 'confirm_clicked', txt: txt.replace(/\s+/g, ' ').slice(0, 120)});
    }
  }
  return JSON.stringify({step: 'no_confirm_btn', txt: txt.replace(/\s+/g, ' ').slice(0, 160)});
})()
""")
print("step3:", r3)
time.sleep(5)
shot(tab, "pin_b_after")

# 4) 终验
r4 = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var trial120 = false;
  for (var i = 0; i < blocks.length; i++) {
    var t = blocks[i].textContent;
    if (t.indexOf('""" + TARGET + r"""') >= 0 && t.indexOf('取消体验') >= 0) { trial120 = true; break; }
  }
  var text = document.body.innerText || '';
  return JSON.stringify({trial120: trial120, toast: text.indexOf('切换成功') >= 0});
})()
""")
print("verify:", r4)
