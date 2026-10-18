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
if tab is None:
    raise SystemExit('no wrapper tab')

JS = r"""
(function(){
  var wj = document.querySelector('wujie-app');
  if (!wj || !wj.shadowRoot) return 'no wujie shadow';
  var sr = wj.shadowRoot;
  var body = sr.querySelector('body');
  var txt = body ? (body.innerText || '') : '(no body in shadow)';
  return 'WUJIE BODY LEN=' + txt.length + '\n' + txt.slice(0, 3500);
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(r.get('result', {}).get('value', ''))[:3800])
