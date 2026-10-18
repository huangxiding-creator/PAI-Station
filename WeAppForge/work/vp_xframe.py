# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.new_tab('https://mp.weixin.qq.com/wxamp/xframe/skit/manage/goods?token=1577852751&lang=zh_CN')
tab.wait(5.0)
print('URL:', (tab.url or '')[:110])

JS = r"""
(function(){
  var txt = (document.body && document.body.innerText) || '';
  return 'BODYLEN=' + txt.length + '\n' + txt.slice(0, 3500);
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:3800])
tab.get_screenshot(path=r'E:\AI-Station\WeAppForge\work\vp_xframe_goods.png')
