# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'skit/manage/goods' in (t.url or ''):
        tab = t
        break
if tab is None:
    raise SystemExit('no goods tab')

JS = r"""
(function(){
  var ifs = document.querySelectorAll('iframe');
  var parts = [];
  for (var i = 0; i < ifs.length; i++) {
    var src = (ifs[i].src || '').slice(-70);
    try {
      var d = ifs[i].contentDocument;
      if (!d) { parts.push('IF' + i + ' ' + src + ' NODOC'); continue; }
      var t = (d.body && d.body.innerText) || '';
      parts.push('IF' + i + ' ' + src + ' LEN=' + t.length + '\n' + t.slice(0, 1600));
    } catch (e) { parts.push('IF' + i + ' ' + src + ' ERR=' + e.message); }
  }
  return parts.join('\n@@@@\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:4000])
