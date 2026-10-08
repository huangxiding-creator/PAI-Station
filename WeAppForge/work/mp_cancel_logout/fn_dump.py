# -*- coding: utf-8 -*-
"""fn_dump.py — 读活组件方法源码：forbid 弹窗取消注销的真实调用链。"""
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
var idx = null, mpd = null;
for (var k = 0; k < vueEls.length; k++) {
  var c = vueEls[k];
  var nm = c.$options.name || '';
  var cls = c.$el ? String(c.$el.className) : '';
  if (!idx && c.$options.methods && c.$options.methods.httpCancelMiniGameClose) idx = c;
  if (!mpd && nm === 'mp-dialog') mpd = c;
}
function src(f) { try { return String(f).slice(0, 700); } catch (e) { return 'ERR'; } }
if (idx) {
  out.index_name = idx.$options.name;
  out.onClickForbid = src(idx.onClickForbid);
  out.handleChangeDialog = src(idx.handleChangeDialog);
  out.getPunishRecordInfo = src(idx.getPunishRecordInfo);
}
if (mpd) {
  out.mpd_ok = src(mpd.ok);
  out.mpd_onClick = src(mpd.onClick);
  out.mpd_dispatch = src(mpd.dispatch);
  out.mpd_visible = mpd._data.visible;
  // mp-dialog 的父组件监听
  var p = mpd.$parent;
  out.mpd_parent = p ? (p.$options.name || '?') : null;
  // slot 里取消注销锚点的事件绑定（vnode data.on）
  var vn = mpd._vnode;
  var found = [];
  function walkVnode(v, d) {
    if (!v || d > 30 || found.length > 4) return;
    if (v.elm && v.elm.tagName === 'A' && (v.elm.innerText || '').trim() === '\\u53d6\\u6d88\\u6ce8\\u9500') {
      found.push({on: v.data && v.data.on ? Object.keys(v.data.on) : [], attrs: v.data && v.data.attrs ? v.data.attrs : {},
        handlers: v.data && v.data.on ? Object.keys(v.data.on).map(function (k2) { return k2 + ':' + src(v.data.on[k2]); }) : []});
    }
    if (v.children) for (var i = 0; i < v.children.length; i++) walkVnode(v.children[i], d + 1);
    if (v.componentOptions && v.componentInstance) walkVnode(v.componentInstance._vnode, d + 1);
  }
  walkVnode(vn, 0);
  out.anchor_vnodes = found;
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
