# -*- coding: utf-8 -*-
"""续跑2：systemd 服务 + 启动 + 本机 401 自检 + 本机防火墙核查。"""
import base64
import sys

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work")
from ecs_deploy import ecs_cmd  # noqa: E402

unit = (
    "[Unit]\nDescription=qianwen-engine (biaoxun KB)\nAfter=network.target\n\n"
    "[Service]\nWorkingDirectory=/opt/qianwen/services/qianwen-engine\n"
    "ExecStart=/opt/qianwen/venv/bin/python -m uvicorn qianwen_engine.app:app"
    " --host 0.0.0.0 --port 8869 --log-level warning\n"
    "Restart=always\nRestartSec=3\n\n[Install]\nWantedBy=multi-user.target\n"
)
ub64 = base64.b64encode(unit.encode()).decode()

code, out = ecs_cmd(
    f"printf %s '{ub64}' | base64 -d > /etc/systemd/system/qianwen-engine.service"
    " && systemctl daemon-reload && systemctl enable --now qianwen-engine"
    " && sleep 4 && echo unit=$(systemctl is-active qianwen-engine)"
    " && curl -s -o /dev/null -w 'local_probe=%{{http_code}}' http://127.0.0.1:8869/api/quota"
    " && echo && echo ufw=$(ufw status 2>/dev/null | head -1 || echo none)"
    " && echo iptables=$(iptables -L INPUT -n 2>/dev/null | wc -l)",
    "qw-systemd", wait=180)
print("exit:", code)
print(out.strip())
assert code == 0 and "local_probe=401" in out, "服务自检未达 401"
print("SYSTEMD OK")
