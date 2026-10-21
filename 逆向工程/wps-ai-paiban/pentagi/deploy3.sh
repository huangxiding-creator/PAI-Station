#!/bin/bash
# PentAGI 部署三役：先修 WSL DNS，再拉最小栈
set -o pipefail
set -x

echo "== 1) 修 resolv.conf（NAT DNS 172.17.32.1 已死，切公网 DNS）=="
if ! grep -q 'nameserver 223.5.5.5' /etc/resolv.conf; then
  cp /etc/resolv.conf /etc/resolv.conf.bak.$(date +%s) 2>/dev/null || true
  printf 'nameserver 223.5.5.5\nnameserver 119.29.29.29\nnameserver 172.17.32.1\n' > /etc/resolv.conf
fi
# 防止 wsl 自动重生成（wsl.conf 已有 network 段则跳过）
if ! grep -q 'generateResolvConf' /etc/wsl.conf 2>/dev/null; then
  printf '\n[network]\ngenerateResolvConf = false\n' >> /etc/wsl.conf
fi
cat /etc/resolv.conf
nslookup docker.m.daocloud.io 2>&1 | tail -4 || true

echo "== 2) 拉最小栈 =="
cd /root/pentagi
for i in 1 2 3; do
  echo "-- 尝试 $i --"
  if docker compose up -d pentagi; then break; fi
  systemctl restart docker
  sleep 6
done

echo "== 3) 栈状态与验活 =="
docker compose ps
sleep 8
echo "-- 容器日志尾 --"
docker logs pentagi --tail 15 2>&1 || true
echo "-- HTTPS 验活 --"
curl -k -s -o /dev/null -w "https://localhost:8443 -> HTTP %{http_code}\n" https://localhost:8443/ || true
