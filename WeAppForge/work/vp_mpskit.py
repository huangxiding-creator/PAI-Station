# -*- coding: utf-8 -*-
import sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

for loc in ('mpskit', 'xpath://iframe[@name="mpskit"]', 1):
    try:
        f = tab.get_frame(loc)
        print('GOT frame via', repr(loc))
        try:
            txt = f.run_js('return document.body.innerText')
            print('BODYLEN', len(str(txt)))
            print(str(txt)[:800])
        except Exception as e:
            print('run_js err:', e)
        break
    except Exception as e:
        print('get_frame', repr(loc), 'err:', str(e)[:120])
