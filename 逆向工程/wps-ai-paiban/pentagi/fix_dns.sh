#!/bin/bash
# DNS 根治：systemd-resolved 上游固化公网 DNS，关闭 stub 冲突，恢复 resolv.conf 实义文件
set -o pipefail
echo "== 现状 =="
cat /etc/resolv.conf
systemctl is-active systemd-resolved || true

echo "== 修 systemd-resolved 上游 =="
if grep -q '^\[Resolve\]' /etc/systemd/resolved.conf 2>/dev/null; then
  sed -i 's/^#\?DNS=.*/DNS=223.5.5.5 119.29.29.29/' /etc/systemd/resolved.conf
  grep -q '^DNS=' /etc/systemd/resolved.conf || sed -i '/^\[Resolve\]/a DNS=223.5.5.5 119.29.29.29' /etc/systemd/resolved.conf
  grep -q '^DNSStubListener=' /etc/systemd/resolved.conf && sed -i 's/^#\?DNSStubListener=.*/DNSStubListener=no/' /etc/systemd/resolved.conf || sed -i '/^\[Resolve\]/a DNSStubListener=no' /etc/systemd/resolved.conf
else
  printf '[Resolve]\nDNS=223.5.5.5 119.29.29.29\nDNSStubListener=no\n' > /etc/systemd/resolved.conf
fi
systemctl restart systemd-resolved || true
sleep 2

echo "== resolv.conf 实义化 =="
printf 'nameserver 223.5.5.5\nnameserver 119.29.29.29\n' > /etc/resolv.conf
cat /etc/resolv.conf
getent hosts open.bigmodel.cn || echo "!! 主机侧解析仍失败"

echo "== 重启 docker 刷新容器 DNS =="
systemctl restart docker
sleep 6

echo "== 只起最小栈（不碰 exporter/scraper）=="
cd /root/pentagi
docker compose up -d pentagi 2>&1 | tail -3
sleep 14
docker compose ps

echo "== 容器内出站验证 =="
docker exec pentagi sh -c 'wget -q -T 8 -O /dev/null https://open.bigmodel.cn/api/paas/v4 && echo GLM端点可达 || (wget -q -T 8 -O /dev/null https://docker.m.daocloud.io && echo 仅镜像域可达 || echo 全不可达)'

echo "== 日志与验活 =="
docker logs pentagi --since 2m 2>&1 | grep -Ei 'listening|fatal|error|embedder' | tail -6
curl -k -s -o /dev/null -w "https://localhost:8443 -> HTTP %{http_code}\n" https://localhost:8443/
