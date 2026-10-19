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
# 1) 关当前详情弹窗
gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='关闭' && vis(btns[b])){btns[b].click(); return 'closed';}
    }
  }
  return 'no';
})()
""")
time.sleep(1.5)
# 2) 点在审 0.9.22 的详情（第二个，y 在 400-700 区间）
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('span');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='详情' && vis(els[i])){
      var rect=els[i].getBoundingClientRect();
      if (rect.top >= 400 && rect.top < 700){els[i].click(); return 'opened@'+Math.round(rect.top);}
    }
  }
  return 'not-found';
})()
""")
print(r)
time.sleep(6)
d = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  var out=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button, a, .btn'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,16));}}
    if (txt) out.push({head:txt.slice(0,220), btns:bl});
  }
  return JSON.stringify(out.slice(0,4));
})()
""")
print(d[:1000])
