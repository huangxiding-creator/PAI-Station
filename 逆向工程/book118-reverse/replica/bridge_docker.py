# -*- coding: utf-8 -*-
"""production_bridge 对接件：book118 纯 HTTP 腿替身（零改动 kb_factory）。

用法（ProductionBridge 适配器注入面——桥的既定契约，见
kb_factory/harvest_engine/production_bridge.py adapters 注入即收窄站点集）：

    from kb_factory.harvest_engine.production_bridge import ProductionBridge
    from bridge_docker import Book118HttpShim
    bridge = ProductionBridge(adapters={"book118": Book118HttpShim()})
    metas = bridge.search_channel("国际工程EPC", 10)
    print(bridge.last_report.per_site["book118"])   # {status, count, reason, elapsed_ms}

契约对齐：
- .search(query, limit) → list[FileMeta]（kb_factory.channel_adapters.base 真符号；
  extra 携带 book118_doc_id/book118_encode_aid/needmoney/vip_type，供 harvest
  T19 fetch_ladder/harvest_preview_pdf 同源复用）
- .reason property → 站原话（配额墙形态 'search_quota: …'；桥的 reason 鸭子型
  两态兼容分支直接命中 property 形态）
- 桥级频控：shim 自带（检索 3s/日额 300，quota 窗口实测小时级——日额可 env 调）
- 配额墙（SearchQuota）：如实 []+reason（与 T19 login_gated 同型处理，但语义
  已修正为 usage-quota 非登录墙；恢复后自动复活，无需改代码）
"""
from __future__ import annotations

import os
import sys
from pathlib import Path

_HERE = Path(__file__).resolve().parent
for _p in (str(_HERE),):
    if _p not in sys.path:
        sys.path.insert(0, _p)

from book118_api import (  # noqa: E402
    Book118ApiError, Book118Client, SearchQuota)

_FMT = {"doc": "doc", "docx": "doc", "pdf": "pdf", "ppt": "ppt", "pptx": "ppt",
        "xls": "xls", "xlsx": "xls", "txt": "txt", "epub": "epub"}


class Book118HttpShim:
    """Book118Adapter（浏览器版）的纯 HTTP 替身；生命周期零浏览器。"""

    site = "book118"

    def __init__(self, *, daily_limit: int | None = None):
        from kb_factory.channel_adapters.base import RateLimiter
        self._limiter = RateLimiter(
            min_interval=3.0,
            daily_limit=daily_limit if daily_limit is not None else int(
                os.environ.get("KB_BOOK118_HTTP_DAILY_LIMIT", "300")),
            name="book118_http_search")
        self._client = Book118Client()
        self._reason = ""

    def search(self, query: str, limit: int):
        from kb_factory.channel_adapters.base import FileMeta
        self._limiter.acquire()
        try:
            hits = self._client.search(query, limit)
        except SearchQuota as e:
            self._reason = f"search_quota: {e.detail}"[:160]
            return []
        except Book118ApiError as e:
            self._reason = f"{e.kind}: {e.detail}"[:160]
            return []
        self._reason = ""
        out = []
        for h in hits:
            out.append(FileMeta(
                title=h.title,
                fmt=_FMT.get(h.filetype.lower(), h.filetype or "doc"),
                source_url=h.shtm_url,
                extra={"book118_doc_id": h.shtm_url.rsplit("/", 1)[-1].split(".")[0],
                       "book118_encode_aid": h.encode_aid,
                       "book118_needmoney": h.needmoney,
                       "book118_vip_type": h.vip_type,
                       "book118_pagenumber": h.pagenumber,
                       "kb_harvest_site": "book118"}))
        return out

    @property
    def reason(self) -> str:
        return self._reason


if __name__ == "__main__":
    # 演示：桥注入面真跑（bridge 只跑注入站点=book118，收窄站点集契约）
    sys.path.insert(0, str(_HERE.parents[2]))     # E:\AI-Station（kb_factory 包）
    from kb_factory.harvest_engine.production_bridge import (  # noqa: E402
        ProductionBridge, to_pool_evidence)
    import json
    bridge = ProductionBridge(adapters={"book118": Book118HttpShim()})
    metas = bridge.search_channel("国际工程EPC", 10)
    rep = bridge.last_report.per_site["book118"]
    print(json.dumps(rep, ensure_ascii=False))
    print(f"metas={len(metas)}")
    for m in metas[:3]:
        print("  -", m.title[:40], m.source_url)
    if metas:
        row = to_pool_evidence(metas[0])
        print("pool_row.dedup_key =", row["dedup_key"][:24], "… form =", row["form"])
