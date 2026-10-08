# -*- coding: utf-8 -*-
"""domain_step3b.py — 宽匹配：任何 textContent 含「服务器域名」的最小元素 + 周边 HTML。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

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
  // 最小含「服务器域名」的元素（自后向前遍历取子孙最少者≈最深）
  var all = document.querySelectorAll('*');
  var best = null;
  for (var i = all.length - 1; i >= 0; i--) {
    var el = all[i];
    if ((el.childElementCount <= 4) && (el.textContent || '').indexOf('服务器域名') >= 0
        && (el.textContent || '').length < 300) {
      best = el; break;
    }
  }
  if (!best) return JSON.stringify({hit: false, body_has: (document.body.innerText.indexOf('服务器域名') >= 0)});
  var p = best;
  for (var up = 0; up < 4; up++) p = p.parentElement || p;
  return JSON.stringify({hit: true, html: p.outerHTML.slice(0, 3500)});
})()
""")
d = json.loads(r)
if d.get("hit"):
    print(d["html"][:3500])
else:
    print("NO_HIT", d)
