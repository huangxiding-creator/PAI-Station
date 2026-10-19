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
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var cands=[];
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var e=els[i];
    if (/^H[1-6]$/.test(e.tagName)) continue;
    if (ownText(e)==='提交审核' && vis(e)) cands.push({tag:e.tagName, cls:(e.className||'').toString().slice(0,50), role:e.getAttribute('role')||''});
  }
  return JSON.stringify(cands);
})()
""")
print('candidates:', r[:600])
