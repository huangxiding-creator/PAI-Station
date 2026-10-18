# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'skit/manage/goods' in (t.url or ''):
        tab = t; break
if tab is None:
    tab = page.new_tab('https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token=1577852751&lang=zh_CN')
    tab.wait(4.0)
print('TAB:', (tab.url or '')[:90])
JS = """
(function(){
  var out = [];
  function grab(doc, label) {
    try { out.push(label + ':\n' + ((doc.body && doc.body.innerText) || 'NOBODY').slice(0, 3500)); }
    catch (e) { out.push(label + ' ERR ' + e.message); }
  }
  grab(document, 'MAIN');
  var ifs = document.querySelectorAll('iframe');
  for (var i = 0; i < ifs.length; i++) {
    try {
      var d = ifs[i].contentDocument;
      out.push('--- IFRAME ' + i + ' ' + (ifs[i].src||'').slice(-70));
      if (d) { grab(d, 'IF' + i); 
        var ifs2 = d.querySelectorAll('iframe');
        for (var j = 0; j < ifs2.length; j++) {
          try { var d2 = ifs2[j].contentDocument; if (d2) grab(d2, 'IF' + i + '_' + j); } catch (e) {}
        }
      }
    } catch (e) { out.push('IFRAME ' + i + ' ERR ' + e.message); }
  }
  return out.join('\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print(str(r.get('result', {}).get('value', ''))[:7000])
