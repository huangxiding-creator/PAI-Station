# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
gt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'getcodepage' in (t.url or ''):
        gt = t; break
gt.run_js("location.reload()")
ok = False
for i in range(20):
    time.sleep(1)
    n = gt.run_js("return document.querySelectorAll('.code_version_log').length")
    if n and int(n) > 0:
        ok = True
        print(f'rendered after {i+1}s, blocks={n}')
        break
time.sleep(1)
r = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,150));
  return JSON.stringify(out);
})()
""")
print(r[:1000])
