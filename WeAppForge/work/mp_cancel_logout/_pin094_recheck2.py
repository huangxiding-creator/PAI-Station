# -*- coding: utf-8 -*-
"""钉位复核2：结构化解析 — 每个版本号出现处的前后文窗口，判 0.9.4/0.9.3 归属哪个区。"""
import json, sys
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
txt = (tab.run_js("return document.body.innerText;") or "").replace("\n", "|")
wins = []
for key in ("体验版", "0.9.4", "0.9.3"):
    s = 0
    while True:
        i = txt.find(key, s)
        if i < 0: break
        wins.append(key + " @" + str(i) + ": …" + txt[max(0, i-30):i+90])
        s = i + len(key)
print(json.dumps(wins[:14], ensure_ascii=False, indent=0))
# DOM 级判定：体验版卡容器内的版本号
JS = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var heads = document.querySelectorAll('*');
  var trialBlock = null;
  for (var i=0;i<heads.length;i++){
    var o = ownText(heads[i]);
    if (o === '体验版本' || o === '体验版'){ trialBlock = heads[i]; break; }
  }
  if (!trialBlock) return 'no-trial-header';
  var node = trialBlock;
  for (var d=0; d<8 && node; d++){
    node = node.parentElement;
    if (!node) break;
    var t = node.innerText || '';
    if (t.indexOf('版本号') >= 0){
      var m = t.match(/版本号\s*([0-9.]+)/);
      if (m) return 'trial-card-version=' + m[1] + ' depth=' + d;
    }
  }
  return 'trial-header-found-but-no-version';
})();
"""
print("DOM:", tab.run_js(JS))
