# -*- coding: utf-8 -*-
# wxfdb 线上版本实况：版本管理页看 线上版本行+项目备注
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ''):
            return t
gt = find_tab('getcodepage')
if not gt:
    print('no getcodepage tab'); sys.exit(1)
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab('getcodepage')
r = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,200));
  return JSON.stringify(out.slice(0,4));
})()
""")
print(r[:1200])
