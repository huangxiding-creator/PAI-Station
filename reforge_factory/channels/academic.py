# -*- coding: utf-8 -*-
"""学术 API 三件套适配器 (T-015 / REQ-029.AC1 / KB-CHANNEL-BUILDER-SPEC 首批).

OpenAlex / Semantic Scholar / arXiv —— 免 key 零账号风险 (计划书 L 卷实测全通;
共享 IP 匿名限流 429 时由调用方守卫测试如实 skip, 不造假)。

统一 Doc 契约: search_openalex / search_s2 / search_arxiv 各返回
    [{"title": str, "url": str, "year": int|None,
      "abstract_head": str,          # 摘要前 300 字 (ABSTRACT_HEAD)
      "source": str}]
按 title 非空过滤 (无题文献不成 Doc)。

礼貌红线 (R10): urllib 标准库, timeout 20s, 同主机相邻请求间隔 >= 1s
(失败请求也计入间隔); 每渠道单次操作 1-2 发, 由调用方限。
"""
from __future__ import annotations

import json
import time
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET

TIMEOUT_S = 20
POLITE_INTERVAL_S = 1.0
ABSTRACT_HEAD = 300
USER_AGENT = (
    "AI-Station-reforge-factory/1.0 (research channel adapter; "
    "polite; contact: research-station local)"
)

OPENALEX_ENDPOINT = "https://api.openalex.org/works"
S2_ENDPOINT = "https://api.semanticscholar.org/graph/v1/paper/search"
ARXIV_ENDPOINT = "http://export.arxiv.org/api/query"

S2_FIELDS = "title,url,year,abstract,venue"
_ATOM = "{http://www.w3.org/2005/Atom}"

#: host -> 上次请求时刻 (time.monotonic); 失败请求也标记 (礼貌计数含失败)
_last_request_at: dict[str, float] = {}


def _polite_wait(host: str) -> None:
    prev = _last_request_at.get(host)
    if prev is None:
        return
    elapsed = time.monotonic() - prev
    if elapsed < POLITE_INTERVAL_S:
        time.sleep(POLITE_INTERVAL_S - elapsed)


def http_get(url: str, *, timeout: float = TIMEOUT_S,
             ua: str = USER_AGENT) -> tuple[int, bytes]:
    """礼貌 GET: 同主机间隔 >= POLITE_INTERVAL_S; 返回 (status, body)。

    HTTPError / URLError / timeout 原样抛出 (守卫重试在调用方), 抛出前同样
    标记主机礼貌时刻 —— 限流端点对失败请求也计数, 我们不占便宜。
    """
    host = urllib.parse.urlsplit(url).netloc
    _polite_wait(host)
    req = urllib.request.Request(url, headers={"User-Agent": ua})
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            return resp.status, resp.read()
    finally:
        _last_request_at[host] = time.monotonic()


def make_doc(*, title, url, year, abstract, source) -> dict | None:
    """统一 Doc 构造: 压平空白; title 空 → None (不成 Doc)。"""
    title = " ".join(str(title or "").split())
    if not title:
        return None
    abstract = " ".join(str(abstract or "").split())
    return {
        "title": title,
        "url": str(url or ""),
        "year": year if isinstance(year, int) else None,
        "abstract_head": abstract[:ABSTRACT_HEAD],
        "source": " ".join(str(source or "").split()),
    }


def _invert_abstract(inv: dict) -> str:
    """OpenAlex abstract_inverted_index (word -> [positions]) → 正序摘要文本。"""
    words: dict[int, str] = {}
    for word, positions in (inv or {}).items():
        for pos in positions or []:
            try:
                words[int(pos)] = str(word)
            except (TypeError, ValueError):
                continue
    return " ".join(words[i] for i in sorted(words))


def search_openalex(q: str, limit: int = 5) -> list[dict]:
    """OpenAlex works 检索 (免 key)。200 但 0 条返回 []; HTTP 错抛 urllib.error。"""
    params = urllib.parse.urlencode({"search": q, "per-page": max(1, min(int(limit), 25))})
    _, body = http_get(f"{OPENALEX_ENDPOINT}?{params}")
    data = json.loads(body.decode("utf-8"))
    docs: list[dict] = []
    for w in (data.get("results") or [])[:max(1, min(int(limit), 25))]:
        loc = ((w.get("primary_location") or {}).get("source")) or {}
        doc = make_doc(
            title=w.get("display_name"),
            url=w.get("doi") or w.get("id") or "",
            year=w.get("publication_year"),
            abstract=_invert_abstract(w.get("abstract_inverted_index")),
            source=loc.get("display_name") or "OpenAlex",
        )
        if doc:
            docs.append(doc)
    return docs


def search_s2(q: str, limit: int = 5) -> list[dict]:
    """Semantic Scholar paper 检索 (免 key; 匿名共享 IP 常 429, 调用方守卫如实处理)。"""
    params = urllib.parse.urlencode({
        "query": q, "limit": max(1, min(int(limit), 100)), "fields": S2_FIELDS,
    })
    _, body = http_get(f"{S2_ENDPOINT}?{params}")
    data = json.loads(body.decode("utf-8"))
    docs: list[dict] = []
    for p in (data.get("data") or [])[:max(1, min(int(limit), 100))]:
        doc = make_doc(
            title=p.get("title"),
            url=p.get("url") or "",
            year=p.get("year"),
            abstract=p.get("abstract"),
            source=p.get("venue") or "Semantic Scholar",
        )
        if doc:
            docs.append(doc)
    return docs


def search_arxiv(q: str, limit: int = 5) -> list[dict]:
    """arXiv Atom API 检索 (免 key; http 端点, 响应可慢, timeout 20s)。"""
    params = urllib.parse.urlencode({
        "search_query": f"all:{q}", "max_results": max(1, min(int(limit), 50)),
    })
    _, body = http_get(f"{ARXIV_ENDPOINT}?{params}")
    root = ET.fromstring(body.decode("utf-8"))
    docs: list[dict] = []
    for entry in root.findall(f"{_ATOM}entry"):
        published = (entry.findtext(f"{_ATOM}published") or "")[:4]
        year = int(published) if published.isdigit() else None
        doc = make_doc(
            title=entry.findtext(f"{_ATOM}title", ""),
            url=entry.findtext(f"{_ATOM}id", ""),
            year=year,
            abstract=entry.findtext(f"{_ATOM}summary", ""),
            source="arXiv",
        )
        if doc:
            docs.append(doc)
    return docs
