# -*- coding: utf-8 -*-
"""domain_step3.py — 开发设置页：服务器域名区结构 + 修改按钮定位 + 现有 downloadFile 域名。"""
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
    if "/wxamp/devprofile" in (t.url or ""):
        tab = t
        break
assert tab

r = tab.run_js(r"""
return (function(){
  // 找「服务器域名」锚点元素
  var anchor = null;
  var spans = document.querySelectorAll('span, div, h3, h2, td, th');
  for (var i = 0; i < spans.length; i++) {
    var el = spans[i];
    for (var k = 0; k < el.childNodes.length; k++) {
      var n = el.childNodes[k];
      if (n.nodeType === 3 && n.textContent.trim() === '服务器域名') { anchor = el; break; }
    }
    if (anchor) break;
  }
  if (!anchor) return JSON.stringify({anchor: false});
  // 锚点向上找容器（覆盖整个域名设置卡）
  var card = anchor.closest('.weui-desktop-card, .card, .panel, form, .weui-desktop-panels') || anchor.parentElement;
  for (var up = 0; up < 6 && card && card.offsetWidth < 400; up++) card = card.parentElement;
  var txt = (card ? card.innerText : '').replace(/\n+/g, ' | ').slice(0, 1500);
  // 卡内所有可点元素（含「修改」）
  var btns = [];
  if (card) card.querySelectorAll('a, button').forEach(function(b){
    var t = (b.innerText || '').replace(/\s+/g, ' ').trim();
    if (t) btns.push({t: t.slice(0, 20), tag: b.tagName, vis: b.offsetParent !== null,
                      href: (b.getAttribute('href') || '').slice(0, 60)});
  });
  return JSON.stringify({anchor: true, card_txt: txt, btns: btns.slice(0, 25)});
})()
""")
print(json.dumps(json.loads(r), ensure_ascii=False, indent=1))
shot(tab, "domain_card")
