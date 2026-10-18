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
      var h = d.documentElement ? d.documentElement.outerHTML : '';
      out.push('IF' + i + ' htmlLen=' + h.length
        + ' title=' + (d.title || '')
        + ' bodyText=' + (((d.body && d.body.innerText) || '')).slice(0, 150).replace(/\n/g, '|'));
    } catch (e) { out.push('IF' + i + ' ERR=' + e.message); }
  }
  return out.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:2000])
# 把该标签页带到最前（用户桌面可见扫码）
try:
    tab.set.activate()
    print('TAB ACTIVATED')
except Exception as e:
    print('activate fail:', e)
