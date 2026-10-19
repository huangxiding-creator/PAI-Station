# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        r = t.run_js(r"""
return (function(){
  var tas=document.querySelectorAll('textarea'); var tl=[];
  for (var j=0;j<tas.length;j++){tl.push({ph:tas[j].placeholder||'', len:(tas[j].value||'').length, vis:!!tas[j].offsetParent});}
  var anyBtn=document.querySelectorAll('button, .weui-desktop-btn, a.weui-desktop-btn');
  var bl=[];
  for (var b=0;b<anyBtn.length;b++){var x=(anyBtn[b].innerText||'').trim(); if(x) bl.push(x.slice(0,18)+'|vis:'+!!anyBtn[b].offsetParent);}
  var rs=document.querySelectorAll('input[type=radio]'); var rl=[];
  for (var k=0;k<rs.length;k++){rl.push(rs[k].value+':'+rs[k].checked);}
  return JSON.stringify({title:document.title, n_ta:tl.length, ta:tl.slice(0,3), radios:rl.slice(0,6), btns:bl.slice(-12), body_tail:(document.body.innerText||'').replace(/\s+/g,' ').slice(-350)});
})()
""")
        print(r[:1400])
        break
