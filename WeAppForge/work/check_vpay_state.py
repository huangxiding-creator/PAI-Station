# -*- coding: utf-8 -*-
import json, io, re
p = r'E:/AI-Station/data/state/qianwen_tcb_envparams.json'
raw = io.open(p, encoding='utf-8').read()
d = json.loads(raw)
# 快照结构可能是 {env: {...}} 或直接 dict
env = d.get('env') if isinstance(d, dict) else None
if env is None:
    env = d
vp = env.get('virtual_pay.secret') or env.get('VIRTUAL_PAY') or ''
print('env keys:', sorted(env.keys())[:12])
if not vp:
    print('no virtual_pay.secret key in snapshot')
else:
    keys = re.findall(r'^([A-Za-z0-9_]+)=', vp, flags=re.M)
    print('virtual_pay.secret keys:', sorted(set(keys)))
    m = re.search(r'^env=(.+)$', vp, flags=re.M)
    print('env =', m.group(1).strip() if m else '(absent)')
    for k in ('offer_id', 'report_product_498', 'report_product_598',
              'report_product_698', 'report_product_1999', 'export_product_id',
              'prod_appkey', 'sandbox_appkey'):
        m = re.search(r'^%s=(.+)$' % k, vp, flags=re.M)
        if not m:
            print(k, '= (MISSING)')
        elif k in ('prod_appkey', 'sandbox_appkey'):
            v = m.group(1).strip()
            print(k, '= SET(len %d) hash %s' % (len(v), __import__('hashlib').sha256(v.encode()).hexdigest()[:8]))
        else:
            print(k, '=', m.group(1).strip())
