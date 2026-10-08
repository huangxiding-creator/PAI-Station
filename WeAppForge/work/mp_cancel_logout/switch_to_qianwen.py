# -*- coding: utf-8 -*-
"""switch_to_qianwen.py — 9336 控制台同管切号 wxfdb→wx5cee（总包AI顾问）。
配方（HANDOFF 已实证）：隐藏 div[title="切换账号"] JS 直点（Vue handler 不挑可见性）
→ .switch_account_dialog .account_item 点目标号 → 整页刷新换 token。
"""
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
    if "/wxamp/index/index" in (t.url or "") or "wacodepage" in (t.url or ""):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

# 1) 展开隐藏切换器
r1 = tab.run_js(r"""
return (function(){
  var el = document.querySelector('div[title="切换账号"]');
  if (!el) return JSON.stringify({step: 'find_switcher', ok: false});
  el.click();
  return JSON.stringify({step: 'clicked'});
})()
""")
print("step1:", r1)
time.sleep(2)

# 2) dump 账号列表
r2 = tab.run_js(r"""
return (function(){
  var dlg = document.querySelector('.switch_account_dialog') || document;
  var items = dlg.querySelectorAll('.account_item');
  var out = [];
  for (var i = 0; i < items.length; i++) {
    out.push({i: i, t: (items[i].innerText || '').replace(/\s+/g, ' ').trim().slice(0, 60)});
  }
  return JSON.stringify(out);
})()
""")
print("accounts:", r2)
shot(tab, "switch_accounts")

# 3) 点总包AI顾问（wx5cee）
r3 = tab.run_js(r"""
return (function(){
  var dlg = document.querySelector('.switch_account_dialog') || document;
  var items = dlg.querySelectorAll('.account_item');
  for (var i = 0; i < items.length; i++) {
    var t = items[i].innerText || '';
    if (t.indexOf('AI') >= 0 || t.indexOf('顾问') >= 0) {
      items[i].click();
      return JSON.stringify({step: 'clicked_target', t: t.replace(/\s+/g, ' ').slice(0, 50)});
    }
  }
  return JSON.stringify({step: 'target_not_found'});
})()
""")
print("step3:", r3)
time.sleep(6)   # 整页刷新换 token
shot(tab, "switch_after")
u = tab.url or ""
print("url:", u[:120])
