# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')

JS = r"""
(function(){
  function findWj(root, path, out, depth) {
    if (depth > 5) return;
    var wjs = root.querySelectorAll ? root.querySelectorAll('wujie-app') : [];
    for (var i = 0; i < wjs.length; i++) {
      var sr = wjs[i].shadowRoot;
      if (!sr) { out.push(path + ' wujie-app[' + i + '] NO-SHADOW'); continue; }
      var app = sr.querySelector('#app');
      var appKids = app ? app.children.length : -1;
      var body = sr.querySelector('body');
      var bt = body ? (body.innerText || '').slice(0, 200).replace(/\n/g, '|') : '(nobody)';
      out.push(path + ' wujie-app[' + i + '] appKids=' + appKids + ' body="' + bt + '"');
      // 深入该 shadow 继续找嵌套 wujie
      findWj(sr, path + '/wj' + i, out, depth + 1);
    }
  }
  var out = [];
  findWj(document, 'S', out, 0);
  return out.join('\n');
})()
"""

for t in page.get_tabs():
    if 'skit/manage/goods' not in (t.url or ''):
        continue
    try:
        r = t.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
        print('=== TAB', (t.url or '')[:55])
        print(str(r.get('result', {}).get('value', ''))[:1200])
        print()
    except Exception as e:
        print('TAB ERR', e)
