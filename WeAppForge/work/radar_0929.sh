#!/bin/sh
# 雷达只读取证：用户表最近活动 + 今天午后引擎收到的请求
echo "== users recent =="
sqlite3 /opt/qianwen/data/qianwen/db.sqlite "select substr(openid,1,8), quota_day, free_used, updated_at from users order by updated_at desc limit 6;"
echo "== engine requests since 12:00 =="
sudo journalctl -u qianwen-engine --since "2026-09-29 12:00" --no-pager | grep -E "POST /api|GET /api" | tail -30
echo "== answers recent =="
sqlite3 /opt/qianwen/data/qianwen/db.sqlite "select substr(id,1,10), status, unlocked, created_at from answers order by created_at desc limit 6;"
echo "RADAR_DONE"
