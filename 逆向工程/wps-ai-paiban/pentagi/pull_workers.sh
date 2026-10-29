#!/bin/bash
set -o pipefail
cd /root/pentagi
echo "== 拉工作镜像（scraper + kali 沙箱）=="
docker pull docker.m.daocloud.io/vxcontrol/scraper:latest 2>&1 | tail -1 || \
  docker pull vxcontrol/scraper:latest 2>&1 | tail -1
docker pull docker.m.daocloud.io/vxcontrol/kali-linux:latest 2>&1 | tail -1 || \
  docker pull vxcontrol/kali-linux:latest 2>&1 | tail -1
docker images --format '{{.Repository}}:{{.Tag}}' | grep -E 'scraper|kali'
echo "== tag 成本名 =="
docker tag docker.m.daocloud.io/vxcontrol/scraper:latest vxcontrol/scraper:latest 2>/dev/null || true
docker tag docker.m.daocloud.io/vxcontrol/kali-linux:latest vxcontrol/kali-linux:latest 2>/dev/null || true
echo "== 再发一发 assistant =="
bash /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/first_flow2.sh 2>&1 | head -3
