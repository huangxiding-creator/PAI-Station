# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.new_tab('https://mp.weixin.qq.com/cgi-bin/home?t=home/index&lang=zh_CN&token=1577852751')
tab.wait(3.5)
print('URL:', (tab.url or '')[:100])

JS = r"""
(function(){
  var out = [];
  var txt = (document.body && document.body.innerText) || '';
  out.push('BODYLEN=' + txt.length);
  out.push('HAS_LOGIN_QR=' + (txt.indexOf('扫码') >= 0));
  var links = document.querySelectorAll('a');
  for (var i = 0; i < links.length; i++) {
    var t = (links[i].innerText || '').trim();
    if (t && (t.indexOf('支付') >= 0 || t.indexOf('道具') >= 0 || t.indexOf('虚拟') >= 0)) {
      out.push('LINK: ' + t + ' => ' + (links[i].getAttribute('href') || '')[: 0] + (links[i].getAttribute('href') || ''));
    }
  }
  return out.join('\n');
})()
"""
# note: fix accidental slice syntax
JS = JS.replace("(links[i].getAttribute('href') || '')[: 0] + ", "")
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:3000])
