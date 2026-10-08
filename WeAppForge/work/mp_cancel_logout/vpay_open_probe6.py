# -*- coding: utf-8 -*-
"""vpay_open_probe6 — JS 反查账号菜单开器：可见昵称节点祖先链 + 可见 account 元素矩形。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p6.log"


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


JS = r"""
return (function(){
  var out = {nick_chains: [], vis_account: [], vis_switch: null};
  var nicks = Array.from(document.querySelectorAll('*')).filter(function(e){
    return e.children.length === 0 && (e.textContent === '总包AI顾问' || e.textContent === 'biaoxun');
  });
  nicks.forEach(function(e){
    var chain = [], p = e;
    for (var i = 0; i < 8 && p; i++) {
      chain.push(p.tagName + '.' + (p.className && p.className.toString().slice(0, 60) || ''));
      p = p.parentElement;
    }
    out.nick_chains.push(chain);
  });
  Array.from(document.querySelectorAll('[class*="account"],[class*="menu_box"],[class*="header"]')).forEach(function(e){
    var r = e.getBoundingClientRect();
    if (r.width > 0 && r.height > 0 && r.top < 200) {
      out.vis_account.push({tag: e.tagName, cls: (e.className||'').toString().slice(0, 80),
        x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height),
        txt: (e.textContent||'').trim().slice(0, 40)});
    }
  });
  var sw = document.querySelector('div[title="切换账号"]');
  if (sw) {
    var r2 = sw.getBoundingClientRect();
    out.vis_switch = {x: Math.round(r2.x), y: Math.round(r2.y), w: Math.round(r2.width), h: Math.round(r2.height)};
  }
  return JSON.stringify(out);
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
    try:
        raw = tab.run_js(JS)
        log({"js": json.loads(raw)})
    except Exception as e:
        log({"js_err": str(e)[:400]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
