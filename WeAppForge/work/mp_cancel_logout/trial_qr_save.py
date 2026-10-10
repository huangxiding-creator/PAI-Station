# -*- coding: utf-8 -*-
"""trial_qr_save.py — 抓体验版二维码 base64 → 落盘 PNG。"""
import base64
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\website\zongbaoshuo-miniprogram\trial_qr_v120.png"

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "mp.weixin.qq.com" in (t.url or "") and "getcodepage" in (t.url or ""):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

r = tab.run_js(r"""
return (function(){
  var els = document.querySelectorAll('img');
  for (var i = 0; i < els.length; i++) {
    var src = els[i].src || '';
    if (src.indexOf('data:image/png;base64,') === 0 && els[i].offsetParent !== null && src.length > 2000) {
      return src;
    }
  }
  return '';
})()
""")
if not r:
    print(json.dumps({"qr": False}))
    raise SystemExit(1)

b64 = r.split(",", 1)[1]
data = base64.b64decode(b64)
with open(OUT, "wb") as f:
    f.write(data)
print(json.dumps({"qr": True, "path": OUT, "bytes": len(data), "png_sig": data[:4].hex()}))
