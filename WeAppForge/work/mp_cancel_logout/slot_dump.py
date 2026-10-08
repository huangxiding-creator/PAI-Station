# -*- coding: utf-8 -*-
"""slot_dump.py — msg 组件 slot 里取消注销锚点 vnode 的事件绑定与处理器源码。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

DUMP = """
var out = {};
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
out.msg_parent = msg.$parent ? (msg.$parent.$options.name || '?') : null;
out.parent_methods = msg.$parent ? Object.keys(msg.$parent.$options.methods || {}) : [];
var found = [];
function walkVnode(v, d) {
  if (!v || d > 40 || found.length > 3) return;
  var isAnchor = v.elm && v.elm.tagName === 'A' && (v.elm.innerText || '').trim() === '\\u53d6\\u6d88\\u6ce8\\u9500';
  var isAnchor2 = v.elm && v.elm.getAttribute && (v.elm.getAttribute('data-msgid') || '') === '\\u53d6\\u6d88\\u6ce8\\u9500';
  if (isAnchor || isAnchor2) {
    var on = (v.data && v.data.on) || {};
    var evs = {};
    for (var k2 in on) { try { evs[k2] = String(on[k2]).slice(0, 500); } catch (e) { evs[k2] = 'ERR'; } }
    found.push({events: Object.keys(on), handlers: evs, attrs: (v.data && v.data.attrs) || {}});
  }
  if (v.children) for (var i = 0; i < v.children.length; i++) walkVnode(v.children[i], d + 1);
}
var slots = (msg.$slots && msg.$slots.default) || [];
for (var s = 0; s < slots.length; s++) walkVnode(slots[s], 0);
if (!found.length && msg._vnode) walkVnode(msg._vnode, 0);
out.found = found;
return JSON.stringify(out);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(DUMP) or "{}")
    print(json.dumps(r, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
