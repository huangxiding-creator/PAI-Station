# -*- coding: utf-8 -*-
import io
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
lines = []
# dialogs / modals
for e in tab.eles('css:[class*="dialog"], [class*="modal"], [class*="Dialog"], [class*="Modal"]'):
    try:
        t = (e.text or '').strip()
        w = e.rect.viewport_midpoint
    except Exception:
        continue
    if t and len(t) > 10:
        lines.append('DLG[%s]: %s' % (e.tag, t.replace('\n', ' | ')[:200]))
# buttons mentioning 验证
for b in tab.eles('tag:button'):
    try:
        t = (b.text or '').strip()
    except Exception:
        continue
    if '验证' in t or 'MFA' in t:
        lines.append('BTN: ' + t[:40])
with io.open('dns_mfa_dump.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines) if lines else 'EMPTY')
print('dumped', len(lines))
