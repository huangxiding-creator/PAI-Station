# -*- coding: utf-8 -*-
# 控制台切号 wx5cee → wxfdb（1008 配方：隐藏 div[title=切换账号] JS 直点 → account_item）
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
if not gt:
    print('NO_MP_TAB'); sys.exit(1)
# 1) 直点隐藏切换账号
r = gt.run_js("""
return (function(){
  var els=document.querySelectorAll('div[title="切换账号"]');
  if (!els.length) return 'no-switch-div';
  els[0].click(); return 'switch-clicked';
})()
""")
print('switch:', r)
time.sleep(3)
# 2) 对话框里找 wxfdb 账号项（账号项通常含昵称/原始ID文本）
s = gt.run_js("""
return (function(){
  var dlg=document.querySelector('.switch_account_dialog, .weui-desktop-dialog');
  var items=document.querySelectorAll('.account_item, [class*=account_item], [class*=account-item]');
  var txt=[];
  for (var i=0;i<items.length;i++){txt.push((items[i].innerText||'').replace(/\s+/g,' ').slice(0,50));}
  var body=(document.body.innerText||'').slice(0,400);
  return JSON.stringify({n_items:items.length, items:txt.slice(0,8), dlg: dlg?(dlg.innerText||'').slice(0,120):null, body_head:body.replace(/\s+/g,' ').slice(0,200)});
})()
""")
print('after:', s[:700])
