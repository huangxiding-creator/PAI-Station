# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
ft = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        ft = t; break
print('url:', (ft.url or '')[:100])
for tick in range(20):
    time.sleep(1)
    s = ft.run_js("return (function(){" + VIS + """
  var out=[];
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal, .weui-desktop-toast, .weui-toast');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt) out.push(txt.slice(0,120));
  }
  var body=(document.body.innerText||'').replace(/\s+/g,' ');
  var i2=body.indexOf('提交审核');
  return JSON.stringify({pop:out, form_gone: i2<0 || body.indexOf('你正在提交开发版')<0, head:body.slice(0,80)});
})()
""")
    if tick in (0,3,8,14,19):
        print(f'[{tick}s]', s[:350])
