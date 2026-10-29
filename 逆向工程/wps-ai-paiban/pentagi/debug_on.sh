#!/bin/bash
cd /root/pentagi
sed -i 's/^DEBUG=.*/DEBUG=true/' .env
docker compose up -d pentagi 2>&1 | tail -2
sleep 6
echo "== 重发 createAssistant（debug 日志下）=="
bash /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/first_flow2.sh 2>&1 | head -4
sleep 5
echo "== 日志尾部 =="
docker logs pentagi --since 1m 2>&1 | grep -viE 'GIN|privileges' | tail -15
