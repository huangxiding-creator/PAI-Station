#!/bin/bash
# PentAGI 部署脚本（WSL RE-Ubuntu 内执行）
set -e
if [ ! -d /root/pentagi/.git ] && [ ! -f /root/pentagi/.env ]; then
  cp -r /mnt/e/AI-Station/github/pentagi /root/pentagi
  echo "[copy] 仓库已复制到 /root/pentagi"
else
  echo "[copy] /root/pentagi 已存在，复用"
fi
python3 /mnt/e/AI-Station/逆向工程/wps-ai-paiban/pentagi/make_env.py || echo "[warn] 未找到 GLM 密钥，栈照常启动但无 LLM 供能"
cd /root/pentagi
echo "[compose] 拉取镜像并启动（后台继续，首次拉取可能数分钟）..."
docker compose up -d
docker compose ps
