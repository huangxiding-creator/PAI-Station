# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
# getcodepage tab
gt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'getcodepage' in (t.url or ''):
        gt = t; break
if not gt:
    print('no getcodepage tab'); sys.exit(1)
gt.run_js("location.reload()")
time.sleep(5)
r = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++){
    out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,170));
  }
  return JSON.stringify(out);
})()
""")
print(r[:1200])
