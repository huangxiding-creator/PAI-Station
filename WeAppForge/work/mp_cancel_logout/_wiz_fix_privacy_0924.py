# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
r = page.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var rs=document.querySelectorAll('input[type=radio]');
  for (var k=0;k<rs.length;k++){
    if (!vis(rs[k])) continue;
    if ((rs[k].value||'')==='0' && rs[k].checked){
      var lbl=rs[k].closest('label, .weui-desktop-form-radio, weui-desktop-form-radio');
      var t=((lbl&&lbl.innerText)||(rs[k].parentElement.innerText)||'').trim();
      if (t.indexOf('采集用户隐私')>=0) return 'already-collect';
    }
  }
  for (var k2=0;k2<rs.length;k2++){
    if (!vis(rs[k2])) continue;
    if ((rs[k2].value||'')==='0'){
      var lbl2=rs[k2].closest('label, .weui-desktop-form-radio, weui-desktop-form-radio');
      var t2=((lbl2&&lbl2.innerText)||(rs[k2].parentElement.innerText)||'').trim();
      if (t2.indexOf('采集用户隐私')>=0){rs[k2].click(); return 'flipped-to-collect';}
    }
  }
  return 'not-found';
})()
""")
print('privacy:', r)
time.sleep(1)
v = page.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var rs=document.querySelectorAll('input[type=radio]'); var out=[];
  for (var k=0;k<rs.length;k++){if(vis(rs[k])) out.push({txt:((rs[k].parentElement.innerText)||'').trim().slice(0,12), checked:rs[k].checked});}
  var tas=document.querySelectorAll('textarea'); var tl=null;
  for (var j=0;j<tas.length;j++){if(vis(tas[j])) tl={len:(tas[j].value||'').length, head:(tas[j].value||'').slice(0,30)};}
  return JSON.stringify({radios:out, desc:tl});
})()
""")
print('final:', v[:600])
