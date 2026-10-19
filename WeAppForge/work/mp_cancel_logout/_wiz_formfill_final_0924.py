# -*- coding: utf-8 -*-
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
ft = find_tab('get_class')
DESC = "工程行业AI问答工具。本次更新：研究报告详情页免费体验升级——免费问报告每日6问、免费试读入口前置、解锁后无限问；问答答案引用报告章节原文。所有AI生成内容均有显著标识（含导出海报），接内容安全检测并提供举报入口。仅收集微信openid与提问内容，无需测试账号。"
JS_FILL = """
return (function(){
  var DESC = %s;
  var ta=document.querySelector('textarea');
  if (!ta) return 'no-textarea';
  if ((ta.value||'') !== DESC) {
    ta.value = DESC;
    ta.dispatchEvent(new Event('input', {bubbles: true}));
  }
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var rs=document.querySelectorAll('input[type=radio]');
  function pick(word){
    for (var k=0;k<rs.length;k++){
      if (!vis(rs[k])) continue;
      var lbl=rs[k].closest('label')||rs[k].parentElement;
      if (((lbl.innerText)||'').indexOf(word)>=0 && !rs[k].checked){lbl.click(); return word;}
    }
    return '';
  }
  var a=pick('无需登录账号即可使用');
  var b=pick('未采集用户隐私');
  var rl=[];
  for (var k2=0;k2<rs.length;k2++){
    if (!vis(rs[k2])) continue;
    var lbl2=rs[k2].closest('label')||rs[k2].parentElement;
    var t2=(lbl2.innerText||'').trim();
    if (['否','是'].indexOf(t2)>=0 || t2.indexOf('采集')>=0 || t2.indexOf('登录')>=0)
      rl.push(t2.slice(0,12)+':'+rs[k2].checked);
  }
  return JSON.stringify({desc:(ta.value||'').length, picked:[a,b], radios:rl});
})()
""" % json.dumps(DESC, ensure_ascii=False)
print('form set:', ft.run_js(JS_FILL)[:400])
JS_SUBMIT = """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submitted';}
  }
  return 'not-found';
})()
"""
print('submit:', ft.run_js(JS_SUBMIT))
JS_CONFIRM = """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var btns=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<btns.length;b++){
      if ((btns[b].innerText||'').trim()==='确定，继续提交' && vis(btns[b])){btns[b].click(); return 'FINAL-CONFIRMED';}
    }
  }
  return '';
})()
"""
for tick in range(30):
    time.sleep(1)
    c = ft.run_js(JS_CONFIRM)
    if c:
        print(f'[{tick}s]', c); break
time.sleep(6)
gt = find_tab('getcodepage')
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab('getcodepage')
blocks = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,120));
  return JSON.stringify(out);
})()
""")
print('TRUTH:', blocks[:800])
