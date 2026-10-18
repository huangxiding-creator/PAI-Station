# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

f = tab.get_frame('mpskit')
JS = r"""
(function(){
  var out = [];
  function walk(root, path, depth) {
    if (depth > 5) return;
    var all = root.querySelectorAll ? root.querySelectorAll('*') : [];
    for (var i = 0; i < all.length; i++) {
      var el = all[i];
      if (el.shadowRoot) {
        var sr = el.shadowRoot;
        var app = sr.querySelector('#app') || sr.querySelector('body');
        var kids = app ? app.children.length : -1;
        var txt = '';
        try { txt = (app && app.innerText) || ''; } catch (e) {}
        out.push(path + ' ' + el.tagName + '->shadow appKids=' + kids + ' txtLen=' + txt.length);
        if (txt) out.push('TEXT: ' + txt.slice(0, 1800));
        walk(sr, path + '/' + el.tagName + 'S', depth + 1);
      }
    }
    var ifs = root.querySelectorAll ? root.querySelectorAll('iframe') : [];
    for (var i = 0; i < ifs.length; i++) {
      try { if (ifs[i].contentDocument) walk(ifs[i].contentDocument, path + '/F' + i, depth + 1); } catch (e) {}
    }
  }
  out.push('SELF bodyKids=' + document.body.children.length);
  walk(document, '', 0);
  return out.join('\n');
})()
"""
print(str(f.run_js('return ' + JS))[:3000])
