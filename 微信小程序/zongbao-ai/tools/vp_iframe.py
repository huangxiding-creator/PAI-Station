# -*- coding: utf-8 -*-
"""进 mpskit iframe（无界微前端）找商品管理。"""
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = "1185026370"

# 先确保在 goods 页
url = f"https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token={tok}&lang=zh_CN"
page.run_js(f"location.href='{url}'")
time.sleep(6)

# 方法1：尝试用 DrissionPage 的 iframe 支持
try:
    # 获取名为 mpskit 的 iframe
    ifr = page.ele('iframe[name=mpskit]')
    if ifr:
        frame = ifr.frame  # 切入 iframe
        txt = frame.run_js("""
return (function(){
  var out=[];
  var els=document.querySelectorAll('td,th,button,h3,h4,[class*=product],[class*=goods],[class*=item],[class*=btn],a');
  for(var i=0;i<Math.min(els.length,50);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if(t&&t.length>2&&t.length<300) out.push({tag:els[i].tagName,text:t.slice(0,150)});
  }
  return JSON.stringify(out.slice(0,20));
})()
""")
        print("[iframe-mpskit] 内容:")
        for l in json.loads(txt or "[]"):
            print(f"  [{l['tag']}] {l['text']}")
        sys.exit(0)
except Exception as e:
    print(f"iframe切入失败: {e}")

# 方法2：看 shadow DOM (wujie 微前端用 shadow root)
shadow = page.run_js("""
return (function(){
  function walkShadow(root, depth) {
    if (!root || depth > 5) return [];
    var out = [];
    try {
      var els = root.querySelectorAll('*');
      for (var i=0;i<Math.min(els.length,200);i++){
        var sr = els[i].shadowRoot;
        if (sr) {
          var inner = sr.querySelectorAll('td,th,button,h3,h4,[class*=product],[class*=goods],a');
          for (var j=0;j<Math.min(inner.length,30);j++){
            var t=(inner[j].innerText||'').replace(/\\s+/g,' ').trim();
            if(t&&t.length>2) out.push({tag:inner[j].tagName,text:t.slice(0,150)});
          }
          // 递归
          out = out.concat(walkShadow(sr, depth+1));
        }
      }
    } catch(e) {}
    return out;
  }
  return JSON.stringify(walkShadow(document, 0).slice(0,25));
})()
""")
print("[shadow-dom] 内容:")
for l in json.loads(shadow or "[]"):
    print(f"  [{l['tag']}] {l['text']}")

# 方法3：搜所有标签页
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    u = t.url or ""
    if "goods" in u or "product" in u or "skit" in u:
        print(f"\n[tab] {u[:100]}")
        txt3 = t.run_js("""
return (function(){
  var out=[];
  var els=document.querySelectorAll('td,th,button,h3,a[class*=btn],[class*=product],[class*=goods]');
  for(var i=0;i<Math.min(els.length,40);i++){
    var t=(els[i].innerText||'').replace(/\\s+/g,' ').trim();
    if(t&&t.length>3) out.push(t.slice(0,150));
  }
  return JSON.stringify(out.slice(0,15));
})()
""")
        for l in json.loads(txt3 or "[]"):
            print("  ", l)
