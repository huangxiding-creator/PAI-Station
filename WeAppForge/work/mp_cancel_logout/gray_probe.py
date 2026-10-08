# -*- coding: utf-8 -*-
"""gray_probe.py — 版本页全量 dump：找 0.9.0 块 + 灰度发布横幅（撤销发布按钮）。"""
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
    if "wacodepage/getcodepage" in (t.url or ""):
        tab = t
        break
assert tab, "no getcodepage tab"

r = tab.run_js(r"""
return (function(){
  var out = {v090: null, gray: null};
  // 1) 0.9.0 块
  var logs = document.querySelectorAll('.code_version_log');
  for (var i = 0; i < logs.length; i++) {
    if (logs[i].textContent.indexOf('0.9.0') >= 0) {
      out.v090 = logs[i].textContent.replace(/\s+/g, ' ').slice(0, 260);
      break;
    }
  }
  // 2) 灰度发布横幅：含「灰度」的可容器 + 其内按钮
  var all = document.querySelectorAll('div');
  for (var j = 0; j < all.length; j++) {
    var d = all[j];
    var t = d.textContent || '';
    if (t.indexOf('灰度发布') >= 0 && t.length < 600) {
      var btns = [];
      d.querySelectorAll('a, button').forEach(function(b){
        var bt = (b.innerText || '').replace(/\s+/g, ' ').trim();
        if (bt) btns.push(bt.slice(0, 16));
      });
      out.gray = {txt: t.replace(/\s+/g, ' ').slice(0, 300), btns: btns};
      break;
    }
  }
  return JSON.stringify(out);
})()
""")
print(json.dumps(json.loads(r), ensure_ascii=False, indent=1))
shot(tab, "gray_probe")
