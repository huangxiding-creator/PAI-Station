# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
out = page.run_js(r"""
return (function(){
  function vis(el){
    var e=el;
    while (e && e!==document.body){
      var st=getComputedStyle(e);
      if (st.display==='none'||st.visibility==='hidden'||parseFloat(st.opacity||'1')===0) return false;
      e=e.parentElement;
    }
    return !!(el.offsetParent || el.getBoundingClientRect().height>0);
  }
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [role=dialog]');
  var vd=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,20));}}
    vd.push({head:(mods[i].innerText||'').replace(/\s+/g,' ').slice(0,110), btns:bl});
  }
  var tas=document.querySelectorAll('textarea'); var tavis=[];
  for (var j=0;j<tas.length;j++){if(vis(tas[j])) tavis.push({ph:tas[j].placeholder||'', len:(tas[j].value||'').length});}
  var rs=document.querySelectorAll('input[type=radio]'); var rvis=0;
  for (var k=0;k<rs.length;k++){if(vis(rs[k])) rvis++;}
  return JSON.stringify({visible_dialogs:vd, textareas:tavis, visible_radios:rvis});
})()
""")
print(out[:1200])
