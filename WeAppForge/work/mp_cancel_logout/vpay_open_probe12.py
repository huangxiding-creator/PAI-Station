# -*- coding: utf-8 -*-
"""vpay_open_probe12 — 真点「虚拟支付」菜单 → 等渲染 → 剖主文档+wujie iframe 全文找开通向导。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p12.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p12_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


JS_DEEP = r"""
return (function(){
  function txt(doc){
    try { return (doc.body ? doc.body.innerText : '').slice(0, 3000); } catch(e){ return 'XDOM'; }
  }
  var res = {main_txt: txt(document), iframes: []};
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    var r = f.getBoundingClientRect();
    var entry = {i: i, src: (f.src||'').slice(0, 140), w: Math.round(r.width), h: Math.round(r.height)};
    try {
      var d = f.contentDocument;
      if (d) {
        entry.txt = txt(d).slice(0, 2500);
        entry.inner_iframes = Array.from(d.querySelectorAll('iframe')).map(function(g){
          var rr = g.getBoundingClientRect();
          return {src: (g.src||'').slice(0, 140), w: Math.round(rr.width), h: Math.round(rr.height),
                  txt: (function(){try{return (g.contentDocument.body?g.contentDocument.body.innerText:'').slice(0,2500);}catch(e){return 'XDOM';}})()};
        });
      }
    } catch(e) { entry.xdom = true; }
    res.iframes.push(entry);
  });
  return JSON.stringify(res);
})();
"""


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
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={token}&lang=zh_CN")
    time.sleep(3.5)

    # 真点菜单链接
    try:
        r = tab.run_js('return (function(){var a=document.querySelector(\'a[href*="subApp/skit"]\'); if(!a) return "no-link"; a.click(); return "clicked";})();')
        log({"click_vpay_menu": r})
    except Exception as e:
        log({"click_err": str(e)[:200]})
        return 1
    time.sleep(9)

    log({"url": (tab.url or "")[:140], "shot": shot(tab, "vpay")})
    try:
        raw = tab.run_js(JS_DEEP)
        log({"deep": raw and raw[:6000]})
    except Exception as e:
        log({"deep_err": str(e)[:300]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
