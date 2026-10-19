# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""
def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ''):
            return t
def dlg_click(tab, want):
    return tab.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'');
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      var t=(btns[b].innerText||'').trim();
      if (t===\"""" + want + """\" && vis(btns[b])){btns[b].click(); return 'clicked:'+t;}
    }
  }
  return '';
})()
""")

gt = find_tab('getcodepage')
# 起：0.9.24 行提交审核
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='0.9.24'){
      var row=els[i];
      for (var d=0;d<8 && row;d++){
        if ((row.innerText||'').indexOf('提交审核')>=0){
          var btn=row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn && vis(btn)){btn.click(); return 'row-clicked';}
        }
        row=row.parentElement;
      }
    }
  }
  return 'no-btn';
})()
""")
print('start:', r)

# 弹窗路由（最长 6 分钟）
stage = 'dialogs'
for tick in range(360):
    time.sleep(1)
    ft = find_tab('get_class')
    if ft and tick > 5:
        v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea');
  return ta && vis(ta) ? (ta.value||'').length : -1;
})()
""")
        if v is not None and int(v) >= 0:
            print(f'FORM OPEN @{tick}s desc_len={v}')
            stage = 'form'
            break
    try:
        s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t);}}
    if (txt) return txt.slice(0,60)+'||BTN:'+bl.join(',');
  }
  return '';
})()
""")
    except Exception:
        s = ''
    if not s: continue
    head, _, btns = s.partition('||BTN:')
    if '相关须知' in head:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    if ((mods[i].innerText||'').indexOf('相关须知')<0) continue;
    var cb=mods[i].querySelector('input[type=checkbox]');
    if (cb && !cb.checked) cb.click();
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='下一步' && vis(btns[b])){btns[b].click(); return 1;}
    }
  }
  return 0;
})()
""")
        print(f'[{tick}s] 须知→下一步')
    elif '插件' in head and '确认' in btns:
        print(f'[{tick}s] 插件→确认:', dlg_click(gt, '确认'))
    elif '安全测试' in head or '继续提交' in btns:
        print(f'[{tick}s] 安全→继续提交:', dlg_click(gt, '继续提交'))
    elif '隐私' in head and '前往确认' in btns:
        print(f'[{tick}s] 隐私→暂不确认:', dlg_click(gt, '暂不确认'))
    elif tick % 45 == 0 and head:
        print(f'[{tick}s] dlg:', s[:150])
print('stage:', stage)
