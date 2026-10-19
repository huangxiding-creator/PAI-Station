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
# 页面顶部的「详情」= 在审 0.9.22 块
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('span');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='详情' && vis(els[i])){
      var rect=els[i].getBoundingClientRect();
      if (rect.top < 400){els[i].click(); return 'opened@'+Math.round(rect.top);}
    }
  }
  return 'not-found';
})()
""")
print(r)
time.sleep(6)
# 全量 dump 新出现的可见 dialog/drawer 内容与动作
d = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .drawer, [class*=drawer], [class*=detail]');
  var out=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt && txt.length>20) out.push(txt.slice(0,250));
  }
  return JSON.stringify(out.slice(0,5));
})()
""")
print(d[:900])
