# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
out = []
for t in page.get_tabs():
    out.append('TAB: ' + (t.url or '')[:110])
print('\n'.join(out[:12]))
