# -*- coding: utf-8 -*-
"""vpay_open_probe8 — 点 switch_account_dialog 里「总包科技」条目 → 验证切号成功(wxfdb)。幂等：对话框没开就先开。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p8.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p8_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


JS_CLICK_TECH = r"""
return (function(){
  var items = Array.from(document.querySelectorAll('.switch_account_dialog .account_item, .switch_account_panel .account_item'));
  if (!items.length) return 'no-items';
  for (var i = 0; i < items.length; i++) {
    var t = items[i].textContent || '';
    if (t.indexOf('总包科技') >= 0) {
      items[i].click();
      return 'clicked:' + t.trim().replace(/\s+/g, '|').slice(0, 80);
    }
  }
  return 'not-found:' + items.length;
})();
"""

JS_STATE = r"""
return (function(){
  var dlg = document.querySelector('.switch_account_dialog');
  var its = Array.from(document.querySelectorAll('.switch_account_dialog .account_item')).map(function(e){
    return (e.textContent||'').trim().replace(/\s+/g, '|').slice(0, 90);
  });
  return JSON.stringify({dialog: !!dlg, items: its});
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

    # 幂等：确保对话框开着（没开就 JS 点切换账号）
    try:
        st = json.loads(tab.run_js(JS_STATE))
        log({"dialog_state": st})
        if not st.get("dialog"):
            tab.run_js('return (function(){var e=document.querySelector(\'div[title="切换账号"]\'); if(!e) return "no-el"; e.click(); return "clicked";})();')
            time.sleep(3)
            st = json.loads(tab.run_js(JS_STATE))
            log({"dialog_state2": st})
    except Exception as e:
        log({"state_err": str(e)[:300]})

    # 点总包科技条目
    try:
        r = tab.run_js(JS_CLICK_TECH)
        log({"click_tech": r})
    except Exception as e:
        log({"click_tech_err": str(e)[:300]})
        return 1
    time.sleep(9)  # 切号整页刷新

    url = tab.url or ""
    html = tab.html or ""
    m2 = re.search(r"token=(\d{8,})", url)
    am = re.findall(r"(wx[0-9a-f]{16})", html)
    log({"step": "after_switch", "url": url[:140], "token": m2.group(1) if m2 else "",
         "hits": {"总包科技": html.count("总包科技"), "总包AI顾问": html.count("总包AI顾问")},
         "appids": sorted(set(am))[:6], "shot": shot(tab, "switched")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
