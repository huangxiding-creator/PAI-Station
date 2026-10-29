#!/bin/bash
# PentAGI 拉活脚本（wps 战役既账复用）— wsl -d RE-Ubuntu -u root -- bash /mnt/e/AI-Station/逆向工程/baidu-netdisk/scripts/pentagi_up.sh
set -o pipefail
cd /root/pentagi || { echo "NO /root/pentagi"; exit 1; }
echo "=== docker compose up -d pentagi ==="
docker compose up -d pentagi 2>&1 | tail -10
echo "=== ps ==="
docker compose ps 2>/dev/null | head -5
