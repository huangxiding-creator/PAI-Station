# -*- coding: utf-8 -*-
"""_leg_snippets_c — 腿批量建造配置·丙组: 政府/金融/地信/国际组织 (1025 腿批量令).

仅供 _gen_legs_batch.py 引用; 每条 = 薄腿的 endpoint/extract 逐字源码。
mode: full=端点+解析实装; semi=端点实装, 形态待实测校准。
"""
from __future__ import annotations

SEC_EDGAR_EP = r'''    return ("https://efts.sec.gov/LATEST/search-index",
            {"q": query}, {}, "GET", None)'''

SEC_EDGAR_EX = r'''    d = data if isinstance(data, dict) else {}
    hits = []
    for h in (((d.get("hits") or {}).get("hits")) or []):
        s = h.get("_source") or {}
        names = ", ".join(s.get("display_names") or [])
        ciks = s.get("ciks") or []
        idr = str(h.get("_id") or "")
        acc, fname = (idr.split(":", 1) + [""])[:2]
        url = ""
        if ciks and acc:
            url = ("https://www.sec.gov/Archives/edgar/data/%s/%s/%s"
                   % (str(ciks[0]).zfill(10),
                      acc.replace("-", ""), fname))
        hits.append({
            "title": "SEC EDGAR 全文命中: %s (%s)"
                     % (names, s.get("file_type") or ""),
            "url": url,
            "meta": [m for m in [names, s.get("file_date") or "",
                                 s.get("file_type") or ""] if m],
            "excerpt": "EDGAR FTS 命中: %s | 表单 %s | 日期 %s | CIK %s"
                       % (names, s.get("file_type") or "-",
                          s.get("file_date") or "-", ciks[:1]),
        })
    return hits'''

OPENVERSE_EP = r'''    return ("https://api.openverse.org/v1/images/",
            {"q": query, "page_size": str(rows)}, {}, "GET", None)'''

OPENVERSE_EX = r'''    hits = []
    for r in ((data or {}).get("results") or []):
        hits.append({
            "title": r.get("title") or "(无题)",
            "url": r.get("foreign_landing_url") or r.get("url") or "",
            "meta": [m for m in [r.get("source") or "",
                                 r.get("license") or "",
                                 r.get("license_version") or ""] if m],
            "excerpt": "Openverse 图像面命中: %s (source=%s, license=%s %s)"
                       % (r.get("title") or "", r.get("source") or "",
                          r.get("license") or "",
                          r.get("license_version") or ""),
        })
    return hits'''

RELIEFWEB_EP = r'''    return ("https://api.reliefweb.int/v1/reports",
            {"appname": "ai-station-research-leg",
             "query[value]": query, "limit": str(rows),
             "sort[]": "date:desc",
             "fields[include][]": ["title", "url", "source.shortname",
                                   "date.created"]},
            {}, "GET", None)'''

RELIEFWEB_EX = r'''    hits = []
    for d in ((data or {}).get("data") or []):
        f = d.get("fields") or {}
        src = f.get("source") or []
        if not isinstance(src, list):
            src = [src]
        srcname = ", ".join(s.get("shortname") or s.get("name") or ""
                            for s in src if isinstance(s, dict))
        title = f.get("title") or "(无题)"
        hits.append({
            "title": title,
            "url": f.get("url") or "",
            "meta": [m for m in [srcname,
                                 str((f.get("date") or {})
                                     .get("created") or "")[:10]] if m],
            "excerpt": "ReliefWeb 人道报告: %s (来源: %s)"
                       % (title, srcname or "-"),
        })
    return hits'''

IMF_EP = r'''    return ("https://www.imf.org/external/datamapper/api/v1/indicators",
            {}, {}, "GET", None)'''

IMF_EX = r'''    ind = (data or {}).get("indicators") or {}
    hits = []
    for code, meta in ind.items():
        if not isinstance(meta, dict):
            continue
        label = meta.get("label") or code
        hits.append({
            "title": label,
            "url": "https://www.imf.org/external/datamapper/api/v1/" + code,
            "meta": [m for m in [code, meta.get("unit") or "",
                                 str(meta.get("source")
                                     or "")[:60]] if m],
            "excerpt": "IMF DataMapper 指标: %s (%s) — unit=%s "
                       "(指标清单面, 查询词过滤待接)"
                       % (label, code, meta.get("unit") or "-"),
        })
    return hits'''

USGS_EQ_EP = r'''    # FDSN 无文本检索参数 — query 仅入台账, 面按最新时间序取事件样本
    return ("https://earthquake.usgs.gov/fdsnws/event/1/query",
            {"format": "geojson", "limit": str(rows), "orderby": "time"},
            {}, "GET", None)'''

USGS_EQ_EX = r'''    hits = []
    for f in ((data or {}).get("features") or []):
        p = f.get("properties") or {}
        co = (f.get("geometry") or {}).get("coordinates") or ["", "", ""]
        mag, place = p.get("mag"), (p.get("place") or "")
        hits.append({
            "title": "M%s %s" % (mag, place),
            "url": p.get("url") or "",
            "meta": [m for m in ["M%s级" % mag, place,
                                 "%s,%s" % (co[1], co[0])] if m],
            "excerpt": "USGS 地震事件: M%s %s — 坐标(%s, %s) 深度%skm "
                       "(FDSN 时间面, 无文本q)"
                       % (mag, place, co[1], co[0], co[2]),
        })
    return hits'''

FEMA_EP = r'''    return ("https://www.fema.gov/api/open/v2/DisasterDeclarationsSummaries",
            {"$top": str(rows), "$orderby": "declarationDate desc",
             "$filter": "contains(declarationTitle,'%s')"
                        % query.replace("'", "''")},
            {}, "GET", None)'''

FEMA_EX = r'''    hits = []
    for d in ((data or {}).get("DisasterDeclarationsSummaries") or []):
        title = d.get("declarationTitle") or "(无题)"
        county = d.get("declaredCountyArea")
        if isinstance(county, list):
            county = ", ".join(str(c) for c in county)
        hits.append({
            "title": "%s — %s%s" % (title, d.get("state") or "",
                                    (" " + county) if county else ""),
            "url": "https://www.fema.gov/disaster/"
                   + str(d.get("disasterNumber") or ""),
            "meta": [m for m in [str(d.get("disasterNumber") or ""),
                                 str(d.get("declarationDate")
                                     or "")[:10],
                                 d.get("incidentType") or ""] if m],
            "excerpt": "OpenFEMA 灾害声明: %s (%s)"
                       % (title, d.get("incidentType") or "-"),
        })
    return hits'''

OVERPASS_EP = r'''    q = ('[out:json][timeout:25];node["name"~"%s",i];out %d;'
         % (query.replace('"', '\\"'), rows))
    return ("https://overpass-api.de/api/interpreter", None,
            {"Content-Type": "application/x-www-form-urlencoded"},
            "POST", ("data=" + quote(q)).encode("ascii"))'''

OVERPASS_EX = r'''    hits = []
    for el in ((data or {}).get("elements") or []):
        tags = el.get("tags") or {}
        name = tags.get("name") or "(无名节点)"
        typ = el.get("type") or "node"
        tags_line = ", ".join("%s=%s" % kv for kv in list(tags.items())[:8])
        hits.append({
            "title": name,
            "url": "https://www.openstreetmap.org/%s/%s"
                   % (typ, el.get("id") or ""),
            "meta": [m for m in [typ,
                                 "%s,%s" % (el.get("lat"), el.get("lon")),
                                 tags.get("amenity")
                                 or tags.get("highway") or ""] if m],
            "excerpt": "OSM Overpass 实体: %s (%s) — %s"
                       % (name, typ, tags_line),
        })
    return hits'''

PROZORRO_EP = r'''    # ProZorro API 检索面无文本q参数 — 列表面 + limit (query 仅入台账)
    return ("https://public.api.openprocurement.org/api/v2/tenders",
            {"limit": str(rows)}, {}, "GET", None)'''

PROZORRO_EX = r'''    hits = []
    for t in ((data or {}).get("data") or []):
        tid = t.get("id") or ""
        hits.append({
            "title": "ProZorro 标书: " + tid,
            "url": "https://prozorro.gov.ua/tender/" + tid,
            "meta": [m for m in [t.get("dateModified") or "",
                                 t.get("status") or ""] if m],
            "excerpt": "ProZorro 乌克兰公共采购标书 (API 无文本q — 列表面, "
                       "检索词过滤待接)",
        })
    return hits'''

SEARX_SPACE_EP = r'''    return ("https://instances.searx.space/data/instances.json",
            {}, {}, "GET", None)'''

SEARX_SPACE_EX = r'''    inst = (data or {}).get("instances") or {}
    hits = []
    for url, meta in (inst.items() if isinstance(inst, dict) else []):
        if not isinstance(meta, dict):
            continue
        http = ((meta.get("http") or {}).get("status_code")) or ""
        tls = ((meta.get("tls") or {}).get("grade")) or ""
        hits.append({
            "title": "SearXNG 实例: " + str(url),
            "url": str(url),
            "meta": [m for m in ["http=%s" % http, "TLS=%s" % tls] if m],
            "excerpt": "searx.space 实例清单面 (非检索面; 实例健康度元数据, "
                       "查询词不适用)",
        })
    return hits'''

CNINFO_EP = r'''    body = urlencode(
        {"pageNum": "1", "pageSize": str(rows), "column": "szse",
         "tabName": "fulltext", "plate": "", "stock": "",
         "searchkey": query, "secid": "", "category": "",
         "trade": "", "seDate": ""}).encode("ascii")
    return ("http://www.cninfo.com.cn/new/hisAnnouncement/query", None,
            {"Content-Type": "application/x-www-form-urlencoded",
             "Referer": "http://www.cninfo.com.cn/new/commonUrl/"
                        "pageOfSearch?url=disclosure/list/company"},
            "POST", body)'''

CNINFO_EX = r'''    hits = []
    for a in ((data or {}).get("announcements") or []):
        adjunct = a.get("adjunctUrl") or ""
        hits.append({
            "title": a.get("announcementTitle") or "(无题)",
            "url": ("http://static.cninfo.com.cn/" + adjunct)
                   if adjunct else "",
            "meta": [m for m in [str(a.get("secCode") or ""),
                                 str(a.get("secName") or ""),
                                 str(a.get("announcementTime")
                                     or "")[:10]] if m],
            "excerpt": "巨潮资讯公告: %s (%s)"
                       % (a.get("announcementTitle") or "",
                          a.get("secName") or ""),
        })
    return hits'''

SSE_EP = r'''    # TODO(1025批量): sqlId/参数形态待实测校准 (Referer 头为过闸关键)
    return ("https://query.sse.com.cn/search/getESSearchDoc.do",
            {"sqlId": "BS_GGLL", "searchkey": query,
             "isPagination": "true", "pageHelp": "1",
             "pageSize": str(rows)},
            {"Referer": "https://www.sse.com.cn/"}, "GET", None)'''

SSE_EX = r'''    docs = data if isinstance(data, list) else []
    hits = []
    for d in docs:
        if not isinstance(d, dict):
            continue
        title = next((str(d.get(k)) for k in
                      ("docTitle", "title", "infoTitle", "docSubject")
                      if d.get(k)), "(无题)")
        url = next((str(d.get(k)) for k in ("URL", "url", "docUrl")
                    if d.get(k)), "")
        hits.append({
            "title": title,
            "url": url,
            "meta": [str(d.get(k)) for k in
                     ("date", "docDate", "publishDate") if d.get(k)],
            "excerpt": "上交所公告检索命中: %s (返回形态待实测校准)" % title,
        })
    return hits'''

SZSE_EP = r'''    # TODO(1025批量): CATALOGID(报表类目id)待按采集面校准 (1945=年报线)
    return ("https://www.szse.cn/api/report/ShowReport/data",
            {"SHOWTYPE": "JSON", "CATALOGID": "1945", "PAGENO": "1"},
            {}, "GET", None)'''

SZSE_EX = r'''    hits = []
    if not isinstance(data, list):
        return hits
    for blk in data:
        if not isinstance(blk, dict):
            continue
        for r in (blk.get("data") or []):
            if not isinstance(r, dict):
                continue
            kvs = [(k, str(v)) for k, v in r.items()
                   if isinstance(v, str) and v.strip()]
            if not kvs:
                continue
            title = next((v for _, v in kvs if len(v) > 3), kvs[0][1])
            hits.append({
                "title": title[:120],
                "url": "https://www.szse.cn/disclosure/listed/fixed/"
                       "index.html",
                "meta": [v for _, v in kvs[:4]],
                "excerpt": "深交所 ShowReport 报表面: %s"
                           % " | ".join("%s=%s" % kv for kv in kvs[:8]),
            })
    return hits'''

BAIDU_EP = r'''    return ("https://www.baidu.com/s",
            {"wd": query, "rn": str(rows)}, {}, "GET", None)'''

BAIDU_EX = r'''    if not isinstance(data, str):
        return []
    hits, seen = [], set()
    for m in re.finditer(
            r'<h3[^>]*>\s*<a[^>]+href="(http[^"]+)"[^>]*>(.*?)</a>',
            data, re.S):
        url = m.group(1)
        if url in seen:
            continue
        seen.add(url)
        title = re.sub(r"<[^>]+>", "", m.group(2)).strip()
        if not title:
            continue
        hits.append({
            "title": title,
            "url": url,
            "meta": ["百度SERP(跳转链)"],
            "excerpt": "百度结果: %s (百度跳转链, 实链resolve待接; "
                       "风控面(需cookie/验证码)则如实失败)" % title,
        })
    return hits'''

CCGP_EP = r'''    body = urlencode(
        {"kw": query, "searchtype": "1", "page": "1"}).encode("utf-8")
    return ("http://search.ccgp.gov.cn/bxsearch", None,
            {"Content-Type": "application/x-www-form-urlencoded"},
            "POST", body)'''

CCGP_EX = r'''    # TODO(1025批量): ccgp 结果页为 GBK 编码, 芯按 utf-8/replace 解码致乱码 —
    # 解析面待芯扩展 GBK 解码后接入; 如实零命中 (不伪造)
    return []'''

EMSC_EP = r'''    # EMSC FDSN 文本面 (事件流, 无文本q) — query 仅入台账
    return ("https://www.seismicportal.eu/fdsnws/event/1/query",
            {"format": "text", "limit": str(rows)}, {}, "GET", None)'''

EMSC_EX = r'''    if not isinstance(data, str):
        return []
    hits = []
    for ln in data.splitlines():
        if not ln or ln.startswith("#"):
            continue
        p = ln.split("|")
        if len(p) < 12:
            continue
        hits.append({
            "title": "EMSC M%s %s" % (p[10], p[11]),
            "url": "https://www.seismicportal.eu/fdsnws/event/1/query"
                   "?eventid=%s" % p[0],
            "meta": [p[1], "M%s%s" % (p[10], p[9]),
                     "%s,%s" % (p[2], p[3])],
            "excerpt": "EMSC 地震事件: M%s %s — 时间 %s, 坐标(%s, %s), "
                       "深度%skm (FDSN text 面)"
                       % (p[10], p[11], p[1], p[2], p[3], p[4]),
        })
    return hits'''

NCEI_EP = r'''    # TODO(1025批量): NCEI Data Service 检索面参数形态待实测校准
    return ("https://www.ncei.noaa.gov/access/services/search/v1/data",
            {"searchTerm": query, "pageSize": str(rows), "format": "json"},
            {}, "GET", None)'''

NCEI_EX = r'''    docs = ((data or {}).get("results") or (data or {}).get("dataset") or [])
    hits = []
    for d in (docs if isinstance(docs, list) else []):
        if not isinstance(d, dict):
            continue
        title = str(d.get("title") or d.get("name") or "(无题)")
        hits.append({
            "title": title,
            "url": str(d.get("info") or d.get("url") or ""),
            "meta": [str(d.get("beginDate") or ""),
                     str(d.get("endDate") or "")],
            "excerpt": "NCEI 数据集命中: %s (返回形态待实测校准)" % title,
        })
    return hits'''

OECD_SDMX_EP = r'''    # SDMX REST dataflow 清单面 (XML) — 查询词过滤待接
    return ("https://sdmx.oecd.org/public/rest/dataflow/all/all/latest",
            {}, {}, "GET", None)'''

OECD_SDMX_EX = r'''    if not isinstance(data, str):
        return []
    try:
        root = ET.fromstring(data)
    except ET.ParseError:
        return []
    hits = []
    for el in root.iter():
        if not str(el.tag).endswith("Dataflow"):
            continue
        fid = el.get("id") or ""
        name = ""
        for ch in el:
            if str(ch.tag).endswith("Name") and (ch.text or "").strip():
                name = ch.text.strip()
                break
        hits.append({
            "title": "%s (%s)" % (name or fid, fid),
            "url": "https://sdmx.oecd.org/public/rest/dataflow/"
                   "all/all/latest",
            "meta": [fid, el.get("agencyID") or "",
                     el.get("version") or ""],
            "excerpt": "OECD SDMX 数据流: %s [%s] (agency=%s)"
                       % (name or fid, fid, el.get("agencyID") or "-"),
        })
    return hits'''

#: 丙组登记
GROUP_C: dict[str, dict] = {
    "sec_edgar": {"mode": "full",
        "src": "SEC EDGAR 全文检索 (efts search-index)",
        "form": "GET JSON q (UA声明在芯)",
        "imports": [], "ep": SEC_EDGAR_EP, "ex": SEC_EDGAR_EX,
        "help": ["SEC EDGAR 全文检索面 (efts.sec.gov/LATEST/search-index,",
                 "需声明UA — 芯UA已实测200在案); accession→文档真链拼装。"]},
    "openverse": {"mode": "full", "src": "Openverse API v1 (images)",
        "form": "GET JSON q/page_size",
        "imports": [], "ep": OPENVERSE_EP, "ex": OPENVERSE_EX,
        "help": ["Openverse 开放图像检索 (api.openverse.org, 免key限速)。"]},
    "openverse_2": {"mode": "full",
        "src": "Openverse (tool://别名面)",
        "form": "GET JSON q/page_size (同面)",
        "imports": [], "ep": OPENVERSE_EP, "ex": OPENVERSE_EX,
        "help": ["Openverse 同面别名登记 (tool://openverse_2)。"]},
    "reliefweb_api": {"mode": "full", "src": "ReliefWeb API v1 (reports)",
        "form": "GET JSON appname/query[value]/fields[]",
        "imports": [], "ep": RELIEFWEB_EP, "ex": RELIEFWEB_EX,
        "help": ["ReliefWeb 人道主义报告检索 (appname 为站方要求的调用方",
                 "标识非key)。"]},
    "imf_datamapper_sdmx": {"mode": "semi",
        "src": "IMF DataMapper indicators API",
        "form": "GET JSON (指标清单面)",
        "imports": [], "ep": IMF_EP, "ex": IMF_EX,
        "help": ["IMF DataMapper 指标清单面 (官方API); 查询词过滤=指标",
                 "id 取数待接 — 如实标注清单面。"]},
    "usgs_earthquake_api": {"mode": "semi",
        "src": "USGS FDSN event query (geojson)",
        "form": "GET geojson limit/orderby (时间面)",
        "imports": [], "ep": USGS_EQ_EP, "ex": USGS_EQ_EX,
        "help": ["USGS 地震 FDSN 事件面 (geojson); FDSN 无文本q — 按",
                 "最新时间序取样本, query 仅入台账。"]},
    "openfema": {"mode": "semi",
        "src": "OpenFEMA OData v2",
        "form": "GET JSON OData $filter(contains)/$top",
        "imports": [], "ep": FEMA_EP, "ex": FEMA_EX,
        "help": ["OpenFEMA 灾害声明 OData 面 (contains 过滤 declarationTitle)。"]},
    "openstreetmap_overpass_api": {"mode": "semi",
        "src": "OSM Overpass API (interpreter)",
        "form": "POST Overpass QL (name正则)",
        "imports": ["from urllib.parse import quote"],
        "ep": OVERPASS_EP, "ex": OVERPASS_EX,
        "help": ["OSM Overpass QL 查询 (POST data= 编码); 查询词=name 正则",
                 "节点面。"]},
    "prozorro": {"mode": "semi",
        "src": "ProZorro public API v2 (tenders)",
        "form": "GET JSON limit (列表面)",
        "imports": [], "ep": PROZORRO_EP, "ex": PROZORRO_EX,
        "help": ["ProZorro 乌克兰公共采购 API (无文本q — 标书列表面)。"]},
    "searx_space": {"mode": "semi",
        "src": "searx.space instances 清单",
        "form": "GET JSON (实例清单面)",
        "imports": [], "ep": SEARX_SPACE_EP, "ex": SEARX_SPACE_EX,
        "help": ["searx.space SearXNG 实例健康清单 (非检索面 — 实例选点用)。"]},
    "cninfo_com_cn": {"mode": "semi",
        "src": "巨潮资讯 hisAnnouncement/query",
        "form": "POST form (searchkey)",
        "imports": ["from urllib.parse import urlencode"],
        "ep": CNINFO_EP, "ex": CNINFO_EX,
        "help": ["巨潮资讯公告检索 (POST /new/hisAnnouncement/query 实测200",
                 "在案; Referer 过闸头)。"]},
    "sse_com_cn": {"mode": "semi",
        "src": "上交所 getESSearchDoc.do",
        "form": "GET JSON+Referer头 (sqlId待校准)",
        "imports": [], "ep": SSE_EP, "ex": SSE_EX,
        "help": ["上交所检索端点 (query.sse.com.cn JSON+Referer 实测200在案);",
                 "sqlId 参数形态待实测校准。"]},
    "szse_cn": {"mode": "semi",
        "src": "深交所 ShowReport/data",
        "form": "GET JSON CATALOGID (类目待校准)",
        "imports": [], "ep": SZSE_EP, "ex": SZSE_EX,
        "help": ["深交所报表端点 (/api/report/ShowReport/data 实测200在案);",
                 "CATALOGID 类目清单待校准 (1945=年报线)。"]},
    "baidu_serp_api": {"mode": "semi",
        "src": "百度 SERP (免key直取蓝本)",
        "form": "GET HTML regex wd/rn",
        "imports": ["import re"], "ep": BAIDU_EP, "ex": BAIDU_EX,
        "help": ["百度 SERP 免key直取 (蓝本 ohblue/baidu-serp-api); h3 标题",
                 "正则收割 — 百度风控(需cookie/验证码)则如实失败。"]},
    "python_baidusearch_pypi_baidusearch": {"mode": "semi",
        "src": "百度 SERP (baidusearch 库同面)",
        "form": "GET HTML regex wd/rn (同面)",
        "imports": ["import re"], "ep": BAIDU_EP, "ex": BAIDU_EX,
        "help": ["pip 库 baidusearch 蓝本同面 (amazingcoderpro/python-",
                 "baidusearch) — 免装库直接走同端点。"]},
    "ccgp_gov_cn": {"mode": "semi",
        "src": "中国政府采购网 bxsearch (POST)",
        "form": "POST form kw + 解析TODO(GBK)",
        "imports": ["from urllib.parse import urlencode"],
        "ep": CCGP_EP, "ex": CCGP_EX,
        "help": ["政采网检索 POST 端点 (search.ccgp.gov.cn 实测200在案);",
                 "结果页 GBK 编码 — 解析面待芯扩展 GBK 解码后接入 (如实零命中)。"]},
    "emsc_seismic_portal": {"mode": "semi",
        "src": "EMSC FDSN event (text面)",
        "form": "GET text FDSN limit (事件流)",
        "imports": [], "ep": EMSC_EP, "ex": EMSC_EX,
        "help": ["EMSC 地震门户 FDSN text 面 (无文本q — 事件流, query 仅",
                 "入台账); 竖线分隔文本解析。"]},
    "noaa_ncei": {"mode": "semi",
        "src": "NCEI Data Service search",
        "form": "GET JSON searchTerm (形态待校准)",
        "imports": [], "ep": NCEI_EP, "ex": NCEI_EX,
        "help": ["NOAA NCEI 数据检索服务 (access/services/search/v1);",
                 "返回形态待实测校准 — 双键容错。"]},
    "oecd_data_explorer_sdmx": {"mode": "semi",
        "src": "OECD SDMX REST dataflow 清单",
        "form": "GET XML dataflow清单 (查询过滤待接)",
        "imports": ["import xml.etree.ElementTree as ET"],
        "ep": OECD_SDMX_EP, "ex": OECD_SDMX_EX,
        "help": ["OECD SDMX 公共 REST 面 (dataflow 清单 XML); 查询词过滤",
                 "=流id取数待接。"]},
}
