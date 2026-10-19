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
  var els=document.querySelectorAll('a.btn_primary, a.btn');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submit-clicked';}
  }
  return 'not-found';
})()
""")
print('click:', r)
# 连续监听弹窗 15s，见「前往确认」即点
for tick in range(15):
    time.sleep(1)
    s = form_tab.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button, a, .btn');
    var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,18));}}
    if (txt) return JSON.stringify({head:txt.slice(0,200), btns:bl});
  }
  return '';
})()
""")
    if s:
        print(f'[{tick}s] dlg:', s[:400])
        if '前往确认' in s:
            form_tab.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='前往确认' && vis(btns[b])){btns[b].click(); return 'clicked-go';}
    }
  }
  return 'no';
})()
""")
            print('[go-confirm clicked]')
            break
        if '确定，继续提交' in s:
            print('FINAL-CONFIRM-UP')  # 终确认框出现，暂不动
            break
print('url:', (form_tab.url or '')[:120])
