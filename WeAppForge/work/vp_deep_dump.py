# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or ''):
        tab = t
        break
if tab is None:
    raise SystemExit('no wrapper tab')

# 递归走 iframe 树（同源），收每层 bodyText + 可点击元素摘要
JS = r"""
(function(){
  function walk(doc, path, depth, out) {
    if (depth > 4) return;
    var txt = ((doc.body && doc.body.innerText) || '');
    if (txt) out.push(path + ' TEXTLEN=' + txt.length + '\n' + txt.slice(0, 1500));
    var btns = doc.querySelectorAll('button, .weui-btn, a.btn, [class*=btn]');
    var bl = [];
    for (var i = 0; i < btns.length && i < 40; i++) {
      var b = (btns[i].innerText || '').trim().replace(/\n/g, '/');
      if (b && b.length < 30) bl.push(b);
    }
    if (bl.length) out.push(path + ' BTNS: ' + bl.join(' | '));
    var ifs = doc.querySelectorAll('iframe');
    for (var i = 0; i < ifs.length; i++) {
      try {
        var d = ifs[i].contentDocument;
        if (d) walk(d, path + '>' + i, depth + 1, out);
      } catch (e) { out.push(path + '>' + i + ' XDOC'); }
    }
  }
  var out = [];
  walk(document, 'SELF', 0, out);
  return out.join('\n=====\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:400])
print(str(r.get('result', {}).get('value', ''))[:8000])
