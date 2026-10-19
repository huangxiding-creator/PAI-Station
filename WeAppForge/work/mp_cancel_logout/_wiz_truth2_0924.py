# -*- coding: utf-8 -*-
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
    return None
gt = find_tab('getcodepage')
gt.run_js("location.reload()")
time.sleep(8)
gt2 = find_tab('getcodepage')   # 重载后重取句柄
for i in range(15):
    try:
        n = int(gt2.run_js("return document.querySelectorAll('.code_version_log').length") or 0)
        if n > 0:
            r = gt2.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,140));
  return JSON.stringify(out);
})()
""")
            print(r[:1000]); sys.exit(0)
    except Exception as e:
        pass
    time.sleep(1)
print('TIMEOUT no blocks')
