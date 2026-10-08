# -*- coding: utf-8 -*-
"""gray_probe2.py — 找带「撤销发布/全量发布」按钮的灰度发布横幅真身。"""
import json
import sys

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
assert tab

r = tab.run_js(r"""
return (function(){
  var out = [];
  var els = document.querySelectorAll('a, button');
  for (var i = 0; i < els.length; i++) {
    var b = els[i];
    var t = '';
    for (var k = 0; k < b.childNodes.length; k++) {
      var n = b.childNodes[k];
      if (n.nodeType === 3) t += n.textContent;
    }
    t = t.trim();
    if (t === '撤销发布' || t === '全量发布' || t.indexOf('撤销') === 0) {
      // 向上取容器文案
      var p = b.parentElement;
      for (var u = 0; u < 5 && p; u++) {
        if ((p.textContent || '').length > 40) break;
        p = p.parentElement;
      }
      out.push({btn: t, vis: b.offsetParent !== null,
                ctx: (p ? p.textContent : '').replace(/\s+/g, ' ').slice(0, 220)});
    }
  }
  return JSON.stringify(out);
})()
""")
print(json.dumps(json.loads(r), ensure_ascii=False, indent=1))
shot(tab, "gray_banner")
