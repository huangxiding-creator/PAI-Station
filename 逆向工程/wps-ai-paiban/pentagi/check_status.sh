#!/bin/bash
cd /root/pentagi
echo "== flows/assistants =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id,status,title FROM flows; SELECT id,status,flow_id FROM assistants;'
echo "== msglogs =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT count(*) FROM msglogs;'
echo "== msgchains =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id, flow_id, assistant_id FROM msgchains;' 2>&1 | head -8
echo "== 容器日志（非GIN）=="
docker logs pentagi --since 6m 2>&1 | grep -viE 'GIN|privileges' | tail -10
