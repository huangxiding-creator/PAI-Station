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

JS = r"""
(function(){
  var out = [];
  var ifs = document.querySelectorAll('iframe');
  for (var i = 0; i < ifs.length; i++) {
    try {
      var d = ifs[i].contentDocument;
      if (!d) { out.push('IF' + i + ' NODOC'); continue; }
      var t = ((d.body && d.body.innerText) || '');
      out.push('IF' + i + ' LEN=' + t.length + '\n' + t.slice(0, 2600));
    } catch (e) { out.push('IF' + i + ' ERR=' + e.message); }
  }
  return out.join('\n@@@@\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:5500])
