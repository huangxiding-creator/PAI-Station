# -*- coding: utf-8 -*-
"""1002 通用云助手执行器：python ecs_run_1002.py <remote_script_file>
回传完整 Output（b64 解码），失败退出码非 0。"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

if len(sys.argv) != 2:
    print("usage: ecs_run_1002.py <remote_script_file>")
    sys.exit(2)

REMOTE = open(sys.argv[1], encoding="utf-8").read()
REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"

r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "run-clean-1002", "--CommandContent", REMOTE,
     "--Timeout", "120"],
    capture_output=True, text=True, timeout=120)
if r.returncode != 0:
    print("RunCommand failed:", r.stderr[:800])
    sys.exit(1)
inv = json.loads(r.stdout)["InvokeId"]

for _ in range(40):
    time.sleep(3)
    g = subprocess.run(
        ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", inv],
        capture_output=True, text=True, timeout=60)
    d = json.loads(g.stdout)
    res = d["Invocation"]["InvocationResults"]["InvocationResult"][0]
    st = res.get("InvocationStatus")
    if st in ("Finished", "Success", "Failed", "Cancelled", "Timeout"):
        out = res.get("Output", "") or "(empty)"
        try:
            out = base64.b64decode(out + "===").decode("utf-8", "replace")
        except Exception:
            pass
        code = res.get("ExitCode", "?")
        print(f"Status={st} ExitCode={code}")
        print(out)
        sys.exit(0 if st in ("Finished", "Success") and str(code) in ("0", "?") else 1)
print("poll timeout")
sys.exit(1)
