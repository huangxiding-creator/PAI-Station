# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
# 找当前激活 tab（get_class 表单页）
r = page.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var btns=document.querySelectorAll('button');
  var out=[];
  for (var b=0;b<btns.length;b++){
    if (!vis(btns[b])) continue;
    var t=(btns[b].innerText||'').trim();
    if (t) out.push({t:t.slice(0,20), cls:(btns[b].className||'').slice(0,60), disabled:btns[b].disabled});
  }
  return JSON.stringify(out.slice(-10));
})()
""")
print('tail buttons:', r[:800])
