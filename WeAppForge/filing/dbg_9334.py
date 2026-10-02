# -*- coding: utf-8 -*-
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
print('URL:', tab.url)
print('TITLE:', tab.title)
# dump first visible buttons
for b in tab.eles('tag:button')[:20]:
    try:
        if b.text:
            print('BTN:', b.text.strip()[:30])
    except Exception:
        pass
print('inputs:', len(tab.eles('css:input[name="Name"]')))
