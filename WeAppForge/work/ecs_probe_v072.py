# 1001 自测：经阿里云助手探生产 DB（poster/answer/followup/quota 四表核验）
import base64
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"

SQL = (
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite "
    '"SELECT \'POSTER|\||aid|\'||aid||\'|\'||env||\'|\'||length(b64) FROM posters WHERE aid=\'-5Ohm7ZS\';" ; '
    "echo --- ; "
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite "
    '"SELECT \'ANS|\'||id||\'|\'||status||\'|\'||length(answer)||\'|tldr\'||(tldr IS NOT NULL)||\'|rel\'||(related IS NOT NULL) FROM answers WHERE id=\'-5Ohm7ZS\';" ; '
    "echo --- ; "
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite "
    '"SELECT \'FU|\'||id||\'|\'||status||\'|\'||length(answer) FROM followups WHERE aid=\'-5Ohm7ZS\';" ; '
    "echo --- ; "
    "sqlite3 /opt/qianwen/data/qianwen/db.sqlite "
    '"SELECT \'REW|\'||action||\'|x\'||count(*) FROM rewards WHERE aid=\'-5Ohm7ZS\' GROUP BY action;"'
)


def run(cmd):
    b64 = base64.b64encode(cmd.encode()).decode()
    r = subprocess.run(
        ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
         "--Type", "RunShellScript", "--Name", "probe-v072", "--CommandContent", b64],
        capture_output=True, text=True, timeout=90)
    if not r.stdout.strip():
        sys.exit("RunCommand failed: " + r.stderr[-500:])
    inv = json.loads(r.stdout)["InvokeId"]
    for _ in range(20):
        time.sleep(2)
        g = subprocess.run(["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION,
                            "--InvokeId", inv], capture_output=True, text=True, timeout=60)
        try:
            res = json.loads(g.stdout)["Invocation"]["InvocationResults"]["InvocationResult"][0]
        except Exception:
            continue
        if res.get("InvocationStatus") in ("Finished", "Success", "Failed"):
            print(res.get("Output", "")[:3000])
            return
    print("TIMEOUT waiting invocation", inv)


if __name__ == "__main__":
    run(SQL)
