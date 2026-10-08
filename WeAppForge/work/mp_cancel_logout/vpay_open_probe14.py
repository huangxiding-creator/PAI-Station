# -*- coding: utf-8 -*-
"""vpay_open_probe14 — 点「开通」→ 回读新面（协议/表单/弹窗）。一次一点，回读为准。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p14.log"

JS_CLICK_OPEN = r"""
return (function(){
  function findOpen(root){
    try {
      var btns = Array.from(root.querySelectorAll('button'));
      for (var i = 0; i < btns.length; i++) {
        var own = Array.prototype.filter.call(btns[i].childNodes, function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join('');
        if (own === '开通') {
          var r = btns[i].getBoundingClientRect();
          if (r.width > 0) { btns[i].click(); return 'clicked@' + Math.round(r.x) + ',' + Math.round(r.y); }
        }
      }
      Array.from(root.querySelectorAll('*')).forEach(function(e){
        if (e.shadowRoot) { var r2 = findOpen(e.shadowRoot); if (r2) throw {found: r2}; }
      });
    } catch (err) { if (err && err.found) throw err; }
    return null;
  }
  try { var r = findOpen(document); return r || 'not-found'; }
  catch (err) { return (err && err.found) || String(err).slice(0, 100); }
})();
"""

JS_DUMP = r"""
return (function(){
  function txtOf(root){
    var parts = [];
    try {
      Array.from(root.querySelectorAll('button, input, label, h1, h2, h3, h4, .weui-desktop-modal, [class*=modal], [class*=dialog], [class*=form], [class*=item], p, li')).forEach(function(e){
        var own = Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ').trim();
        if (!own) return;
        var r = e.getBoundingClientRect();
        if (r.width > 0) parts.push(e.tagName + '|' + (e.className||'').toString().slice(0,28) + '|' + own.slice(0, 40) + '|' + Math.round(r.x) + ',' + Math.round(r.y));
      });
    } catch (err) {}
    return parts;
  }
  var out = {main: txtOf(document).slice(0, 60), shadow: [], iframes: []};
  function pierce(root, bag){
    try {
      Array.from(root.querySelectorAll('*')).forEach(function(e){
        if (e.shadowRoot) { bag.push({host: e.tagName, items: txtOf(e.shadowRoot).slice(0, 60)}); pierce(e.shadowRoot, bag); }
      });
    } catch (err) {}
  }
  pierce(document, out.shadow);
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    try { if (f.contentDocument) { out.iframes.push({i: i, txt: (f.contentDocument.body ? f.contentDocument.body.innerText : '').slice(0, 1500)}); } } catch(err) {}
  });
  return JSON.stringify(out);
})();
"""


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p14_{tag}_{time.strftime('%H%M%S')}.png"
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
    if "/subApp/skit" not in (tab.url or ""):
        tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={m.group(1)}&lang=zh_CN")
        time.sleep(3)
        tab.run_js('return (function(){var a=document.querySelector(\'a[href*="subApp/skit"]\'); if(a){a.click(); return "clicked";} return "no-link";})();')
        time.sleep(9)
    else:
        time.sleep(2)

    try:
        r = tab.run_js(JS_CLICK_OPEN)
        log({"click_open": r})
    except Exception as e:
        log({"click_open_err": str(e)[:300]})
        return 1
    time.sleep(6)

    try:
        raw = tab.run_js(JS_DUMP)
        log({"dump": raw and raw[:7000]})
    except Exception as e:
        log({"dump_err": str(e)[:300]})
    log({"shot": shot(tab, "after_open")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
