# -*- coding: utf-8 -*-
"""render_dump.py — storeNoticePanel/属主组件 render 源码 + 锚点最近 Vue 祖先。"""
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
// 1) storeNoticePanel
var snp = null;
for (var k = 0; k < vueEls.length; k++) { if ((vueEls[k].$options.name || '') === 'storeNoticePanel') { snp = vueEls[k]; break; } }
if (snp) {
  out.snp_methods = Object.keys(snp.$options.methods || {});
  out.snp_data = Object.keys(snp._data || {});
  try { out.snp_render = String(snp.$options.render).slice(0, 3000); } catch (e) { out.snp_render = 'ERR'; }
  try { out.snp_static = JSON.stringify(snp.$options.staticRenderFns ? snp.$options.staticRenderFns.length : 0); } catch (e) {}
}
// 2) 取消注销锚点的最近 Vue 祖先
var anchor = null;
var aa = document.querySelectorAll('a');
for (var i2 = 0; i2 < aa.length; i2++) { if ((aa[i2].getAttribute('data-msgid') || '') === '\\u53d6\\u6d88\\u6ce8\\u9500') { anchor = aa[i2]; break; } }
out.anchor = !!anchor;
if (anchor) {
  var n = anchor.parentElement, comp = null, hops = 0;
  while (n && hops < 40) { if (n.__vue__) { comp = n.__vue__; break; } n = n.parentElement; hops++; }
  out.anchor_owner = comp ? (comp.$options.name || '?') : null;
  if (comp) {
    out.owner_methods = Object.keys(comp.$options.methods || {}).slice(0, 30);
    try { out.owner_render_has_cancel = String(comp.$options.render).indexOf('cancel') >= 0; } catch (e) {}
    try {
      var rs = String(comp.$options.render);
      var ci = rs.indexOf('cancel');
      out.owner_render_ctx = ci >= 0 ? rs.substr(Math.max(0, ci - 400), 900) : null;
    } catch (e) {}
  }
}
return JSON.stringify(out);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(DUMP) or "{}")
    print(json.dumps(r, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
