# -*- coding: utf-8 -*-
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch(); time.sleep(1)

def run(js):
    return page.run_js(js)

# 1) 点 0.9.24 行的提交审核
js_click_submit = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='0.9.24'){
      var row=els[i];
      for (var d=0;d<8 && row;d++){
        var t=row.innerText||'';
        if (t.indexOf('提交审核')>=0){
          var btn=row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn){btn.click(); return 'clicked:'+ (btn.innerText||'').trim();}
        }
        row=row.parentElement;
      }
    }
  }
  return 'no-btn';
})()
"""
print('submit:', run(js_click_submit))
time.sleep(2.5)

# 2) dump 可见弹窗
def dump_visible():
    return run(r"""
return (function(){
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, [role=dialog], .weui-desktop-dialog__wrp');
  var out=[];
  for (var i=0;i<mods.length;i++){
    var m=mods[i];
    var st=getComputedStyle(m); var pp=m.offsetParent;
    if (!pp && st.display==='none') continue;
    var btns=m.querySelectorAll('button, .weui-desktop-btn');
    var bl=[];
    for (var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t.slice(0,24));}
    if (bl.length||((m.innerText||'').trim())) out.push({head:(m.innerText||'').replace(/\s+/g,' ').slice(0,90), btns:bl});
  }
  return JSON.stringify(out.slice(0,6));
})()
""")
print('dialogs:', dump_visible()[:900])
