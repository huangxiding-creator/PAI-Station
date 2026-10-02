# 1001 自测探针 v2：生产 DB 四表核验（aid 带前导杠，SQL 内用引号字面量）
import base64
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"
AID = "-5Ohm7ZS"

# SQL 本体 base64 直灌远端，绕开一切 shell 引号地狱
SQL_TEXT = (
    "SELECT 'POSTER|' || aid || '|' || env || '|' || length(b64) FROM posters "
    f"WHERE aid='{AID}';\n"
    "SELECT 'ANS|' || id || '|' || status || '|' || length(answer) || '|tldr' || (tldr IS NOT NULL) "
    f"|| '|rel' || (related IS NOT NULL) FROM answers WHERE id='{AID}';\n"
    "SELECT 'FU|' || id || '|' || status || '|' || length(answer) "
    f"FROM followups WHERE aid='{AID}';\n"
    "SELECT 'REW|' || action || '|x' || count(*) "
    f"FROM rewards WHERE aid='{AID}' GROUP BY action;\n"
)
sql_b64 = base64.b64encode(SQL_TEXT.encode()).decode()
remote = (
    f"echo {sql_b64} | base64 -d > /tmp/probe.sql && "
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite < /tmp/probe.sql"
)

r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "probe-v072b", "--CommandContent", remote,
     "--Timeout", "120"],
    capture_output=True, text=True, timeout=90)
if not r.stdout.strip():
    sys.exit("RunCommand failed: " + r.stderr[-400:])
inv = json.loads(r.stdout)["InvokeId"]
print("InvokeId:", inv)
for _ in range(25):
    time.sleep(2)
    g = subprocess.run(
        ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION,
         "--InvokeId", inv],
        capture_output=True, text=True, timeout=60)
    try:
        d = json.loads(g.stdout)
        res = d["Invocation"]["InvocationResults"]["InvocationResult"][0]
        st = res.get("InvocationStatus")
        if st in ("Finished", "Success", "Failed", "Cancelled", "Timeout"):
            print("Status:", st)
            print(res.get("Output", "")[:2500] or "(empty output)")
            sys.exit(0)
    except Exception as e:
        print("poll parse err:", e, g.stdout[:200])
print("TIMEOUT")
