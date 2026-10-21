#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""PentAGI .env 生成器（在 WSL RE-Ubuntu 内运行）。
从本仓生产件配置中正则定位智谱 API 密钥（格式: 32hex.16alnum），写入 /root/pentagi/.env。
纪律：密钥不回显（仅掩码预览）、.env 权限 600、不进 git。"""
import os
import re
import secrets
import string
import sys

CANDIDATES = [
    "/mnt/e/AI-Station/data/secrets/zhipu.secret",   # 正仓密钥库（api_key=/api_key_2= 轮换）
]
KEY_RE = re.compile(r"[0-9a-f]{16,}\.[A-Za-z0-9]{8,}")
ENV_SRC = "/root/pentagi/.env.example"
ENV_DST = "/root/pentagi/.env"


def hunt_glm_key():
    for path in CANDIDATES:
        try:
            for line in open(path, encoding="utf-8", errors="ignore"):
                if line.strip().startswith(("api_key=", "api_key_2=", "key=")):
                    m = KEY_RE.search(line)
                    if m:
                        return path, m.group(0)
        except OSError:
            continue
    env_key = os.environ.get("GLM_API_KEY") or os.environ.get("ZHIPU_API_KEY")
    if env_key:
        m = KEY_RE.search(env_key)
        if m:
            return "ENV:GLM_API_KEY", m.group(0)
    return None, None


def main():
    src, key = hunt_glm_key()
    env = open(ENV_SRC, encoding="utf-8").read()

    def rand(n=24):
        alphabet = string.ascii_letters + string.digits
        return "".join(secrets.choice(alphabet) for _ in range(n))

    pg_pw = rand(28)
    cookie_salt = rand(32)
    scr_user, scr_pass = rand(12), rand(20)

    env = re.sub(r"(?m)^PENTAGI_POSTGRES_PASSWORD=.*$", f"PENTAGI_POSTGRES_PASSWORD={pg_pw}", env)
    env = re.sub(r"(?m)^COOKIE_SIGNING_SALT=.*$", f"COOKIE_SIGNING_SALT={cookie_salt}", env)
    env = re.sub(r"(?m)^LOCAL_SCRAPER_USERNAME=.*$", f"LOCAL_SCRAPER_USERNAME={scr_user}", env)
    env = re.sub(r"(?m)^LOCAL_SCRAPER_PASSWORD=.*$", f"LOCAL_SCRAPER_PASSWORD={scr_pass}", env)
    env = re.sub(r"(?m)^SCRAPER_PRIVATE_URL=.*$",
                 f"SCRAPER_PRIVATE_URL=https://{scr_user}:{scr_pass}@scraper/", env)
    # 智谱供能：GLM provider 原生支持，指到中国站 open.bigmodel.cn
    env = re.sub(r"(?m)^GLM_SERVER_URL=.*$", "GLM_SERVER_URL=https://open.bigmodel.cn/api/paas/v4", env)
    if key:
        env = re.sub(r"(?m)^GLM_API_KEY=.*$", f"GLM_API_KEY={key}", env)

    with open(ENV_DST, "w", encoding="utf-8") as f:
        f.write(env)
    os.chmod(ENV_DST, 0o600)
    masked = f"{key[:6]}…{key[-4:]}" if key else "(未找到)"
    print(f"[env] 已写 {ENV_DST} (600) pg_pw/cookie_salt/scraper 已随机化")
    print(f"[key] GLM key 来源={src or '无'} 掩码={masked}")
    return 0 if key else 1


if __name__ == "__main__":
    sys.exit(main())
