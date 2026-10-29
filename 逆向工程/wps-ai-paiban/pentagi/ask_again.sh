#!/bin/bash
set -o pipefail
BASE=https://localhost:8443/api/v1
C=/tmp/pt.cookie
echo "== 登录（新口令）=="
NEWPW=$(cat /root/pentagi/.adminpw)
printf '{"mail":"admin@pentagi.com","password":"%s"}' "$NEWPW" > /tmp/pt_login2.json
curl -k -s -c $C -H 'Content-Type: application/json' --data @/tmp/pt_login2.json \
  -w ' HTTP=%{http_code}\n' $BASE/auth/login | head -c 120; echo
echo "== 复用 flow 1 再发 assistant =="
cat > /tmp/pt_ask.json <<'EOF'
{"input":"基于以下本机授权测绘事实输出攻击面研判清单（只分析，禁止任何对外扫描/联网）：1) wpscloudsvr.exe 监听 0.0.0.0:46608 与 127.0.0.1:4709，私有协议不吃明文HTTP；2) Copilot侧边栏链路 kcopilotentry.dll→kwpsaitypeset.dll(JS API注入)→KSOLITE.DLL AES；3) 本地模板容器为固定IV AES-128-CBC（相等预言机/内容指纹泄露）；4) 会员门禁走 personal-ai-bus.wps.cn + VAS pay-counter。按风险排序给缓解建议，中文回答。","provider":"glm"}
EOF
curl -k -s -b $C -X POST -H 'Content-Type: application/json' --data @/tmp/pt_ask.json \
  -w '\nHTTP=%{http_code}\n' $BASE/flows/1/assistants/ | head -c 300; echo
