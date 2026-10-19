# -*- coding: utf-8 -*-
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)
js = r"""
return (function(){
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [role=dialog]');
  var out=[];
  for (var i=0;i<mods.length;i++){
    var m=mods[i];
    if (!m.offsetParent && m.style.display!=='flex') continue;   // 可见性粗筛
    var btns=m.querySelectorAll('button, .weui-desktop-btn');
    var bl=[];
    for (var b=0;b<btns.length;b++){
      var t=(btns[b].innerText||'').trim();
      if (t) bl.push(t.slice(0,20));
    }
    out.push({head:(m.innerText||'').replace(/\s+/g,' ').slice(0,80), btns:bl});
  }
  return JSON.stringify(out);
})()
"""
print("VISIBLE:", page.run_js(js)[:800])
