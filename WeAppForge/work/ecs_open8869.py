# -*- coding: utf-8 -*-
"""续跑4：ufw 放行 8869 + 假 code 登录冒烟（期望微信 40029=appid/secret 链路通）。"""
import sys

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work")
from ecs_deploy import ecs_cmd  # noqa: E402

code, out = ecs_cmd(
    "ufw allow 8869/tcp comment 'qianwen engine' >/dev/null"
    " && ufw status | grep 8869"
    " && curl -s -X POST http://127.0.0.1:8869/api/login"
    " -H 'Content-Type: application/json' -d '{\"code\":\"fakecode-ecs-smoke\"}' | head -c 300",
    "qw-ufw", wait=120)
print("exit:", code)
print(out)
