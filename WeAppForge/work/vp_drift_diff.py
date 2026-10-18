# -*- coding: utf-8 -*-
import base64, hashlib, io, json

CANON = 'E:/AI-Station/data/secrets/virtual_pay.secret'
ENVP = 'E:/AI-Station/data/state/qianwen_tcb_envparams.json'

canon = io.open(CANON, encoding='utf-8').read()
envp = json.loads(io.open(ENVP, encoding='utf-8').read())
files = json.loads(base64.b64decode(envp['SECRET_FILES_B64']))
inner = base64.b64decode(files['virtual_pay.secret']).decode('utf-8')

ck = [l.split('=', 1)[0] for l in canon.splitlines() if '=' in l and not l.startswith('#')]
ik = [l.split('=', 1)[0] for l in inner.splitlines() if '=' in l and not l.startswith('#')]
print('canon keys :', sorted(ck))
print('deploy keys:', sorted(ik))
print('canon-only :', sorted(set(ck) - set(ik)))
print('deploy-only:', sorted(set(ik) - set(ck)))
cv = dict(l.split('=', 1) for l in canon.splitlines() if '=' in l and not l.startswith('#'))
iv = dict(l.split('=', 1) for l in inner.splitlines() if '=' in l and not l.startswith('#'))
for k in sorted(set(cv) & set(iv)):
    if cv[k] != iv[k]:
        print('VALUE DIFF', k, ': canon len', len(cv[k]), 'deploy len', len(iv[k]),
              'same' if cv[k] == iv[k] else 'DIFF')
print('canon bytes', len(canon), 'deploy bytes', len(inner))
