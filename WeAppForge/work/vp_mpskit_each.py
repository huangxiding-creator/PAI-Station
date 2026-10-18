# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
subs = [t for t in page.get_tabs() if 'subApp/skit/manage/goods' in (t.url or '')]

JS = r"""
(function(){
  var out = [];
  function walk(root, path, depth) {
    if (depth > 4) return;
    var all = root.querySelectorAll ? root.querySelectorAll('*') : [];
    for (var i = 0; i < all.length; i++) {
      var el = all[i];
      if (el.shadowRoot) {
        var sr = el.shadowRoot;
        var app = sr.querySelector('#app') || sr.querySelector('body') || sr;
        var txt = '';
        try { txt = app.innerText || ''; } catch (e) {}
        out.push(path + ' SHADOW[' + el.tagName + '] kids=' + (app.children ? app.children.length : -1) + ' txtLen=' + txt.length);
        if (txt.length > 10) out.push('TEXT: ' + txt.slice(0, 1200));
        walk(sr, path + '/S', depth + 1);
      }
    }
    var ifs = root.querySelectorAll ? root.querySelectorAll('iframe') : [];
    for (var i = 0; i < ifs.length; i++) {
      try { if (ifs[i].contentDocument) walk(ifs[i].contentDocument, path + '/F' + i, depth + 1); } catch (e) {}
    }
  }
  walk(document, '', 0);
  return out.join('\n') || 'EMPTY';
})()
"""

for idx, tab in enumerate(subs):
    tree = tab.run_cdp('Page.getFrameTree').get('frameTree', {})
    frames = []
    def w(node):
        f = node.get('frame', {})
        frames.append((f.get('name') or '', f.get('id')))
        for c in node.get('childFrames', []):
            w(c)
    w(tree)
    mp = [fid for name, fid in frames if name == 'mpskit']
    print('=== TAB', idx, 'frames:', [(n, i[:8]) for n, i in frames])
    if not mp:
        print('  no mpskit frame')
        continue
    try:
        wo = tab.run_cdp('Page.createIsolatedWorld', frameId=mp[0], grantUniversalAccess=True)
        ctx = wo.get('executionContextId')
        r = tab.run_cdp('Runtime.evaluate', expression=JS, contextId=ctx, returnByValue=True)
        val = str(r.get('result', {}).get('value', ''))
        print('  mpskit:', val[:1500].replace('\n', '\n  '))
    except Exception as e:
        print('  ERR', str(e)[:150])
    print()
