# -*- coding: utf-8 -*-
"""vpay_open_probe9 — 跨根(主文档+同源iframe+shadow)搜 switch_account 条目点总包科技；兜底坐标点。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p9.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p9_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


JS_CLICK_ANYROOT = r"""
return (function(){
  var report = [];
  function tryRoot(doc, name){
    try {
      var items = Array.from(doc.querySelectorAll('.account_item'));
      report.push({root: name, n: items.length});
      for (var i = 0; i < items.length; i++) {
        var t = (items[i].textContent || '');
        if (t.indexOf('总包科技') >= 0) {
          items[i].click();
          return {clicked_root: name, text: t.trim().replace(/\s+/g, '|').slice(0, 90)};
        }
      }
      // 宽网：任何 class 含 account_item 的
      var items2 = Array.from(doc.querySelectorAll('[class*="account_item"]'));
      for (var j = 0; j < items2.length; j++) {
        var t2 = (items2[j].textContent || '');
        if (t2.indexOf('总包科技') >= 0) {
          items2[j].click();
          return {clicked_root: name, via: 'wildcard', text: t2.trim().replace(/\s+/g, '|').slice(0, 90)};
        }
      }
    } catch (err) { report.push({root: name, err: String(err).slice(0, 60)}); }
    return null;
  }
  var r = tryRoot(document, 'main');
  if (r) return JSON.stringify(r);
  var iframes = Array.from(document.querySelectorAll('iframe'));
  for (var k = 0; k < iframes.length; k++) {
    r = tryRoot(iframes[k].contentDocument, 'iframe' + k);
    if (r) return JSON.stringify(r);
  }
  return JSON.stringify({not_found: true, report: report});
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

    # 确保对话框开
    try:
        r0 = tab.run_js('return (function(){return !!document.querySelector(".switch_account_dialog") ? "open" : (function(){var e=document.querySelector(\'div[title="切换账号"]\'); if(e){e.click(); return "opened-now";} return "no-btn";})();})();')
        log({"ensure_dialog": r0})
        time.sleep(3)
    except Exception as e:
        log({"ensure_dialog_err": str(e)[:200]})

    # 跨根点击
    try:
        r = tab.run_js(JS_CLICK_ANYROOT)
        log({"click": r})
        parsed = json.loads(r) if isinstance(r, str) else {}
        if parsed.get("not_found"):
            # 兜底：坐标点 probe7 实测矩形中心 (268+552/2, 325+64/2)
            tab.actions.click(544, 357)
            log({"fallback": "coord_click", "x": 544, "y": 357})
    except Exception as e:
        log({"click_err": str(e)[:300]})
        tab.actions.click(544, 357)
        log({"fallback": "coord_click_after_err"})
    time.sleep(9)

    url = tab.url or ""
    html = tab.html or ""
    m2 = re.search(r"token=(\d{8,})", url)
    am = re.findall(r"(wx[0-9a-f]{16})", html)
    log({"step": "after", "url": url[:140], "token": m2.group(1) if m2 else "",
         "hits": {"总包科技": html.count("总包科技"), "总包AI顾问": html.count("总包AI顾问")},
         "appids": sorted(set(am))[:6], "shot": shot(tab, "after")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
