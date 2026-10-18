# -*- coding: utf-8 -*-
import sys, json, base64
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

# 1) 现势截图
r = tab.run_cdp('Page.captureScreenshot', format='png')
open('E:/AI-Station/WeAppForge/work/vp_now3.png', 'wb').write(base64.b64decode(r.get('data', '')))
print('shot vp_now3.png saved')

# 2) backendNodeId 反查
try:
    d = tab.run_cdp('DOM.describeNode', backendNodeId=86)
    print('describe86:', json.dumps(d, ensure_ascii=False)[:800])
except Exception as e:
    print('describe86 ERR:', str(e)[:200])

# 3) 坐标反查重跑（新鲜 nodeId）
for x, y in [(543, 260), (543, 640)]:
    try:
        n = tab.run_cdp('DOM.getNodeForLocation', x=x, y=y, includeUserAgentShadowDOM=True)
        nid = n.get('nodeId')
        bid = n.get('backendNodeId')
        print(x, y, 'nodeId', nid, 'backend', bid)
        if nid:
            dd = tab.run_cdp('DOM.describeNode', nodeId=nid)
            print('  describe:', json.dumps(dd, ensure_ascii=False)[:300])
            # 父链
            p = dd.get('node', {}).get('parentId')
            depth = 0
            while p and depth < 6:
                dp = tab.run_cdp('DOM.describeNode', nodeId=p)
                nd = dp.get('node', {})
                print('  ^', nd.get('nodeName'), (nd.get('attributes') or [])[:6])
                p = nd.get('parentId')
                depth += 1
    except Exception as e:
        print(x, y, 'ERR', str(e)[:150])
