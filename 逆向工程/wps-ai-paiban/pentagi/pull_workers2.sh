#!/bin/bash
set -o pipefail
echo "== 直接从 DockerHub 拉（DNS 已修）=="
docker pull vxcontrol/scraper:latest 2>&1 | tail -2
echo "== docker.1ms.run 兜底 =="
docker pull docker.1ms.run/vxcontrol/scraper:latest 2>&1 | tail -2
docker images --format '{{.Repository}}:{{.Tag}}' | grep -i scraper
