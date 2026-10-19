# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
# 表单 tab 现状
ft = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        ft = t; break
if ft:
    v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea');
  var rs=document.querySelectorAll('input[type=radio]'); var rl=[];
  for (var k=0;k<rs.length;k++){if(!vis(rs[k]))continue; var lbl=rs[k].closest('label')||rs[k].parentElement;
    if((lbl.innerText||'').indexOf('采集')>=0) rl.push({txt:(lbl.innerText||'').trim().slice(0,10),ck:rs[k].checked});}
  return JSON.stringify({form_alive: !!ta && vis(ta), desc_len: ta?(ta.value||'').length:-1, privacy: rl,
    head:(document.body.innerText||'').replace(/\s+/g,' ').slice(0,120)});
})()
""")
    print('form tab:', v[:500])
else:
    print('no form tab')
# getcodepage 可见弹窗
gt = [t for tid in page.browser.tab_ids for t in [page.browser.get_tab(tid)] if 'getcodepage' in (t.url or '')]
if gt:
    d = gt[0].run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    return (mods[i].innerText||'').replace(/\s+/g,' ').slice(0,150);
  }
  return '';
})()
""")
    print('gp visible dlg:', d[:200])
