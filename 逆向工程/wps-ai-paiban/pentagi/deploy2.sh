#!/bin/bash
# PentAGI 最小栈部署（pentagi+pgvector，跳过 quay.io 的 postgres-exporter 监控件）
set -x
cd /root/pentagi

echo "== 现有 daemon.json =="
cat /etc/docker/daemon.json 2>/dev/null || echo "(无)"

echo "== 拉取最小栈镜像 =="
if ! docker compose up -d pentagi 2>&1 | tail -20; then
  echo "== 直连失败，配置镜像加速兜底 =="
  python3 - <<'PY'
import json, os
p = "/etc/docker/daemon.json"
cfg = {}
if os.path.exists(p):
    try:
        cfg = json.load(open(p))
    except Exception:
        cfg = {}
cfg.setdefault("registry-mirrors", [
    "https://docker.m.daocloud.io",
    "https://docker.1ms.run",
    "https://hub.rat.dev",
])
json.dump(cfg, open(p, "w"), indent=2)
print("daemon.json ->", cfg)
PY
  systemctl restart docker
  sleep 5
  echo "== 重试 =="
  docker compose up -d pentagi 2>&1 | tail -20
fi

echo "== 栈状态 =="
docker compose ps
