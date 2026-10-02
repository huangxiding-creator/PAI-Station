# -*- coding: utf-8 -*-
"""1002 只读清点探针：ECS i-f8za6qhv 上与 qianwen 相关的部署物 vs 其他在役服务。
纯 ASCII 命令体，云助手直跑，零改动。"""
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"

REMOTE = r"""
echo '== running services (qianwen/laya/xueyuan/nginx/docker) =='
systemctl list-units --type=service --state=running --no-pager | grep -Ei 'qianwen|uvicorn|laya|xueyuan|market|nginx|docker|tengine' || echo none
echo '== listening ports =='
ss -tlnp 2>/dev/null | awk 'NR==1 || /LISTEN/'
echo '== /opt inventory =='
ls -la /opt
echo '== /opt/qianwen size =='
du -sh /opt/qianwen 2>/dev/null || echo none
echo '== nginx conf.d sites =='
ls -la /root/dify/docker/nginx/conf.d/ 2>/dev/null || echo none
echo '== docker containers =='
docker ps --format '{{.Names}} | {{.Ports}}' 2>/dev/null || echo no-docker
echo '== qianwen systemd unit =='
systemctl cat qianwen-engine 2>/dev/null | head -20 || echo no-unit
"""

r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "inv-clean-1002", "--CommandContent", REMOTE,
     "--Timeout", "60"],
    capture_output=True, text=True, timeout=90)
if r.returncode != 0:
    print("RunCommand failed:", r.stderr[:800])
    sys.exit(1)
inv = json.loads(r.stdout)["InvokeId"]
print("InvokeId:", inv)

for _ in range(20):
    time.sleep(3)
    g = subprocess.run(
        ["aliyun", "ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", inv],
        capture_output=True, text=True, timeout=60)
    d = json.loads(g.stdout)
    res = d["Invocation"]["InvocationResults"]["InvocationResult"][0]
    st = res.get("InvocationStatus")
    if st in ("Finished", "Success", "Failed", "Cancelled", "Timeout"):
        print("Status:", st)
        out = res.get("Output", "") or "(empty)"
        try:
            import base64
            out = base64.b64decode(out + "===").decode("utf-8", "replace")
        except Exception:
            pass
        print(out)
        sys.exit(0)
print("poll timeout")
sys.exit(1)
