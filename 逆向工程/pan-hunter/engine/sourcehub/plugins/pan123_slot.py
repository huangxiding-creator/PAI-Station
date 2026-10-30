# -*- coding: utf-8 -*-
"""123 云盘·凭据插件预留位（W2 只留接口+文档，不实现登录）

事实依据（W1 真件门）：123 免登列表全通，直链 download_info 一律 code=5112
「您需要注册登录或付费后下载」——免费层墙为盘级。用户自供凭据后可走官方开放态
（open.123pan.com API，需 access_token）。本期不实现任何登录/取 token 逻辑。
"""
from __future__ import annotations

from pathlib import Path

from . import BasePlugin


class Pan123SlotPlugin(BasePlugin):
    name = "pan123"
    tier = "123"
    cred_path = Path(r"E:\AI-Station\data\secrets\pan123_credentials.json")   # 约定路径（未用）
    cli = []                                                                  # 未接 CLI（预留）
    note = ("预留插件位：W1 实证直链=5112 免费层墙；用户自供官方凭据后走开放平台态。"
            "本期仅接口占位，无登录实现。默认关。")
