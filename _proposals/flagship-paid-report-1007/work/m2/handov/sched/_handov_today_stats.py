# -*- coding: utf-8 -*-
import sqlite3
db = sqlite3.connect(r'F:\We-AIPO\autopub\data\state.db')
print('--- 11-20 全部记录 ---')
for r in db.execute("SELECT id, account, content_type, substr(title,1,38), status, created_at FROM publish_records WHERE created_at >= '2026-11-20' ORDER BY id"):
    print(r)
print('--- 昨日 (11-19) 状态分布 ---')
for r in db.execute("SELECT status, COUNT(*) FROM publish_records WHERE created_at LIKE '2026-11-19%' GROUP BY status"):
    print(r)
