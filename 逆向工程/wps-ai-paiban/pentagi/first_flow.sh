#!/bin/bash
# PentAGI 首个授权 flow 终版：改密 → 一发建 flow+assistant 并跑 GLM 研判
set -o pipefail
BASE=https://localhost:8443/api/v1
C=/tmp/pt.cookie
NEWPW='WpsAiPaiban2026x'
printf '%s' "$NEWPW" > /root/pentagi/.adminpw; chmod 600 /root/pentagi/.adminpw

echo "== 1) 登录 =="
curl -k -s -c $C -H 'Content-Type: application/json' \
  -d '{"mail":"admin@pentagi.com","password":"admin"}' \
  -w ' HTTP=%{http_code}\n' $BASE/auth/login | head -c 120; echo

echo "== 2) 改密（snake_case）=="
printf '{"current_password":"admin","password":"%s","confirm_password":"%s"}' "$NEWPW" "$NEWPW" > /tmp/pt_pw.json
curl -k -s -b $C -c $C -X PUT -H 'Content-Type: application/json' \
  --data @/tmp/pt_pw.json -w ' HTTP=%{http_code}\n' $BASE/user/password | head -c 160; echo

echo "== 3) 一发建 flow+assistant（provider=glm）=="
cat > /tmp/pt_ask.json <<'EOF'
{"input":"基于以下本机授权测绘事实，输出攻击面研判清单（只分析，禁止任何对外扫描/联网动作）：1) wpscloudsvr.exe 监听 0.0.0.0:46608 与 127.0.0.1:4709，私有协议不吃明文HTTP；2) Copilot侧边栏链路 kcopilotentry.dll→kwpsaitypeset.dll(JS API注入)→KSOLITE.DLL AES；3) 本地模板容器为固定IV AES-128-CBC（相等预言机/内容指纹泄露）；4) 会员门禁走 personal-ai-bus.wps.cn + VAS pay-counter。请按风险排序给缓解建议，中文回答。","provider":"glm"}
EOF
curl -k -s -b $C -X POST -H 'Content-Type: application/json' \
  --data @/tmp/pt_ask.json -w '\nHTTP=%{http_code}\n' \
  $BASE/flows/0/assistants/ | head -c 600; echo
