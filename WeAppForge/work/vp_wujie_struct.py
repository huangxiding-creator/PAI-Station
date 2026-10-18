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
  var wj = document.querySelector('wujie-app');
  if (!wj || !wj.shadowRoot) return 'no wujie shadow';
  var sr = wj.shadowRoot;
  function sig(el, depth) {
    var t = el.tagName ? el.tagName.toLowerCase() : '#node';
    var id = el.id ? '#' + el.id : '';
    var cls = (typeof el.className === 'string' && el.className) ? '.' + el.className.split(/\s+/).slice(0, 3).join('.') : '';
    var ownText = '';
    if (el.tagName) {
      var own = '';
      for (var i = 0; i < el.childNodes.length; i++) {
        var n = el.childNodes[i];
        if (n.nodeType === 3) own += n.nodeValue;
      }
      ownText = own.trim().slice(0, 40);
    }
    var line = '  '.repeat(depth) + t + id + cls + (ownText ? ' "' + ownText + '"' : '');
    var out = [line];
    var kids = el.children || [];
    for (var i = 0; i < kids.length && i < 30; i++) {
      out = out.concat(sig(kids[i], depth + 1));
    }
    return out;
  }
  var lines = sig(sr, 0).slice(0, 80);
  return lines.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(r.get('result', {}).get('value', ''))[:4000])
