# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.get_tabs()[-1]
JS = """
(function(){
  var out = [];
  var ifs = document.querySelectorAll('iframe');
  for (var i = 0; i < ifs.length; i++) {
    try {
      var d = ifs[i].contentDocument;
      if (!d || !d.body) { out.push('IFRAME ' + i + ': no body'); continue; }
      var t = d.body.innerText || '';
      out.push('=== IFRAME ' + i + ' (' + (ifs[i].src||'').slice(-60) + ') ===\n' + t.slice(0, 3500));
    } catch (e) { out.push('IFRAME ' + i + ' ERR ' + e.message); }
  }
  return out.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(r.get('result', {}).get('value', ''))[:7000])
