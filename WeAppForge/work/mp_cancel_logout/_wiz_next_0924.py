# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
r1 = page.run_js(r"""
return (function(){
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    var m=mods[i];
    var t=(m.innerText||'');
    if (t.indexOf('提交审核的相关须知')>=0){
      var btns=m.querySelectorAll('button');
      for (var b=0;b<btns.length;b++){
        if ((btns[b].innerText||'').trim()==='下一步'){btns[b].click(); return 'next-clicked';}
      }
      // 兜底：checkbox 先勾
      var cb=m.querySelector('input[type=checkbox]');
      if (cb && !cb.checked){cb.click();}
    }
  }
  return 'not-found';
})()
""")
print('r1:', r1)
time.sleep(2.5)
r2 = page.run_js(r"""
return (function(){
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  var out=[];
  for (var i=0;i<mods.length;i++){
    var m=mods[i]; var t=(m.innerText||'').replace(/\s+/g,' ');
    if (!t) continue;
    var btns=m.querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){var x=(btns[b].innerText||'').trim(); if(x) bl.push(x.slice(0,20));}
    out.push(t.slice(0,100)+' ||BTN:'+bl.join(','));
  }
  return JSON.stringify(out.slice(0,8));
})()
""")
print('after:', r2[:1000])
