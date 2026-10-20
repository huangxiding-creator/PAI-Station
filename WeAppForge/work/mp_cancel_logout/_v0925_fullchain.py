# -*- coding: utf-8 -*-
# wx5cee 0.9.25 提审全链（行点击→弹窗路由→表单→终确认→落账验证）
import sys, time, json
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
DESC = '工程行业AI问答工具。本次更新：页面语言全面升级——研究页以「问报告」为主角，一键直达提问；全部页面文案更凝练友好。所有AI生成内容均有显著标识（含导出海报），接内容安全检测并提供举报入口。仅收集微信openid与提问内容，无需测试账号。'
gt = find_tab('getcodepage')
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='0.9.25'){
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
print('1 row:', r)
stage = 'dialogs'
for tick in range(300):
    time.sleep(1)
    ft = find_tab('get_class')
    if ft and tick > 5:
        v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea'); return ta && vis(ta) ? 'form-open' : '';})()
""")
        if v:
            print('2 FORM @%ds' % tick); stage = 'form'; break
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
    if not s:
        continue
    head, _, btns = s.partition('||BTN:')
    if '相关须知' in head:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i]) || (mods[i].innerText||'').indexOf('相关须知')<0) continue;
    var cb=mods[i].querySelector('input[type=checkbox]'); if (cb && !cb.checked) cb.click();
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='下一步' && vis(bs[b])){bs[b].click(); return 1;} }
  }
  return 0;})()
""")
        print('[%ds] 须知→下一步' % tick)
    elif '插件' in head and '确认' in btns:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='确认' && vis(bs[b])){bs[b].click(); return 'ok';} } }
  return 'no';})()
""")
        print('[%ds] 插件→确认' % tick)
    elif '继续提交' in btns:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='继续提交' && vis(bs[b])){bs[b].click(); return 'ok';} } }
  return 'no';})()
""")
        print('[%ds] 继续提交' % tick)
print('stage:', stage)
if stage != 'form':
    sys.exit(1)
JS_FILL = """
return (function(){
  var DESC = %s;
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var ta=document.querySelector('textarea');
  if (!ta) return 'no-textarea';
  if ((ta.value||'') !== DESC) { ta.value = DESC; ta.dispatchEvent(new Event('input',{bubbles:true})); }
  var rs=document.querySelectorAll('input[type=radio]');
  function pick(w){ for (var k=0;k<rs.length;k++){ if (!vis(rs[k])) continue;
    var lbl=rs[k].closest('label')||rs[k].parentElement;
    if (((lbl.innerText)||'').indexOf(w)>=0 && !rs[k].checked){lbl.click(); return w;} } return ''; }
  pick('无需登录账号即可使用');
  return JSON.stringify({desc:(ta.value||'').length});
})()
""" % json.dumps(DESC, ensure_ascii=False)
ft = find_tab('get_class')
print('3 form:', ft.run_js(JS_FILL)[:120])
r2 = ft.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){ if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submitted';} }
  return 'not-found';
})()
""")
print('4 submit:', r2)
for tick in range(30):
    time.sleep(1)
    c = ft.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='确定，继续提交' && vis(bs[b])){bs[b].click(); return 'FINAL';} } }
  return '';})()
""")
    if c:
        print('5 [%ds] %s' % (tick, c)); break
time.sleep(6)
gt = find_tab('getcodepage')
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab('getcodepage')
print('6 TRUTH:', gt.run_js("""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,110));
  return JSON.stringify(out.slice(0,3));
})()
""")[:600])
