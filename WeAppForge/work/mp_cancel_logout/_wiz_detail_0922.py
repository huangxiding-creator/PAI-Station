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
  var els=document.querySelectorAll('span');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='详情' && vis(els[i])){
      var rect=els[i].getBoundingClientRect();
      if (rect.top < 400){  // 在审块（页面最上）
        els[i].click(); return 'detail-opened@'+Math.round(rect.top);
      }
    }
  }
  return 'not-found';
})()
""")
print(r)
time.sleep(3)
d = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('span, a, button');
  var out=[];
  for (var i=0;i<els.length;i++){
    var t=ownText(els[i]);
    if (t && t.length<=10 && vis(els[i]) && /撤|放弃|取消/.test(t)) out.push({t:t,tag:els[i].tagName});
  }
  var drawer=(document.body.innerText||'').replace(/\s+/g,' ');
  var i2=drawer.indexOf('审核中');
  return JSON.stringify({withdraw_acts:out, ctx:i2>=0?drawer.slice(Math.max(0,i2-50),i2+250):''});
})()
""")
print(d[:600])
