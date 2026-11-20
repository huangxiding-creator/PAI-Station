# -*- coding: utf-8 -*-
import sqlite3, json
db = sqlite3.connect(r'F:\We-AIPO\autopub\data\state.db')
print('--- 今晨发表账 (11-20 新增) ---')
for r in db.execute("SELECT id, account, content_type, title, status, created_at FROM publish_records WHERE created_at >= '2026-11-20' ORDER BY id"):
    print(r)
print('--- handov 稿状态 ---')
for r in db.execute("SELECT id, account, title, status, detail FROM publish_records WHERE title LIKE '%竣工验收与移交%' OR title LIKE '%钱和责任%' OR title LIKE '%质保金说工程有质量%'"):
    print(r)
