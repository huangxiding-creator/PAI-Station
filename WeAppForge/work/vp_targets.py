# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
r = page.run_cdp('Target.getTargets')
for t in r.get('targetInfos', []):
    ty = t.get('type')
    url = (t.get('url') or '')[:110]
    if ty in ('page', 'webview') or 'skit' in url or 'mp.weixin' in url:
        print(ty, '|', t.get('targetId', '')[:10], '|', url)
