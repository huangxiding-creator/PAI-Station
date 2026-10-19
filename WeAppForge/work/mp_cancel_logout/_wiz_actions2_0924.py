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
  var els=document.querySelectorAll('*');
  var out=[];
  for (var i=0;i<els.length;i++){
    var t=ownText(els[i]);
    if (t && t.length<=8 && vis(els[i]) && ['提交审核','详情','撤回','撤销','放弃','取消审核'].indexOf(t)>=0){
      var rect=els[i].getBoundingClientRect();
      out.push({t:t, tag:els[i].tagName, y:Math.round(rect.top)});
    }
  }
  return JSON.stringify(out.slice(0,20));
})()
""")
print(r[:800])
