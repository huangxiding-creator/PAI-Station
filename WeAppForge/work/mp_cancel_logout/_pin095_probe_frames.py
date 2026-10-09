# -*- coding: utf-8 -*-
"""_pin095_probe_frames — 判帧拓扑：0.9.5 文本在顶层还是 iframe 里 + iframe 清单。"""
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
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
m = re.search(r"token=(\d{8,})", tab.url or "")
token = m.group(1)

nt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(7)
print("url:", nt.url)

JS = r"""
return (function(){
  var body = document.body.innerText || '';
  var frames = [];
  document.querySelectorAll('iframe').forEach(function(f, i){
    var ft = '';
    try { ft = (f.contentDocument && f.contentDocument.body) ? (f.contentDocument.body.innerText || '').slice(0, 200) : '(cross-origin或空)'; } catch(e) { ft = '(跨域不可读)'; }
    frames.push({i: i, src: (f.src || '').slice(0, 120), text: ft});
  });
  return JSON.stringify({
    top_has_095: body.indexOf('0.9.5') >= 0,
    top_has_体验版: body.indexOf('体验版') >= 0,
    top_len: body.length,
    top_head: body.slice(0, 150).replace(/\n/g, '|'),
    iframes: frames
  });
})();
"""
print("top:", nt.run_js(JS))
