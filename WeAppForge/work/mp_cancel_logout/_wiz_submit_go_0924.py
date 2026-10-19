# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
form_tab = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        form_tab = t; break
if not form_tab:
    print('NO_FORM_TAB'); sys.exit(1)
r = form_tab.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var btns=document.querySelectorAll('button');
  var out=[];
  for (var b=0;b<btns.length;b++){
    if (!vis(btns[b])) continue;
    var t=(btns[b].innerText||'').trim();
    if (t) out.push({t:t.slice(0,24), disabled:btns[b].disabled, primary:(btns[b].className||'').indexOf('primary')>=0});
  }
  return JSON.stringify(out.slice(-8));
})()
""")
print('form buttons:', r[:700])
