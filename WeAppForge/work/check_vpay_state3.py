# -*- coding: utf-8 -*-
import json, io, base64, re
p = r'E:/AI-Station/data/state/qianwen_tcb_envparams.json'
env = json.loads(io.open(p, encoding='utf-8').read())
files = json.loads(base64.b64decode(env['SECRET_FILES_B64']))
vp = files['virtual_pay.secret']
print('bytes:', len(vp))
for i, line in enumerate(vp.splitlines()):
    line = line.rstrip()
    if not line or line.startswith('#'):
        print(i, 'COMMENT/BLANK', line[:40]); continue
    m = re.match(r'([\w\-\.]+)\s*[=:]\s*(.*)$', line)
    if m:
        k, v = m.group(1), m.group(2)
        shown = v if len(v) <= 6 else v[:3] + '***' + '(%d chars)' % len(v)
        print(i, repr(k), '=', shown)
    else:
        print(i, 'RAW', repr(line[:20]))
