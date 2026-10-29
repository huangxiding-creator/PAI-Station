# -*- coding: utf-8 -*-
"""探路：9338 已登录浏览器进虚拟支付商品管理页，读现有商品清单。"""
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

# 先看当前 URL（应已登录）
u = page.url or ""
print("当前:", u[:80])

# 虚拟支付入口：小程序管理后台 → 功能 → 虚拟支付（多个可能路径）
# 方法1：直接走已知 URL 格式
# 方法2：从左侧菜单点入
page.run_js("""
(function(){
  // 找左侧菜单里的"虚拟支付"或"微信支付"链接
  var links = document.querySelectorAll('a, [class*=menu] span, [class*=nav] span');
  var out = [];
  for (var i = 0; i < links.length; i++) {
    var t = (links[i].innerText || '').trim();
    if (t && t.length < 20 && /虚拟|支付|道具|短剧/.test(t)) {
      out.push(t + ' -> ' + (links[i].href || links[i].getAttribute('data-url') || '?'));
    }
  }
  window.__vp_menu = out;
})();
""")
menus = page.run_js("return window.__vp_menu || []")
print("菜单命中:", json.dumps(menus[:8], ensure_ascii=False))

# 也看下已有的 product_id 格式参考
import re
u2 = page.url or ""
m = re.search(r"token=(\d+)", u2)
if m:
    tok = m.group(1)
    # 尝试直接跳转虚拟支付管理页（常见路径）
    for path in [
        "wxamp/virtualpay/productmanage",
        "wxamp/payproduct/productmanage",
        "wxamp/wacodepage/payproduct",
    ]:
        url = f"https://mp.weixin.qq.com/{path}?token={tok}"
        page.run_js(f"location.href='{url}'")
        time.sleep(4)
        u3 = page.url or ""
        title = page.run_js("return document.title || ''")
        print(f"尝试 {path}: {u3[:60]} | {title}")
        if "虚拟" in (page.html or "") or "商品" in (page.html or ""):
            print("HIT!")
            break

# 从首页菜单找
if not any("虚拟" in str(m) for m in menus):
    # 走主页面找
    page.run_js("location.href='https://mp.weixin.qq.com/'")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
    page.run_js(f"""
(function(){{
  var els = document.querySelectorAll('*');
  var hits = [];
  for (var i=0;i<els.length;i++){{
    var t=(els[i].childNodes && Array.prototype.filter.call(els[i].childNodes, function(n){{return n.nodeType===3;}}).map(function(n){{return n.nodeValue.trim();}}).join(' ')) || '';
    if (t==='虚拟支付' || t==='微信支付' || t==='道具管理'){{
      hits.push({{text:t, tag:els[i].tagName, cls:els[i].className.slice(0,50)}});
      els[i].click();
    }}
  }}
  window.__found = hits;
}})();
""")
    found = page.run_js("return window.__found || []")
    print("首页点击:", json.dumps(found[:5], ensure_ascii=False))
    time.sleep(5)
    u3 = page.url or ""
    print("跳转到:", u3[:80])

# 无论在哪，读页面文本找商品管理入口
html = page.html or ""
if "商品" in html:
    rows = page.run_js("""
return (function(){
  var items = document.querySelectorAll('td, [class*=product], [class*=goods]');
  var out = [];
  for (var i=0;i<Math.min(items.length,30);i++){
    var t = (items[i].innerText||'').replace(/\\s+/g,' ').trim();
    if (t && t.length > 5 && t.length < 200) out.push(t.slice(0,100));
  }
  return JSON.stringify(out.slice(0,10));
})()
""")
    print("页面条目:", rows[:800])
