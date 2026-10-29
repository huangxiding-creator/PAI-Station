# -*- coding: utf-8 -*-
"""虚拟支付商品管理：直跳 goods 管理子页。"""
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = "1185026370"

VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""

# 当前在 skit/manage/order → 试相邻路径
for path in ["goods", "product", "commodity"]:
    url = f"https://mp.weixin.qq.com/wxamp/subApp/skit/manage/{path}?token={tok}&lang=zh_CN"
    page.run_js(f"location.href='{url}'")
    time.sleep(5)
    u = page.url or ""
    txt = page.run_js("""
return (function(){
  var out=[];
  var els=document.querySelectorAll('td,th,[class*=product],[class*=goods],[class*=item],button,a[class*=btn],h3,h4');
  for(var i=0;i<Math.min(els.length,50);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if(t&&t.length>3&&t.length<300) out.push(t.slice(0,200));
  }
  return JSON.stringify(out.slice(0,20));
})()
""")
    lines = json.loads(txt or "[]")
    print(f"[{path}] URL={u[-30:]} 内容{len(lines)}条")
    for l in lines[:12]:
        print("  ", l)
    if lines:
        break

# 也看有没有iframe
ifr = page.run_js("""
return (function(){
  var iframes = document.querySelectorAll('iframe');
  var out = [];
  for (var i=0;i<iframes.length;i++) out.push({src:(iframes[i].src||'').slice(0,120), id:iframes[i].id, name:iframes[i].name});
  return JSON.stringify(out);
})()
""")
print("\niframes:", ifr[:500])

# 如果有iframe，切进去
if_data = json.loads(ifr or "[]")
for f in if_data:
    if f.get("src") and "skit" in (f.get("src") or ""):
        print("\n尝试进 iframe:", f["src"][:80])
        # 用 tab 切换
        for tid in page.browser.tab_ids:
            t = page.browser.get_tab(tid)
            if f["src"][:40] in (t.url or ""):
                page = t
                break
        time.sleep(3)
        txt2 = page.run_js("""
return (function(){
  var out=[];
  var els=document.querySelectorAll('td,th,button,h3,h4,[class*=product],[class*=goods]');
  for(var i=0;i<Math.min(els.length,30);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if(t&&t.length>3) out.push(t.slice(0,200));
  }
  return JSON.stringify(out.slice(0,15));
})()
""")
        print("iframe内容:")
        for l in json.loads(txt2 or "[]"):
            print("  ", l)
        break
