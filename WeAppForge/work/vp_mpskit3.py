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

# 全量 frame id
tree = tab.run_cdp('Page.getFrameTree').get('frameTree', {})
mp_id = None
def walk(node):
    global mp_id
    f = node.get('frame', {})
    if (f.get('name') or '') == 'mpskit':
        mp_id = f.get('id')
    for c in node.get('childFrames', []):
        walk(c)
walk(tree)
print('mpskit frameId =', mp_id)

w = tab.run_cdp('Page.createIsolatedWorld', frameId=mp_id, grantUniversalAccess=True)
ctx = w.get('executionContextId')
print('ctx =', ctx)

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
        if (txt) out.push('TEXT: ' + txt.slice(0, 2000));
        walk(sr, path + '/' + el.tagName + 'S', depth + 1);
      }
    }
    var ifs = root.querySelectorAll ? root.querySelectorAll('iframe') : [];
    for (var i = 0; i < ifs.length; i++) {
      try { if (ifs[i].contentDocument) walk(ifs[i].contentDocument, path + '/F' + i, depth + 1); } catch (e) {}
    }
  }
  out.push('SELF bodyKids=' + document.body.children.length + ' bodyLen=' + (document.body.innerText || '').length);
  walk(document, '', 0);
  return out.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, contextId=ctx, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:400])
print(str(r.get('result', {}).get('value', ''))[:4000])
