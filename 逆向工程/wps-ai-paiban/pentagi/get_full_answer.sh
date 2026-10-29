#!/bin/bash
cd /root/pentagi
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c \
  "SELECT result FROM assistantlogs WHERE flow_id=6 AND type='answer' ORDER BY id DESC LIMIT 1;" \
  > /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/deepseek_answer.md
wc -c /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/deepseek_answer.md
echo "== 前500字 =="
head -c 500 /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/deepseek_answer.md
