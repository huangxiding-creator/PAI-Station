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
# 1) 提交
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
# 2) 终确认
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
# 3) 高频捕获 10s（toast/对话框/错误容器）
seen = set()
for tick in range(33):
    time.sleep(0.3)
    try:
        s = ft.run_js("return (function(){" + VIS + """
  var out=[];
  var sel='.weui-desktop-toast, .weui-toast, .weui-desktop-dialog, .weui-desktop-modal, .weui-desktop-msg, .error, .weui-desktop-alert';
  var mods=document.querySelectorAll(sel);
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ').trim();
    if (txt) out.push(txt.slice(0,140));
  }
  var body=(document.body.innerText||'');
  var m=body.match(/(errcode|ret|失败|错误|不能|无法|已被|占用)[^\n]{0,80}/i);
  return JSON.stringify({pop:out, body_err: m?m[0]:''});
})()
""")
    except Exception:
        continue
    if s and s not in seen:
        seen.add(s)
        print(f'[{tick*0.3:.1f}s]', s[:300])
