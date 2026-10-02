# -*- coding: utf-8 -*-
"""Add CNAME ai -> cdn.dnsv1.com for CloudBase gateway."""
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
if 'cns/detail/epcschool.top' not in tab.url:
    tab.get('https://cloud.tencent.com/cns/detail/epcschool.top/records')
time.sleep(3)

btn = tab.ele('tag:button@@text():添加记录')
if not btn:
    print('NO_ADD_BUTTON url=', tab.url)
    raise SystemExit(1)
btn.click()
time.sleep(1)

ni = tab.ele('css:input[name="Name"]')
ni.clear()
ni.input('ai')

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
    for o in tab.eles('text:CNAME'):
        if o.tag == 'li':
            o.click()
            picked = True
            break
    print('type picked CNAME:', picked)
time.sleep(0.5)

vi = tab.ele('css:input[name="Value"]')
vi.clear()
vi.input('cdn.dnsv1.com')

ok = False
for b in tab.eles('css:button.app-cns-console-btn--solid'):
    if (b.text or '').strip() == '确认':
        b.click()
        ok = True
        break
print('confirm clicked:', ok)
time.sleep(2.5)

# dump any toast / error text
for t in tab.eles('css:.app-cns-console-message, .c-message, [class*="toast"]'):
    if t.text:
        print('TOAST:', t.text[:80])
print('done')
