# -*- coding: utf-8 -*-
"""洞见研报 (djyanbao.com) 渠道适配器（元数据层）。

复刻件照抄（E:\\AI-Station\\逆向工程\\djyanbao-reverse\\replica\\djyanbao_api.py 段1，勿改端点）：
    GET https://api.djyanbao.com/api/report?page=N&limit=M&q=<urlenc>&sort=publish_at&order=DESC&matchPhrase=false
    → {code:0, data:{data:[卡片×M], meta:{itemCount}}}   [匿名 200，零 Cookie 零 Bearer]
    头: client-ver: v2.0.14 / client-type: pc / client-id: <uuid4> + Origin/Referer(www 面) + 桌面 UA
卡片: id/typeId/title/authors/orgName/publishAt/pageTotal/fileSize/uploaderName/stockName/
      reportScore/highlight{title[],content[]}（AI 评分/摘要片段匿名免费面自带）
映射: fmt 归一 pdf/doc/ppt/xls（卡片无格式字段：研报主体为 pdf——复刻件 10/24 实测结论，
      标题尾部显式扩展名时按扩展归一）；title 剥 <em> 高亮；perm=green（题录层免费面）；
      badge=green_free（catalog_engine.metadata.BADGES 闭集内取 green）；
      source_url=www 详情页；extra 放 doc_id/机构/作者/日期/评分等原始事实（缺省如实 None）。
铁律: 零登录（不触 Bearer/download/join）、间隔>=2s、日上限500、连错5次熔断到日切
      （可配 KB_DJYANBAO_MIN_INTERVAL / KB_DJYANBAO_DAILY_LIMIT）。
"""
import json
import os
import re
import ssl
import time
import urllib.parse
import urllib.request
import uuid as uuid_mod

from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta, RateLimiter

_BASE = "https://api.djyanbao.com/api"
_WEB = "https://www.djyanbao.com"
_CLIENT_VER = "v2.0.14"
_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_FMT_EXT = {"pdf": "pdf", "doc": "doc", "docx": "doc",
            "ppt": "ppt", "pptx": "ppt", "xls": "xls", "xlsx": "xls"}
_FMT_DEFAULT = "pdf"  # 卡片无格式字段；复刻件实测研报主体为 pdf
_PAGE_SIZE = 10       # 复刻件实测页大小
_MAX_PAGES = 50       # 翻页安全上限（10条/页×50页 与日上限同量级）

_CLIENT_ID = str(uuid_mod.uuid4())  # 进程级 client-id（复刻件：每会话一枚 uuid4）

_EM = re.compile(r"</?em>")
_EXT_TAIL = re.compile(r"\.(pdf|docx?|pptx?|xlsx?)$", re.IGNORECASE)


def _path(query: str, page: int, limit: int) -> str:
    return ("/report?page=%d&limit=%d&q=%s&sort=publish_at&order=DESC&matchPhrase=false"
            % (page, limit, urllib.parse.quote(query)))


def _headers() -> dict:
    return {"User-Agent": _UA, "Content-Type": "application/json",
            "client-ver": _CLIENT_VER, "client-type": "pc", "client-id": _CLIENT_ID,
            "Origin": _WEB, "Referer": _WEB + "/",
            "Accept": "application/json, text/plain, */*", "Accept-Language": "zh-CN,zh;q=0.9"}


def _urllib_fetch(query: str, page: int, timeout: float) -> dict:
    """真网络腿：stdlib urllib GET（测试用假 _fetch 替换，不打真网络）。"""
    req = urllib.request.Request(_BASE + _path(query, page, _PAGE_SIZE),
                                 headers=_headers(), method="GET")
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


_fetch = _urllib_fetch  # 可 monkeypatch 的网络函数（单一定义点）


def _strip_em(s):
    return _EM.sub("", s or "")


def _clean_title(s: str) -> str:
    """研报标题清洗：剥 <em> 高亮 + 去首尾空白（含全角空格）。"""
    return _strip_em(s).strip(" \t\r\n\u3000")


def _norm_fmt(title: str) -> str:
    """fmt 归一 pdf/doc/ppt/xls：卡片无格式字段→默认 pdf（研报主体），标题尾扩展名优先。"""
    m = _EXT_TAIL.search(title or "")
    return _FMT_EXT[m.group(1).lower()] if m else _FMT_DEFAULT


def _parse(j: dict):
    """校验 code 并取 (卡片列表, itemCount)——路径照抄复刻件段1（code!=0 如实抛）。"""
    if not isinstance(j, dict) or j.get("code") not in (0, "0"):
        code = j.get("code") if isinstance(j, dict) else type(j).__name__
        msg = j.get("message", "") if isinstance(j, dict) else ""
        raise RuntimeError("code=%s msg=%s" % (code, msg))
    d = j.get("data") or {}
    return d.get("data") or [], (d.get("meta") or {}).get("itemCount", -1)


def _to_meta(x: dict) -> FileMeta:
    rid = x.get("id")
    title = _clean_title(x.get("title", ""))
    hl = x.get("highlight") or {}
    snippet = _strip_em((hl.get("content") or [""])[0]).strip()
    return FileMeta(
        title=title,
        fmt=_norm_fmt(title),
        pages=x.get("pageTotal") or None,  # 0/缺省→如实 None（零造假）
        badge="green_free",
        perm="green",                     # 题录层免费面
        source_url="%s/report/%d" % (_WEB, rid) if rid is not None else None,
        extra={"doc_id": rid, "org": x.get("orgName"), "authors": x.get("authors"),
               "publish_at": (x.get("publishAt") or "")[:10], "type_id": x.get("typeId"),
               "stock_name": x.get("stockName"), "report_score": x.get("reportScore"),
               "file_size": x.get("fileSize"), "snippet": snippet[:150]})


class DjyanbaoAdapter(ChannelAdapter):
    channel = "djyanbao"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 15.0,
                 retries: int = 1, audit=None):
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_DJYANBAO_MIN_INTERVAL", "2")),
                daily_limit=int(os.environ.get("KB_DJYANBAO_DAILY_LIMIT", "500")),
                name="djyanbao")  # error_threshold 用基座默认 5=连错5次熔断到日切
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
        out, page = [], 1
        while len(out) < limit and page <= _MAX_PAGES:
            self.limiter.acquire()  # 日上限/熔断在此抛 RateLimitExceeded / CircuitOpenError
            t0 = time.monotonic()
            j, err = None, None
            for _attempt in range(self.retries + 1):
                try:
                    j = _fetch(query, page, self.timeout)
                    break
                except Exception as e:  # 网络/传输失败：重试1次
                    err = e
            if j is None:
                self.limiter.record_error()
                self._log("error", query, t0, 0, f"{type(err).__name__}: {err}")
                break  # 如实降级：返回已取得的部分
            try:
                raw, total = _parse(j)
                page_metas = [_to_meta(x) for x in raw]
            except Exception as e:  # code!=0/形状异常：按错误路径降级，不崩溃
                self.limiter.record_error()
                self._log("error", query, t0, 0, f"{type(e).__name__}: {e}")
                break
            self.limiter.record_success()
            self._log("request", query, t0, len(page_metas), f"page={page} total={total}")
            if not page_metas:
                break  # 空页停
            out.extend(page_metas)
            page += 1
        return out[:limit]
