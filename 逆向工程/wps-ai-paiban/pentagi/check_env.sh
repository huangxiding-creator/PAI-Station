#!/bin/bash
docker exec pentagi sh -c 'env | grep -E "^(GLM|EMBEDDING|OPEN_AI)" | sed -E "s/=(.{4}).*/=\1***/"' | head -8
echo "--- msgchains ---"
cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT * FROM msgchains LIMIT 3;' 2>&1 | head -8
echo "--- containers 表 ---"
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id, flow_id, status FROM containers;' 2>&1 | head -8
