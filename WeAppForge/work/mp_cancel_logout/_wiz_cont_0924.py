# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
r = page.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='继续提交' && vis(btns[b])){btns[b].click(); return 'cont-clicked';}
    }
  }
  return 'not-found';
})()
""")
print('r:', r)
time.sleep(3)
out = page.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  var vd=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,20));}}
    vd.push({head:(mods[i].innerText||'').replace(/\s+/g,' ').slice(0,160), btns:bl});
  }
  var tas=document.querySelectorAll('textarea'); var tavis=[];
  for (var j=0;j<tas.length;j++){if(vis(tas[j])) tavis.push({ph:tas[j].placeholder||'', len:(tas[j].value||'').length, maxlen:tas[j].maxLength||-1});}
  var rs=document.querySelectorAll('input[type=radio]'); var rvis=[];
  for (var k=0;k<rs.length;k++){if(vis(rs[k])) rvis.push({name:rs[k].name, val:rs[k].value, checked:rs[k].checked});}
  return JSON.stringify({visible_dialogs:vd, textareas:tavis, radios:rvis.slice(0,12)});
})()
""")
print('state:', out[:1500])
