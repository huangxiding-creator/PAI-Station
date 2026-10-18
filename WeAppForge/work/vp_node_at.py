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

# 视口 CSS 尺寸（scale 2 → 截图 2174x1534 ≈ 1087x767 CSS）
r = tab.run_cdp('Page.getLayoutMetrics')
cs = r.get('cssLayoutViewport', {})
print('viewport CSS:', cs.get('clientWidth'), 'x', cs.get('clientHeight'))

# 编辑弹窗所在区域几个探针（截图上：弹窗约 x 27%-73%, y 18%-88%）
probes = [(543, 60), (543, 150), (543, 260), (543, 380), (543, 540), (543, 700), (350, 120), (900, 700)]
for x, y in probes:
    try:
        n = tab.run_cdp('DOM.getNodeForLocation', x=x, y=y, includeUserAgentShadowDOM=True, includeUserAgentShadowDOM_pierce=True)
        print(x, y, '->', json.dumps(n)[:220])
    except Exception as e:
        # 老版本参数名兼容
        try:
            n = tab.run_cdp('DOM.getNodeForLocation', x=x, y=y, includeUserAgentShadowDOM=True)
            print(x, y, '->', json.dumps(n)[:220])
        except Exception as e2:
            print(x, y, 'ERR', str(e2)[:100])
