# -*- coding: utf-8 -*-
"""_leg_snippets_b — 腿批量建造配置·乙组: 搜索/新闻/通用网研引擎 (1025 腿批量令).

仅供 _gen_legs_batch.py 引用; 每条 = 薄腿的 endpoint/extract 逐字源码。
mode: full=端点+解析实装; semi=端点实装, 形态待实测校准。
"""
from __future__ import annotations

DDGS_EP = r'''    return ("https://html.duckduckgo.com/html/",
            {"q": query}, {}, "GET", None)'''

DDGS_EX = r'''    if not isinstance(data, str):
        return []
    snips = [re.sub(r"<[^>]+>", " ", s.group(1)).strip()
             for s in re.finditer(
                 r'class="result__snippet"[^>]*>(.*?)</a>', data, re.S)]
    hits, seen = [], set()
    for i, m in enumerate(re.finditer(
            r'class="result__a"[^>]*href="([^"]+)"[^>]*>(.*?)</a>',
            data, re.S)):
        url = m.group(1)
        mu = re.search(r"[?&]uddg=([^&\"]+)", url)
        if mu:
            url = unquote(mu.group(1))
        if url in seen or "duckduckgo.com" in url:
            continue
        seen.add(url)
        title = re.sub(r"<[^>]+>", "", m.group(2)).strip()
        if not title:
            continue
        snip = snips[i] if i < len(snips) else ""
        hits.append({
            "title": title,
            "url": url,
            "meta": ["DDG html面"],
            "excerpt": (snip or
                        "DuckDuckGo html 面命中: %s" % title)[:1500],
        })
    return hits'''

DDG_IA_EP = r'''    return ("https://api.duckduckgo.com/",
            {"q": query, "format": "json", "no_html": "1",
             "no_redirect": "1", "skip_disambig": "1"}, {}, "GET", None)'''

DDG_IA_EX = r'''    d = data if isinstance(data, dict) else {}
    hits = []
    if d.get("Heading"):
        hits.append({
            "title": d.get("Heading"),
            "url": d.get("AbstractURL") or "",
            "meta": [m for m in [d.get("AbstractSource") or ""] if m],
            "excerpt": d.get("AbstractText") or "",
        })

    def _flat(items):
        out = []
        for t in (items or []):
            if not isinstance(t, dict):
                continue
            if t.get("Topics"):
                out += _flat(t.get("Topics"))
            else:
                out.append(t)
        return out

    for t in _flat(d.get("RelatedTopics")):
        txt = t.get("Text") or ""
        hits.append({
            "title": (txt.split(" - ")[0] or "(无题)")[:120],
            "url": t.get("FirstURL") or "",
            "meta": ["DDG Instant Answer 关联面"],
            "excerpt": txt[:1500],
        })
    return hits'''

WIBY_EP = r'''    return ("https://wiby.me/json/",
            {"q": query}, {}, "GET", None)'''

WIBY_EX = r'''    hits = []
    if isinstance(data, list):
        for d in data:
            if not isinstance(d, dict):
                continue
            url = str(d.get("URL") or d.get("url") or "")
            hits.append({
                "title": str(d.get("Title") or d.get("title")
                             or url[:60] or "(无题)"),
                "url": url,
                "meta": ["wiby 独立索引"],
                "excerpt": str(d.get("Snippet")
                               or d.get("snippet") or "")[:1500],
            })
    return hits'''

MARGINALIA_EP = r'''    return ("https://api.marginalia.com/public/search/"
            + quote(query, safe=""),
            {"count": str(rows)}, {}, "GET", None)'''

MARGINALIA_EX = r'''    hits = []
    if isinstance(data, list):
        for d in data:
            if not isinstance(d, dict):
                continue
            url = str(d.get("url") or "")
            hits.append({
                "title": str(d.get("title") or url[:60] or "(无题)"),
                "url": url,
                "meta": [m for m in [str(d.get("quality") or ""),
                                     str(d.get("year") or "")] if m],
                "excerpt": str(d.get("description") or "")[:1500],
            })
    return hits'''

MWMBL_EP = r'''    # TODO(1025批量): mwmbl 搜索API形态待实测校准 (api.mwmbl.org)
    return ("https://api.mwmbl.org/search",
            {"s": query, "count": str(rows)}, {}, "GET", None)'''

MWMBL_EX = r'''    results = (data if isinstance(data, list)
               else ((data or {}).get("results") or []))
    hits = []
    for d in (results if isinstance(results, list) else []):
        if not isinstance(d, dict):
            continue
        title = str(d.get("title") or d.get("extract")
                    or d.get("url") or "(无题)")
        hits.append({
            "title": title,
            "url": str(d.get("url") or ""),
            "meta": ["mwmbl 独立索引"],
            "excerpt": str(d.get("extract") or "")[:1500],
        })
    return hits'''

REDDIT_EP = r'''    return ("https://www.reddit.com/search.json",
            {"q": query, "limit": str(rows), "sort": "relevance"},
            {}, "GET", None)'''

REDDIT_EX = r'''    hits = []
    for c in (((data or {}).get("data") or {}).get("children") or []):
        p = c.get("data") or {}
        hits.append({
            "title": p.get("title") or "(无题)",
            "url": "https://www.reddit.com" + str(p.get("permalink") or ""),
            "meta": [m for m in ["r/" + str(p.get("subreddit") or ""),
                                 "%s分" % p.get("score"),
                                 "%s评" % p.get("num_comments")] if m],
            "excerpt": (p.get("selftext") or "")[:1500],
        })
    return hits'''

HN_EP = r'''    return ("https://hn.algolia.com/api/v1/search",
            {"query": query, "hitsPerPage": str(rows)}, {}, "GET", None)'''

HN_EX = r'''    hits = []
    for h in ((data or {}).get("hits") or []):
        oid = h.get("objectID") or ""
        txt = re.sub(r"<[^>]+>", " ", h.get("story_text")
                     or h.get("comment_text") or "")[:1500]
        hits.append({
            "title": h.get("title") or h.get("story_title") or "(无题)",
            "url": h.get("url") or
                   ("https://news.ycombinator.com/item?id=" + oid),
            "meta": [m for m in ["%s分" % h.get("points"),
                                 "%s评" % h.get("num_comments"),
                                 str(h.get("created_at") or "")[:10]] if m],
            "excerpt": txt or "HN 讨论面命中 (objectID=%s)" % oid,
        })
    return hits'''

SE_EP = r'''    return ("https://api.stackexchange.com/2.3/search/advanced",
            {"order": "desc", "sort": "relevance", "q": query,
             "site": "stackoverflow", "pagesize": str(rows),
             "filter": "withbody"}, {}, "GET", None)'''

SE_EX = r'''    hits = []
    for it in ((data or {}).get("items") or []):
        hits.append({
            "title": it.get("title") or "(无题)",
            "url": it.get("link") or "",
            "meta": [m for m in ["%s分" % it.get("score"),
                                 "%s答" % it.get("answer_count"),
                                 (it.get("tags") or [""])[0]] if m],
            "excerpt": re.sub(r"<[^>]+>", " ",
                              it.get("body") or "")[:1500],
        })
    return hits'''

WIKIPEDIA_EP = r'''    return ("https://zh.wikipedia.org/w/api.php",
            {"action": "query", "list": "search", "srsearch": query,
             "srlimit": str(rows), "format": "json"}, {}, "GET", None)'''

WIKIPEDIA_EX = r'''    res = (((data or {}).get("query") or {}).get("search")) or []
    hits = []
    for s in res:
        title = s.get("title") or "(无题)"
        hits.append({
            "title": title,
            "url": "https://zh.wikipedia.org/wiki/"
                   + quote(title, safe=""),
            "meta": [m for m in ["%s词" % s.get("wordcount"),
                                 str(s.get("timestamp") or "")[:10]] if m],
            "excerpt": re.sub(r"<[^>]+>", "", s.get("snippet") or ""),
        })
    return hits'''

RSS_BING_EP = r'''    return ("https://www.bing.com/news/search",
            {"q": query, "format": "rss"}, {}, "GET", None)'''

RSS_GNEWS_EP = r'''    return ("https://news.google.com/rss/search",
            {"q": query, "hl": "zh-CN", "gl": "CN", "ceid": "CN:zh-Hans"},
            {}, "GET", None)'''

RSS_EX = r'''    if not isinstance(data, str):
        return []

    def _txt(item, tag):
        m = re.search(r"<%s>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?</%s>"
                      % (tag, tag), item, re.S)
        return re.sub(r"<[^>]+>", "",
                      (m.group(1) if m else "")).strip()

    hits = []
    for it_m in re.finditer(r"<item>(.*?)</item>", data, re.S):
        item = it_m.group(1)
        title = _txt(item, "title")
        if not title:
            continue
        hits.append({
            "title": title,
            "url": _txt(item, "link"),
            "meta": [m for m in [_txt(item, "pubDate"),
                                 _txt(item, "source")] if m],
            "excerpt": _txt(item, "description")[:1500],
        })
    return hits'''

GDELT_EP = r'''    return ("https://api.gdeltproject.org/api/v2/doc/doc",
            {"query": query, "mode": "ArtList", "maxrecords": str(rows),
             "format": "json", "sort": "DateDesc"}, {}, "GET", None)'''

GDELT_EX = r'''    hits = []
    for a in ((data or {}).get("articles") or []):
        hits.append({
            "title": a.get("title") or "(无题)",
            "url": a.get("url") or "",
            "meta": [m for m in [a.get("seendate") or "",
                                 a.get("domain") or "",
                                 a.get("language") or ""] if m],
            "excerpt": (a.get("snippet")
                        or a.get("title") or "")[:1500],
        })
    return hits'''

GDACS_EP = r'''    # GDACS 全局灾害事件 RSS 流 (无文本q) — query 仅入台账
    return ("https://www.gdacs.org/xml/rss.xml", {}, {}, "GET", None)'''

JINA_EP = r'''    return ("https://r.jina.ai/https://www.bing.com/search",
            {"q": query}, {}, "GET", None)'''

JINA_EX = r'''    if not isinstance(data, str):
        return []
    hits, seen = [], set()
    for m in re.finditer(r"\[([^\]]{4,140})\]\((https?://[^)]+)\)", data):
        title, url = m.group(1).strip(), m.group(2)
        if url in seen or "bing.com" in url or "go.microsoft" in url:
            continue
        seen.add(url)
        hits.append({
            "title": title,
            "url": url,
            "meta": ["r.jina.ai 无key限额面"],
            "excerpt": "Jina Reader 经 Bing SERP 转写命中: %s" % title,
        })
    return hits'''

CC_EP = r'''    # TODO(1025批量): craw lid 钉 2024-33 — 滚动最新 lid 待接
    return ("https://index.commoncrawl.org/CC-MAIN-2024-33-index",
            {"url": query, "output": "json", "limit": str(rows)},
            {}, "GET", None)'''

CC_EX = r'''    if not isinstance(data, str):
        return []
    hits = []
    for ln in data.splitlines():
        ln = ln.strip()
        if not ln.startswith("{"):
            continue
        try:
            d = json.loads(ln)
        except json.JSONDecodeError:
            continue
        url = str(d.get("url") or "")
        hits.append({
            "title": "CC 索引快照: " + url[:80],
            "url": url,
            "meta": [m for m in [str(d.get("timestamp") or ""),
                                 "HTTP " + str(d.get("status") or "")]
                     if m],
            "excerpt": "Common Crawl 索引捕获 (原URL %s, 捕获 %s, 状态 %s)"
                       " — 查询词=URL模式"
                       % (url, d.get("timestamp"), d.get("status")),
        })
    return hits'''

WB_AVAIL_EP = r'''    return ("https://archive.org/wayback/available",
            {"url": query}, {}, "GET", None)'''

WB_AVAIL_EX = r'''    snap = (((data or {}).get("archived_snapshots") or {})
            .get("closest") or {})
    if not snap:
        return []
    return [{
        "title": "Wayback 最近可用快照",
        "url": snap.get("url") or "",
        "meta": [m for m in [str(snap.get("timestamp") or ""),
                             snap.get("status") or ""] if m],
        "excerpt": "Wayback Machine 可用性查询命中 "
                   "(查询词=目标URL, 单快照面)",
    }]'''

WB_CDX_EP = r'''    return ("https://web.archive.org/cdx/search/cdx",
            {"url": query, "output": "json", "limit": str(rows),
             "collapse": "urlkey"}, {}, "GET", None)'''

WB_CDX_EX = r'''    if not isinstance(data, list) or len(data) < 2:
        return []
    head, rows_ = data[0], data[1:]
    idx = {k: i for i, k in enumerate(head)}
    hits = []
    for r in rows_:
        if not isinstance(r, list) or len(r) < 5:
            continue
        ts = r[idx.get("timestamp", 1)]
        orig = r[idx.get("original", 2)]
        code = r[idx.get("statuscode", 4)]
        hits.append({
            "title": "Wayback CDX 快照: " + str(orig)[:80],
            "url": "https://web.archive.org/web/%s/%s" % (ts, orig),
            "meta": [m for m in [str(ts), "HTTP " + str(code)] if m],
            "excerpt": "CDX 捕获记录 (原URL %s, 捕获 %s, 状态 %s) "
                       "— 查询词=URL模式" % (orig, ts, code),
        })
    return hits'''

#: 乙组登记
GROUP_B: dict[str, dict] = {
    "ddgs_duckduckgo_search": {"mode": "full",
        "src": "DuckDuckGo html 端点 (ddgs 换代同面)",
        "form": "GET HTML regex q (result__a/snippet)",
        "imports": ["import re", "from urllib.parse import unquote"],
        "ep": DDGS_EP, "ex": DDGS_EX,
        "help": ["ddgs 库换代版底层=html.duckduckgo.com/html — 本腿免装库直接",
                 "走同端点, 正则解析标题/摘要 (uddg 跳转链解包)。"]},
    "duckduckgo_html_lite_instant_answer_api": {"mode": "full",
        "src": "DDG Instant Answer API",
        "form": "GET JSON q/format=json",
        "imports": [], "ep": DDG_IA_EP, "ex": DDG_IA_EX,
        "help": ["DDG Instant Answer 官方 API (免key); Abstract + RelatedTopics",
                 "递归展平面。"]},
    "wiby": {"mode": "full", "src": "Wiby JSON API",
        "form": "GET JSON q",
        "imports": [], "ep": WIBY_EP, "ex": WIBY_EX,
        "help": ["Wiby 独立轻量索引 JSON 面 (wiby.me/json/)。"]},
    "marginalia_search": {"mode": "semi",
        "src": "Marginalia public search API",
        "form": "GET JSON path参query+count (待实测)",
        "imports": ["from urllib.parse import quote"],
        "ep": MARGINALIA_EP, "ex": MARGINALIA_EX,
        "help": ["Marginalia 公共搜索面 (api.marginalia.com/public, 限速);",
                 "public 免key面返回形态待实测校准。"]},
    "marginalia_search_2": {"mode": "semi",
        "src": "Marginalia public search (别名面)",
        "form": "GET JSON path参query+count (待实测)",
        "imports": ["from urllib.parse import quote"],
        "ep": MARGINALIA_EP, "ex": MARGINALIA_EX,
        "help": ["Marginalia 同面别名登记 (github 仓库条目) — 与",
                 "marginalia_search 腿同端点。"]},
    "mwmbl": {"mode": "semi", "src": "mwmbl search API",
        "form": "GET JSON s (形态待实测)",
        "imports": [], "ep": MWMBL_EP, "ex": MWMBL_EX,
        "help": ["mwmbl 独立索引搜索面 (api.mwmbl.org); API 形态待实测",
                 "校准 — 双形态容错解析。"]},
    "reddit_json": {"mode": "full", "src": "Reddit search.json",
        "form": "GET JSON q/limit/sort",
        "imports": [], "ep": REDDIT_EP, "ex": REDDIT_EX,
        "help": ["Reddit 匿名 search.json (限流严, 出口敏感在案 1025 实测:",
                 "直连000/代理403 — 失败如实记, 不伪造)。"]},
    "hn_algolia_api": {"mode": "full", "src": "HN Algolia Search API",
        "form": "GET JSON query/hitsPerPage",
        "imports": ["import re"], "ep": HN_EP, "ex": HN_EX,
        "help": ["Hacker News Algolia 检索面 (免key)。"]},
    "stackexchange_api_stack_overflow": {"mode": "full",
        "src": "StackExchange API 2.3 (search/advanced)",
        "form": "GET JSON q/pagesize+filter=withbody",
        "imports": ["import re"], "ep": SE_EP, "ex": SE_EX,
        "help": ["StackExchange 匿名配额面 (site=stackoverflow,",
                 "filter=withbody 带正文)。"]},
    "wikipedia_api": {"mode": "full", "src": "Wikipedia API (list=search)",
        "form": "GET JSON list=search/srlimit",
        "imports": ["import re", "from urllib.parse import quote"],
        "ep": WIKIPEDIA_EP, "ex": WIKIPEDIA_EX,
        "help": ["维基百科标准查询 API (zh 站; 中英等多语言换域名即可)。"]},
    "bing_news_rss": {"mode": "full", "src": "Bing News RSS",
        "form": "GET RSS q/format=rss",
        "imports": ["import re"], "ep": RSS_BING_EP, "ex": RSS_EX,
        "help": ["Bing 新闻 RSS 面 (format=rss); item 正则解析 (CDATA 容错)。"]},
    "google_news_rss": {"mode": "full", "src": "Google News RSS (中文区)",
        "form": "GET RSS q/zh参数",
        "imports": ["import re"], "ep": RSS_GNEWS_EP, "ex": RSS_EX,
        "help": ["Google News RSS 检索面 (zh-CN 区参数)。"]},
    "google_news_rss_2": {"mode": "full",
        "src": "Google News RSS (tool://别名面)",
        "form": "GET RSS q/zh参数 (同面)",
        "imports": ["import re"], "ep": RSS_GNEWS_EP, "ex": RSS_EX,
        "help": ["Google News RSS 同面别名登记 (tool://google_news_rss_2)。"]},
    "gdelt_2_0_doc_api": {"mode": "full", "src": "GDELT 2.0 DOC API (ArtList)",
        "form": "GET JSON query/mode=ArtList/maxrecords",
        "imports": [], "ep": GDELT_EP, "ex": GDELT_EX,
        "help": ["GDELT DOC 2.0 全球新闻检索 (ArtList JSON, DateDesc)。"]},
    "gdelt_doc_2_0_api": {"mode": "full",
        "src": "GDELT DOC 2.0 API (tool://别名面)",
        "form": "GET JSON query/mode=ArtList/maxrecords (同面)",
        "imports": [], "ep": GDELT_EP, "ex": GDELT_EX,
        "help": ["GDELT DOC 2.0 同面别名登记 (tool://gdelt_doc_2_0_api)。"]},
    "gdacs": {"mode": "semi", "src": "GDACS 事件 RSS (全局流)",
        "form": "GET RSS (无q, 全局事件流)",
        "imports": ["import re"], "ep": GDACS_EP, "ex": RSS_EX,
        "help": ["GDACS 全球灾害警报事件流 (RSS 24h 窗, 无文本 q — query 仅",
                 "入台账, 如实标注)。"]},
    "jina_reader_r_jina_ai_s_jina_ai": {"mode": "semi",
        "src": "Jina Reader (r.jina.ai) 经 Bing SERP",
        "form": "GET markdown (r.jina.ai代理Bing SERP)",
        "imports": ["import re"], "ep": JINA_EP, "ex": JINA_EX,
        "help": ["r.jina.ai 无key限额面代理 Bing SERP 转写 markdown;",
                 "markdown 链接正则收割 (s.jina.ai 需key不走)。"]},
    "common_crawl_2": {"mode": "semi", "src": "Common Crawl index API",
        "form": "GET NDJSON url/output=json (查询词=URL模式)",
        "imports": ["import json"], "ep": CC_EP, "ex": CC_EX,
        "help": ["Common Crawl 索引 API (index.commoncrawl.org, 查询词=URL",
                 "模式); craw lid 钉 2024-33, 滚动更新待接。"]},
    "wayback_machine_api": {"mode": "full",
        "src": "Wayback Availability API",
        "form": "GET JSON url (单快照面)",
        "imports": [], "ep": WB_AVAIL_EP, "ex": WB_AVAIL_EX,
        "help": ["Wayback 可用性查询面 (查询词=目标URL, 单最近快照)。"]},
    "wayback_machine_cdx_api": {"mode": "full",
        "src": "Wayback CDX Server API",
        "form": "GET JSON url/output=json/collapse",
        "imports": [], "ep": WB_CDX_EP, "ex": WB_CDX_EX,
        "help": ["Wayback CDX 快照检索 (查询词=URL模式, collapse=urlkey",
                 "去重)。"]},
}
