# -*- coding: utf-8 -*-
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
ft = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        ft = t; break
r = ft.run_js("""
return (async function(){
  var fd = new FormData();
  fd.append('action','submit_check');
  fd.append('token','1727388897');
  fd.append('lang','zh_CN');
  var res = await fetch('/wxamp/cgi/route?path=%2Fwxopen%2Fwadevelopcode%3Faction%3Dsubmit_check&token=1727388897&lang=zh_CN', {
    method:'POST', body: fd, credentials:'include'});
  var j = await res.text();
  return j.slice(0, 800);
})()
""")
print(r[:800])
