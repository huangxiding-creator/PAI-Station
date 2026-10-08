# -*- coding: utf-8 -*-
"""vpay_open_probe11 — 找「支付与交易/虚拟支付」菜单真入口 href（主文档+iframe 跨根）。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

OUT = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_vopen_p11.log"

JS = r"""
return (function(){
  function collect(doc, root){
    var out = [];
    try {
      Array.from(doc.querySelectorAll('a, [data-msgid], .menu_item, [class*="menu"]')).forEach(function(e){
        var t = (e.textContent||'').trim();
        if (/虚拟支付|支付与交易|微信支付/.test(t) && t.length < 30) {
          out.push({root: root, tag: e.tagName, text: t.slice(0, 24),
                    href: (e.getAttribute('href')||'').slice(0, 150),
                    cls: (e.className||'').toString().slice(0, 50)});
        }
      });
    } catch (err) {}
    return out;
  }
  var all = collect(document, 'main');
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    try { all = all.concat(collect(f.contentDocument, 'iframe' + i)); } catch(err) {}
  });
  return JSON.stringify(all.slice(0, 40));
})();
"""


def log(obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(OUT, "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


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
    try:
        log({"menu_links": json.loads(tab.run_js(JS))})
    except Exception as e:
        log({"js_err": str(e)[:300]})

    # HTML 原文兜底：搜「虚拟支付」周边 ±400
    html = tab.html or ""
    for m2 in list(re.finditer("虚拟支付", html))[:4]:
        i = m2.start()
        log({"raw_ctx": html[max(0, i - 400):i + 400]})
    return 0


if __name__ == "__main__":
    sys.exit(main())
