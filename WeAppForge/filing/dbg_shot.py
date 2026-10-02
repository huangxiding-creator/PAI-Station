# -*- coding: utf-8 -*-
import io
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
# full banner/alert texts
lines = []
for e in tab.eles('css:[class*="message"], [class*="banner"], [class*="alert"], [class*="notice"]'):
    try:
        t = (e.text or '').strip()
    except Exception:
        continue
    if t and len(t) < 300:
        lines.append('BANNER: ' + t.replace('\n', ' | ')[:250])
# open form row state
for ni in tab.eles('css:input[name="Name"]'):
    try:
        val = ni.attr('value')
    except Exception:
        val = '?'
    lines.append('FORM Name value: ' + str(val))
for vi in tab.eles('css:input[name="Value"]'):
    try:
        val = vi.attr('value')
    except Exception:
        val = '?'
    lines.append('FORM Value value: ' + str(val))
# dropdown current type shown
for h in tab.eles('css:.app-cns-console-dropdown__value'):
    lines.append('DD: ' + (h.text or '').strip()[:20])
with io.open('dns_state_dump.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines) if lines else 'EMPTY')
print('dumped', len(lines))
