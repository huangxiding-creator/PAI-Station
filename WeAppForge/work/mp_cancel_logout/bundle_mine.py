# -*- coding: utf-8 -*-
"""bundle_mine.py — __INITIAL_STATE__ + 逐 bundle 搜「取消注销」API 端点。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

MINE = """
async function main() {
  var r = {state: null, bundles: []};
  try {
    var s = window.__INITIAL_STATE__ || null;
    if (s) {
      var j = JSON.stringify(s);
      var hit = j.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500') >= 0 || j.indexOf('\\u51bb\\u7ed3') >= 0 || j.toLowerCase().indexOf('forbid') >= 0;
      r.state = {len: j.length, hit: hit, keys: Object.keys(s).slice(0, 30)};
      if (hit) {
        for (var k in s) {
          var kj = JSON.stringify(s[k]) || '';
          if (kj.indexOf('\\u51bb\\u7ed3') >= 0 || kj.toLowerCase().indexOf('forbid') >= 0 || kj.indexOf('\\u6ce8\\u9500') >= 0) {
            r['state_' + k] = kj.slice(0, 500);
          }
        }
      }
    }
  } catch (e) { r.state = {err: String(e).slice(0, 60)}; }
  var srcs = Array.prototype.slice.call(document.querySelectorAll('script[src]')).map(function (x) { return x.src; })
    .filter(function (u) { return u.indexOf('.js') > 0 && u.indexOf('TCaptcha') < 0; });
  var words = ['\\u53d6\\u6d88\\u6ce8\\u9500', '\\u81ea\\u4e3b\\u6ce8\\u9500'];
  for (var i = 0; i < srcs.length; i++) {
    try {
      var resp = await fetch(srcs[i]);
      var txt = await resp.text();
      var found = null;
      for (var w = 0; w < words.length && !found; w++) {
        var raw = txt.indexOf(words[w]);
        var esc = txt.indexOf(unescape(words[w].replace(/\\\\u/g, '%u')));
        if (raw >= 0) found = {word: words[w], form: 'raw', ctx: txt.substr(Math.max(0, raw - 260), 480)};
        else if (txt.indexOf(words[w]) >= 0) found = {word: words[w], form: 'esc', ctx: txt.substr(Math.max(0, txt.indexOf(words[w]) - 260), 480)};
      }
      if (found) r.bundles.push({url: srcs[i].split('/').pop(), kb: Math.round(txt.length / 1024), found: found});
    } catch (e) { /* skip */ }
  }
  return JSON.stringify(r);
}
return main();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = tab.run_js(MINE, timeout=60)
    print(r if isinstance(r, str) else json.dumps(r, ensure_ascii=True))


if __name__ == "__main__":
    main()
