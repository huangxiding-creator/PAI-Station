# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

JS = r"""
(function(){
  var hits = [];
  function walk(el, path, depth) {
    if (depth > 8 || hits.length > 20) return;
    var kids = [];
    try { kids = el.children || []; } catch (e) { return; }
    for (var i = 0; i < kids.length; i++) {
      var k = kids[i];
      var tag = (k.tagName || '').toLowerCase();
      if (!tag) continue;
      var p2 = path + '/' + tag + '[' + i + ']';
      // 该子树是否含目标词（用 textContent 快筛）
      var tc = '';
      try { tc = k.textContent || ''; } catch (e) {}
      if (tc.indexOf('编辑道具') >= 0 || tc.indexOf('道具管理') >= 0) {
        var own = '';
        for (var j = 0; j < k.childNodes.length; j++) {
          var n = k.childNodes[j];
          if (n.nodeType === 3) own += n.nodeValue;
        }
        hits.push(p2 + ' own="' + own.trim().slice(0, 30) + '" tcLen=' + tc.length);
        // 继续下钻（更深命中更有定位价值）
      }
      if (k.shadowRoot) {
        walk(k.shadowRoot, p2 + '>>SHADOW', depth + 1);
      }
      walk(k, p2, depth + 1);
    }
  }
  walk(document, '', 0);
  return hits.slice(0, 20).join('\n') || 'NO HIT';
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(r.get('result', {}).get('value', ''))[:3000])
