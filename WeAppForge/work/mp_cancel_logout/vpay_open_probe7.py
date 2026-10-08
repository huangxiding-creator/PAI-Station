# -*- coding: utf-8 -*-
"""vpay_open_probe7 — JS 直点隐藏「切换账号」→ dump 账号选择面 → 点总包科技 → 验证。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p7.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p7_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


JS_RECTS = r"""
return (function(){
  var res = [];
  function walk(root, depth){
    if (depth > 6) return;
    Array.from(root.querySelectorAll('*')).forEach(function(e){
      if (e.textContent && e.textContent.indexOf('总包科技') >= 0 && e.children.length <= 4) {
        var r = e.getBoundingClientRect();
        res.push({tag: e.tagName, cls: (e.className||'').toString().slice(0,60),
                  x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height),
                  visible: r.width>0 && r.height>0});
      }
    });
  }
  walk(document, 0);
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    try { walk(f.contentDocument, 0); } catch(err) { res.push({iframe: i, err: 'xdom'}); }
  });
  return JSON.stringify(res.slice(0, 30));
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
    tab.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={m.group(1)}&lang=zh_CN")
    time.sleep(3.5)

    # 1) JS 直点「切换账号」
    try:
        r = tab.run_js('return (function(){var e=document.querySelector(\'div[title="切换账号"]\'); if(!e) return "no-el"; e.click(); return "clicked";})();')
        log({"step": "js_click_switch", "ret": r})
    except Exception as e:
        log({"step": "js_click_switch_err", "err": str(e)[:300]})
        return 1
    time.sleep(4.5)
    html = tab.html or ""
    log({"step": "after", "url": (tab.url or "")[:130],
         "hits": {"总包科技": html.count("总包科技"), "总包AI顾问": html.count("总包AI顾问"),
                  "切换账号": html.count("切换账号")},
         "shot": shot(tab, "aftersw")})

    # 2) 总包科技元素矩形(含 iframe 内)
    try:
        raw = tab.run_js(JS_RECTS)
        log({"rects": json.loads(raw)})
    except Exception as e:
        log({"rects_err": str(e)[:300]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
