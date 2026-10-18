# -*- coding: utf-8 -*-
"""pin_trial_v120_tech.py — 9336 总包科技：1.2.0 钉体验版（块锚定安全定位配方）。"""
import json
import re
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
    u = t.url or ""
    if "mp.weixin.qq.com" in u and "getcodepage" in u:
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

# 1) 以版本号文本锚定目标块（不猜全局按钮）
r = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  if (!blocks.length) {
    var all = document.querySelectorAll('div');
    var hits = [];
    for (var i = 0; i < all.length; i++) {
      if (all[i]. childElementCount > 2 && all[i].textContent.indexOf('""" + TARGET + r"""') >= 0) hits.push(all[i]);
    }
    blocks = hits.slice(-3);
  }
  var out = [];
  for (var i = 0; i < blocks.length; i++) {
    var arrow = blocks[i].querySelector('.weui-desktop-btn_wrp.arrowBtn');
    out.push({
      i: i,
      has120: blocks[i].textContent.indexOf('""" + TARGET + r"""') >= 0,
      hasArrow: !!arrow,
      snip: blocks[i].textContent.replace(/\s+/g, ' ').slice(0, 160)
    });
  }
  return JSON.stringify(out);
})()
""")
print("blocks:", r)

# 2) 块内点下拉 → 点「选为体验版本」
r2 = tab.run_js(r"""
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
print("step2:", r2)
time.sleep(2)

r3 = tab.run_js(r"""
return (function(){
  var items = document.querySelectorAll('.weui-desktop-dropdown__list-ele__text');
  for (var i = 0; i < items.length; i++) {
    var t = (items[i].innerText || items[i].textContent || '').trim();
    if (t.indexOf('选为体验版') >= 0) {
      items[i].click();
      return JSON.stringify({step: 'menu_clicked', t: t});
    }
  }
  var any = document.querySelectorAll('.weui-desktop-dropdown__list-ele');
  var names = [];
  for (var j = 0; j < any.length; j++) names.push((any[j].innerText || '').trim());
  return JSON.stringify({step: 'menu_not_found', names: names.slice(0, 8)});
})()
""")
print("step3:", r3)
time.sleep(2)
shot(tab, "pin_dialog")

# 3) 确认弹窗：应含「将 1.2.0 设为体验版本」→ 点蓝按钮「切换体验版」
r4 = tab.run_js(r"""
return (function(){
  var body = document.body.innerText || '';
  var ok = body.indexOf('设为体验版本') >= 0 && body.indexOf('""" + TARGET + r"""') >= 0;
  var btns = document.querySelectorAll('button, a.weui-desktop-btn, .weui-btn-primary');
  var clicked = null;
  for (var i = 0; i < btns.length; i++) {
    var t = (btns[i].innerText || '').trim();
    if (t === '切换体验版' && btns[i].offsetParent !== null) {
      btns[i].click();
      clicked = t;
      break;
    }
  }
  return JSON.stringify({dialog_seen: ok, clicked: clicked});
})()
""")
print("step4:", r4)
time.sleep(4)
shot(tab, "pin_after")

# 4) 终验：窗口文本应含 体验版 + 1.2.0 关联（trial 卡行含 取消体验 与 1.2.0）
r5 = tab.run_js(r"""
return (function(){
  var text = document.body.innerText || '';
  var blocks = document.querySelectorAll('.code_version_log');
  var trial120 = false;
  for (var i = 0; i < blocks.length; i++) {
    var t = blocks[i].textContent;
    if (t.indexOf('""" + TARGET + r"""') >= 0 && t.indexOf('取消体验') >= 0) { trial120 = true; break; }
  }
  return JSON.stringify({toast_or_card: text.indexOf('切换成功') >= 0 || trial120, trial120: trial120,
    has_qr_panel: text.indexOf('体验版') >= 0});
})()
""")
print("verify:", r5)
