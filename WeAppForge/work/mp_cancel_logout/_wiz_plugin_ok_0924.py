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
gt = find_tab('getcodepage') or find_tab('wasysnotify')
r = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'');
    if (txt.indexOf('插件')>=0){
      var btns=mods[i].querySelectorAll('button');
      for (var b=0;b<btns.length;b++){
        if ((btns[b].innerText||'').trim()==='确认' && vis(btns[b])){btns[b].click(); return 'plugin-confirm';}
      }
    }
  }
  return 'not-found';
})()
""")
print('plugin:', r)
# 后续弹窗接力（安全测试→继续提交；或表单tab开）
for tick in range(240):
    time.sleep(1)
    try:
        s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t);}}
    if (txt) return JSON.stringify({h:txt.slice(0,70), bl:bl});
  }
  return '';
})()
""")
    except Exception:
        s = ''
    ft = find_tab('get_class')
    if ft and tick > 3:
        print(f'FORM TAB UP @{tick}s'); break
    if s:
        if '继续提交' in s and 'bl' in s:
            gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='继续提交' && vis(btns[b])){btns[b].click(); return 'cont';}
    }
  }
  return 'no';
})()
""")
            print(f'[{tick}s] 继续提交 clicked'); continue
        if tick % 20 == 0:
            print(f'[{tick}s] dlg:', s[:120])
