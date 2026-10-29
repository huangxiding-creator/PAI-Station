#!/bin/bash
cd /root/pentagi
echo "== assistantlogs =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT id, assistant_id, status, left(coalesce(info,''),200) FROM assistantlogs ORDER BY id DESC LIMIT 5;" 2>&1 | head -18
echo "== msglogs =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT count(*), max(id) FROM msglogs;" 2>&1
echo "== 容器日志：assistant/worker/glm =="
docker logs pentagi 2>&1 | grep -iE 'assistant|worker|glm|barrier|msgchain' | grep -v 'GIN\|privileges' | tail -12
