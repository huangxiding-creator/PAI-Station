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

d = tab.run_cdp('DOM.describeNode', nodeId=37)
print('describe:', json.dumps(d, ensure_ascii=False)[:600])
try:
    h = tab.run_cdp('DOM.getOuterHTML', nodeId=37)
    print('outerHTML head:', str(h.get('outerHTML', ''))[:400])
except Exception as e:
    print('getOuterHTML err:', str(e)[:150])
# box
try:
    b = tab.run_cdp('DOM.getBoxModel', nodeId=37)
    print('box:', json.dumps(b)[:300])
except Exception as e:
    print('box err:', str(e)[:150])
