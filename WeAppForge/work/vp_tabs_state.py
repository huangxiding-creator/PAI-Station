# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tabs = [t for t in page.get_tabs() if 'skit/manage/goods' in (t.url or '')]

JS = r"""
(function(){
  var out = [];
  var ifs = document.querySelectorAll('iframe');
  for (var i = 0; i < ifs.length; i++) {
    try {
      var d = ifs[i].contentDocument;
      if (!d) { out.push('IF' + i + ' NODOC'); continue; }
      var t = ((d.body && d.body.innerText) || '');
      out.push('IF' + i + ' LEN=' + t.length + ' :: ' + t.slice(0, 400).replace(/\n/g, '|'));
    } catch (e) { out.push('IF' + i + ' ERR'); }
  }
  var myTxt = ((document.body && document.body.innerText) || '');
  return 'SELF LEN=' + myTxt.length + ' :: ' + myTxt.slice(0, 200).replace(/\n/g, '|') + '\n' + out.join('\n');
})()
"""

for idx, tab in enumerate(tabs):
    r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
    print('=== TAB', idx, (tab.url or '')[:60])
    print(str(r.get('result', {}).get('value', ''))[:900])
    print()
