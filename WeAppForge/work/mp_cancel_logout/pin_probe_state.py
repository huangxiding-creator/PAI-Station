# -*- coding: utf-8 -*-
"""pin_probe_state.py — 钉位卡壳侦查：重放 点击链 后 dump 全窗口文本+浮层。只读加一次点击。"""
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

# 当前浮层状态（可能是上次菜单还开着）
r0 = tab.run_js(r"""
return (function(){
  var vis = [];
  var sel = ['.weui-desktop-dialog', '.weui-desktop-dropdown', '[class*="modal"]', '[class*="dialog"]', '.weui-desktop-toast'];
  for (var s = 0; s < sel.length; s++) {
    var els = document.querySelectorAll(sel[s]);
    for (var i = 0; i < els.length; i++) {
      if (els[i].offsetParent !== null || els[i].getClientRects().length) {
        vis.push({cls: sel[s], txt: (els[i].innerText || '').replace(/\s+/g, ' ').slice(0, 200)});
      }
    }
  }
  var t = (document.body.innerText || '');
  return JSON.stringify({overlays: vis, has_switch_btn: t.indexOf('切换体验版') >= 0,
    body_tail: t.replace(/\s+/g, ' ').slice(-600)});
})()
""")
print("state:", r0)
shot(tab, "pin_state")
