# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.get_tabs()[-1] if page.get_tabs() else page.new_tab('https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token=1577852751&lang=zh_CN')
fr = tab.get_frame('xframe/skit/manage/goods')
if fr is None:
    print('FRAME NOT FOUND'); raise SystemExit
txt = (fr.html or '')[:200]
r = fr.run_cdp('Runtime.evaluate',
               expression='document.body ? document.body.innerText.slice(0, 3500) : "NOBODY"',
               returnByValue=True)
val = str(r.get('result', {}).get('value', ''))
print('LEN:', len(val))
print(val[:3500])
