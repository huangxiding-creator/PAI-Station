# 1001 一次性雷达：真机首验检查（新域名 api.yrecepc.cn）
# 判读注意：模拟器自测流量（约 11:20-12:00）也是走 yrecepc 的，须用 UA/时间区分真机
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"

remote = (
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite "
    "\"SELECT id, substr(question,1,24), created_at, datetime(created_at,'unixepoch','+8 hours') "
    "FROM answers ORDER BY id DESC LIMIT 5;\" ; "
    "echo ---NGINX--- ; "
    "docker logs docker-nginx-1 --since 40m 2>&1 | grep -i yrecepc | tail -10 ; "
    "echo ---UA-COUNT--- ; "
    "docker logs docker-nginx-1 --since 40m 2>&1 | grep -i yrecepc "
    "| grep -c 'MicroMessenger' || true"
)

r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "radar-yrecepc-1001", "--CommandContent", remote,
     "--Timeout", "120"],
    capture_output=True, text=True, timeout=90)
if not r.stdout.strip():
    sys.exit("RunCommand failed: " + r.stderr[-400:])
inv = json.loads(r.stdout)["InvokeId"]
for _ in range(25):
    time.sleep(2)
    g = subprocess.run(
        ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", inv],
        capture_output=True, text=True, timeout=60)
    try:
        res = json.loads(g.stdout)["Invocation"]["InvocationResults"]["InvocationResult"][0]
        st = res.get("InvocationStatus")
        if st in ("Finished", "Success", "Failed", "Cancelled", "Timeout"):
            print("Status:", st)
            print(res.get("Output", "")[:3000] or "(empty)")
            sys.exit(0)
    except Exception as e:
        print("poll err:", e, g.stdout[:150])
print("TIMEOUT")
