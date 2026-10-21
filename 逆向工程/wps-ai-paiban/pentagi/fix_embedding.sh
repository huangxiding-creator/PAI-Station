#!/bin/bash
# 补配 embedding（智谱 embedding-3，OpenAI 兼容端点）并重建 pentagi 容器
set -e
cd /root/pentagi
python3 - <<'PY'
import re
env = open("/root/pentagi/.env", encoding="utf-8").read()
m = re.search(r"(?m)^GLM_API_KEY=(\S+)$", env)
key = m.group(1)
env = re.sub(r"(?m)^EMBEDDING_URL=.*$", "EMBEDDING_URL=https://open.bigmodel.cn/api/paas/v4", env)
env = re.sub(r"(?m)^EMBEDDING_KEY=.*$", f"EMBEDDING_KEY={key}", env)
env = re.sub(r"(?m)^EMBEDDING_MODEL=.*$", "EMBEDDING_MODEL=embedding-3", env)
env = re.sub(r"(?m)^EMBEDDING_PROVIDER=.*$", "EMBEDDING_PROVIDER=openai", env)
open("/root/pentagi/.env", "w", encoding="utf-8").write(env)
print("[env] embedding -> open.bigmodel.cn embedding-3 (provider=openai)")
PY
docker compose up -d pentagi 2>&1 | tail -3
sleep 10
echo "-- 日志尾 --"
docker logs pentagi --tail 8 2>&1 | grep -Ei "embedder|error|listening|Starting" || true
echo "-- 验活 --"
curl -k -s -o /dev/null -w "https://localhost:8443 -> HTTP %{http_code}\n" https://localhost:8443/
