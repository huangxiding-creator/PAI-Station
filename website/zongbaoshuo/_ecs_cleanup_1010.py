# -*- coding: utf-8 -*-
"""_ecs_cleanup_1010.py — 清理 ECS 上的总包说官网（用户 1010 令）。
备份→摘 conf→reload→删 root→关 ufw→本机探针验证。"""
import base64
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
NAME = "zbs-cleanup"

SCRIPT = r"""
set -e
echo '=== [1] backup ==='
mkdir -p /root/archives
tar czf /root/archives/zongbaoshuo-legacy-1010.tar.gz /www/ZongBaoShuo /etc/nginx/conf.d/zongbaoshuo-8884.conf 2>/dev/null
md5sum /root/archives/zongbaoshuo-legacy-1010.tar.gz
stat -c%s /root/archives/zongbaoshuo-legacy-1010.tar.gz
echo '=== [2] remove conf + reload ==='
rm -f /etc/nginx/conf.d/zongbaoshuo-8884.conf
nginx -t 2>&1
systemctl reload nginx && echo RELOAD_OK
echo '=== [3] remove root ==='
rm -rf /www/ZongBaoShuo
test ! -e /www/ZongBaoShuo && echo ROOT_GONE
echo '=== [4] ufw close ==='
ufw delete allow 8884/tcp 2>&1 || true
ufw delete allow 8889/tcp 2>&1 || true
ufw status | grep -E '8884|8889' || echo UFW_CLOSED
echo '=== [5] local probe ==='
curl -s -o /dev/null -w '8884=%{http_code}\n' -m 3 http://127.0.0.1:8884/ 2>&1 || echo 8884_dead
curl -s -o /dev/null -w '8889=%{http_code}\n' -m 3 http://127.0.0.1:8889/ 2>&1 || echo 8889_dead
ss -tlnp | grep -E ':(8884|8889)\b' || echo NO_LISTENER
echo '=== neighbors alive check ==='
curl -s -o /dev/null -w 'paistation8882=%{http_code}\n' -m 3 http://127.0.0.1:8882/ || echo 8882_dead
curl -s -o /dev/null -w 'xueyuan8871=%{http_code}\n' -m 3 http://127.0.0.1:8871/ || echo 8871_dead
"""


def run(*a, timeout=90):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    if not r.stdout.strip():
        raise RuntimeError(f"aliyun empty out: {r.stderr[:300]}")
    return r.stdout


def ecs(script, wait=240):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", NAME,
              "--InstanceId.1", INSTANCE, "--Timeout", "240")
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
    ok = all(k in out for k in ("RELOAD_OK", "ROOT_GONE", "UFW_CLOSED", "NO_LISTENER"))
    print("CLEANUP_VERDICT:", "OK" if ok and code == 0 else "CHECK_ABOVE")
