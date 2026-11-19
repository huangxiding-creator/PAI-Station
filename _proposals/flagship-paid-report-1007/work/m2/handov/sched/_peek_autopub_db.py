# -*- coding: utf-8 -*-
import sqlite3
db = sqlite3.connect(r'F:\We-AIPO\autopub\data\state.db')
cur = db.execute("SELECT name FROM sqlite_master WHERE type='table'")
tables = [r[0] for r in cur.fetchall()]
print('tables:', tables)
for t in tables[:16]:
    try:
        cols = [c[1] for c in db.execute(f'PRAGMA table_info({t})').fetchall()]
        n = db.execute(f'SELECT COUNT(*) FROM {t}').fetchone()[0]
        print(f'{t} ({n}):', cols[:14])
    except Exception as e:
        print(t, 'ERR', e)
