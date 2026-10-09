# -*- coding: utf-8 -*-
"""_pin094_probe2 — 刷新版本管理页，dump 0.9.4 行 + 该行内的可点元素（找箭头按钮）。"""
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
    u = t.url or ""
    if "mp.weixin.qq.com" in u and "token=" in u:
        tab = t
        break
m = re.search(r"token=(\d{8,})", tab.url or "")
tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={m.group(1)}&lang=zh_CN")
time.sleep(5)

JS = r"""
return (function(){
  var res = {has094: document.body.innerHTML.indexOf('0.9.4') >= 0, rows: []};
  // 版本卡片一般是 .code_version_item / .dev_version_item / 含版本号的容器
  var cands = document.querySelectorAll('div.code_version_item, div.dev_version_item, [class*="version_item"], [class*="version-item"]');
  cands.forEach(function(c, idx){
    var txt = (c.innerText || '').slice(0, 160).replace(/\s+/g, ' ');
    if (!txt) return;
    res.rows.push({idx: idx, cls: (c.className||'').toString().slice(0,50), txt: txt});
  });
  // 0.9.4 所在行内的所有可点元素
  var all = document.querySelectorAll('div,section');
  for (var i = 0; i < all.length; i++) {
    var t = all[i].innerText || '';
    if (t.indexOf('0.9.4') >= 0 && t.length < 400) {
      var row = all[i];
      row.scrollIntoView({block: 'center'});
      var clicks = [];
      row.querySelectorAll('a,button,i,span[class*=icon],em,[class*=arrow],[class*=more],[class*=dropdown]').forEach(function(e){
        var r = e.getBoundingClientRect();
        var own = Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ').trim();
        if (r.width > 0) clicks.push({tag: e.tagName, cls: (e.className||'').toString().slice(0,44), txt: (own||'').slice(0,24), x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width)});
      });
      res.target = {txt: t.slice(0,120).replace(/\s+/g,' '), clicks: clicks.slice(0,25)};
      break;
    }
  }
  return JSON.stringify(res);
})();
"""
out = tab.run_js(JS)
print(out[:4000])
