# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
page.run_js("location.href='https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token=1185026370&lang=zh_CN'")
time.sleep(8)
page.get_screenshot(path=r"E:\AI-Station\kb_rev\vp_goods_page.png", full_page=True)
print("screenshot saved")

# 主区域文本
main = page.run_js("""
return (function(){
  var body = document.body.innerText || '';
  return body.replace(/\\s+/g, ' ').slice(0, 800);
})()
""")
print("PAGE:", main[:600] if main else "empty")

# 找"新建"按钮
r = page.run_js("""
return (function(){
  var els = document.querySelectorAll('button, a, [class*=btn]');
  var out = [];
  for (var i=0;i<els.length;i++){
    var t = (els[i].innerText||'').trim();
    if (t && t.length < 20 && /新建|添加|创建|create/i.test(t)) {
      out.push({text:t, tag:els[i].tagName});
    }
  }
  return JSON.stringify(out.slice(0,5));
})()
""")
print("BUTTONS:", r[:300])
