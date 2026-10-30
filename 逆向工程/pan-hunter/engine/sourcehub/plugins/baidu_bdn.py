# -*- coding: utf-8 -*-
r"""baidu 本地凭据插件（W2 首个插件）

蓝本：E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py（BDN 工具，本地协议实现，
凭据 JSON 直读+输出全掩码）。本插件只 subprocess 本地调 bdn CLI——凭据文件由用户自供：
  E:\AI-Station\data\secrets\bdn_credentials.json   （bdncore/session.py DEFAULT_CRED_PATH）

红线：本文件不读凭据内容、不复制凭据、不联网；启用与否只由 plugins/config.json 决定。
"""
from __future__ import annotations

from pathlib import Path

from . import BasePlugin

BDN_CLI = r"E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py"


class BaiduBdnPlugin(BasePlugin):
    name = "baidu_bdn"
    tier = "baidu"
    cred_path = Path(r"E:\AI-Station\data\secrets\bdn_credentials.json")
    cli = ["python", BDN_CLI]
    note = ("包装 bdn.py（本地 CLI）。可用子命令例：doctor/whoami/quota/shares/ls。"
            "凭据用户自供；插件只本地执行，零上传。默认关。")
