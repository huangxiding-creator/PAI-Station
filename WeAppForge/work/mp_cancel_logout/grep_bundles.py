# -*- coding: utf-8 -*-
"""grep_bundles.py — 全 bundle 关键词搜索：forbid 弹窗的接线与取消注销 @click。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

GREP = """
async function main() {
  var srcs = Array.prototype.slice.call(document.querySelectorAll('script[src]')).map(function (x) { return x.src; })
    .filter(function (u) { return u.indexOf('.js') > 0 && u.indexOf('TCaptcha') < 0 && u.indexOf('wxtelsdk') < 0; });
  var words = ['\\u81ea\\u4e3b\\u6ce8\\u9500\\u6d41\\u7a0b', '\\u5269\\u4f59\\u51bb\\u7ed3\\u671f',
               'weapp_forbid_dialog', 'dialogForbid', 'SET_DIALOG_FORBID'];
  var results = [];
  var pending = [];
  for (var i = 0; i < srcs.length; i++) {
    pending.push(fetch(srcs[i]).then(function (resp) { return resp.text(); }).then(function (txt) {
      return txt;
    }).catch(function () { return ''; }));
  }
  var texts = await Promise.all(pending);
  for (var t = 0; t < texts.length; t++) {
    var txt = texts[t];
    if (!txt) continue;
    for (var w = 0; w < words.length; w++) {
      var word = words[w];
      var idx = txt.indexOf(word);
      var count = 0;
      while (idx >= 0 && count < 3) {
        results.push({bundle: srcs[t].split('/').pop(), word: word, pos: idx,
          ctx: txt.substr(Math.max(0, idx - 200), 450)});
        count++;
        idx = txt.indexOf(word, idx + 1);
      }
    }
  }
  return JSON.stringify({n: results.length, results: results.slice(0, 14)});
}
return main();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(GREP, timeout=90) or "{}")
    print(json.dumps(r, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
