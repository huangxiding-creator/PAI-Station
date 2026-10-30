# -*- coding: utf-8 -*-
"""_freekey_probe2_1026 — 免费钥申领波·探针第2轮 (参数形态修正复测)."""
from __future__ import annotations
import json
import sys
import urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:/AI-Station/reforge_factory/channels_survey_2026")
from _freekey_probe_1026 import fetch  # noqa: E402 (同一探针函数复用)

ZHIPU_KEY = ""
for ln in open(r"E:/AI-Station/data/secrets/zhipu.secret", encoding="utf-8"):
    if ln.startswith("api_key="):
        ZHIPU_KEY = ln.split("=", 1)[1].strip()
        break

probes = [
    ("noaa_ncei_itemsPerPage", "https://www.ncei.noaa.gov/access/services/search/v1/data?searchTerm=temperature&format=json&itemsPerPage=3", "GET", None, {}),
    ("noaa_ncei_items", "https://www.ncei.noaa.gov/access/services/search/v1/simple-search?query=temperature&format=json", "GET", None, {}),
    ("data_gov_ckan_simple", "https://catalog.data.gov/api/3/action/package_search?q=construction&rows=3", "GET", None, {}),
    ("data_gov_ckan_direct", "https://catalog.data.gov/api/3/action/package_search?q=federal+highway&rows=3", "GET", None, {}),
    ("pncp_10", "https://pncp.gov.br/api/consulta/v1/atas?dataInicial=20261001&dataFinal=20261020&codigoModalidadeContratacao=6&pagina=1&tamanhoPagina=10", "GET", None, {}),
    ("pncp_materials", "https://pncp.gov.br/api/pncp/v1/orgaos/v1/materiais", "GET", None, {}),
    ("sam_gov_hal", "https://sam.gov/api/prod/sgs/v1/search/?index=exclusion&q=construction&page=0&mode=UnitEntities", "GET", None, {"Accept": "application/hal+json"}),
    ("semantic_scholar_7891", "https://api.semanticscholar.org/graph/v1/paper/search?query=construction+cost&limit=3&fields=title,year", "GET", None, {}),
]

for name, url, m, b, h in probes:
    print(json.dumps(fetch(name, url, method=m, body=b, headers=h), ensure_ascii=False), flush=True)

# zhipu web_search_pro 两种官方形态
payload = json.dumps({"tool": "web-search-pro", "stream": False,
                      "messages": [{"role": "user", "content": "工程总承包 合同价格 国际对标"}]}).encode()
print(json.dumps(fetch("zhipu_tools_websearch", "https://open.bigmodel.cn/api/paas/v4/tools",
                       method="POST", body=payload,
                       headers={"Authorization": "Bearer " + ZHIPU_KEY,
                                "Content-Type": "application/json"}), ensure_ascii=False), flush=True)
