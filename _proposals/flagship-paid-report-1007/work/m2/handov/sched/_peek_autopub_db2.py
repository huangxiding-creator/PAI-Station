# -*- coding: utf-8 -*-
import sqlite3
db = sqlite3.connect(r'F:\We-AIPO\autopub\data\state.db')
print('--- profile_registry ---')
for r in db.execute('SELECT profile, nickname, last_login, scan_expiry FROM profile_registry'):
    print(r)
print('--- recent publish_records (last 12) ---')
for r in db.execute("SELECT id, account, content_type, title, status, created_at FROM publish_records ORDER BY id DESC LIMIT 12"):
    print(r)
print('--- queued/pending ---')
for r in db.execute("SELECT id, account, title, status FROM publish_records WHERE status NOT IN ('published','done','sent') ORDER BY id DESC LIMIT 10"):
    print(r)
