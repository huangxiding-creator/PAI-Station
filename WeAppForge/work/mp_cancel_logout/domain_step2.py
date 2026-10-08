# -*- coding: utf-8 -*-
"""domain_step2.py — 开发管理页 → 找「开发设置」「服务器域名」位置。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "/wxamp/" in (t.url or ""):
        tab = t
        break
assert tab

token = (tab.url or "").split("token=")[1].split("&")[0]
tab.get(f"https://mp.weixin.qq.com/wxamp/devprofile/get_profile?token={token}&lang=zh_CN")
time.sleep(4)
print("url:", (tab.url or "")[:140])
shot(tab, "devprofile")

r = tab.run_js(r"""
return (function(){
  var out = [];
  document.querySelectorAll('a[href]').forEach(function(a){
    var t = (a.innerText || '').replace(/\s+/g, ' ').trim();
    if (!t) return;
    if (t.indexOf('开发设置') >= 0 || t.indexOf('服务器域名') >= 0 || t.indexOf('开发') >= 0 || t.indexOf('域名') >= 0) {
      out.push({t: t.slice(0, 30), h: (a.getAttribute('href') || '').slice(0, 120)});
    }
  });
  var body = document.body.innerText || '';
  return JSON.stringify({links: out.slice(0, 30), has_domain_text: body.indexOf('服务器域名') >= 0,
                         has_dev_settings: body.indexOf('开发设置') >= 0});
})()
""")
print("PROBE:", r)
