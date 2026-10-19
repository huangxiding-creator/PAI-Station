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
        for t in [page.browser.get_tab(tid)]:
            if kw in (t.url or ''):
                return t
ft = find_tab('get_class')
# 1) 点提交审核 → 监听弹窗序列，逐个接
r = ft.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submit-clicked';}
  }
  return 'not-found';
})()
""")
print('submit:', r)
handled = []
for tick in range(40):
    time.sleep(1)
    try:
        s = ft.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button, a, .btn'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,18));}}
    if (txt) return JSON.stringify({head:txt.slice(0,160), btns:bl});
  }
  return '';
})()
""")
    except Exception:
        # 页面可能跳转（前往确认会开新页面）
        print(f'[{tick}s] tab url:', (ft.url or '')[:110])
        break
    if s and s not in handled:
        handled.append(s)
        print(f'[{tick}s] dlg:', s[:260])
        if '前往确认' in s:
            ft.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='前往确认' && vis(btns[b])){btns[b].click(); return 'go';}
    }
  }
  return 'no';
})()
""")
            print('  -> 前往确认 clicked（等指引页加载）')
            time.sleep(6)
            print('  url now:', (ft.url or '')[:120])
            break
        if '确定，继续提交' in s:
            # 这次先不点确定——先看隐私弹窗是否先出现
            print('  (final-confirm up, waiting privacy first)')
