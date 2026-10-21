# -*- coding: utf-8 -*-
"""百度文库渠道适配器（W5，元数据层）。

配方照抄 W3.5 实测（kb_rev/web_search_capture/search_api.py + capture.md，勿改端点）：
    POST https://wenku.baidu.com/gsula/sula/syncmrecall
    body={"requests":[{"sceneID":"PCSearch","params":{"word":词,"pn":页,"noCacheMembershipCard":True}}]}
    桌面 UA，零 Cookie 零登录。
铁律：无登录/零下载/间隔>=3s/日上限500(可配 KB_WENKU_MIN_INTERVAL / KB_WENKU_DAILY_LIMIT)。
映射：fileType 1→doc 2→pdf 3→ppt 4→xls 5→txt 7→epub 16→ebook；
     sellType∈{2,5}→badge=wenku_vip/perm=yellow（任务指定启发式，语义未核验见 capture.md §5），其余 green。
"""
import json
import re
import ssl
import time
import urllib.parse
import urllib.request

from kb_factory.channel_adapters.base import (CircuitOpenError, ChannelAdapter, FileMeta,
                                              RateLimiter)

_URL = "https://wenku.baidu.com/gsula/sula/syncmrecall"
_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_FMT = {1: "doc", 2: "pdf", 3: "ppt", 4: "xls", 5: "txt", 7: "epub", 16: "ebook"}
_VIP_SELL = {2, 5}
_MAX_PAGES = 50  # 翻页安全上限（12条/页×50页远超 per_topic 需求）


def _payload(word: str, pn: int) -> dict:
    return {"requests": [{"sceneID": "PCSearch",
                          "params": {"word": word, "pn": pn, "noCacheMembershipCard": True}}]}


def _headers(word: str) -> dict:
    return {"User-Agent": _UA, "Content-Type": "application/json;charset=utf-8",
            "Accept": "application/json, text/plain, */*",
            "Referer": "https://wenku.baidu.com/search?word=" + urllib.parse.quote(word),
            "Origin": "https://wenku.baidu.com", "Accept-Language": "zh-CN,zh;q=0.9"}


def _urllib_fetch(word: str, pn: int, timeout: float) -> dict:
    """真网络腿：stdlib urllib POST（测试用假 _fetch 替换，不打真网络）。"""
    body = json.dumps(_payload(word, pn), ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(_URL, data=body, headers=_headers(word), method="POST")
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


_fetch = _urllib_fetch  # 可 monkeypatch 的网络函数（单一定义点）


def _strip_em(s):
    return re.sub(r"</?em>", "", s or "")


def _parse(j: dict) -> list:
    """从响应提取 .data.items.PCSearch.result.items 的 data 列表（配方路径照抄）。"""
    res = (j.get("data", {}).get("items", {}).get("PCSearch") or {}).get("result", {})
    return [it.get("data", {}) for it in res.get("items", []) if it.get("data")]


def _to_meta(x: dict) -> FileMeta:
    vip = x.get("sellType") in _VIP_SELL
    return FileMeta(
        title=_strip_em(x.get("title")),
        fmt=_FMT.get(x.get("fileType"), str(x.get("fileType"))),
        pages=x.get("pageNum"),
        badge="wenku_vip" if vip else "green_free",
        perm="yellow" if vip else "green",
        source_url=x.get("url") or None,
        extra={"doc_id": x.get("docID"), "sell_type": x.get("sellType"),
               "views": x.get("viewCount"), "downloads": x.get("downloadCount"),
               "score": x.get("qualityScore"), "abstract": _strip_em(x.get("content"))[:150]},
    )


class WenkuMetaAdapter(ChannelAdapter):
    channel = "wenku"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 15.0,
                 retries: int = 1, audit=None):
        import os
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_WENKU_MIN_INTERVAL", "3")),
                daily_limit=int(os.environ.get("KB_WENKU_DAILY_LIMIT", "500")),
                name="wenku")
        self.limiter = limiter
        self.timeout = timeout
        self.retries = retries  # 重试 1 次（含首次共 2 次尝试）
        self.audit = audit      # None=不记审计（单测注入 tmp 审计时才落盘）

    def _log(self, event, query, t0, count, detail=""):
        if self.audit is not None:
            self.audit.log(channel=self.channel, event=event, query=query,
                           elapsed_ms=int((time.monotonic() - t0) * 1000), count=count,
                           detail=detail)

    def available(self) -> bool:
        s = self.limiter.status()
        return not s["circuit_open"] and s["count_today"] < s["daily_limit"]

    def metadata(self, query: str, limit: int = 12) -> list:
        out, pn = [], 1
        while len(out) < limit and pn <= _MAX_PAGES:
            self.limiter.acquire()  # 日上限/熔断在此抛 RateLimitExceeded / CircuitOpenError
            t0 = time.monotonic()
            j, err = None, None
            for _attempt in range(self.retries + 1):
                try:
                    j = _fetch(query, pn, self.timeout)
                    break
                except Exception as e:  # 网络/解析失败：重试1次
                    err = e
            if j is None:
                self.limiter.record_error()
                self._log("error", query, t0, 0, f"{type(err).__name__}: {err}")
                break  # 如实降级：返回已取得的部分
            self.limiter.record_success()
            raw = _parse(j)
            self._log("request", query, t0, len(raw), f"pn={pn}")
            if not raw:
                break  # 空页停
            out.extend(_to_meta(x) for x in raw)
            pn += 1
        return out[:limit]
