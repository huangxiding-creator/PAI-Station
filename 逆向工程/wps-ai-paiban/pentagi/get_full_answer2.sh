#!/bin/bash
cd /root/pentagi
echo "== 列名确认 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT column_name FROM information_schema.columns WHERE table_name='assistantlogs' ORDER BY ordinal_position;"
echo "== type=answer 的完整行 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT message FROM assistantlogs WHERE flow_id=6 AND type='answer' ORDER BY id DESC LIMIT 1;" | head -c 4000
