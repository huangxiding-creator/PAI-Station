# -*- coding: utf-8 -*-
# mp_switch_account — 9338 控制台身份切换（总包说→目标小程序身份）
# 用法: py -3 -X utf8 mp_switch_account.py 总包AI顾问
import sys, time, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

TARGET = sys.argv[1] if len(sys.argv) > 1 else "总包AI顾问"
opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

def js(code):
    return page.run_js(code) or ""

def own_find_and_click(text, exact=True):
    return js("""
return (function(){
  function own(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var t=own(els[i]);
    var hit = %(exact)s ? (t==='%(text)s') : (t.indexOf('%(text)s')>=0);
    if (hit){
      ['mouseover','mousedown','mouseup','click'].forEach(function(ev){els[i].dispatchEvent(new MouseEvent(ev,{bubbles:true}));});
      return 'clicked:'+t.slice(0,20);
    }
  }
  return 'not-found:%(text)s';
})()
""" % {"text": text, "exact": "true" if exact else "false"})

# 1) 点切换账号
print("[1]", own_find_and_click("切换账号"))
time.sleep(5)

# 2) 扫账号选择浮层
popup = js("""
return (function(){
  var sels='.weui-desktop-pop, .dropdown-menu, [class*=dropdown], [class*=popover], [class*=account_list], [class*=switcher], .weui-desktop-modal, .weui-desktop-dialog';
  var found=[];
  document.querySelectorAll(sels).forEach(function(m){
    var t=(m.innerText||'').trim();
    if (t && t.indexOf('总包')>=0) found.push(t.replace(/[\\r\\n]+/g,' | ').slice(0,220));
  });
  var uniq=[]; found.forEach(function(x){if(uniq.indexOf(x)<0)uniq.push(x);});
  return uniq.slice(0,5).join('@@') || '';
})()
""")
print("[2] popup:", (popup or "EMPTY").replace("@@", " || ")[:400])

# 3) 点目标身份
if TARGET in (popup or ""):
    print("[3]", own_find_and_click(TARGET))
    time.sleep(10)
    body = js("return document.body.innerText") or ""
    print("[4] title:", js("return document.title"), "| target on page:", TARGET in body)
    m = re.search(r"token=(\d+)", page.url or "")
    print("[5] url token:", bool(m), "| url:", (page.url or "")[:90])
else:
    print("[3] 目标身份未在浮层出现，停（可能需登出重扫码）")
