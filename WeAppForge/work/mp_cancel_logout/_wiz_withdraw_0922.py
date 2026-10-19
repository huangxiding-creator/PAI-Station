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
# 找审核版本块(0.9.22 审核中)的 撤回 钮
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  var found=[];
  for (var i=0;i<els.length;i++){
    var t=ownText(els[i]);
    if (t==='撤回' && vis(els[i])) found.push({tag:els[i].tagName, cls:(els[i].className||'').toString().slice(0,40)});
  }
  return JSON.stringify(found);
})()
""")
print('withdraw btns:', r[:300])
c = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var t=ownText(els[i]);
    if (t==='撤回' && vis(els[i])){
      // 锚定到审核版本块内的（页面上部）
      var rect=els[i].getBoundingClientRect();
      if (rect.top < 900){
        els[i].click(); return 'withdraw-clicked@'+Math.round(rect.top);
      }
    }
  }
  return 'not-found';
})()
""")
print('click:', c)
time.sleep(3)
d = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,16));}}
    return JSON.stringify({head:(mods[i].innerText||'').replace(/\s+/g,' ').slice(0,180), btns:bl});
  }
  return '';
})()
""")
print('dlg:', d[:400])
