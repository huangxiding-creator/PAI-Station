# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
# wasysnotify tab 占了原 getcodepage——先开回版本管理页
tabs = [page.browser.get_tab(tid) for tid in page.browser.tab_ids]
gt = None
for t in tabs:
    if 'getcodepage' in (t.url or ''):
        gt = t; break
if not gt:
    # 用 form tab 导航到版本管理
    for t in tabs:
        if 'get_class' in (t.url or ''):
            t.run_js("window.open('https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=1727388897&lang=zh_CN','_self')")
            time.sleep(6)
            gt = t; break
r = gt.run_js(r"""
return (function(){
  // 在审块：找含「审核中」的版本块，dump 其内部全部子孙的文本与类名（含 hover 藏匿）
  var blocks=document.querySelectorAll('.code_version_log');
  for (var i=0;i<blocks.length;i++){
    var t=(blocks[i].innerText||'');
    if (t.indexOf('0.9.22')>=0 && t.indexOf('审核中')>=0){
      var html=blocks[i].innerHTML;
      // 抽所有 onclick/class 特征节点
      var acts=[];
      var nodes=blocks[i].querySelectorAll('*');
      for (var j=0;j<nodes.length;j++){
        var n=nodes[j];
        var txt=(n.innerText||'').trim();
        var cls=(n.className&&n.className.toString&&n.className.toString()||'').slice(0,50);
        if (/撤|cancel|withdraw|revoke/i.test(cls) || /撤/.test(txt)){
          acts.push({tag:n.tagName, txt:txt.slice(0,20), cls:cls});
        }
      }
      return JSON.stringify({block_html_len:html.length, withdrawish:acts, btn_html: html.slice(html.length-800)});
    }
  }
  return 'no-block';
})()
""")
print(r[:1500])
