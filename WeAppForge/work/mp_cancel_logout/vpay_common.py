# -*- coding: utf-8 -*-
"""vpay_common — wxfdb 虚拟支付开通战役公共件（9336 通道 + wujie shadow DOM 工具）。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

TAG = "_vpay"
WANT_APPID = "wxfdb55b184756e89e"


def log(tag, obj):
    line = json.dumps(obj, ensure_ascii=False)
    print(line)
    with open(rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\{TAG}_{tag}.log", "a", encoding="utf-8") as f:
        f.write(time.strftime("[%H:%M:%S] ") + line + "\n")


def shot(tab, tag):
    try:
        p = rf"E:\AI-Station\WeAppForge\work\mp_cancel_logout\{TAG}_{tag}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=p)
        return p
    except Exception:
        return ""


def fresh_page():
    """先扫全 tab 找 wxfdb(总包科技) 活会话；找不到再导航重取。返回 (page, tab, token)。"""
    page = attach_or_launch()
    # 1) 现有 tab 里找 wxfdb 会话
    try:
        for t in page.get_tabs():
            u = t.url or ""
            m = re.search(r"token=(\d{8,})", u)
            if not m or "mp.weixin.qq.com" not in u:
                continue
            html = t.html or ""
            if "总包科技" in html or WANT_APPID in html:
                # 回家页刷新会话（带原 token），身份仍在则用
                t.get(f"https://mp.weixin.qq.com/wxamp/index/index?token={m.group(1)}&lang=zh_CN")
                time.sleep(3.5)
                m2 = re.search(r"token=(\d{8,})", t.url or "") or re.search(r"token=(\d{8,})", t.html or "")
                html2 = t.html or ""
                if m2 and ("总包科技" in html2 or WANT_APPID in html2):
                    return page, t, m2.group(1)
    except Exception:
        pass
    # 2) 兜底：无 token 导航
    tab = page.latest_tab
    tab.get("https://mp.weixin.qq.com/wxamp/index/index?lang=zh_CN")
    time.sleep(4)
    url = tab.url or ""
    m = re.search(r"token=(\d{8,})", url)
    if not m:
        html = tab.html or ""
        m = re.search(r"token=(\d{8,})", html)
    if not m:
        return page, tab, ""
    return page, tab, m.group(1)


def ensure_tech(tab):
    """验当前号=总包科技(wxfdb)。"""
    html = tab.html or ""
    am = set(re.findall(r"(wx[0-9a-f]{16})", html))
    return WANT_APPID in am or "总包科技" in html


JS_GOTO_SKIT = 'return (function(){var a=document.querySelector(\'a[href*="subApp/skit"]\'); if(a){a.click(); return "clicked";} return "no-link";})();'

JS_PIERCE_DUMP = r"""
return (function(){
  var out = {vis: [], urls: []};
  function own(e){
    return Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;})
      .map(function(n){return n.nodeValue.trim();}).join(' ').trim();
  }
  function walk(root, where){
    try {
      Array.from(root.querySelectorAll('button, a, input, label, [class*=btn], [class*=check], h1,h2,h3,h4, [class*=step], [class*=title]')).forEach(function(e){
        var o = own(e) || (e.placeholder || '') || (e.value || '');
        if (!o) return;
        var r = e.getBoundingClientRect();
        if (r.width > 0 && r.height > 0) {
          out.vis.push({w: where, tag: e.tagName, cls: (e.className||'').toString().slice(0, 36),
                        txt: o.slice(0, 50), x: Math.round(r.x), y: Math.round(r.y),
                        h: Math.round(r.height), type: e.type || ''});
        }
      });
      Array.from(root.querySelectorAll('*')).forEach(function(e){
        if (e.shadowRoot) walk(e.shadowRoot, where + '/shadow:' + e.tagName);
      });
    } catch (err) {}
  }
  walk(document, 'doc');
  Array.from(document.querySelectorAll('iframe')).forEach(function(f, i){
    try { if (f.contentDocument) walk(f.contentDocument, 'if' + i); } catch(err) {}
  });
  return JSON.stringify(out);
})();
"""

JS_CLICK_SHADOW = r"""
return (function(){
  var MODE = %MODE%;
  var MATCH = %MATCH%;
  function own(e){
    return Array.prototype.filter.call(e.childNodes, function(n){return n.nodeType===3;})
      .map(function(n){return n.nodeValue.trim();}).join(' ').trim();
  }
  function walk(root){
    try {
      var els = Array.from(root.querySelectorAll(MODE === 1 ? 'button' : (MODE === 2 ? 'button, a, div[class*=btn], span' : '*')));
      for (var i = 0; i < els.length; i++) {
        var o = own(els[i]) || els[i].getAttribute && (els[i].getAttribute('title') || '') || '';
        if (o && o.indexOf(MATCH) >= 0 && o.length <= MATCH.length + 12) {
          var r = els[i].getBoundingClientRect();
          if (r.width > 0) { els[i].click(); return 'clicked:' + o.slice(0, 30) + '@' + Math.round(r.x) + ',' + Math.round(r.y); }
        }
      }
      var kids = [];
      try { kids = Array.from(root.querySelectorAll('*')); } catch(err) {}
      for (var j = 0; j < kids.length; j++) {
        if (kids[j].shadowRoot) { var r2 = walk(kids[j].shadowRoot); if (r2) return r2; }
      }
    } catch (err) {}
    return null;
  }
  try { return walk(document) || 'not-found'; } catch (err) { return String(err).slice(0, 120); }
})();
"""


def click_shadow(tab, match, mode=1):
    js = JS_CLICK_SHADOW.replace("%MODE%", str(mode)).replace("%MATCH%", json.dumps(match, ensure_ascii=False))
    return tab.run_js(js)


def pierce_dump(tab):
    return tab.run_js(JS_PIERCE_DUMP)
