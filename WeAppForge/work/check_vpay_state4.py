# -*- coding: utf-8 -*-
import json, io, base64, re, hashlib
p = r'E:/AI-Station/data/state/qianwen_tcb_envparams.json'
env = json.loads(io.open(p, encoding='utf-8').read())
files = json.loads(base64.b64decode(env['SECRET_FILES_B64']))
vp = base64.b64decode(files['virtual_pay.secret']).decode('utf-8')
keys = re.findall(r'^([A-Za-z0-9_]+)=', vp, flags=re.M)
print('keys:', sorted(set(keys)))
for k in ('env', 'offer_id', 'report_product_498', 'report_product_598',
          'report_product_698', 'report_product_1999', 'export_product_id',
          'prod_appkey', 'sandbox_appkey'):
    m = re.search(r'^%s=(.+)$' % k, vp, flags=re.M)
    if not m:
        print(k, '= (MISSING)')
    elif 'appkey' in k or 'key' in k.lower():
        v = m.group(1).strip()
        print(k, '= SET(len %d) sha8=%s' % (len(v), hashlib.sha256(v.encode()).hexdigest()[:8]))
    else:
        print(k, '=', m.group(1).strip())
