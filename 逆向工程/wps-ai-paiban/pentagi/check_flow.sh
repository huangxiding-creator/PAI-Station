#!/bin/bash
cd /root/pentagi
echo "== assistants/flows 状态 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id, status FROM assistants; SELECT id, status FROM flows;'
echo "== msg_logs =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT count(*) FROM msg_logs WHERE assistant_id=1;"
echo "== 容器日志（glm/assistant/flow/error）=="
docker logs pentagi --since 3m 2>&1 | grep -iE 'glm|assistant|flow|error|worker' | tail -8
