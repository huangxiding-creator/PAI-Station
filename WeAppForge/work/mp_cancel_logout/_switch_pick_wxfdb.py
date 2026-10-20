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
gt = find_tab('mp.weixin.qq.com')
r = gt.run_js("""
return (function(){
  var items=document.querySelectorAll('.account_item, [class*=account_item], [class*=account-item]');
  for (var i=0;i<items.length;i++){
    var t=(items[i].innerText||'').replace(/\s+/g,' ');
    if (t.indexOf('总包科技')>=0 && t.indexOf('当前登录')<0){
      items[i].click(); return 'picked-zongbao-tech@'+i;
    }
  }
  return 'not-found';
})()
""")
print('pick:', r)
time.sleep(8)
# 切号后所有 tab 会刷新——重找 mp tab 确认身份
gt2 = find_tab('mp.weixin.qq.com')
body = gt2.run_js("return (document.body.innerText||'').slice(0,150)") or ''
url = gt2.run_js("return location.href") or ''
print('url:', url[:100])
print('has-tech:', '总包科技' in body, '| has-ai:', '总包AI顾问' in body)
