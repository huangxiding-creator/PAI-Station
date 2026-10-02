# -*- coding: utf-8 -*-
"""After MFA verification: check state, click 确认 to save the open CNAME form row."""
import io
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
lines = []

# 1. is MFA dialog still visible?
mfa_open = False
for e in tab.eles('css:[class*="dialog"], [class*="modal"]'):
    try:
        t = (e.text or '')
    except Exception:
        continue
    if '身份校验' in t or '扫码验证' in t:
        w = e.rect.size[0]
        if w and w > 100:
            mfa_open = True
            lines.append('MFA dialog still open: ' + t.replace('\n', ' | ')[:100])
if not mfa_open:
    lines.append('MFA dialog closed (verified OK)')

# 2. form row state
ni = tab.ele('css:input[name="Name"]', timeout=2)
if ni:
    lines.append('FORM still open, Name=' + str(ni.attr('value')))
    # ensure type dropdown shows CNAME
    type_val = ''
    for h in tab.eles('css:.app-cns-console-dropdown__value'):
        txt = (h.text or '').strip()
        if txt in ('A', 'CNAME', 'TXT', 'MX', 'AAAA', 'NS'):
            type_val = txt
    lines.append('TYPE shown: ' + type_val)
    # click 确认
    ok = False
    for b in tab.eles('css:button.app-cns-console-btn--solid'):
        if (b.text or '').strip() == '确认':
            b.click()
            ok = True
            break
    lines.append('confirm clicked: ' + str(ok))
    time.sleep(3)
else:
    lines.append('FORM row not open')

# 3. check saved: look for table row with host ai + CNAME
time.sleep(2)
saved = False
for r in tab.eles('css:tr'):
    try:
        t = r.text or ''
    except Exception:
        continue
    parts = [p.strip() for p in t.split('\n') if p.strip()]
    if parts and parts[0] == 'ai' and 'CNAME' in parts and 'cdn.dnsv1.com' in t:
        saved = True
        lines.append('SAVED ROW: ' + t.replace('\n', ' | ')[:140])
        break
lines.append('saved=' + str(saved))

with io.open('cname_result.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
print('done, saved=', saved)
