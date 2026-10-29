# -*- coding: utf-8 -*-
"""点左侧「虚拟支付」进道具管理。"""
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""

# 点虚拟支付菜单
r = page.run_js("return (function(){" + VIS + """
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var t = Array.prototype.filter.call(els[i].childNodes, function(n){return n.nodeType===3;})
      .map(function(n){return n.nodeValue.trim();}).join(' ');
    if (t === '虚拟支付') {
      els[i].click();
      return 'clicked:' + els[i].tagName + ':' + (els[i].className||'').slice(0,40);
    }
  }
  return 'not-found';
})()
""")
print("[1] 点虚拟支付:", r)
time.sleep(6)

# 看跳到哪里了
u = page.url or ""
print("[2] URL:", u[:100])

# 读页面内容（可能进了虚拟支付首页，有子菜单）
page_txt = page.run_js("""
return (function(){
  var out = [];
  var els = document.querySelectorAll('h1,h2,h3,h4,td,th,[class*=tab],[class*=menu-item],[class*=card],[class*=stat],button,a[class*=btn]');
  for (var i=0;i<Math.min(els.length,40);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if (t && t.length>2 && t.length<200) out.push(t.slice(0,120));
  }
  return JSON.stringify(out.slice(0,20));
})()
""")
print("[3] 页面内容:")
for line in json.loads(page_txt or "[]"):
    print("  ", line)

# 找子菜单里的"商品"/"道具"链接
sub = page.run_js("return (function(){" + VIS + """
  var els = document.querySelectorAll('a, span, [class*=tab]');
  var out = [];
  for (var i=0;i<els.length;i++){
    var t = (els[i].innerText||'').trim();
    if (t && t.length < 12 && /商品|道具|短剧|管理/.test(t)) {
      out.push({text:t, href: els[i].href || els[i].getAttribute('data-href') || '?'});
      if (vis(els[i]) && els[i].click) {
        // 只点第一个"商品管理"或"道具管理"
        if (/商品管理|道具管理/.test(t)) { els[i].click(); out[out.length-1].clicked = true; }
      }
    }
  }
  return JSON.stringify(out.slice(0,8));
})()
""")
print("[4] 子菜单:", sub[:600])
time.sleep(5)

# 再看跳转后的页面
u2 = page.url or ""
print("[5] URL:", u2[:100])
txt2 = page.run_js("""
return (function(){
  var out = [];
  var els = document.querySelectorAll('td,th,[class*=product],[class*=goods],button');
  for (var i=0;i<Math.min(els.length,30);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if (t && t.length>3) out.push(t.slice(0,150));
  }
  return JSON.stringify(out.slice(0,15));
})()
""")
print("[6] 商品列表:")
for line in json.loads(txt2 or "[]"):
    print("  ", line)
