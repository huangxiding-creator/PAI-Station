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
r = form_tab.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='前往确认' && vis(btns[b])){btns[b].click(); return 'go-confirm';}
    }
  }
  return 'not-found';
})()
""")
print('r:', r)
time.sleep(4)
print('url now:', (form_tab.url or '')[:130])
s = form_tab.run_js(r"""
return (function(){
  var t=(document.body.innerText||'').replace(/\s+/g,' ');
  return t.slice(0, 500);
})()
""")
print('page head:', s[:500])
