# -*- coding: utf-8 -*-
"""_ecs_archives_probe.py — 列 ECS /root/archives/ 内容（删前侦察）。"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
NAME = "zbs-archives-probe"


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
    "echo '== /root/archives ==' && ls -la /root/archives/ 2>&1; "
    "echo '== du ==' && du -sh /root/archives/ 2>&1; "
    "echo '== other /www ==' && ls /www/ 2>&1")
print("exit:", code)
print(out)
