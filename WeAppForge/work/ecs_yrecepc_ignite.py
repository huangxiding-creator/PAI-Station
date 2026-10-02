# -*- coding: utf-8 -*-
"""api.yrecepc.cn HTTPS 点火（域名已备案，无需等审核）：
DNS 校验→80 vhost(ACME+444)→LE 证书(HTTP-01 webroot)→全量 conf(80=301/443=ssl proxy)→热加载→公网自检。
与 ecs_gcbrain_ignite.py 同配方；幂等可重跑。前置：用户已加 A 记录 api.yrecepc.cn→47.120.43.20。"""
import base64
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
DOMAIN = "api.yrecepc.cn"
CONF = "/root/dify/docker/nginx/conf.d/api-yrecepc.conf"

VHOST_80_BOOT = f'''server {{
    listen 80;
    server_name {DOMAIN};
    location /.well-known/acme-challenge/ {{ root /var/www/html; }}
    location / {{ return 444; }}
}}
'''

VHOST_FULL = f'''server {{
    listen 80;
    server_name {DOMAIN};
    location /.well-known/acme-challenge/ {{ root /var/www/html; }}
    location / {{ return 301 https://$host$request_uri; }}
}}
server {{
    listen 443 ssl;
    http2 on;
    server_name {DOMAIN};
    ssl_certificate /etc/letsencrypt/live/{DOMAIN}/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/{DOMAIN}/privkey.pem;
    ssl_protocols TLSv1.2 TLSv1.3;
    add_header Strict-Transport-Security "max-age=31536000" always;
    location / {{
        proxy_pass http://172.29.8.146:8869;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_read_timeout 120s;
        proxy_send_timeout 120s;
        client_max_body_size 12m;
    }}
}}
'''


def run(*a, timeout=60):
    r = subprocess.run(["aliyun", *a], capture_output=True, text=True, timeout=timeout)
    return r.stdout


def ecs(script, name, wait=420):
    out = run("ecs", "RunCommand", "--RegionId", REGION, "--Type", "RunShellScript",
              "--CommandContent", script, "--Name", name,
              "--InstanceId.1", INSTANCE, "--Timeout", "600")
    iid = json.loads(out)["InvokeId"]
    for _ in range(int(wait / 3)):
        time.sleep(3)
        res = json.loads(run("ecs", "DescribeInvocationResults", "--RegionId", REGION, "--InvokeId", iid))
        rs = res.get("Invocation", {}).get("InvocationResults", {}).get("InvocationResult", [])
        if rs and rs[0].get("ExitCode") is not None:
            return rs[0]["ExitCode"], base64.b64decode(rs[0].get("Output") or b"").decode("utf-8", "replace")
    return -1, "TIMEOUT"


def nginx_test_reload():
    return "docker exec docker-nginx-1 nginx -t 2>&1 && docker exec docker-nginx-1 nginx -s reload"


def main():
    # [1] DNS 校验（公网 223.5.5.5 直查）
    code, out = ecs(
        f"dig +short {DOMAIN} @223.5.5.5 2>/dev/null || nslookup {DOMAIN} 223.5.5.5 2>&1 | tail -3",
        "qw-yr-dnscheck", wait=60)
    print("[1] DNS:", out.strip())
    if "47.120.43.20" not in out:
        print("!! DNS 尚未指向本机，中止（A 记录未加或未生效）")
        return 1

    # [2] 80 vhost 引导（ACME+444）+ 热加载
    code, out = ecs(
        f"test -f {CONF} || cat > {CONF} <<'EOF'\n{VHOST_80_BOOT}EOF\n{nginx_test_reload()}",
        "qw-yr-boot80", wait=120)
    print("[2] 80 vhost:", out.strip()[-300:])
    if code != 0 or "successful" not in out:
        print("!! 80 vhost 引导失败")
        return 1

    # [3] 签发证书（webroot 与 gcbrain 同卷；deploy-hook 持久化）
    code, out = ecs(
        f"certbot certonly --webroot -w /root/dify/docker/volumes/certbot/www "
        f"-d {DOMAIN} --email 51817@qq.com --agree-tos --non-interactive --no-eff-email "
        f"--config-dir /root/dify/docker/volumes/certbot/conf "
        f"--deploy-hook 'docker exec docker-nginx-1 nginx -s reload' 2>&1 | tail -6",
        "qw-yr-cert", wait=300)
    print("[3] certbot:", out.strip())
    if code != 0 or not any(s in out for s in ("Successfully received certificate", "Congratulations",
                                               "Certificate not yet due for renewal")):
        print("!! 证书签发失败（若 403：边缘拦截仍在，稍后重跑）")
        return 1

    # [4] 全量 conf（80=301 / 443=ssl proxy）+ 热加载 + 公网自检
    script = (
        f"cat > {CONF} <<'EOF'\n{VHOST_FULL}EOF\n"
        "mkdir -p /etc/letsencrypt && printf 'config-dir = /root/dify/docker/volumes/certbot/conf\\n' "
        "> /etc/letsencrypt/cli.ini && "
        f"{nginx_test_reload()} && sleep 2 && "
        f"curl -s https://{DOMAIN}/api/health && echo && "
        f"curl -s -o /dev/null -w 'public443=%{{http_code}}\\n' https://{DOMAIN}/api/health && "
        f"curl -s -o /dev/null -w 'http80=%{{http_code}}\\n' -m 5 http://{DOMAIN}/api/health || true && "
        "certbot renew --dry-run 2>&1 | tail -2"
    )
    code, out = ecs(script, "qw-yr-live", wait=300)
    print("[4] live:", out.strip()[-800:])
    if "public443=200" not in out:
        print("!! 443 上线自检未过")
        return 1
    print(f"[OK] https://{DOMAIN} 已就绪（LE 自动续期在役）→ 切 BASE_URL 上传 0.7.2")
    return 0


if __name__ == "__main__":
    sys.exit(main())
