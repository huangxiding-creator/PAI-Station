# -*- coding: utf-8 -*-
"""续跑3：诊断服务状态 + 日志 + ufw 规则。"""
import sys

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work")
from ecs_deploy import ecs_cmd  # noqa: E402

code, out = ecs_cmd(
    "systemctl is-active qianwen-engine; systemctl is-enabled qianwen-engine;"
    " echo ---journal---; journalctl -u qianwen-engine -n 30 --no-pager | tail -30;"
    " echo ---probe---; curl -s -o /dev/null -w 'code=%{http_code}' http://127.0.0.1:8869/api/quota;"
    " echo; echo ---ufw---; ufw status verbose | head -20",
    "qw-diag", wait=120)
print("exit:", code)
print(out)
