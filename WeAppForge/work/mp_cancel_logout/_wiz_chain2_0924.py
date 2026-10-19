# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
gt = None
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if 'getcodepage' in (t.url or ''):
        gt = t; break
# 须知弹窗现在应该开着：勾选+下一步
r = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'');
    if (txt.indexOf('相关须知')<0) continue;
    var cb=mods[i].querySelector('input[type=checkbox]');
    if (cb && !cb.checked) cb.click();
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='下一步' && vis(btns[b])){btns[b].click(); return 'next-clicked';}
    }
    return 'dlg-but-no-next:'+txt.slice(0,60);
  }
  return 'no-notice-dlg';
})()
""")
print('notice:', r)
time.sleep(3)
# 安全测试提醒 → 继续提交
for tick in range(90):
    time.sleep(1)
    s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    if (txt) return txt.slice(0,80);
  }
  return '';
})()
""")
    if s and tick % 10 == 0:
        print(f'[{tick}s] gp-dlg:', s[:80])
    if '继续提交' in s:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='继续提交' && vis(btns[b])){btns[b].click(); return 'cont-clicked';}
    }
  }
  return 'no';
})()
""")
        print('  -> 继续提交 clicked'); break
