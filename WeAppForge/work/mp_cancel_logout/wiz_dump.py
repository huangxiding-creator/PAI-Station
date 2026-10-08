# -*- coding: utf-8 -*-
"""wiz_dump.py — 9336 控制台取证小工具（避免 bash 内联转义坑）。
用法: python wiz_dump.py <mode> [arg]
  appeal     — 读 appealDetail 页正文（学园 code_ban）
  switcher   — 在控制台首页找小程序切换器
  switch     — 点切换器里的总包AI顾问
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

MODE = sys.argv[1] if len(sys.argv) > 1 else "appeal"
ARG = sys.argv[2] if len(sys.argv) > 2 else ""

page = attach_or_launch()


def pick(url_kw, token_kw=""):
    for tid in page.tab_ids:
        t = page.get_tab(tid)
        u = t.url or ""
        if url_kw in u and (not token_kw or token_kw in u):
            return t
    return None


JS = {}

JS["appeal"] = r"""
var body = (document.body.innerText || '');
body = body.replace(/\s+\n/g, '\n').replace(/\n{2,}/g, '\n');
return JSON.stringify({len: body.length, text: body.slice(0, 1800)});
"""

JS["switcher"] = r"""
var out = {url: location.href.slice(0, 90), appname: [], switches: []};
var logo = document.querySelector('.header_logo, .header_logo_text, [class*=logo]');
if (logo) out.appname.push(logo.textContent.replace(/\s+/g, ' ').trim().slice(0, 40));
// 常见切换器：含「切换」或下拉箭头的头部元素
var els = document.querySelectorAll('div, span, a, button');
for (var i = 0; i < els.length; i++) {
  var t = (els[i].textContent || '').replace(/\s+/g, ' ').trim();
  if (!t || t.length > 30) continue;
  if (t.indexOf('切换') >= 0 || t.indexOf('小程序信息') >= 0) {
    var r = els[i].getBoundingClientRect();
    if (r.width > 0) out.switches.push({t: t, tag: els[i].tagName, cls: (els[i].className || '').toString().slice(0, 50)});
  }
}
return JSON.stringify(out);
"""

JS["switch"] = r"""
// 展开切换器（header logo 区点击）→ 找「总包AI」条目点击
var logo = document.querySelector('.header_logo');
if (!logo) return JSON.stringify({step: 'logo', ok: false});
logo.click();
return JSON.stringify({step: 'logo_clicked'});
"""

JS["appeal2"] = r"""
function deepText(doc, depth, acc) {
  if (!doc || depth > 3) return acc;
  try {
    var b = doc.body ? (doc.body.innerText || '') : '';
    if (b.length > acc.len) { acc.len = b.length; acc.text = b; }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var i = 0; i < frs.length; i++) deepText(frs[i].contentDocument, depth + 1, acc);
  } catch (e) {}
  return acc;
}
var acc = deepText(document, 0, {len: 0, text: ''});
acc.text = acc.text.replace(/\n{2,}/g, ' ~ ');
return JSON.stringify({len: acc.len, text: acc.text.slice(0, 1800), url: location.href.slice(0, 100)});
"""

if MODE == "appeal":
    tab = pick("appealDetail")
    if not tab:
        print(json.dumps({"tab": False}))
        raise SystemExit(1)
    time.sleep(2)
    js = JS.get("appeal2") if ARG == "deep" else JS["appeal"]
    if ARG == "deep":
        time.sleep(4)
    print(tab.run_js("return (function(){" + js + "})()"))
    shot(tab, "appeal_text")
elif MODE == "switcher":
    tab = pick("/wxamp/index/index", "<TOKEN-wxfdb>")
    if not tab:
        tab = pick("/wxamp/index/index")
    if not tab:
        print(json.dumps({"tab": False}))
        raise SystemExit(1)
    print(tab.run_js("return (function(){" + JS["switcher"] + "})()"))
    shot(tab, "switcher")
elif MODE == "switch":
    tab = pick("/wxamp/index/index", "<TOKEN-wxfdb>") or pick("/wxamp/index/index")
    if not tab:
        print(json.dumps({"tab": False}))
        raise SystemExit(1)
    print(tab.run_js("return (function(){" + JS["switch"] + "})()"))
    time.sleep(2)
    # 点开后 dump 菜单条目
    print(tab.run_js(r"""
return JSON.stringify((function(){
  var out = [];
  var els = document.querySelectorAll('div, span, a, li, button');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].textContent || '').replace(/\s+/g, ' ').trim();
    if (!t || t.length > 20) continue;
    if (t.indexOf('总包') >= 0 || t.indexOf('AI') >= 0 || t.indexOf('学园') >= 0 || t.indexOf('说科技') >= 0) {
      var r = els[i].getBoundingClientRect();
      if (r.width > 0 && r.height > 0) out.push({t: t.slice(0, 24), tag: els[i].tagName, cls: (els[i].className || '').toString().slice(0, 40)});
    }
  }
  return out.slice(0, 15);
})());
"""))
    shot(tab, "switch_menu")
else:
    print("unknown mode")
