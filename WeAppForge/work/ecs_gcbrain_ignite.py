# -*- coding: utf-8 -*-
"""api.gcbrain.top HTTPS 点火（备案通过当天跑一次即可）：
DNS 校验→LE 证书(HTTP-01 webroot, 备案通过后 80 已解封)→443 vhost 追加→热加载→公网自检。
前置：80 段 vhost(api-gcbrain.conf)已挂好（0930 预置）；用户已加 A 记录 api→47.120.43.20；
certbot.timer 自动续期 + deploy-hook 已随证书落盘。"""
import base64
import json
import subprocess
import sys
import time

REGION = "cn-heyuan"
INSTANCE = "i-f8za6qhv365cwhti5y35"
DOMAIN = "api.gcbrain.top"

VHOST_443 = f'''
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


def main():
    # [1] DNS 校验（公网 223.5.5.5 直查，防本地缓存；须先过域名实名否则 serverHold 不解析）
    code, out = ecs(
        f"dig +short {DOMAIN} @223.5.5.5 2>/dev/null || nslookup {DOMAIN} 223.5.5.5 2>&1 | tail -3",
        "qw-gcb-dnscheck", wait=60)
    print("[1] DNS:", out.strip())
    if "47.120.43.20" not in out:
        print("!! DNS 尚未指向本机（A记录未加/未实名/未生效），中止")
        return 1

    # [2] 签发证书（写入 dify certbot 卷 = 容器 /etc/letsencrypt；deploy-hook 持久化进续期配置）
    code, out = ecs(
        f"certbot certonly --webroot -w /root/dify/docker/volumes/certbot/www "
        f"-d {DOMAIN} --email 51817@qq.com --agree-tos --non-interactive --no-eff-email "
        f"--config-dir /root/dify/docker/volumes/certbot/conf "
        f"--deploy-hook 'docker exec docker-nginx-1 nginx -s reload' 2>&1 | tail -6",
        "qw-gcb-cert", wait=300)
    print("[2] certbot:", out.strip())
    # certbot 2.9 成功文案是 "Successfully received certificate"（旧版是 Congratulations，两者都认）
    if code != 0 or not any(s in out for s in ("Successfully received certificate", "Congratulations")):
        print("!! 证书签发失败（若 403/超时：备案拦截可能仍在生效，等几小时重跑）")
        return 1

    # [3] 追加 443 vhost + 热加载 + cli.ini 指路（裸 certbot renew 也读对目录）+ 公网自检
    script = (
        f"grep -q 'listen 443' /root/dify/docker/nginx/conf.d/api-gcbrain.conf || "
        f"cat >> /root/dify/docker/nginx/conf.d/api-gcbrain.conf <<'EOF'\n{VHOST_443}EOF\n"
        "mkdir -p /etc/letsencrypt && printf 'config-dir = /root/dify/docker/volumes/certbot/conf\\n' "
        "> /etc/letsencrypt/cli.ini && "
        "docker exec docker-nginx-1 nginx -t 2>&1 && docker exec docker-nginx-1 nginx -s reload && "
        f"sleep 2 && curl -s https://{DOMAIN}/api/health && echo && "
        f"curl -s -o /dev/null -w 'public443=%{http_code}\\n' https://{DOMAIN}/api/health && "
        "certbot renew --dry-run 2>&1 | tail -3"
    )
    code, out = ecs(script, "qw-gcb-live", wait=300)
    print("[3] live:", out.strip()[-800:])
    if code != 0 or "public443=200" not in out:
        print("!! 443 上线自检未过")
        return 1
    print(f"[OK] https://{DOMAIN} 已就绪（LE 自动续期在役）→ 可上传 robot8 提审版")
    return 0


if __name__ == "__main__":
    sys.exit(main())
