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
ft = find_tab('get_class')
ft.listen.start('wxamp')
r = ft.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'clicked';}
  }
  return 'not-found';
})()
""")
print('submit:', r)
time.sleep(1.5)
c = ft.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='确定，继续提交' && vis(btns[b])){btns[b].click(); return 'confirmed';}
    }
  }
  return 'no-confirm';
})()
""")
print('confirm:', c)
time.sleep(6)
n = 0
for pkt in ft.listen.steps(timeout=2):
    n += 1
    try:
        url = pkt.url or ''
        body = (pkt.response.body if pkt.response else '') or ''
        print('NET:', url[:120], '=>', str(body)[:220])
    except Exception as e:
        print('NET err', e)
    if n > 12: break
ft.listen.stop()
print('packets:', n)
