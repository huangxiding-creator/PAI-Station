# -*- coding: utf-8 -*-
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
# getcodepage tab：点 0.9.24 的提交审核
gt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'getcodepage' in (t.url or ''):
        gt = t; break
r0 = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='0.9.24'){
      var row=els[i];
      for (var d=0;d<8 && row;d++){
        var t=row.innerText||'';
        if (t.indexOf('提交审核')>=0){
          var btn=row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn && vis(btn)){btn.click(); return 'row-submit-clicked';}
        }
        row=row.parentElement;
      }
    }
  }
  return 'no-btn';
})()
""")
print('row click:', r0)
# 监听 getcodepage 侧弹窗（须知）
for tick in range(15):
    time.sleep(1)
    s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt) return txt.slice(0,120);
  }
  return '';
})()
""")
    if s:
        print(f'[{tick}s] gp-dlg:', s[:120])
        if '相关须知' in s:
            # 勾选+下一步
            gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'');
    if (txt.indexOf('相关须知')<0) continue;
    var cb=mods[i].querySelector('input[type=checkbox]');
    if (cb && !cb.checked) cb.click();
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='下一步' && vis(btns[b])){btns[b].click(); return 'next';}
    }
  }
  return 'no';
})()
""")
            print('  -> next clicked')
        break
