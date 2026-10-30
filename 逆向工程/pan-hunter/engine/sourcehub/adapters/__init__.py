# -*- coding: utf-8 -*-
"""PAN-HUNTER L2 解析层注册表（W1 · 十盘）

零登录铁律：以下 adapter 全部无 cookie/token 输入位（wenshushu 匿名令牌为盘方公开签发件，
guangya share accessToken 为分享面令牌，均非用户凭据）。
"""
from __future__ import annotations

from .base import BaseAdapter, FileEntry, PanError
from .uc import UcAdapter
from .pan115 import Pan115Adapter
from .pan123 import Pan123Adapter
from .lanzou import LanzouAdapter, LanzouFolderAdapter
from ._izfj import ILanzouAdapter, FeijipanAdapter
from .ecpan import EcpanAdapter
from .wenshushu import WenshushuAdapter
from .cowtransfer import CowtransferAdapter
from .guangyapan import GuangyapanAdapter

ADAPTERS: dict[str, BaseAdapter] = {
    a.name: a() for a in (
        UcAdapter, Pan115Adapter, Pan123Adapter, ILanzouAdapter, FeijipanAdapter,
        LanzouFolderAdapter, EcpanAdapter, WenshushuAdapter, CowtransferAdapter,
        GuangyapanAdapter,
    )
}
# 注：ILanzou/Feijipan 排在 Lanzou 前——"lanzou" 是 "ilanzou.com" 的子串，先匹配长名防误吞。
# LanzouFolderAdapter 自动判别目录/单文件（目录=filemoreajax 列表→逐文件单链）。

#: 盘型红绿灯（权威=analysis/W1_GREEN_GATES.md 终版；此表为路由用同步口径）
DISK_LIGHTS = {
    # W1 真件门绿（5/10）
    "uc": "绿", "lanzou": "绿", "ilanzou": "绿", "feijipan": "绿", "ecpan": "绿",
    # 门未过·定性如实（W1 终判）
    "115": "绿?(owner开关)",          # skip_login 端点活；2026-01 官方停发免费免登流量
    "123": "黄(免费层墙5112)",        # 列表免登全通；直链一律 5112 注册/付费
    "guangya": "绿?(owner开关)",      # 匿名全链通到 207 分享者未开启免登下载
    "wenshushu": "绿?(无当活链)",
    "cow": "死(停服2026-01-10)",
    # 黄盘（发现+探活，W2）
    "baidu": "黄", "quark": "黄", "aliyun": "黄", "xunlei": "黄",
    "189": "黄", "139": "黄", "ctfile": "黄", "pikpak": "黄",
    # 红盘
    "weiyun": "红", "wo": "红",
}

_PAN_URL_RE = {
    "baidu": ("pan.baidu.com/s/", "pan.baidu.com/share/"),
    "quark": ("pan.quark.cn/s/",),
    "aliyun": ("alipan.com/s/", "aliyundrive.com/s/"),
    "xunlei": ("xunlei.com/s/", "pan.xunlei.com"),
    "189": ("cloud.189.cn/t/", "cloud.189.cn/web/share"),
    "139": ("caiyun.139.com", "yun.139.com"),
    "ctfile": ("ctfile.com", "ctfile.net"),
    "pikpak": ("mypikpak.com/s/", "pikpak.com/s/"),
    "weiyun": ("weiyun.com",),
    "wo": ("pan.wo.cn",),
}


def disk_of_url(url: str) -> str | None:
    """任意分享链 → 盘型名（adapter 名或黄/红盘名）。"""
    for name, adapter in ADAPTERS.items():
        if adapter.match_url(url):
            return name
    for disk, pats in _PAN_URL_RE.items():
        if any(p in url for p in pats):
            return disk
    return None


def light_of(disk: str) -> str:
    return DISK_LIGHTS.get(disk, "?")
