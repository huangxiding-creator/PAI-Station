# -*- coding: utf-8 -*-
"""compras_gov_br_pncp 腿 — 巴西 Compras.gov.br/PNCP 开放API (1026 免费钥申领波; B级·工商招投标/项目数据).

registry: channels_survey_2026 (Compras.gov.br/PNCP(巴西), gov.br,
"PNCP免key开放API+免登录网页"); 实测 2026-10-26 direct 200
(atas 端点, tamanhoPagina=10 门槛 — 3 会 400 "Tamanho de página inválido")。
查询词=日期窗 YYYYMMDD-YYYYMMDD (缺省=近45天), 面价=价格登记 ata 采购
公告元数据 (objetoContratacao/nomeOrgao/有效期)。免key零注册。

用法: py reforge_factory/legs/compras_gov_br_pncp_leg.py --campaign EPC-OVERSEAS
      --queries 20261001-20261020
"""
from __future__ import annotations

import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "compras_gov_br_pncp", "source": "Compras.gov.br PNCP API (巴西)",
        "note": "B级·工商招投标·免key开放API (1026 免费钥波: 免key面直点, tamanhoPagina=10门槛在案)",
        "rows_default": 8}


def endpoint(query, rows):
    q = query.strip()
    if "-" in q and len(q.split("-")[0]) == 8:
        di, df = q.split("-", 1)[0], q.split("-", 1)[1]
    else:                                   # 缺省=近45天 (查询词非日期窗时)
        df = time.strftime("%Y%m%d")
        di = time.strftime("%Y%m%d", time.localtime(time.time() - 45 * 86400))
    return ("https://pncp.gov.br/api/consulta/v1/atas",
            {"dataInicial": di, "dataFinal": df,
             "codigoModalidadeContratacao": "6", "pagina": "1",
             "tamanhoPagina": "10"}, {}, "GET", None)


def extract(data):
    hits = []
    for r in (data or {}).get("data") or []:
        hits.append({
            "title": "PNCP %s · %s" % (r.get("numeroAtaRegistroPreco", ""),
                                       str(r.get("objetoContratacao", ""))[:80]),
            "url": "https://pncp.gov.br/app/atas/?orgao_cnpj=%s"
                   % r.get("cnpjOrgao", ""),
            "meta": [m for m in [r.get("nomeOrgao", ""),
                                 "登记:" + str(r.get("dataPublicacaoPncp", ""))[:10],
                                 "有效期至:" + str(r.get("vigenciaFim", ""))[:10],
                                 "年份:" + str(r.get("anoAta", ""))]
                     if m],
            "excerpt": str(r.get("objetoContratacao", "") or "")[:1400],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
