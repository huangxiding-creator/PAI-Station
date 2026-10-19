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
# 点击通知列表第一条（2026-10-18 最新）
r = gt.run_js("return (function(){" + VIS + """
  var items=document.querySelectorAll('li, .notice-item, [class*=notice] li, [class*=message] li');
  var clicked=0;
  for (var i=0;i<items.length && clicked<1;i++){
    var t=(items[i].innerText||'');
    if (t.indexOf('代码发布审核结果')>=0 && t.indexOf('2026-10-18')>=0 && vis(items[i])){
      items[i].click(); clicked++; return 'opened-first';
    }
  }
  // 兜底：任意可见的 2026-10-18 审核结果节点
  var els=document.querySelectorAll('*');
  for (var j=0;j<els.length;j++){
    var t2=(els[j].childNodes.length&&els[j].innerText||'');
    if (els[j].children.length===0 && (els[j].innerText||'').trim().indexOf('代码发布审核结果')>=0 && vis(els[j])){
      els[j].click(); return 'opened-leaf';
    }
  }
  return 'not-found';
})()
""")
print(r)
time.sleep(4)
d = gt.run_js("return (function(){" + VIS + """
  var out=[];
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [class*=notice], [class*=detail]');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt && txt.length>40 && txt.indexOf('审核')>=0) out.push(txt.slice(0,400));
  }
  return JSON.stringify(out.slice(0,3));
})()
""")
print(d[:1400])
