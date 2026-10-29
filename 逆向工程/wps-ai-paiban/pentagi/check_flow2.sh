#!/bin/bash
cd /root/pentagi
echo "== 相关表 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "\dt" | grep -E 'assistant|msg|chain|flow' | head -8
echo "== assistant_logs 最新 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT id, assistant_id, status, left(coalesce(info::text,''),300) FROM assistant_logs ORDER BY id DESC LIMIT 3;" 2>&1 | head -16
echo "== assistants 状态 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id,status FROM assistants;'
echo "== 容器日志尾部 =="
docker logs pentagi --since 4m 2>&1 | grep -viE 'GIN|privileges' | tail -8
