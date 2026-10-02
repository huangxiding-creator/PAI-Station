# -*- coding: utf-8 -*-
"""续跑5：云端真实 KB 单问冒烟——验证 metaso 会话跨 IP 可用（必要性单查）。"""
import sys

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work")
from ecs_deploy import ecs_cmd  # noqa: E402

code, out = ecs_cmd(
    "cd /opt/qianwen/services/qianwen-engine && timeout 400 /opt/qianwen/venv/bin/python -c \"\n"
    "from qianwen_engine import metaso_kb\n"
    "a = metaso_kb.ask('EPC 联合体投标对牵头方资质有什么要求？')\n"
    "print('KB_CHARS', len(a.answer))\n"
    "print('KB_CITES', len(a.citations))\n"
    "print('KB_ELAPSED', a.elapsed_sec)\n"
    "\"",
    "qw-kbsmoke", wait=460)
print("exit:", code)
print(out[-800:])
