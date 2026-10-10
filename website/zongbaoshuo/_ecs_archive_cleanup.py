# -*- coding: utf-8 -*-
"""_ecs_archive_cleanup.py — 删 ECS /root/archives/zongbaoshuo-legacy-1010.tar.gz 并验尸。
（qianwen-legacy-1002.tar.gz 不在本令范围，保留。）"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
NAME = "zbs-archive-cleanup"


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    if not r.stdout.strip():
        raise RuntimeError(f"aliyun empty out: {r.stderr[:300]}")
    return r.stdout


def ecs(script, wait=120):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", NAME,
              "--InstanceId.1", INSTANCE, "--Timeout", "120")
    iid = json.loads(out)["InvokeId"]
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(run("ecs", "DescribeInvocationResults",
                             "--RegionId", REGION, "--InvokeId", iid))
        rs = res.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("ExitCode") is not None:
            return rs[0]["ExitCode"], base64.b64decode(
                rs[0].get("Output") or "").decode("utf-8", "replace")
    return -1, "TIMEOUT"


code, out = ecs(
    "set -e; "
    "test -f /root/archives/zongbaoshuo-legacy-1010.tar.gz && echo FOUND; "
    "rm -f /root/archives/zongbaoshuo-legacy-1010.tar.gz; "
    "echo '== after ==' && ls -la /root/archives/; "
    "test ! -e /root/archives/zongbaoshuo-legacy-1010.tar.gz && echo VERIFIED_GONE")
print("exit:", code)
print(out)
