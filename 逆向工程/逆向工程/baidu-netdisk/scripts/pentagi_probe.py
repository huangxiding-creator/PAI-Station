# -*- coding: utf-8 -*-
"""PentAGI 短提示探针：隔离「基础设施死」vs「长提示噎死」"""
import json, ssl, subprocess, sys, time, urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BASE = "https://localhost:8443"
CTX = ssl._create_unverified_context()


def wsl(cmd):
    r = subprocess.run(["wsl", "-d", "RE-Ubuntu", "-u", "root", "--", "sh", "-c", cmd],
                       capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=60)
    return r.stdout.strip()


def http(url, data=None, cookie=None):
    req = urllib.request.Request(url, data=json.dumps(data).encode() if data else None,
                                 headers={"Content-Type": "application/json"})
    if cookie:
        req.add_header("Cookie", cookie)
    with urllib.request.urlopen(req, timeout=30, context=CTX) as r:
        return r.status, r.read().decode("utf-8", "replace"), r.headers.get("Set-Cookie", "")


pw = wsl("cat /root/pentagi/.adminpw")
_, _, sc = http(f"{BASE}/api/v1/auth/login", {"mail": "admin@pentagi.com", "password": pw})
cookie = sc.split(";")[0]
base_n = int(wsl("cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
                 + '"SELECT count(*) FROM msglogs;"'))
gql = {"query": "mutation($flowId: ID!, $modelProvider: String!, $input: String!, $useAgents: Boolean!, $resourceIds: [ID!]) { createAssistant(flowId: $flowId, modelProvider: $modelProvider, input: $input, useAgents: $useAgents, resourceIds: $resourceIds) { flow { id status } assistant { id status } } }",
       "variables": {"flowId": "0", "modelProvider": "glm", "input": "回答一个词：1+1=?（连通性探针）",
                      "useAgents": False, "resourceIds": []}}
st, body, _ = http(f"{BASE}/api/v1/graphql", gql, cookie=cookie)
print("create:", st, body[:150])
for i in range(16):  # 最多 4 分钟
    time.sleep(15)
    n = int(wsl("cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
                + '"SELECT count(*) FROM msglogs;"'))
    print(f"poll {i+1}/16 count={n}")
    if n > base_n:
        rows = wsl("cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
                   + f'"SELECT type || \'|||\' || left(info, 2000) FROM msglogs WHERE id > {base_n} ORDER BY id;"')
        print("PROBE-OK:")
        print(rows[:1500])
        sys.exit(0)
print("PROBE-FAIL: 短提示也无果 → 基础设施级卡死（assistant worker/GLM 调用链）")
sys.exit(3)
