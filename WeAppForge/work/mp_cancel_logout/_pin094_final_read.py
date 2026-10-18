# -*- coding: utf-8 -*-
"""钉位终读：全新标签页 + 稳健选择器（体验卡=含『下载二维码』且含『版本号』的最小容器）。"""
import json, re, sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
m = re.search(r"token=(\d{8,})", tab.url or "")
nt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={m.group(1)}&lang=zh_CN")
time.sleep(7)
JS = r"""
return (function(){
  var all = document.querySelectorAll('div,section');
  var best = null;
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('下载二维码') >= 0 && t.indexOf('版本号') >= 0 && t.indexOf('0.9.') >= 0 && t.length < 300) {
      if (!best || t.length < best.length) best = t;   // 最小容器=体验版本卡本体
    }
  }
  if (!best) return JSON.stringify({ver: null});
  var mm = best.match(/版本号\s*([0-9.]+)/);
  return JSON.stringify({ver: mm ? mm[1] : null, ctx: best.replace(/\n/g, '|').slice(0, 130)});
})();
"""
r = json.loads(nt.run_js(JS))
nt.get_screenshot(path=r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_pin094_final_read.png")
nt.close()
print(json.dumps(r, ensure_ascii=False))
