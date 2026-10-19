# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ''):
            return t
ft = find_tab('get_class')
srcs = ft.run_js("""
return JSON.stringify(Array.from(document.querySelectorAll('script[src]')).map(function(s){return s.src;}).slice(0,30));
""")
import json
urls = json.loads(srcs)
print('scripts:', len(urls))
# 在页面上下文里 fetch 每个同源脚本，搜 submit_check 附近的错误映射
r = ft.run_js("""
return (async function(){
  var srcs = Array.from(document.querySelectorAll('script[src]')).map(function(s){return s.src;}).filter(function(u){return u.indexOf('mp.weixin.qq.com')>=0 || u.indexOf('/wxamp/')>=0;});
  var hits = [];
  for (var i=0;i<srcs.length && i<20;i++){
    try {
      var txt = await fetch(srcs[i]).then(function(r){return r.text();});
      if (txt.indexOf('submit_check')>=0){
        var idx = txt.indexOf('submit_check');
        hits.push({url: srcs[i].slice(-60), around: txt.slice(Math.max(0,idx-200), idx+600).replace(/\s+/g,' ').slice(0,700)});
      }
    } catch(e){}
  }
  return JSON.stringify(hits.slice(0,3));
})()
""")
print(r[:2000])
