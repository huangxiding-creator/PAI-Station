# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ''):
            return t
gt = find_tab('getcodepage')
r = gt.run_js("return (function(){" + VIS + """
  var els=document.querySelectorAll('a, span, div');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if (t==='通知中心' && vis(els[i])){
      els[i].click(); return 'notif-opened';
    }
  }
  return 'not-found';
})()
""")
print(r)
time.sleep(4)
# 通知面板可能在任一 tab 弹出；先看 getcodepage 新内容
d = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [class*=notice], [class*=notif], [class*=message]');
  var out=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt && txt.length>15) out.push(txt.slice(0,300));
  }
  return JSON.stringify(out.slice(0,5));
})()
""")
print(d[:1200])
