# -*- coding: utf-8 -*-
"""fns_dump.py — 锚点 vnode click.fns 真身源码。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

DUMP = """
var els = document.querySelectorAll('*');
var vueEls = [];
for (var j = 0; j < els.length; j++) { if (els[j].__vue__) vueEls.push(els[j].__vue__); }
var msg = null;
for (var k = 0; k < vueEls.length; k++) {
  var c = vueEls[k];
  if ((c.$options.name || '') !== 'msg') continue;
  var h = '';
  try { h = c.$el ? (c.$el.innerHTML || '') : ''; } catch (e) { continue; }
  if (h.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500') >= 0) { msg = c; break; }
}
if (!msg) return JSON.stringify({err: 'no_msg'});
var found = null;
function walkVnode(v, d) {
  if (!v || d > 40 || found) return;
  var mid = v.elm && v.elm.getAttribute ? (v.elm.getAttribute('data-msgid') || '') : '';
  if (v.elm && v.elm.tagName === 'A' && mid === '\\u53d6\\u6d88\\u6ce8\\u9500') { found = v; return; }
  if (v.children) for (var i = 0; i < v.children.length; i++) { walkVnode(v.children[i], d + 1); if (found) return; }
}
var slots = (msg.$slots && msg.$slots.default) || [];
for (var s = 0; s < slots.length && !found; s++) walkVnode(slots[s], 0);
if (!found && msg._vnode) walkVnode(msg._vnode, 0);
if (!found) return JSON.stringify({err: 'no_vnode'});
var on = (found.data && found.data.on) || {};
var fns = on.click && on.click.fns;
var src = '';
if (Array.isArray(fns)) src = fns.map(function (f) { return String(f).slice(0, 800); }).join('\\n----\\n');
else src = String(fns).slice(0, 900);
return JSON.stringify({fns_src: src});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(DUMP) or "{}")
    print(json.dumps(r, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
