# -*- coding: utf-8 -*-
"""_handov_probe_list — 探草稿列表页结构与翻页."""
import re, sys, time
from DrissionPage import ChromiumPage, ChromiumOptions

port = int(sys.argv[1]); key = sys.argv[2]
co = ChromiumOptions(); co.set_local_port(port)
page = ChromiumPage(co)
page.get("https://mp.weixin.qq.com/")
time.sleep(2)
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
print("token:", tok)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN&type=77")
time.sleep(4)
# 打印页面所有含「发表」的可见卡片行 与 翻页控件
info = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var out={titles:[],pagers:[]};
  // 找卡片标题 (weui 列表行)
  var rows=document.querySelectorAll('.weui-desktop-card, .appmsg_list_item, .weui-desktop-panel tr, li');
  var seen={};
  rows.forEach(function(r){
    if(!vis(r)) return;
    var t=(r.innerText||'').split('\\n')[0].trim();
    if(t && t.length>6 && !seen[t] && out.titles.length<25){seen[t]=1;out.titles.push(t.slice(0,46));}
  });
  // 翻页按钮
  document.querySelectorAll('button, .weui-desktop-pagination a, [class*=pagination] *').forEach(function(b){
    if(!vis(b))return; var t=(b.innerText||'').trim();
    if((t.indexOf('下一页')>=0||t.indexOf('页')>=0) && out.pagers.length<8){out.pagers.push(t);}
  });
  out.hasKey = document.body.innerText.indexOf('KEYMARK')>=0;
  out.keyInBody = document.body.innerText.indexOf('""" + key + """')>=0;
  return JSON.stringify(out);
})()
""")
print(info[:1500])
