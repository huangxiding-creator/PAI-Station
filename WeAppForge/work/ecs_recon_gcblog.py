# -*- coding: utf-8 -*-
"""ECS 侦察（只读不动网）：本机 nginx 里 dify.gcblog.net 如何被服务、
certbot 已管哪些域名、ACME 用什么方式——判断 gcblog.net 家族子域名能否当天新增 HTTPS。"""
import base64
import json
import subprocess
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True, timeout=timeout,
                       encoding="utf-8", errors="replace")
    return r.stdout


def ecs(script, name, wait=180):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              "--InstanceId.1", INSTANCE, "--Timeout", "300")
    iid = json.loads(out)["InvokeId"]
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(run("ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", iid))
        rs = res.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("ExitCode") is not None:
            return rs[0]["ExitCode"], base64.b64decode(rs[0].get("Output") or b"").decode("utf-8", "replace")
    return -1, "TIMEOUT"


SCRIPT = r'''
echo "=== conf.d files ==="
ls -la /root/dify/docker/nginx/conf.d/
echo "=== nginx -T: server blocks (name/cert/listen/upstream) ==="
docker exec docker-nginx-1 nginx -T 2>/dev/null | grep -nE "server_name|ssl_certificate |listen |proxy_pass " | head -60
echo "=== certbot renewal certs ==="
ls -1 /root/dify/docker/volumes/certbot/conf/renewal/ 2>/dev/null
echo "=== renewal confs (authenticator / webroot) ==="
grep -H -E "authenticator|webroot_path" /root/dify/docker/volumes/certbot/conf/renewal/*.conf 2>/dev/null
echo "=== live cert dirs ==="
ls -1 /root/dify/docker/volumes/certbot/conf/live/ 2>/dev/null
echo "=== host letsencrypt ==="
ls -1 /etc/letsencrypt/live 2>/dev/null
cat /etc/letsencrypt/cli.ini 2>/dev/null
'''

if __name__ == "__main__":
    code, out = ecs(SCRIPT, "qw-gcblog-recon")
    print("exit", code)
    print(out)
