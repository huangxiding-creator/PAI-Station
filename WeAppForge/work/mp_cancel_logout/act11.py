# -*- coding: utf-8 -*-
"""act11.py — 找到挂载态的 httpCancelMiniGameClose 组件，直接调用官方方法。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import DOM_PROBE, INDEX  # noqa: E402

FIND = """
var roots = [];
var els = document.querySelectorAll('*');
var seenRoots = [];
for (var i = 0; i < els.length; i++) {
  var v = els[i].__vue__;
  if (v && v.$root && seenRoots.indexOf(v.$root._uid) < 0) seenRoots.push(v.$root._uid);
}
var uids = seenRoots;
var comps = [];
var found = null;
function walk(c, depth) {
  if (!c || depth > 30 || comps.length > 4000) return;
  comps.push(c);
  if (c.$options && c.$options.methods && c.$options.methods.httpCancelMiniGameClose && !found) found = c;
  var kids = c.$children || [];
  for (var i = 0; i < kids.length; i++) walk(kids[i], depth + 1);
}
// 收集全部根：借任意元素找 root 不全，改用 __vue__ 元素直接记录
var vueEls = [];
for (var j = 0; j < els.length; j++) { if (els[j].__vue__) vueEls.push(els[j].__vue__); }
var rootDone = {};
for (var k = 0; k < vueEls.length; k++) {
  var rt = vueEls[k].$root;
  if (!rt || rootDone[rt._uid]) continue;
  rootDone[rt._uid] = 1;
  walk(rt, 0);
}
if (!found) return JSON.stringify({err: 'not_found', roots: Object.keys(rootDone).length, comps: comps.length});
var info = {name: found.$options.name || '?', comps: comps.length,
  methods: Object.keys(found.$options.methods || {}).slice(0, 30),
  dataKeys: Object.keys(found._data || {}).slice(0, 20),
  elTag: found.$el ? found.$el.tagName + '.' + String(found.$el.className).slice(0, 50) : null};
window.__cancelComp = found;
return JSON.stringify(info);
"""

CALL = """
var c = window.__cancelComp;
if (!c) return JSON.stringify({err: 'no_comp'});
try { c.httpCancelMiniGameClose(); return JSON.stringify({called: true}); }
catch (e) { return JSON.stringify({err: String(e).slice(0, 120)}); }
"""

TOAST = """
var t = document.body.innerText || '';
return JSON.stringify({succ: t.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500\\u6210\\u529f') >= 0,
  fail: t.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500\\u5931\\u8d25') >= 0});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    if "wxamp" not in (tab.url or ""):
        tab.get(INDEX)
        time.sleep(4)

    info = json.loads(tab.run_js(FIND) or "{}")
    out("ACT11_find", info=info)
    if "err" in info:
        return 1

    r = json.loads(tab.run_js(CALL) or "{}")
    out("ACT11_called", r=r, shot=shot(tab, "act11_called"))
    time.sleep(4)
    toast = json.loads(tab.run_js(TOAST) or "{}")
    out("ACT11_toast", toast=toast, shot=shot(tab, "act11_toast"))

    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT11_STILL_PRESENT", verify=v, toast=toast,
        url=(tab.url or "")[:140], shot=shot(tab, "act11_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
