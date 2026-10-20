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
gt = find_tab('getcodepage')
if not gt:
    print('NO_GC_TAB'); sys.exit(1)
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab('getcodepage')
r = gt.run_js(r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var blocks=document.querySelectorAll('.code_version_log');
  var rows=[];
  for (var i=0;i<blocks.length;i++) rows.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,110));
  // 找 1.4.0 审核行内的可点动作
  var acts=[];
  var els=document.querySelectorAll('span, a, button, div.weui-desktop-btn');
  for (var j=0;j<els.length;j++){
    var t=ownText(els[j]) || (els[j].innerText||'').trim();
    if (t && t.length<=8 && /撤|放弃|取消/.test(t) && vis(els[j])) acts.push(t+'<'+els[j].tagName+'>');
  }
  return JSON.stringify({rows:rows.slice(0,4), withdraw_acts:acts.slice(0,6)});
})()
""")
print(r[:900])
