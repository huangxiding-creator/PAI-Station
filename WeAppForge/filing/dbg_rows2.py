# -*- coding: utf-8 -*-
import io
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
out = []
for r in tab.eles('css:tr'):
    try:
        t = (r.text or '').replace('\n', ' | ')
    except Exception:
        continue
    if 'ai' in t[:60] or '变更' in t or '提示' in t or '冲突' in t or 'cdn.dnsv1' in t:
        out.append(t[:200])
with io.open('dns_rows_dump.txt', 'w', encoding='utf-8') as f:
    f.write('\n\n'.join(out))
print('wrote', len(out), 'rows')
