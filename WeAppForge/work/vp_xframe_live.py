# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
xf = None
for t in page.get_tabs():
    if 'xframe/skit/manage/goods' in (t.url or ''):
        xf = t
        break
if xf is None:
    raise SystemExit('no xframe tab')

tree = xf.run_cdp('Page.getFrameTree').get('frameTree', {})
frames = []
def w(node, d):
    f = node.get('frame', {})
    frames.append((d, f.get('name') or '', f.get('id'), f.get('url') or ''))
    for c in node.get('childFrames', []):
        w(c, d + 1)
w(tree, 0)
for d, n, i, u in frames:
    print('  ' * d + n + ' ' + i[:10] + ' ' + u[:100])

# 主文档直接读
JS = r"""
(function(){
  var out = [];
  function walk(root, path, depth) {
    if (depth > 5) return;
    var txt = '';
    try { txt = (root.body && root.body.innerText) || ''; } catch (e) {}
    if (txt) out.push(path + ' TEXTLEN=' + txt.length + ' :: ' + txt.slice(0, 600).replace(/\n/g, '|'));
    var all = root.querySelectorAll ? root.querySelectorAll('*') : [];
    for (var i = 0; i < all.length; i++) {
      if (all[i].shadowRoot) {
        var sr = all[i].shadowRoot;
        var app = sr.querySelector('#app') || sr.querySelector('body') || sr;
        var t2 = '';
        try { t2 = app.innerText || ''; } catch (e) {}
        out.push(path + '>>SHADOW[' + all[i].tagName + '] txtLen=' + t2.length);
        if (t2) out.push('SHTEXT: ' + t2.slice(0, 1500));
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
r = xf.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print()
print(str(r.get('result', {}).get('value', ''))[:3000])
