# -*- coding: utf-8 -*-
"""trial_block_probe.py — dump 1.2.0 体验版行的可点元素与二维码入口。"""
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
    if "mp.weixin.qq.com" in (t.url or "") and "getcodepage" in (t.url or ""):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

r = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var blk = null;
  for (var i = 0; i < blocks.length; i++) {
    if (blocks[i].textContent.indexOf('体验版') >= 0 && blocks[i].textContent.indexOf('1.2.0') >= 0) { blk = blocks[i]; break; }
  }
  if (!blk) {
    for (var i = 0; i < blocks.length; i++) {
      if (blocks[i].textContent.indexOf('取消体验') >= 0) { blk = blocks[i]; break; }
    }
  }
  if (!blk) return JSON.stringify({found: false, n_blocks: blocks.length});
  var acts = [];
  var els = blk.querySelectorAll('a, button, span[class*="link"], div[class*="code_version"]');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').replace(/\s+/g, ' ').trim();
    if (t && t.length <= 30) {
      acts.push({tag: els[i].tagName, t: t, cls: (els[i].className||'').toString().slice(0, 60), vis: els[i].offsetParent !== null});
    }
  }
  return JSON.stringify({found: true, acts: acts.slice(0, 25), html_head: blk.innerHTML.replace(/\s+/g, ' ').slice(0, 600)});
})()
""")
print("block:", r[:3000])
