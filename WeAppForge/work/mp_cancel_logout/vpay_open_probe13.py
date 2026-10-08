# -*- coding: utf-8 -*-
"""vpay_open_probe13 — 穿透 wujie shadow DOM：找虚拟支付「开通」等交互元素的真身与矩形。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p13.log"

JS_PIERCE = r"""
return (function(){
  var hits = [], shadowHosts = 0;
  function walk(root, path){
    if (!root || hits.length > 60) return;
    var all;
    try { all = root.querySelectorAll('*'); } catch(e){ return; }
    Array.prototype.forEach.call(all, function(e){
      if (e.shadowRoot) {
        shadowHosts++;
        walk(e.shadowRoot, path + '>>shadow(' + e.tagName + '.' + (e.className||'').toString().slice(0,30) + ')');
      }
      var t = (e.textContent || '');
      var own = (e.childNodes && Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ')) || '';
      if (/^(开通|立即开通|同意并开通|申请开通)$/.test(own.trim()) || /开通条件|功能介绍|技术服务费/.test(own) && own.length < 40) {
        var r = e.getBoundingClientRect();
        hits.push({path: path.slice(0, 120), tag: e.tagName,
                   cls: (e.className||'').toString().slice(0, 50),
                   own: own.trim().slice(0, 30),
                   x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height),
                   vis: r.width > 0 && r.height > 0});
      }
    });
  }
  walk(document, 'doc');
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    try {
      if (f.contentDocument) walk(f.contentDocument, 'if' + i);
      Array.from(f.contentDocument.querySelectorAll('*')).forEach(function(e){
        if (e.shadowRoot) { shadowHosts++; walk(e.shadowRoot, 'if' + i + '>>shadow'); }
      });
    } catch(err) {}
  });
  return JSON.stringify({shadowHosts: shadowHosts, hits: hits.slice(0, 50)});
})();
"""


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p13_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    m = re.search(r"token=(\d{8,})", tab.url or "")
    if not m:
        for t in page.get_tabs():
            mm = re.search(r"token=(\d{8,})", t.url or "")
            if mm:
                m = mm
                break
    if not m:
        log({"state": "NO_TOKEN"})
        return 1
    token = m.group(1)

    # 若已不在 skit 页则先点菜单
    if "/subApp/skit" not in (tab.url or ""):
        tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
        time.sleep(3)
        tab.run_js('return (function(){var a=document.querySelector(\'a[href*="subApp/skit"]\'); if(a){a.click(); return "clicked";} return "no-link";})();')
        time.sleep(9)
    else:
        time.sleep(2)

    try:
        raw = tab.run_js(JS_PIERCE)
        log({"pierce": raw and raw[:5000]})
    except Exception as e:
        log({"pierce_err": str(e)[:300]})
    log({"shot": shot(tab, "pierce")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
