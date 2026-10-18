# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
r = page.run_cdp('Target.getTargets')
for t in r.get('targetInfos', []):
    print(t.get('type'), '|', t.get('targetId', '')[:12], '|', t.get('url', '')[:100])
