# -*- coding: utf-8 -*-
"""_pin095_probe_dom — getcodepage 结构勘探：arrowBtn 在哪、0.9.5 行文本长什么样。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or "") and "scanlogin" not in (t.url or ""):
        tab = t; break
m = re.search(r"token=(\d{8,})", tab.url or "")
token = m.group(1)

nt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(7)
print("url:", nt.url)

JS = r"""
return (function(){
  var out = {arrow_btns: [], ctx_095: null, body_head: ''};
  document.querySelectorAll('.arrowBtn').forEach(function(e, i){
    var r = e.getBoundingClientRect();
    var row = e.closest('div,section');
    var rowTxt = row ? (row.innerText || '').slice(0, 160).replace(/\n/g, '|') : '';
    out.arrow_btns.push({i: i, vis: r.width > 0, row: rowTxt});
  });
  var all = document.querySelectorAll('div,section');
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('0.9.5') >= 0 && t.length < 800) {
      out.ctx_095 = {len: t.length, txt: t.slice(0, 300).replace(/\n/g, '|')};
      break;
    }
  }
  out.body_head = (document.body.innerText || '').slice(0, 200).replace(/\n/g, '|');
  return JSON.stringify(out);
})();
"""
print("dom:", nt.run_js(JS))
nt.get_screenshot(path=r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_pin095_probe_dom.png")
