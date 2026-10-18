# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
for i, t in enumerate(page.get_tabs()):
    print(i, '|', (t.url or '')[:130])
