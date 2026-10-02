# -*- coding: utf-8 -*-
"""Add TXT _cloudbase-challenge.ai for CloudBase domain ownership verification."""
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
# go to DNSPod records page for epcschool.top (tencent cloud cns console)
if 'cns/detail/epcschool.top' not in tab.url:
    tab.get('https://cloud.tencent.com/cns/detail/epcschool.top/records')
time.sleep(3)

# click 添加记录 button
btn = tab.ele('tag:button@@text():添加记录')
if not btn:
    print('NO_ADD_BUTTON url=', tab.url)
    raise SystemExit(1)
btn.click()
time.sleep(1)

# fill host record
ni = tab.ele('css:input[name="Name"]')
ni.clear()
ni.input('_cloudbase-challenge.ai')

# open type dropdown (header whose value is 'A')
hdr = None
for h in tab.eles('css:.app-cns-console-dropdown__header'):
    v = h.ele('css:.app-cns-console-dropdown__value', timeout=0.3)
    if v and (v.text or '').strip() == 'A':
        hdr = h
        break
if hdr:
    hdr.click()
    time.sleep(0.8)
    picked = False
    for o in tab.eles('text:TXT'):
        if o.tag == 'li':
            o.click()
            picked = True
            break
    print('type picked TXT:', picked)
time.sleep(0.5)

# fill value
vi = tab.ele('css:input[name="Value"]')
vi.clear()
vi.input('cloudbase-d2gzke5r0b706b3a3')

# confirm
ok = False
for b in tab.eles('css:button.app-cns-console-btn--solid'):
    if (b.text or '').strip() == '确认':
        b.click()
        ok = True
        break
print('confirm clicked:', ok)
time.sleep(2.5)

# verify by reading back the table filtered: just dump rows containing challenge
found = False
for t in tab.eles('text:_cloudbase-challenge.ai'):
    row = t.parent('tr')
    if row:
        txt = row.text.replace('\n', ' | ')
        if 'TXT' in txt:
            print('ROW:', txt[:160])
            found = True
            break
print('record visible in table:', found)
