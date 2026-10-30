# -*- coding: utf-8 -*-
"""_freekey_probe_1026 — B级免费钥申领波·点亮面探针 (2026-10-26).

逐候选渠道 1 请求探活 (直连优先→7890/7891/7893 兜底, 7895 已停不在列):
仅记录 HTTP 状态/通道/响应长度/结构头 120 字, 零打印密钥 (数字零造假铁律)。
输出: stdout JSON 行 (供 btier_freekey_ledger.md 落账)。
"""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.parse
import urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROXIES = [None, "http://127.0.0.1:7890", "http://127.0.0.1:7891", "http://127.0.0.1:7893"]
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) research-leg/1.0 "
      "(AI-Station freekey-wave; +stdlib-urllib)")


def fetch(name, url, *, method="GET", body=None, headers=None, timeout=25):
    hdrs = {"User-Agent": UA, "Accept": "application/json,text/*;q=0.9"}
    hdrs.update(headers or {})
    last = (0, "", "none")
    for p in PROXIES:
        try:
            if p:
                opener = urllib.request.build_opener(
                    urllib.request.ProxyHandler({"http": p, "https": p}))
            else:
                opener = urllib.request.build_opener(
                    urllib.request.ProxyHandler({}))
            req = urllib.request.Request(url, data=body, headers=hdrs, method=method)
            with opener.open(req, timeout=timeout) as r:
                raw = r.read()
                last = (r.status, raw[:400].decode("utf-8", "replace"), p or "direct")
                last = (last[0], last[1], last[2], len(raw))
                return {"name": name, "status": last[0], "via": last[2],
                        "bytes": last[3], "head": last[1][:120].replace("\n", " ")}
        except urllib.error.HTTPError as e:
            try:
                head = e.read()[:200].decode("utf-8", "replace").replace("\n", " ")
            except Exception:
                head = ""
            if e.code < 500:          # 4xx = 已达站方拒, 换代理无义 (除直连墙)
                if p is None:
                    continue
                return {"name": name, "status": e.code, "via": p or "direct",
                        "bytes": 0, "head": head[:120]}
            last = (e.code, head, p or "direct")
        except Exception as e:
            last = (0, "%s: %s" % (type(e).__name__, str(e)[:80]), p or "direct")
    return {"name": name, "status": last[0], "via": "all-fail",
            "bytes": 0, "head": str(last[1])[:120]}


ZHIPU_KEY = ""
try:
    for ln in open(r"E:/AI-Station/data/secrets/zhipu.secret", encoding="utf-8"):
        if ln.startswith("api_key="):
            ZHIPU_KEY = ln.split("=", 1)[1].strip()
            break
except OSError:
    pass

probes = [
    ("ecb_sdw", "https://data-api.ecb.europa.eu/service/data/EXR/D.USD.EUR.SP00.A?lastNObservations=1&format=jsondata", "GET", None, {}),
    ("noaa_ncei", "https://www.ncei.noaa.gov/access/services/search/v1/data?searchTerm=temperature&pageSize=3&format=json", "GET", None, {}),
    ("nasa_firms_wms", "https://firms.modaps.eosdis.nasa.gov/wms/key?service=WMS&request=GetCapabilities&version=1.3.0", "GET", None, {}),
    ("nasa_images", "https://images-api.nasa.gov/search?q=wildfire&media_type=image&page_size=3", "GET", None, {}),
    ("core_api", "https://api.core.ac.uk/v3/search/works?q=construction&limit=3", "GET", None, {}),
    ("data_gov_us_ckan", "https://catalog.data.gov/api/3/action/package_search?q=construction+contract&rows=3", "GET", None, {}),
    ("open_canada", "https://open.canada.ca/data/en/api/3/action/package_search?q=construction&rows=3", "GET", None, {}),
    ("compras_gov_br_pncp", "https://pncp.gov.br/api/consulta/v1/atas?dataInicial=20261001&dataFinal=20261020&codigoModalidadeContratacao=6&pagina=1&tamanhoPagina=3", "GET", None, {}),
    ("opencorporates_web", "https://opencorporates.com/companies?q=AECOM", "GET", None, {}),
    ("us_census_bureau_api", "https://api.census.gov/data/2023/acs/acs1?get=NAME,B19013_001E&for=state:06", "GET", None, {}),
    ("sam_gov_excl", "https://sam.gov/api/prod/sgs/v1/search/?index=exclusion&q=construction&page=0&mode=UnitEntities", "GET", None, {}),
    ("not_human_search", "https://nothumansearch.ai/api/search?q=construction", "GET", None, {}),
    ("semantic_scholar_api", "https://api.semanticscholar.org/graph/v1/paper/search?query=construction+cost+estimating&limit=3&fields=title,year", "GET", None, {}),
    ("hn_algolia_api", "https://hn.algolia.com/api/v1/search?query=construction&hitsPerPage=3", "GET", None, {}),
    ("courtlistener_api", "https://www.courtlistener.com/api/rest/v4/search/?q=construction", "GET", None, {}),
    ("courtlistener_register", "https://www.courtlistener.com/register/next/", "GET", None, {}),
    ("s2_key_form", "https://www.semanticscholar.org/product/api", "GET", None, {}),
]

for name, url, m, b, h in probes:
    print(json.dumps(fetch(name, url, method=m, body=b, headers=h), ensure_ascii=False), flush=True)

if ZHIPU_KEY:
    payload = json.dumps({"tool": "web_search_pro", "stream": False,
                          "messages": [{"role": "user", "content": "工程总承包 合同价格 国际对标"}]}).encode()
    r = fetch("web_search_pro", "https://open.bigmodel.cn/api/paas/v4/tools",
              method="POST", body=payload,
              headers={"Authorization": "Bearer " + ZHIPU_KEY,
                       "Content-Type": "application/json"})
    r["keyed"] = True
    print(json.dumps(r, ensure_ascii=False), flush=True)
else:
    print(json.dumps({"name": "web_search_pro", "status": -1, "via": "none",
                      "bytes": 0, "head": "zhipu.secret api_key 缺失"}), flush=True)
