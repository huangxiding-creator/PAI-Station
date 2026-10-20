# -*- coding: utf-8 -*-
"""_ecs_recon_1010.py — 侦察 ECS 上总包说官网足迹（8884/8889/nginx conf/root 目录）。
只读不改。"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
NAME = "zbs-recon"

SCRIPT = r"""
echo '=== listeners 8884/8889 ==='
ss -tlnp | grep -E ':(8884|8889)\b' || echo NONE
echo '=== nginx conf files mentioning ZongBaoShuo/8884/8889 ==='
grep -rlE '8884|8889|ZongBaoShuo' /etc/nginx/ /www/server/nginx/conf/ 2>/dev/null | grep -v access.log | grep -v error.log || echo NONE
echo '=== conf contents ==='
for f in $(grep -rlE '8884|8889|ZongBaoShuo' /etc/nginx/ /www/server/nginx/conf/ 2>/dev/null | grep -vE 'access|error\.log'); do echo "--- $f"; cat "$f"; done
echo '=== root dir ==='
ls -la /www/ZongBaoShuo/ 2>/dev/null || echo NO_DIR
du -sh /www/ZongBaoShuo 2>/dev/null
echo '=== nginx process shape ==='
ps aux | grep -E 'nginx: master' | grep -v grep
echo '=== ufw rules for 8884/8889 ==='
ufw status | grep -E '8884|8889' || echo UFW_NONE
echo '=== local probe ==='
curl -s -o /dev/null -w '8884=%{http_code}\n' -m 3 http://127.0.0.1:8884/ || echo 8884_dead
curl -s -o /dev/null -w '8889=%{http_code}\n' -m 3 http://127.0.0.1:8889/ || echo 8889_dead
"""


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    if not r.stdout.strip():
        raise RuntimeError(f"aliyun empty out: {r.stderr[:300]}")
    return r.stdout


def ecs(script, wait=180):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", NAME,
              "--InstanceId.1", INSTANCE, "--Timeout", "180")
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


if __name__ == "__main__":
    code, out = ecs(SCRIPT)
    print(f"exit={code}")
    print(out)
