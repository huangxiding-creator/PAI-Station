# -*- coding: utf-8 -*-
"""vue_probe.py — 挖 Vue 实例与脚本包，找取消注销的 API 端点/开弹窗方法。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

PROBE = """
var r = {};
// 1) Vue 痕迹
r.hasVue2Root = !!(document.querySelector('#app') && document.querySelector('#app').__vue__);
r.keys = Object.keys(window).filter(function (k) { return k.toLowerCase().indexOf('vue') >= 0 || k.indexOf('__') === 0; }).slice(0, 20);
// 2) 找冻结弹窗元素上的 Vue 痕迹（Vue2 元素带 __vue__）
var dlg = document.querySelectorAll('.weui-desktop-dialog__wrp');
r.dlgVues = [];
for (var i = 0; i < dlg.length; i++) {
  var t = (dlg[i].innerText || '').slice(0, 20);
  if (t.indexOf('注销') >= 0 && dlg[i].__vue__) {
    var c = dlg[i].__vue__;
    r.dlgVues.push({tag: c.$options.name || '?', props: Object.keys(c.$props || {}), methods: Object.keys(c.$options.methods || {}).slice(0, 15), data: Object.keys(c.$data || {}).slice(0, 15)});
  }
}
// 3) 取消注销锚点最近的 Vue 组件
var all = document.querySelectorAll('a[data-msgid]');
var a = null;
for (var j = 0; j < all.length; j++) { if ((all[j].getAttribute('data-msgid') || '') === '\\u53d6\\u6d88\\u6ce8\\u9500') { a = all[j]; break; } }
r.anchorFound = !!a;
if (a) {
  var n = a, hops = 0, comp = null;
  while (n && hops < 12) { if (n.__vue__) { comp = n.__vue__; break; } n = n.parentElement; hops++; }
  r.anchorComp = !!comp;
  if (comp) {
    var p = comp, chain = [];
    for (var k2 = 0; k2 < 4 && p; k2++) { chain.push({name: p.$options.name || p.$options._componentTag || '?', methods: Object.keys(p.$options.methods || {}).slice(0, 20)}); p = p.$parent; }
    r.compChain = chain;
  }
}
// 4) 脚本清单
r.scripts = Array.prototype.slice.call(document.querySelectorAll('script[src]')).map(function (s) { return (s.src || '').split('/').pop(); }).slice(0, 25);
return JSON.stringify(r);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(PROBE) or "{}")
    print(json.dumps(r, ensure_ascii=True))


if __name__ == "__main__":
    main()
