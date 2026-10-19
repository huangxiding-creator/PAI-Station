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
DESC = "工程行业AI问答工具。本次更新：研究报告详情页免费体验升级——免费问报告每日6问、免费试读入口前置、解锁后无限问；问答答案引用报告章节原文。所有AI生成内容均有显著标识（含导出海报），接内容安全检测并提供举报入口。仅收集微信openid与提问内容，无需测试账号。"

gt = find_tab('getcodepage')
# 1) 0.9.24 行提交审核
r = gt.run_js("return (function(){" + VIS + """
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
print('1 row-click:', r)

# 2) 须知：勾选+下一步（最长等 15s）
for tick in range(15):
    time.sleep(1)
    s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'');
    if (txt.indexOf('相关须知')>=0){
      var cb=mods[i].querySelector('input[type=checkbox]');
      if (cb && !cb.checked) cb.click();
      var btns=mods[i].querySelectorAll('button');
      for (var b=0;b<btns.length;b++){
        if ((btns[b].innerText||'').trim()==='下一步' && vis(btns[b])){btns[b].click(); return 'notice-next';}
      }
    }
  }
  return '';
})()
""")
    if s:
        print(f'2 notice: {s} @{tick}s'); break

# 3) 安全测试提醒 → 继续提交（最长等 3min：接口扫描）
done3 = False
for tick in range(180):
    time.sleep(1)
    try:
        s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t);}}
    if (txt) return JSON.stringify({h:txt.slice(0,60), bl:bl});
  }
  return '';
})()
""")
    except Exception:
        # getcodepage 跳走了 → 表单 tab 开了
        ft = find_tab('get_class')
        if ft:
            print(f'3 form tab appeared @{tick}s'); done3 = True; break
        continue
    if s and '继续提交' in s:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='继续提交' && vis(btns[b])){btns[b].click(); return 'cont';}
    }
  }
  return 'no';
})()
""")
        print(f'3 安全测试-继续提交 clicked @{tick}s'); done3 = True; break
    if s and tick % 30 == 0:
        print(f'3 [{tick}s] dlg:', s[:100])
print('stage3 done:', done3)

# 4) 表单：等开+核验/补填
ft = find_tab('get_class')
if not ft:
    for i in range(30):
        time.sleep(1)
        ft = find_tab('get_class')
        if ft: break
time.sleep(5)
v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea');
  var rs=document.querySelectorAll('input[type=radio]'); var rl=[];
  for (var k=0;k<rs.length;k++){if(!vis(rs[k]))continue; var lbl=rs[k].closest('label')||rs[k].parentElement;
    if((lbl.innerText||'').indexOf('采集')>=0||(lbl.innerText||'').indexOf('登录')>=0||(lbl.innerText||'').trim()==='否'||(lbl.innerText||'').trim()==='是')
      rl.push({txt:(lbl.innerText||'').trim().slice(0,10),ck:rs[k].checked});}
  return JSON.stringify({alive:!!ta&&vis(ta), desc: ta?(ta.value||'').length:-1, radios:rl});
})()
""")
print('4 form:', v[:400])
