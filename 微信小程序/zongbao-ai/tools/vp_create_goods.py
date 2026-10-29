# -*- coding: utf-8 -*-
"""虚拟支付商品管理页：读现有商品清单+找新建按钮。"""
import sys, time, json, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

tok = "1185026370"
url = f"https://mp.weixin.qq.com/wxamp/virtualpay/productmanage?token={tok}&lang=zh_CN"
page.run_js(f"location.href='{url}'")
time.sleep(6)

# 读页面所有可见文本块
txt = page.run_js("""
return (function(){
  var out = [];
  var els = document.querySelectorAll('td, th, [class*=product], [class*=goods], [class*=item], button, a.btn');
  for (var i=0;i<Math.min(els.length,60);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if (t && t.length>3 && t.length<300) out.push(t.slice(0,150));
  }
  return JSON.stringify(out.slice(0,25));
})()
""")
print("商品管理页面内容:")
for line in json.loads(txt or "[]"):
    print(" ", line)

# 找"新建"/"添加"按钮
btns = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els = document.querySelectorAll('button, a');
  var out=[];
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if (t && /新建|添加|创建/.test(t) && vis(els[i])) {
      out.push({text:t, tag:els[i].tagName, cls:(els[i].className||'').slice(0,60)});
    }
  }
  return JSON.stringify(out);
})()
""")
print("\n新建按钮:", btns[:500])

# 也看下左侧菜单是否有子菜单
subs = page.run_js("""
return (function(){
  var els = document.querySelectorAll('[class*=menu] span, [class*=nav] span, [class*=tab] span, [class*=side] a');
  var out=[];
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if (t && t.length<15 && /商品|道具|短剧|管理/.test(t)) out.push(t);
  }
  return JSON.stringify(out.slice(0,10));
})()
""")
print("子菜单:", subs[:300])
