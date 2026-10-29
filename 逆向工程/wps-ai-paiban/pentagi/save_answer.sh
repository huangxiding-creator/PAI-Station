#!/bin/bash
cd /root/pentagi
OUT=/mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/deepseek_answer.md
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c \
  "SELECT message FROM assistantlogs WHERE flow_id=6 AND type='answer' ORDER BY id DESC LIMIT 1;" > "$OUT"
BYTES=$(wc -c < "$OUT")
echo "已保存 $OUT ($BYTES 字节)"
echo "== thinking 列 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c \
  "SELECT left(coalesce(thinking,'(无)'), 300) FROM assistantlogs WHERE flow_id=6 AND type='answer' ORDER BY id DESC LIMIT 1;"
echo ""
echo "== 清理 flow 6 沙箱容器 =="
docker rm -f pentagi-terminal-6 2>&1 || true
echo "== 助手终态 =="
docker compose exec -T pgvector psql -U postgres -d pentagidb -c 'SELECT id, status FROM assistants WHERE id=6; SELECT id, status FROM flows WHERE id=6;'
