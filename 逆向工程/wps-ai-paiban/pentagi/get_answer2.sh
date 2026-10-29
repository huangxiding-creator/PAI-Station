#!/bin/bash
cd /root/pentagi
echo "== msglogs 列 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c '\d msglogs' | head -12
echo "== 最新消息 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT * FROM msglogs ORDER BY id DESC LIMIT 1;" | head -c 2000
echo ""
