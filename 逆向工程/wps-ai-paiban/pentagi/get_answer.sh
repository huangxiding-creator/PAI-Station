#!/bin/bash
cd /root/pentagi
echo "== 助手状态 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id, status FROM assistants WHERE id=6;'
echo "== msglogs 计数 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT count(*) FROM msglogs;'
echo "== 最新消息（前2000字）=="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT left(info, 2000) FROM msglogs ORDER BY id DESC LIMIT 1;"
