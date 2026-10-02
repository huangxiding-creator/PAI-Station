# -*- coding: utf-8 -*-
"""1002 只读探针第二轮：清理矩阵所需事实——vhost 内容/证书位/certbot 定时器/
qianwen 数据与 secret 落位（只列名不读值）/ufw 规则。零改动。"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
IID = "i-f8za6qhv365cwhti5y35"

REMOTE = r"""
echo '== api-yrecepc.conf =='
cat /root/dify/docker/nginx/conf.d/api-yrecepc.conf
echo '== api-gcbrain.conf =='
cat /root/dify/docker/nginx/conf.d/api-gcbrain.conf
echo '== letsencrypt live =='
ls /etc/letsencrypt/live 2>/dev/null || echo none
echo '== certbot cron/timers =='
crontab -l 2>/dev/null | grep -Ei 'certbot|acme|renew' || echo no-crontab-entry
systemctl list-timers --no-pager 2>/dev/null | grep -Ei 'certbot|acme' || echo no-timer
echo '== /opt/qianwen tree (2 levels) =='
find /opt/qianwen -maxdepth 2 | head -40
echo '== qianwen sqlite/secrets names only =='
find /opt/qianwen -maxdepth 4 \( -name '*.sqlite*' -o -name 'secrets' -o -name '*.pem' -o -name '*.key' \) 2>/dev/null | head -30
echo '== data dir sizes =='
du -sh /opt/qianwen/data 2>/dev/null; du -sh /opt/qianwen/services 2>/dev/null; du -sh /opt/qianwen/venv 2>/dev/null
echo '== ufw rules (8869/8871/80/443) =='
ufw status 2>/dev/null | grep -E '8869|8871|^80|^443|Anywhere' | head -20 || echo ufw-na
echo '== root dir audit scripts =='
ls /root/ 2>/dev/null | head -30
"""

r = subprocess.run(
    ["aliyun", "ecs", "RunCommand", "--RegionId", REGION, "--InstanceId.1", IID,
     "--Type", "RunShellScript", "--Name", "inv2-clean-1002", "--CommandContent", REMOTE,
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
            out = base64.b64decode(out + "===").decode("utf-8", "replace")
        except Exception:
            pass
        print(out)
        sys.exit(0)
print("poll timeout")
sys.exit(1)
