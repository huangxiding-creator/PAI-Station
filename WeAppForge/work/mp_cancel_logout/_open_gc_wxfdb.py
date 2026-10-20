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
gt = find_tab('mp.weixin.qq.com')
gt.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=415764933&lang=zh_CN'")
time.sleep(8)
gt2 = find_tab('getcodepage')
print('url:', (gt2.url or '')[:110])
r = gt2.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,130));
  return JSON.stringify(out.slice(0,5));
})()
""")
print(r[:1000])
