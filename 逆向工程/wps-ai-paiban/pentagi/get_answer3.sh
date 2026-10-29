#!/bin/bash
cd /root/pentagi
echo "== msgchains =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT id, flow_id, model, model_provider FROM msgchains WHERE flow_id=6;"
echo "== assistantlogs 列 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c '\d assistantlogs' | head -12
echo "== flow 6 assistantlogs 最新 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT id, status, left(result, 3000) FROM assistantlogs WHERE flow_id=6 ORDER BY id DESC LIMIT 3;" | head -c 3500
echo ""
echo "== 容器状态 =="
docker ps --format '{{.Names}} {{.Status}}' | grep terminal
