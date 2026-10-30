# -*- coding: utf-8 -*-
"""PAN-HUNTER W2 发现层注册表（大四盘+139）

零登录铁律：全部 adapter 无凭据位；BDCLND（百度分享码派生）/share_token（阿里匿名签发）
/stoken（夸克匿名签发）/captcha_token（迅雷盾匿名签发）均为公开面令牌，非用户凭据。
能力=列表+探活；direct download 不在本层（黄盘交付=本地凭据插件，默认关，见 plugins/）。
"""
from __future__ import annotations

from .base import (BudgetExceeded, DEntry, DiscoveryLedger, DResult,
                   LEDGER, link_gap, strip_pwd)
from .baidu import BaiduDiscovery
from .aliyun import AliyunDiscovery
from .quark import QuarkDiscovery
from .xunlei import XunleiDiscovery
from .pan139 import Pan139Discovery

DISCOVERY: dict[str, BaseDiscovery] = {
    a.name: a() for a in (BaiduDiscovery, AliyunDiscovery, QuarkDiscovery,
                          XunleiDiscovery, Pan139Discovery)
}

#: 发现层口径灯（PROPOSAL §四 二级·黄：免登发现+列表+探活；下载=可选本地凭据插件）
DISK_TIER = {"baidu": "黄", "aliyun": "黄", "quark": "黄", "xunlei": "黄", "139": "黄"}


def discovery_of_url(url: str) -> str | None:
    for name, d in DISCOVERY.items():
        if d.match_url(url):
            return name
    return None


def discover_url(url: str, pwd: str = "",
                 ledger: DiscoveryLedger | None = None) -> DResult:
    """单链发现层入口（ph.py discover / 跑批共用）。"""
    name = discovery_of_url(url)
    if not name:
        return DResult(url=url, disk="?", state="err:unrouted", message="非五盘链接")
    if ledger is not None:
        DISCOVERY[name].ledger = ledger
    base, p = strip_pwd(url)
    return DISCOVERY[name].discover(base, pwd or p)
