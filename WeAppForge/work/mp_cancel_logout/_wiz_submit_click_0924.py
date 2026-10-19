# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
form_tab = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'get_class' in (t.url or ''):
        form_tab = t; break
r = form_tab.run_js(r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){
      var target=els[i];
      // 优先找到可点层（自身或最近的 btn 类祖先）
      var clicker=target.closest('button, .weui-desktop-btn, .weui-desktop-btn_default, [role=button]') || target;
      clicker.click();
      return 'clicked:'+(clicker.tagName)+'.'+(clicker.className||'').toString().slice(0,40);
    }
  }
  return 'not-found';
})()
""")
print('click:', r)
time.sleep(3)
# 点后状态：可见弹窗
s = form_tab.run_js(r"""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  var vd=[];
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    vd.push((mods[i].innerText||'').replace(/\s+/g,' ').slice(0,180));
  }
  return JSON.stringify(vd);
})()
""")
print('after dialogs:', s[:800])
