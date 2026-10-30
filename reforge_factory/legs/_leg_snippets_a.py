# -*- coding: utf-8 -*-
"""_leg_snippets_a — 腿批量建造配置·甲组: 学术/数据 API (1025 腿批量令).

仅供 _gen_legs_batch.py 引用; 每条 = 薄腿的 endpoint/extract 逐字源码。
mode: full=端点+解析实装; semi=端点实装, 形态待实测校准。
"""
from __future__ import annotations

ARXIV_EP = r'''    return ("https://export.arxiv.org/api/query",
            {"search_query": "all:%s" % query, "start": "0",
             "max_results": str(rows)}, {}, "GET", None)'''

ARXIV_EX = r'''    if not isinstance(data, str):
        return []
    try:
        root = ET.fromstring(data)
    except ET.ParseError:
        return []
    ns = {"a": "http://www.w3.org/2005/Atom"}
    hits = []
    for e in root.findall("a:entry", ns):
        title = re.sub(r"\s+", " ", e.findtext("a:title", "", ns)).strip()
        url = e.findtext("a:id", "", ns)
        for l in e.findall("a:link", ns):
            if l.get("type") == "application/pdf":
                url = l.get("href") or url
        auth = e.find("a:author/a:name", ns)
        hits.append({
            "title": title or "(无题)",
            "url": url,
            "meta": [m for m in [e.findtext("a:published", "", ns)[:10],
                                 (auth.text or "").strip()
                                 if auth is not None else ""]
                     if m],
            "excerpt": re.sub(r"\s+", " ",
                              e.findtext("a:summary", "", ns))[:1500],
        })
    return hits'''

OPENALEX_EP = r'''    return ("https://api.openalex.org/works",
            {"search": query, "per-page": str(rows)}, {}, "GET", None)'''

OPENALEX_EX = r'''    hits = []
    for w in ((data or {}).get("results") or []):
        pos = {}
        for word, ix in (w.get("abstract_inverted_index") or {}).items():
            for i in (ix or []):
                pos[i] = word
        abstract = " ".join(pos[k] for k in sorted(pos))[:1500]
        src = ((w.get("primary_location") or {}).get("source") or {})
        hits.append({
            "title": w.get("display_name") or "(无题)",
            "url": w.get("doi") or w.get("id") or "",
            "meta": [m for m in [str(w.get("publication_year") or ""),
                                 src.get("display_name") or "",
                                 w.get("type") or ""] if m],
            "excerpt": abstract,
        })
    return hits'''

S2_EP = r'''    return ("https://api.semanticscholar.org/graph/v1/paper/search",
            {"query": query, "limit": str(rows),
             "fields": "title,url,abstract,year,venue,authors"},
            {}, "GET", None)'''

S2_EX = r'''    hits = []
    for p in ((data or {}).get("data") or []):
        auths = ", ".join(a.get("name", "")
                          for a in (p.get("authors") or [])[:3])
        hits.append({
            "title": p.get("title") or "(无题)",
            "url": p.get("url") or "",
            "meta": [m for m in [str(p.get("year") or ""),
                                 p.get("venue") or "", auths] if m],
            "excerpt": (p.get("abstract")
                        or "(无摘要返回 — 见原文)")[:1500],
        })
    return hits'''

CROSSREF_EP = r'''    return ("https://api.crossref.org/works",
            {"query": query, "rows": str(rows)}, {}, "GET", None)'''

CROSSREF_EX = r'''    msg = ((data or {}).get("message") or {})
    hits = []
    for it in (msg.get("items") or []):
        title = next((t for t in (it.get("title") or []) if t), "") or "(无题)"
        dp = ((it.get("issued") or {}).get("date-parts") or [[None]])[0]
        year = str(dp[0]) if dp and dp[0] else ""
        auths = ", ".join("%s %s" % (a.get("given", ""), a.get("family", ""))
                          for a in (it.get("author") or [])[:3]).strip()
        hits.append({
            "title": title,
            "url": it.get("URL") or
                   ("https://doi.org/" + str(it.get("doi") or "")),
            "meta": [m for m in [year,
                                 (it.get("container-title") or [""])[0],
                                 auths, it.get("DOI") or ""] if m],
            "excerpt": re.sub(r"<[^>]+>", " ",
                              it.get("abstract") or "")[:1500],
        })
    return hits'''

DOAJ_EP = r'''    return ("https://doaj.org/api/search/articles/" + quote(query, safe=""),
            {"pageSize": str(rows)}, {}, "GET", None)'''

DOAJ_EX = r'''    hits = []
    for r in ((data or {}).get("results") or []):
        b = r.get("bibjson") or {}
        link = ""
        for l in (b.get("link") or []):
            if l.get("url"):
                link = l["url"]
                break
        hits.append({
            "title": b.get("title") or "(无题)",
            "url": link or
                   ("https://doaj.org/article/" + str(r.get("id") or "")),
            "meta": [m for m in [str(b.get("year") or ""),
                                 (b.get("journal") or {}).get("title") or "",
                                 ", ".join(a.get("name", "")
                                           for a in
                                           (b.get("author") or [])[:3])]
                     if m],
            "excerpt": (b.get("abstract") or "")[:1500],
        })
    return hits'''

EPMC_EP = r'''    return ("https://www.ebi.ac.uk/europepmc/webservices/rest/search",
            {"query": query, "format": "json", "pageSize": str(rows),
             "resultType": "core"}, {}, "GET", None)'''

EPMC_EX = r'''    res = ((data or {}).get("resultList") or {}).get("result") or []
    hits = []
    for p in res:
        pid = p.get("id") or ""
        url = ("https://europepmc.org/article/%s/%s"
               % (p.get("source") or "", pid)) if pid else ""
        hits.append({
            "title": p.get("title") or "(无题)",
            "url": url,
            "meta": [m for m in [str(p.get("pubYear") or ""),
                                 p.get("journalTitle") or "",
                                 p.get("doi") or ""] if m],
            "excerpt": (p.get("abstractText") or "")[:1500],
        })
    return hits'''

UNPAYWALL_EP = r'''    # Unpaywall 检索面仅需 email 参数 (官方文档测试惯例占位, 正式邮箱待换)
    return ("https://api.unpaywall.org/v2/search",
            {"query": query, "email": "test@example.org"}, {}, "GET", None)'''

UNPAYWALL_EX = r'''    hits = []
    for r in ((data or {}).get("results") or []):
        doi = str(r.get("doi") or "")
        hits.append({
            "title": r.get("title") or "(无题)",
            "url": ("https://doi.org/" + doi) if doi else "",
            "meta": [m for m in [str(r.get("year") or ""),
                                 r.get("journal_name") or "",
                                 "OA=%s" % r.get("is_oa")] if m],
            "excerpt": "Unpaywall 命中: %s — OA状态 %s (期刊 %s)"
                       % (doi, r.get("is_oa"), r.get("journal_name") or "-"),
        })
    return hits'''

CKAN_DGUK_EP = r'''    return ("https://data.gov.uk/api/3/action/package_search",
            {"q": query, "rows": str(rows)}, {}, "GET", None)'''

CKAN_DGUK_EX = r'''    res = ((data or {}).get("result") or {})
    hits = []
    for d in (res.get("results") or []):
        org = d.get("organization") or {}
        hits.append({
            "title": d.get("title") or d.get("name") or "(无题)",
            "url": d.get("url") or
                   ("https://data.gov.uk/dataset/"
                    + str(d.get("name") or "")),
            "meta": [m for m in [org.get("title") or org.get("name") or "",
                                 ", ".join(t.get("display_name", "")
                                           for t in
                                           (d.get("tags") or [])[:4])] if m],
            "excerpt": re.sub(r"<[^>]+>", " ",
                              d.get("notes") or "")[:1500],
        })
    return hits'''

CKAN_HDX_EP = r'''    return ("https://data.humdata.org/api/3/action/package_search",
            {"q": query, "rows": str(rows)}, {}, "GET", None)'''

CKAN_HDX_EX = r'''    res = ((data or {}).get("result") or {})
    hits = []
    for d in (res.get("results") or []):
        org = d.get("organization") or {}
        hits.append({
            "title": d.get("title") or d.get("name") or "(无题)",
            "url": d.get("url") or
                   ("https://data.humdata.org/dataset/"
                    + str(d.get("name") or "")),
            "meta": [m for m in [org.get("title") or org.get("name") or "",
                                 ", ".join(t.get("display_name", "")
                                           for t in
                                           (d.get("tags") or [])[:4])] if m],
            "excerpt": re.sub(r"<[^>]+>", " ",
                              d.get("notes") or "")[:1500],
        })
    return hits'''

IA_EP = r'''    return ("https://archive.org/advancedsearch.php",
            {"q": query, "rows": str(rows), "page": "1", "output": "json",
             "fl[]": ["identifier", "title", "description",
                      "mediatype", "year"]},
            {}, "GET", None)'''

IA_EX = r'''    docs = (((data or {}).get("response") or {}).get("docs")) or []
    hits = []
    for d in docs:
        ident = d.get("identifier") or ""
        desc = d.get("description") or ""
        if isinstance(desc, list):
            desc = " ".join(str(x) for x in desc)
        hits.append({
            "title": d.get("title") or ident or "(无题)",
            "url": "https://archive.org/details/" + ident,
            "meta": [m for m in [d.get("mediatype") or "",
                                 str(d.get("year") or "")] if m],
            "excerpt": re.sub(r"<[^>]+>", " ", str(desc))[:1500],
        })
    return hits'''

HF_HUB_EP = r'''    return ("https://huggingface.co/api/models",
            {"search": query, "limit": str(rows)}, {}, "GET", None)'''

HF_HUB_EX = r'''    hits = []
    if isinstance(data, list):
        for mm in data:
            ident = mm.get("id") or "(无题)"
            hits.append({
                "title": ident,
                "url": "https://huggingface.co/" + ident,
                "meta": [m for m in [mm.get("pipeline_tag") or "",
                                     "%s下载" % mm.get("downloads"),
                                     "%s赞" % mm.get("likes")] if m],
                "excerpt": "HF Hub 模型面: %s (downloads=%s, likes=%s)"
                           % (ident, mm.get("downloads"),
                              mm.get("likes")),
            })
    return hits'''

OPENAIRE_EP = r'''    return ("https://api.openaire.eu/search/publications",
            {"keywords": query, "size": str(rows), "format": "json"},
            {}, "GET", None)'''

OPENAIRE_EX = r'''    hits = []

    def _walk(node):
        out = []
        if isinstance(node, dict):
            t = node.get("title")
            if isinstance(t, dict):
                t = t.get("$")
            if isinstance(t, str) and t.strip():
                out.append((t.strip(), node))
            for v in node.values():
                out += _walk(v)
        elif isinstance(node, list):
            for v in node:
                out += _walk(v)
        return out

    for t, d in _walk(data if isinstance(data, dict) else {}):
        hits.append({
            "title": t or "(无题)",
            "url": str(d.get("url") or d.get("webresourceurl") or ""),
            "meta": [str(d.get("dateofacceptance") or ""),
                     str(d.get("publisher") or "")],
            "excerpt": "OpenAIRE 出版物命中: %s (嵌套JSON形态, "
                       "解析面待实测校准)" % t,
        })
    return hits'''

#: 甲组登记 (mode/full|semi; imports=标准库追加; ep/ex=源码; form=台账端点形态)
GROUP_A: dict[str, dict] = {
    "arxiv_api": {"mode": "full", "src": "arXiv API (Atom query)",
        "form": "GET Atom XML search_query/max_results",
        "imports": ["import re", "import xml.etree.ElementTree as ET"],
        "ep": ARXIV_EP, "ex": ARXIV_EX,
        "help": ["arXiv 官方 Atom 查询面 (export.arxiv.org, search_query=all:词",
                 "+ max_results)。XML 面 → ElementTree 解析 (标题/链接/作者/摘要)。"]},
    "arxiv_py": {"mode": "full", "src": "arXiv 官方API面 (arxiv.py 封装同面)",
        "form": "GET Atom XML search_query/max_results (同arxiv_api)",
        "imports": ["import re", "import xml.etree.ElementTree as ET"],
        "ep": ARXIV_EP, "ex": ARXIV_EX,
        "help": ["封装库 lukasschwab/arxiv.py 底层=arXiv 官方 API — 本腿直接走",
                 "官方同一端点 (免装库), 引擎 id 对齐 registry 登记。"]},
    "openalex_api": {"mode": "full", "src": "OpenAlex Works API (search)",
        "form": "GET JSON search/per-page",
        "imports": [], "ep": OPENALEX_EP, "ex": OPENALEX_EX,
        "help": ["OpenAlex 学术工作面 (api.openalex.org/works, 匿名限额);",
                 "摘要为倒排索引 → 原位重排还原。"]},
    "openalex": {"mode": "full", "src": "OpenAlex Works API (tool://别名面)",
        "form": "GET JSON search/per-page (同openalex_api)",
        "imports": [], "ep": OPENALEX_EP, "ex": OPENALEX_EX,
        "help": ["OpenAlex 同面别名登记 (tool://openalex) — 与 openalex_api 腿",
                 "同端点, 引擎 id 对齐 SURVEY_ALIASES。"]},
    "semantic_scholar_graph_api": {"mode": "full",
        "src": "Semantic Scholar Graph API (paper/search)",
        "form": "GET JSON query/limit+fields",
        "imports": [], "ep": S2_EP, "ex": S2_EX,
        "help": ["Semantic Scholar Graph API 论文检索 (无key限速);",
                 "fields 显式列 → 标题/年份/期刊/作者/摘要。"]},
    "semantic_scholar_api": {"mode": "full",
        "src": "Semantic Scholar API (tool://别名面)",
        "form": "GET JSON query/limit+fields (同graph面)",
        "imports": [], "ep": S2_EP, "ex": S2_EX,
        "help": ["Semantic Scholar 同面别名登记 (tool://semantic_scholar_api)",
                 "— 与 graph API 腿同端点。"]},
    "crossref_rest_api": {"mode": "full", "src": "Crossref REST API (works)",
        "form": "GET JSON query/rows",
        "imports": ["import re"], "ep": CROSSREF_EP, "ex": CROSSREF_EX,
        "help": ["Crossref 公共 REST 面 (api.crossref.org/works, mailto 礼貌池",
                 "可选 — 本腿匿名面如实跑)。"]},
    "crossref_api": {"mode": "full", "src": "Crossref API (tool://别名面)",
        "form": "GET JSON query/rows (同works面)",
        "imports": ["import re"], "ep": CROSSREF_EP, "ex": CROSSREF_EX,
        "help": ["Crossref 同面别名登记 (tool://crossref_api) — 与 REST 腿",
                 "同端点。"]},
    "sckott_habanero": {"mode": "full",
        "src": "Crossref 公共API面 (habanero 封装同面)",
        "form": "GET JSON query/rows (同works面)",
        "imports": ["import re"], "ep": CROSSREF_EP, "ex": CROSSREF_EX,
        "help": ["python 库 sckott/habanero 底层=Crossref 公共 API — 本腿直接",
                 "走官方端点 (免装库)。"]},
    "doaj_api": {"mode": "full", "src": "DOAJ API (search articles)",
        "form": "GET JSON path参query+pageSize",
        "imports": ["from urllib.parse import quote"],
        "ep": DOAJ_EP, "ex": DOAJ_EX,
        "help": ["DOAJ 开放获取期刊文章检索 (检索词入 path);",
                 "bibjson 面 → 标题/期刊/作者/摘要。"]},
    "europe_pmc_rest_api": {"mode": "full",
        "src": "Europe PMC REST API (search)",
        "form": "GET JSON query/pageSize+resultType=core",
        "imports": [], "ep": EPMC_EP, "ex": EPMC_EX,
        "help": ["Europe PMC 生命科学文献检索 (resultType=core 带摘要);",
                 "含 PubMed 收录面。"]},
    "unpaywall_api": {"mode": "full", "src": "Unpaywall API v2 (search)",
        "form": "GET JSON query+email(占位)",
        "imports": [], "ep": UNPAYWALL_EP, "ex": UNPAYWALL_EX,
        "help": ["Unpaywall OA 状态检索 (仅需 email 参数, 官方测试惯例占位",
                 "test@example.org — 正式邮箱待换)。"]},
    "data_gov_uk": {"mode": "full",
        "src": "data.gov.uk CKAN package_search",
        "form": "GET CKAN JSON q/rows",
        "imports": ["import re"], "ep": CKAN_DGUK_EP, "ex": CKAN_DGUK_EX,
        "help": ["英国政府开放数据 CKAN 检索面 (api/3/action标准)。"]},
    "hdx_humanitarian_data_exchange": {"mode": "full",
        "src": "HDX CKAN package_search",
        "form": "GET CKAN JSON q/rows",
        "imports": ["import re"], "ep": CKAN_HDX_EP, "ex": CKAN_HDX_EX,
        "help": ["HDX 人道主义数据交换 CKAN 检索面 (data.humdata.org)。"]},
    "internet_archive": {"mode": "full",
        "src": "Internet Archive advancedsearch",
        "form": "GET JSON q/rows+fl[]",
        "imports": ["import re"], "ep": IA_EP, "ex": IA_EX,
        "help": ["Internet Archive 高级检索面 (fl[] 列字段: identifier/title/",
                 "description/mediatype/year)。"]},
    "huggingface_hub_api": {"mode": "full",
        "src": "HuggingFace Hub API (models search)",
        "form": "GET JSON search/limit (模型面)",
        "imports": [], "ep": HF_HUB_EP, "ex": HF_HUB_EX,
        "help": ["HF Hub 模型检索面 (与在役 hf_datasets 腿同族 — 本腿=模型",
                 "面, 数据集面见 hf_datasets_leg.py)。"]},
    "openaire_search_api": {"mode": "semi",
        "src": "OpenAIRE Search API (publications)",
        "form": "GET JSON keywords/size (嵌套形态待校准)",
        "imports": [], "ep": OPENAIRE_EP, "ex": OPENAIRE_EX,
        "help": ["OpenAIRE 出版物检索 (keywords 参数); JSON 嵌套形态较深 —",
                 "递归走取 title 面, 解析细节待实测校准。"]},
}
