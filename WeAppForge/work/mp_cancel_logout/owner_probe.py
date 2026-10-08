# -*- coding: utf-8 -*-
"""owner_probe.py — 探 wxaacctclose 归属 + 找冻结弹窗的属主组件。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

QUERY = """
async function main() {
  try {
    var resp = await fetch('/publicpoc/wxaacctclose?action=querycloseinfo&token=91558662&lang=zh_CN', {
      method: 'GET', credentials: 'same-origin'
    });
    var text = await resp.text();
    return JSON.stringify({status: resp.status, body: text.slice(0, 400)});
  } catch (e) { return JSON.stringify({err: String(e).slice(0, 120)}); }
}
return main();
"""

OWNER = """
var els = document.querySelectorAll('*');
var vueEls = [];
for (var j = 0; j < els.length; j++) { if (els[j].__vue__) vueEls.push(els[j].__vue__); }
var owners = [];
for (var k = 0; k < vueEls.length; k++) {
  var c = vueEls[k];
  var html = '';
  try { html = c.$el ? (c.$el.innerHTML || '') : ''; } catch (e) { continue; }
  if (html.indexOf('\\u81ea\\u4e3b\\u6ce8\\u9500\\u6d41\\u7a0b') >= 0) {
    var r = {name: c.$options.name || '?', tag: c.$el.tagName + '.' + String(c.$el.className).slice(0, 40),
      methods: Object.keys(c.$options.methods || {}).slice(0, 25),
      data: Object.keys(c._data || {}).slice(0, 15)};
    // 弹窗显隐数据态
    if (c._data && typeof c._data.dialogForbid !== 'undefined') r.dialogForbid = c._data.dialogForbid;
    if (c._data && typeof c._data.dialogMiniGameFreeze !== 'undefined') r.mgf = c._data.dialogMiniGameFreeze;
    owners.push(r);
    if (owners.length >= 5) break;
  }
}
return JSON.stringify({n: owners.length, owners: owners});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    q = json.loads(tab.run_js(QUERY, timeout=30) or "{}")
    o = json.loads(tab.run_js(OWNER) or "{}")
    print(json.dumps({"querycloseinfo": q, "owners": o}, ensure_ascii=True))


if __name__ == "__main__":
    main()
