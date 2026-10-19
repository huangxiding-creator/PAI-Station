# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    url = (t.url or '')[:100]
    try:
        d = t.run_js("return (function(){" + VIS + """
  var out=[];
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t2=(btns[b].innerText||'').trim(); if(t2) bl.push(t2.slice(0,14));}}
    if (txt) out.push({h:txt.slice(0,80), bl:bl});
  }
  var ta=document.querySelector('textarea');
  return JSON.stringify({dlgs:out.slice(0,3), has_form: !!(ta&&vis(ta))});
})()
""")
        print('-', url, '=>', d[:350])
    except Exception as e:
        print('-', url, 'ERR', str(e)[:60])
