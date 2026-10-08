# -*- coding: utf-8 -*-
"""vue_walk.py — 遍历 Vue 组件树，定位注销弹窗组件与其方法/数据/事件。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

WALK = """
var root = document.querySelector('#app') && document.querySelector('#app').__vue__;
if (!root) return JSON.stringify({err: 'no_root'});
var hits = [];
var seen = 0;
function walk(c, depth) {
  if (!c || seen > 3000 || depth > 25) return;
  seen++;
  var name = c.$options.name || c.$options._componentTag || '';
  var methods = Object.keys(c.$options.methods || {});
  var dataK = Object.keys(c._data || {});
  var html = '';
  try { html = (c.$el && c.$el.innerHTML) ? c.$el.innerHTML.slice(0, 4000) : ''; } catch (e) {}
  var hasCancel = html.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500') >= 0;
  var hasForbid = html.indexOf('forbid') >= 0 || html.indexOf('\\u51bb\\u7ed3') >= 0;
  var nm = (name + '|' + methods.join(',')).toLowerCase();
  var nameHit = nm.indexOf('cancel') >= 0 || nm.indexOf('forbid') >= 0 || nm.indexOf('logout') >= 0 || nm.indexOf('zhuxiao') >= 0;
  if (hasCancel || nameHit) {
    hits.push({name: name, depth: depth, hasCancelHtml: hasCancel,
      methods: methods.slice(0, 25), data: dataK.slice(0, 20),
      elTag: c.$el ? c.$el.tagName + '.' + String(c.$el.className).slice(0, 40) : null,
      visible: !!(c.$el && c.$el.offsetWidth > 0)});
  }
  var kids = c.$children || [];
  for (var i = 0; i < kids.length; i++) walk(kids[i], depth + 1);
}
walk(root, 0);
return JSON.stringify({seen: seen, hits: hits.slice(0, 12)});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(WALK) or "{}")
    print(json.dumps(r, ensure_ascii=True))


if __name__ == "__main__":
    main()
