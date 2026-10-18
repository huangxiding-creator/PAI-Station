# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    u = t.url or ''
    if 'wadevelopcode/get_class' in u:
        tab = t
        break
if tab is None:
    raise SystemExit('no get_class tab')
print('TAB:', (tab.url or '')[:110])

JS = r"""
(function(){
  var out = [];
  var txt = (document.body && document.body.innerText) || '';
  out.push('BODYLEN=' + txt.length);
  out.push('HEAD=' + txt.slice(0, 300).replace(/\n/g, ' | '));
  var links = document.querySelectorAll('a');
  var n = 0;
  for (var i = 0; i < links.length && n < 40; i++) {
    var t = (links[i].innerText || '').trim();
    var h = links[i].getAttribute('href') || '';
    if (t && h && (t.indexOf('支付') >= 0 || t.indexOf('虚拟') >= 0 || t.indexOf('道具') >= 0 || t.indexOf('功能') >= 0)) {
      out.push('LINK: ' + t + ' => ' + h.slice(0, 130));
      n++;
    }
  }
  return out.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:3000])
