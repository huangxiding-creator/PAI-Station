# -*- coding: utf-8 -*-
"""续跑：apt 装 python3-venv → 重建 venv → pip → systemd（复用 ecs_deploy 的通道函数）。"""
import sys

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work")
from ecs_deploy import ecs_cmd  # noqa: E402

SCRIPT = (
    "rm -rf /opt/qianwen/venv"
    " && apt-get update -qq && apt-get install -y -qq python3-venv"
    " && python3 -m venv /opt/qianwen/venv"
    " && /opt/qianwen/venv/bin/pip install -q -i https://mirrors.aliyun.com/pypi/simple/"
    " fastapi 'uvicorn[standard]' curl_cffi"
    " && /opt/qianwen/venv/bin/python -c 'import curl_cffi,fastapi,uvicorn;"
    " print(\"IMPORT_OK\")'"
)
code, out = ecs_cmd(SCRIPT, "qw-pip2", wait=600)
print("pip exit:", code)
print(out.strip()[-500:])
assert code == 0 and "IMPORT_OK" in out, "pip 腿失败"
print("PIP OK")
