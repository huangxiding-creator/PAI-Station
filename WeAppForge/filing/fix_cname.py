# -*- coding: utf-8 -*-
"""Modify ai CNAME value -> ai.epcschool.top.tcbaccess.tencentcloudbase.com"""
import io
import time
from DrissionPage import ChromiumPage, ChromiumOptions

co = ChromiumOptions().set_local_port(9334)
page = ChromiumPage(addr_or_opts=co)
tab = page.latest_tab
lines = []

# find the row whose first cell is exactly 'ai' and click its 修改 button
target_row = None
for r in tab.eles('css:tr'):
    try:
        t = r.text or ''
    except Exception:
        continue
    parts = [p.strip() for p in t.split('\n') if p.strip()]
    if parts and parts[0] == 'ai' and 'CNAME' in parts:
        target_row = r
        break
if not target_row:
    lines.append('ROW ai not found')
else:
    btn = None
    for b in target_row.eles('tag:button'):
        if (b.text or '').strip() == '修改':
            btn = b
            break
    if not btn:
        # maybe a/span
        for b in target_row.eles('css:a, span'):
            if (b.text or '').strip() == '修改':
                btn = b
                break
    if not btn:
        lines.append('修改 button not found in row')
    else:
        btn.click()
        time.sleep(1.5)
        # edit row opens; find the Value input (host may be readonly)
        vi = tab.ele('css:input[name="Value"]', timeout=5)
        if vi:
            vi.clear()
            vi.input('ai.epcschool.top.tcbaccess.tencentcloudbase.com')
            time.sleep(0.5)
            ok = False
            for b in tab.eles('css:button.app-cns-console-btn--solid'):
                if (b.text or '').strip() in ('确认', '保存'):
                    b.click()
                    ok = True
                    break
            lines.append('save clicked: ' + str(ok))
            time.sleep(3)
        else:
            lines.append('edit Value input not found')

# verify
time.sleep(2)
for r in tab.eles('css:tr'):
    try:
        t = r.text or ''
    except Exception:
        continue
    parts = [p.strip() for p in t.split('\n') if p.strip()]
    if parts and parts[0] == 'ai' and 'CNAME' in parts:
        lines.append('NOW ROW: ' + t.replace('\n', ' | ')[:150])
        break

with io.open('cname_fix_result.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(lines))
print('done')
