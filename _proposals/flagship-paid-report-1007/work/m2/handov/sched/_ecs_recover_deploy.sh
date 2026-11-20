#!/bin/bash
# _ecs_recover_deploy — ECS重启后自动恢复部署链
set -u
T0=$(date +%s)
echo "[recover] 等SSH复活..."
until ssh -o ConnectTimeout=10 -o BatchMode=yes root@47.120.43.20 "echo ALIVE" 2>/dev/null | grep -q ALIVE; do
  sleep 20
  NOW=$(date +%s)
  if [ $((NOW-T0)) -gt 900 ]; then echo "[recover] SSH 15分钟未恢复, 退出"; exit 1; fi
done
echo "[recover] SSH已复活 ($(( $(date +%s)-T0 ))s)"
ssh -o ConnectTimeout=10 root@47.120.43.20 "df -h / | tail -1; systemctl is-active docker; docker ps --format '{{.Names}}' 2>/dev/null | head -6"
echo "[deploy] 传输..."
scp -o ConnectTimeout=15 "$TEMP/rp_handov.tgz" root@47.120.43.20:/tmp/ || scp -o ConnectTimeout=15 "C:/Users/91216/AppData/Local/Temp/rp_handov.tgz" root@47.120.43.20:/tmp/ || { echo "[deploy] tgz传输失败"; exit 2; }
scp -o ConnectTimeout=15 "E:/AI-Station/report_platform/content/full/HANDOV-2026.pdf" root@47.120.43.20:/tmp/ || { echo "[deploy] PDF传输失败"; exit 2; }
echo "[deploy] 解压部署..."
ssh -o ConnectTimeout=15 root@47.120.43.20 '
mkdir -p /www/report_platform
tar -xzf /tmp/rp_handov.tgz -C /www/report_platform --strip-components=0 2>/dev/null || tar -xzf /tmp/rp_handov.tgz -C /www/report_platform
mkdir -p /www/report_platform/content/full
cp /tmp/HANDOV-2026.pdf /www/report_platform/content/full/
systemctl start report_platform 2>/dev/null || (cd /www/report_platform && nohup python3 server.py > /tmp/rp_server.log 2>&1 &)
sleep 4
systemctl is-active report_platform 2>/dev/null
curl -s -o /dev/null -w "local8885: %{http_code}\n" --max-time 8 http://127.0.0.1:8885/ 2>/dev/null
ls /www/report_platform/site/handov-2026.html 2>/dev/null && echo "handov page OK"
'
echo "[deploy] 完成"
