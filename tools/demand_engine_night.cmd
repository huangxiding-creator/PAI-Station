@echo off
rem Demand Engine 夜班: 三面采集 + 周报 (1019)
cd /d E:\AI-Station
set WECHAT_ACCOUNTS_FILE=F:/We-AIPO/data/wechat_accounts.json
py -X utf8 tools\dl_collect_wechat.py >> data\demand_ledger\collect.log 2>&1
py -X utf8 tools\dl_collect_internal.py >> data\demand_ledger\collect.log 2>&1
py -X utf8 tools\dl_collect_comments.py >> data\demand_ledger\collect.log 2>&1
F:\We-AIPO\.venv\Scripts\python.exe -X utf8 tools\dl_collect_channels.py >> data\demand_ledger\collect.log 2>&1
py -X utf8 tools\demand_ledger_report.py >> data\demand_ledger\collect.log 2>&1
