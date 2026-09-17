"""RSS 信号域：微信公众号 RSS 源复用 We-AIPO（09-17 用户指令）。

源清单唯一基准 = E:\\CPOPC\\We-AIPO\\公众号RSS\\wechat2rss_subscriptions.opml
（We-AIPO 侧持续更新，本域每次采集前只读同步镜像 → 「始终保持最新」）。
"""
from .harvester import (
    AdaptivePacer,
    FeedRef,
    HarvestReport,
    SyncReport,
    harvest,
    html_to_text,
    parse_opml,
    slugify,
    sync_opml,
)

__all__ = [
    "AdaptivePacer", "FeedRef", "HarvestReport", "SyncReport",
    "harvest", "html_to_text", "parse_opml", "slugify", "sync_opml",
]
