# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')

JS = r"""
(function(){
  function walk(root, path, depth, out) {
    if (depth > 5 || !root) return;
    // 收本层文本
    try {
      var txt = ((root.body && root.body.innerText) || '');
      if (txt) out.push(path + ' TEXTLEN=' + txt.length + '\n' + txt.slice(0, 1200));
    } catch (e) {}
    // 穿 shadowRoot
    try {
      var all = root.querySelectorAll ? root.querySelectorAll('*') : [];
      for (var i = 0; i < all.length; i++) {
        if (all[i].shadowRoot) {
          var sr = all[i].shadowRoot;
          var st = ((sr.body && sr.body.innerText) || (sr.textContent || ''));
          out.push(path + '>>SHADOW(' + all[i].tagName + ') LEN=' + st.length + '\n' + String(st).slice(0, 1200));
          walk(sr, path + '>>S', depth + 1, out);
        }
      }
    } catch (e) {}
    // 穿 iframe
    try {
      var ifs = root.querySelectorAll ? root.querySelectorAll('iframe') : [];
      for (var i = 0; i < ifs.length; i++) {
        try { if (ifs[i].contentDocument) walk(ifs[i].contentDocument, path + '>F' + i, depth + 1, out); } catch (e) {}
      }
    } catch (e) {}
  }
  var out = [];
  walk(document, 'S', 0, out);
  if (!out.length) out.push('(empty walk)');
  return out.join('\n=====\n');
})()
"""

for t in page.get_tabs():
    if 'skit/manage/goods' not in (t.url or ''):
        continue
    if 'xframe' in (t.url or ''):
        continue  # xframe 壳页跳过
    try:
        r = t.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
        val = str(r.get('result', {}).get('value', ''))
        print('=== TAB', (t.url or '')[:50])
        print(val[:3500])
        print()
    except Exception as e:
        print('TAB ERR', e)
