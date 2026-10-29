# -*- coding: utf-8 -*-
"""PentAGI 独立审计调度器：GLM 审计 PROTOCOL.md（三件套之 PentAGI 腿实证）
链路：wsl 取 admin 密码 → /api/v1/auth/login → GraphQL createAssistant(glm) → pg msglogs 轮询收果
产物：analysis/PENTAGI_PROTOCOL_AUDIT_1029.md
用法: python -I pentagi_audit.py   （账本：wps-ai-paiban/pentagi/README-运维手册.md）
"""
import json, ssl, subprocess, sys, time, urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
BASE = "https://localhost:8443"
PROTOCOL = r"E:\AI-Station\逆向工程\baidu-netdisk\PROTOCOL.md"
OUT = r"E:\AI-Station\逆向工程\baidu-netdisk\analysis\PENTAGI_PROTOCOL_AUDIT_1029.md"
CTX = ssl._create_unverified_context()


def wsl(cmd: str) -> str:
    r = subprocess.run(["wsl", "-d", "RE-Ubuntu", "-u", "root", "--", "sh", "-c", cmd],
                       capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=60)
    if r.returncode != 0:
        raise RuntimeError(f"wsl 失败: {r.stderr[:200]}")
    return r.stdout.strip()


def http(url, data=None, cookie=None):
    req = urllib.request.Request(url, data=json.dumps(data).encode() if data else None,
                                 headers={"Content-Type": "application/json"})
    if cookie:
        req.add_header("Cookie", cookie)
    with urllib.request.urlopen(req, timeout=30, context=CTX) as r:
        return r.status, r.read().decode("utf-8", "replace"), r.headers.get("Set-Cookie", "")


def main() -> int:
    pw = wsl("cat /root/pentagi/.adminpw")
    print(f"[pentagi] adminpw: {'*' * len(pw)} (len={len(pw)})")
    st, body, sc = http(f"{BASE}/api/v1/auth/login",
                        {"mail": "admin@pentagi.com", "password": pw})
    print(f"[pentagi] login: HTTP {st}")
    if st != 200:
        print(body[:300]); return 1
    cookie = sc.split(";")[0]
    baseline = int(wsl(
        "cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
        + '"SELECT count(*) FROM msglogs;"'))
    print(f"[pentagi] msglogs baseline = {baseline}")
    protocol = open(PROTOCOL, encoding="utf-8").read()
    prompt = ("你是独立协议审计员（对抗视角）。以下是百度网盘 8.2.5 逆向规格书 PROTOCOL.md。"
              "请审计并输出四节清单（中文，逐条给行内证据）："
              "1)端点表内部矛盾或重复冲突项；2)错误码覆盖缺口（对照常见 errno 家族）；"
              "3)证据分级可疑项（标A级但参数形态可疑/像推断的）；"
              "4)对基于此规格书实现的第三方 CLI 的账号风控/安全风险提示（按严重度排序）。\n\n"
              + protocol[:40000])
    gql = {"query": "mutation($flowId: ID!, $modelProvider: String!, $input: String!, $useAgents: Boolean!, $resourceIds: [ID!]) { createAssistant(flowId: $flowId, modelProvider: $modelProvider, input: $input, useAgents: $useAgents, resourceIds: $resourceIds) { flow { id title status } assistant { id status title } } }",
           "variables": {"flowId": "0", "modelProvider": "glm", "input": prompt,
                          "useAgents": False, "resourceIds": []}}
    st, body, _ = http(f"{BASE}/api/v1/graphql", gql, cookie=cookie)
    print(f"[pentagi] createAssistant: HTTP {st} {body[:200]}")
    if st != 200:
        return 2
    flow_id = json.loads(body)["data"]["createAssistant"]["flow"]["id"]
    print(f"[pentagi] flowId={flow_id} 轮询开始")
    for i in range(48):  # 最多 12 分钟
        time.sleep(15)
        n = int(wsl("cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
                    + '"SELECT count(*) FROM msglogs;"'))
        if n > baseline:
            rows = wsl("cd /root/pentagi && docker compose exec -T pgvector psql -U postgres -d pentagidb -t -A -c "
                       + f'"SELECT type || \'|||\' || left(info, 12000) FROM msglogs WHERE id > {baseline} ORDER BY id;"')
            print(f"[pentagi] 收果 {n - baseline} 行 (第{i + 1}轮)")
            with open(OUT, "w", encoding="utf-8") as f:
                f.write("# PentAGI 独立审计 · PROTOCOL.md（GLM, 2026-10-29）\n\n"
                        f"- flow: {flow_id} | 轮询 {i + 1} 轮 | msglogs +{n - baseline}\n\n---\n\n")
                for line in rows.splitlines():
                    if "|||" in line:
                        t, info = line.split("|||", 1)
                        f.write(f"\n## msglog[{t}]\n\n{info}\n")
            print(f"[pentagi] 已落盘 {OUT}")
            return 0
        print(f"[pentagi] 等待中 {i + 1}/48 (count={n})")
    print("[pentagi] 超时未收果")
    return 3


if __name__ == "__main__":
    raise SystemExit(main())
