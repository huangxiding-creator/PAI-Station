# -*- coding: utf-8 -*-
import sqlite3, json
db = sqlite3.connect(r'F:\We-AIPO\autopub\data\state.db')
for r in db.execute('SELECT id, account, content_type, status, detail, evidence FROM publish_records WHERE id IN (2302, 2299)'):
    print('---', r[0], r[1], r[2], r[3])
    try:
        d = json.loads(r[4]) if r[4] else {}
        print(json.dumps(d, ensure_ascii=False)[:800])
    except Exception:
        print('detail:', str(r[4])[:400])
    print('evidence:', str(r[5])[:300])
