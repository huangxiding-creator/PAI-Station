#!/bin/bash
# PentAGI 供能切换：GLM(余额耗尽) → DeepSeek
set -o pipefail
echo "== 1) 密钥入正仓（E盘 data/secrets，gitignored）=="
# 由调用方经环境变量传入，不在此文件硬编码
printf 'api_key=%s\n' "$DEEPSEEK_KEY" > /mnt/e/AI-Station/data/secrets/deepseek.secret
chmod 600 /mnt/e/AI-Station/data/secrets/deepseek.secret 2>/dev/null || true
echo "deepseek.secret 已写 (600)"

echo "== 2) PentAGI .env 切 DeepSeek =="
cd /root/pentagi
python3 - <<'PY'
import os, re
key = os.environ["DEEPSEEK_KEY"]
env = open("/root/pentagi/.env", encoding="utf-8").read()
env = re.sub(r"(?m)^DEEPSEEK_API_KEY=.*$", f"DEEPSEEK_API_KEY={key}", env)
env = re.sub(r"(?m)^DEEPSEEK_SERVER_URL=.*$", "DEEPSEEK_SERVER_URL=https://api.deepseek.com", env)
open("/root/pentagi/.env", "w", encoding="utf-8").write(env)
print("[env] DEEPSEEK_API_KEY =", key[:6] + "***" + key[-4:])
PY
docker compose up -d pentagi 2>&1 | tail -2
sleep 8
docker exec pentagi sh -c 'env | grep ^DEEPSEEK | sed -E "s/=(.{4}).*/=\1***/"'
echo ""
echo "== 3) DeepSeek 出站验活 =="
docker exec pentagi sh -c 'wget -q -T 10 -O /dev/null https://api.deepseek.com && echo DeepSeek端点可达 || echo 不可达'
echo ""
echo "== 4) 登录 + GraphQL createAssistant(modelProvider=deepseek) =="
BASE=https://localhost:8443/api/v1
C=/tmp/pt.cookie
NEWPW=$(cat /root/pentagi/.adminpw)
printf '{"mail":"admin@pentagi.com","password":"%s"}' "$NEWPW" > /tmp/pt_login3.json
curl -k -s -c $C -H 'Content-Type: application/json' --data @/tmp/pt_login3.json -w ' [login %{http_code}]\n' $BASE/auth/login | head -c 60; echo

cat > /tmp/pt_ds.json <<'EOF'
{"query":"mutation($flowId: ID!, $modelProvider: String!, $input: String!, $useAgents: Boolean!, $resourceIds: [ID!]) { createAssistant(flowId: $flowId, modelProvider: $modelProvider, input: $input, useAgents: $useAgents, resourceIds: $resourceIds) { flow { id title status } assistant { id status title } } }",
 "variables":{"flowId":"0","modelProvider":"deepseek","input":"基于以下本机授权测绘事实输出攻击面研判清单（只分析，禁止任何对外扫描/联网）：1) wpscloudsvr.exe 监听 0.0.0.0:46608 与 127.0.0.1:4709，私有协议不吃明文HTTP；2) Copilot侧边栏链路 kcopilotentry.dll→kwpsaitypeset.dll(JS API注入)→KSOLITE.DLL AES；3) 本地模板容器为固定IV AES-128-CBC（相等预言机/内容指纹泄露）；4) 会员门禁走 personal-ai-bus.wps.cn + VAS pay-counter。按风险排序给缓解建议，中文回答。","useAgents":false,"resourceIds":[]}}
EOF
curl -k -s -b $C -X POST -H 'Content-Type: application/json' \
  --data @/tmp/pt_ds.json -w '\nHTTP=%{http_code}\n' $BASE/graphql | head -c 400; echo
