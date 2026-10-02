# -*- coding: utf-8 -*-
"""备案审核期关站：api.gcbrain.top 80段 301→444（连接即断=未开站），ACME路径保留备用。
备案通过后由 ecs_gcbrain_ignite.py 点火443（并在点火时把444恢复为301）。"""
import base64
import json
import subprocess
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"

CONF = """# qianwen engine vhost (api.gcbrain.top) -- 备案审核期：关站444（ACME路径备用）
# 0930: ICP备案提交前 301→444=未开站；通过后 ignite 点火443并恢复301
server {
    listen 80;
    server_name api.gcbrain.top;
    location /.well-known/acme-challenge/ { root /var/www/html; }
    location / { return 444; }
}
"""


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


if __name__ == "__main__":
    script = (
        "cat > /root/dify/docker/nginx/conf.d/api-gcbrain.conf <<'EOF'\n" + CONF + "EOF\n"
        "docker exec docker-nginx-1 nginx -t 2>&1 && "
        "docker exec docker-nginx-1 nginx -s reload && sleep 1 && "
        "curl -s -o /dev/null -w 'local80=%{http_code}' -H 'Host: api.gcbrain.top' "
        "http://127.0.0.1/api/health; echo"
    )
    code, out = ecs(script, "qw-gcb-close80")
    print("exit", code)
    print(out)
