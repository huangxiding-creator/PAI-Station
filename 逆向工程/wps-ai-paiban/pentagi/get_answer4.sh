#!/bin/bash
cd /root/pentagi
echo "== flow 6 assistantlogs（最新3条）=="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT id, type, left(message, 200), '---', left(result, 3000) FROM assistantlogs WHERE flow_id=6 ORDER BY id DESC LIMIT 3;"
echo ""
echo "== 容器日志（flow 6 最近活动）=="
docker logs pentagi --since 2m 2>&1 | grep -iE 'flow.*6|deepseek|assistant.*6|tool|terminal' | grep -viE 'gorm|GIN' | tail -8
