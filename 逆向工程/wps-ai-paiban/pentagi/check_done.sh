#!/bin/bash
# 检查 GLM 助手是否已产出 msglogs（DONE）否则输出 WAIT
cd /root/pentagi
N=$(docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "SELECT count(*) FROM msglogs;" 2>/dev/null)
if [ "${N:-0}" -gt 0 ]; then
  echo DONE
  docker compose exec -T pgvector psql -U postgres -d pentagidb -c "SELECT id, type, left(info,500) FROM msglogs ORDER BY id DESC LIMIT 4;" 2>/dev/null | head -30
else
  echo WAIT
fi
