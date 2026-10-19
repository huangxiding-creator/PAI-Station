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

# 1) 版本页真值
gt = find_tab('getcodepage')
if gt:
    gt.run_js("location.reload()"); time.sleep(7)
gt = find_tab('getcodepage')  # 重载后重取
blocks = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,110));
  return JSON.stringify(out);
})()
""")
print('TRUTH:', blocks[:700])

# 2) 表单 tab 状态（描述/单选是否还在）
ft = find_tab('get_class')
if ft:
    v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea');
  var rs=document.querySelectorAll('input[type=radio]'); var rl=[];
  for (var k=0;k<rs.length;k++){if(!vis(rs[k]))continue; var lbl=rs[k].closest('label')||rs[k].parentElement;
    rl.push({txt:(lbl.innerText||'').trim().slice(0,10),ck:rs[k].checked});}
  return JSON.stringify({alive:!!ta&&vis(ta), desc: ta?(ta.value||'').length:-1, radios:rl});
})()
""")
    print('FORM:', v[:400])
