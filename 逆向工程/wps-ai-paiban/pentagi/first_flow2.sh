#!/bin/bash
# PentAGI 首个 flow（GraphQL 正道）：createAssistant(flowId:0, modelProvider, input, useAgents)
set -o pipefail
BASE=https://localhost:8443
C=/tmp/pt.cookie
cat > /tmp/pt_gql.json <<'EOF'
{"query":"mutation($flowId: ID!, $modelProvider: String!, $input: String!, $useAgents: Boolean!, $resourceIds: [ID!]) { createAssistant(flowId: $flowId, modelProvider: $modelProvider, input: $input, useAgents: $useAgents, resourceIds: $resourceIds) { flow { id title status } assistant { id status title } } }",
 "variables":{"flowId":"0","modelProvider":"glm","input":"基于以下本机授权测绘事实输出攻击面研判清单（只分析，禁止任何对外扫描/联网）：1) wpscloudsvr.exe 监听 0.0.0.0:46608 与 127.0.0.1:4709，私有协议不吃明文HTTP；2) Copilot侧边栏链路 kcopilotentry.dll→kwpsaitypeset.dll(JS API注入)→KSOLITE.DLL AES；3) 本地模板容器为固定IV AES-128-CBC（相等预言机/内容指纹泄露）；4) 会员门禁走 personal-ai-bus.wps.cn + VAS pay-counter。按风险排序给缓解建议，中文回答。","useAgents":false,"resourceIds":[]}}
EOF
echo "== createAssistant (GraphQL, flowId=0) =="
curl -k -s -b $C -X POST -H 'Content-Type: application/json' \
  --data @/tmp/pt_gql.json -w '\nHTTP=%{http_code}\n' $BASE/api/v1/graphql | head -c 500; echo
