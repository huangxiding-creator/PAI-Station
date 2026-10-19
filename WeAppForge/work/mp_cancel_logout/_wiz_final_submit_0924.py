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
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
# 1) 选 未采集用户隐私（用户令 1019）
r1 = form_tab.run_js("return (function(){" + VIS + """
  var rs=document.querySelectorAll('input[type=radio]');
  for (var k=0;k<rs.length;k++){
    if (!vis(rs[k])) continue;
    if ((rs[k].value||'')==='1'){
      var lbl=rs[k].closest('label') || rs[k].parentElement;
      if ((lbl.innerText||'').indexOf('未采集用户隐私')>=0){lbl.click(); return 'clicked-no-collect';}
    }
  }
  return 'not-found';
})()
""")
print('flip:', r1)
time.sleep(1)
# 2) 终核
v = form_tab.run_js("return (function(){" + VIS + """
  var rs=document.querySelectorAll('input[type=radio]'); var out=[];
  for (var k=0;k<rs.length;k++){ if(!vis(rs[k])) continue;
    var lbl=rs[k].closest('label')||rs[k].parentElement;
    if((lbl.innerText||'').indexOf('采集')>=0) out.push({txt:(lbl.innerText||'').trim().slice(0,10),ck:rs[k].checked});}
  var ta=document.querySelector('textarea');
  return JSON.stringify({privacy:out, desc_len: ta&&vis(ta)?(ta.value||'').length:-1});
})()
""")
print('verify:', v[:300])
# 3) 点提交审核
r2 = form_tab.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submit-clicked';}
  }
  return 'not-found';
})()
""")
print('submit:', r2)
# 4) 接住「确定，继续提交」终确认
for tick in range(12):
    time.sleep(1)
    s = form_tab.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt) return txt.slice(0,200);
  }
  return '';
})()
""")
    if s:
        print(f'[{tick}s] dlg:', s[:200])
        if '确定，继续提交' in s:
            form_tab.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='确定，继续提交' && vis(btns[b])){btns[b].click(); return 'final-confirmed';}
    }
  }
  return 'no';
})()
""")
            print('FINAL-CONFIRMED')
            break
        break
time.sleep(4)
print('url:', (form_tab.url or '')[:120])
