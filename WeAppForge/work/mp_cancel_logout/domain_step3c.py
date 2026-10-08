# -*- coding: utf-8 -*-
"""domain_step3c.py — 抓「服务器域名」卡：四组域名 + 修改按钮 + 现有 downloadFile 值。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "/wxamp/devprofile" in (t.url or ""):
        tab = t
        break
assert tab

r = tab.run_js(r"""
return (function(){
  // 域名卡=含「服务器域名」h4 的 mod_default_box
  var boxes = document.querySelectorAll('.mod_default_box');
  var card = null;
  for (var i = 0; i < boxes.length; i++) {
    if ((boxes[i].innerText || '').indexOf('服务器域名') >= 0) { card = boxes[i]; break; }
  }
  if (!card) return JSON.stringify({card: false, n_boxes: boxes.length});
  var rows = [];
  card.querySelectorAll('.table_cell, .mod_default_hd h4').forEach(function(td){
    rows.push((td.innerText || '').replace(/\s+/g, ' ').trim().slice(0, 120));
  });
  var links = [];
  card.querySelectorAll('a').forEach(function(a){
    var t = (a.innerText || '').replace(/\s+/g, ' ').trim();
    if (t) links.push({t: t.slice(0, 20), href: (a.getAttribute('href') || '').slice(0, 40),
                       vis: a.offsetParent !== null});
  });
  return JSON.stringify({card: true, rows: rows.slice(0, 40), links: links.slice(0, 30)});
})()
""")
print(json.dumps(json.loads(r), ensure_ascii=False, indent=1))
