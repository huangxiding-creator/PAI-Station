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

def vis_js():
    return """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""

# 1) 取消当前确认框
r1 = form_tab.run_js("return (function(){" + vis_js() + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='取消' && vis(btns[b])){btns[b].click(); return 'cancelled';}
    }
  }
  return 'no-dlg';
})()
""")
print('cancel:', r1)
time.sleep(2)

# 2) 重新点选 采集用户隐私（点 label 文本所在可点层）
r2 = form_tab.run_js("return (function(){" + vis_js() + """
  var rs=document.querySelectorAll('input[type=radio]');
  for (var k=0;k<rs.length;k++){
    if (!vis(rs[k])) continue;
    if ((rs[k].value||'')==='0'){
      var lbl=rs[k].closest('label') || rs[k].parentElement;
      var t=(lbl.innerText||lbl.textContent||'').trim();
      if (t.indexOf('采集用户隐私')>=0){
        lbl.click(); return 'clicked-collect:'+rs[k].checked;
      }
    }
  }
  return 'not-found';
})()
""")
print('flip:', r2)
time.sleep(1.5)

# 3) 核验三组单选 + 描述仍在
v = form_tab.run_js("return (function(){" + vis_js() + """
  var rs=document.querySelectorAll('input[type=radio]'); var out=[];
  for (var k=0;k<rs.length;k++){
    if (!vis(rs[k])) continue;
    var lbl=rs[k].closest('label') || rs[k].parentElement;
    out.push({txt:(lbl.innerText||'').trim().slice(0,12), v:rs[k].value, ck:rs[k].checked});
  }
  var ta=document.querySelector('textarea'); 
  return JSON.stringify({radios:out, desc_len: ta && vis(ta) ? (ta.value||'').length : -1});
})()
""")
print('verify:', v[:500])
