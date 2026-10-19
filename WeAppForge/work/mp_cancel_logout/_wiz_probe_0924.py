# -*- coding: utf-8 -*-
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
time.sleep(2)
js = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var out = {dialogs: [], checkbox: null, body_head: (document.body.innerText||'').slice(0,400)};
  var m = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [role=dialog]');
  for (var i=0;i<m.length;i++){
    var t=(m[i].innerText||'').replace(/\s+/g,' ').slice(0,200);
    if (t) out.dialogs.push(t);
    var cb=m[i].querySelector('input[type=checkbox]');
    if (cb) out.checkbox={checked:cb.checked, visible: !!m[i].offsetParent};
  }
  var btns=document.querySelectorAll('button');
  out.btn_sample=[];
  for (var b=0;b<btns.length && out.btn_sample.length<12;b++){
    var t2=(btns[b].innerText||'').trim();
    if (t2 && btns[b].offsetParent) out.btn_sample.push(t2.slice(0,16));
  }
  return JSON.stringify(out);
})()
"""
print(page.run_js(js)[:1200])
