# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
gt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'getcodepage' in (t.url or ''):
        gt = t; break
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a, button, .link, [role=button], .weui-desktop-btn');
  var out=[];
  for (var i=0;i<els.length;i++){
    var t=ownText(els[i]) || (els[i].innerText||'').trim().slice(0,12);
    if (t && vis(els[i])) out.push(t.slice(0,16));
  }
  return JSON.stringify(out.slice(0,40));
})()
""")
print(r[:1000])
