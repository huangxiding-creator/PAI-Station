# -*- coding: utf-8 -*-
"""domain_step1.py — 控制台导航探针：wxamp 首页 → 左侧菜单「开发管理」结构 dump。"""
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
    if "/wxamp/index/index" in (t.url or ""):
        tab = t
        break
assert tab, "no wxamp tab"

r = tab.run_js(r"""
return (function(){
  var out = [];
  // 左侧菜单所有带文本的节点（a / li / div 限菜单容器）
  var sels = ['.weui-desktop-menu__item', '.menu_item', 'a[href]', '.sub_menu a'];
  var seen = {};
  document.querySelectorAll('a[href]').forEach(function(a){
    var t = (a.innerText || '').replace(/\s+/g, ' ').trim();
    if (!t) return;
    var h = a.getAttribute('href') || '';
    if (t.indexOf('开发') >= 0 || t.indexOf('设置') >= 0 || t.indexOf('管理') >= 0 || t.indexOf('版本') >= 0) {
      var k = t + '|' + h;
      if (!seen[k]) { seen[k] = 1; out.push({t: t.slice(0, 30), h: h.slice(0, 120)}); }
    }
  });
  return JSON.stringify(out.slice(0, 40));
})()
""")
print("NAV:", r)
shot(tab, "menu_probe")
