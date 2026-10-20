# -*- coding: utf-8 -*-
"""code-repro lens: v0.9.23 unified pool prices a ZERO-COST report-QA retrieval
miss at 1 unit, and 6 such misses fully starve the flagship consult /api/ask
channel for the day (and vice versa).

Reproduces the finding against the live code (no metaso / no real zhipu calls):
  phase A: 6 vague report questions that MISS retrieval -> each debits the shared
           pool BEFORE retrieval, no refund on the miss path, 0 zhipu calls.
  phase B: consult /api/ask -> 402 (pool empty), blocked before any KB work.
  phase C (reverse): fresh user spends 6 consults -> even a zero-cost report
           MISS question returns 429.
"""
import json
import os
import shutil
import sys
from pathlib import Path

ENGINE = Path(r"E:/AI-Station/services/qianwen-engine")
sys.path.insert(0, str(ENGINE))

ROOT = Path(__file__).parent
TMP = ROOT / "t"
if TMP.exists():
    shutil.rmtree(TMP)
TMP.mkdir()
os.environ["QW_FAKE_ASK"] = "1"  # consult leg: canned KB answer, never touches metaso

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod, config, report_catalog, store, wechat, zhipu  # noqa: E402

config.DB_PATH = TMP / "t.sqlite"
config.DATA_DIR = TMP
content = TMP / "content"
(content / "full").mkdir(parents=True)
(content / "sample").mkdir(parents=True)
chapters = [
    (1, "合同体系", "合同类型与条款要点"), (2, "计价规则", "计价方式与调价机制"),
    (3, "风险管理", "风险分担与应对措施"), (4, "结算流程", "进度结算与付款节点"),
    (5, "变更签证", "变更签证的办理流程"), (6, "索赔实务", "索赔证据与时效管理"),
]
cat = {"reports": [{
    "sku": "SKU-A", "title": "甲测试报告", "subtitle": "s", "price": 498,
    "price_label": "¥498", "words_wan": 5, "badges": [], "cat": "ent",
    "cat_name": "企业研究", "intro_lede": "d", "intro": "i", "audience": "a",
    "chapters": [{"id": i, "title": f"第{i}章 {kw}", "desc": d}
                 for i, kw, d in chapters],
    "sample_file": "sku-a.md", "sample_label": "试读",
}]}
(content / "report.json").write_text(json.dumps(cat, ensure_ascii=False), encoding="utf-8")
(content / "full" / "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
(content / "sample" / "sku-a.md").write_text("# 试读\n本报告围绕合同计价与变更签证展开。",
                                             encoding="utf-8")
config.REPORT_CONTENT_DIR = content
report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
store._init_done = False

calls = {"n": 0}


def fake_deep(system, prompt, **k):
    calls["n"] += 1
    return "结论行\n第1章：论据一"


zhipu.deep_answer = fake_deep

MISS_Q = "量子纠缠是什么原理"          # 0 bigram overlap -> retrieval miss (same as REQ-001.AC2)
HIT_Q = "变更签证怎么办理"             # hits 第5章 (same as REQ-001.AC1)

print("== phase A: 6 zero-cost retrieval misses (report channel) ==")
with TestClient(app_mod.app) as c:
    c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-u1")})
    for i in range(6):
        r = c.post("/api/report/SKU-A/ask", json={"q": f"{MISS_Q}{i}号"})
        d = r.json()
        print(f"  miss#{i+1}: http={r.status_code} left={d.get('left')} "
              f"conclusion={d.get('conclusion')[:12]}")
    print(f"  zhipu calls after 6 misses: {calls['n']}   (zero external cost)")
    print(f"  pool state: {store.quota_left('open-u1')}")

    print("== phase B: consult /api/ask after 6 misses ==")
    r402 = c.post("/api/ask", json={"question": "EPC合同里变更签证的办理流程是什么"})
    print(f"  consult: http={r402.status_code} body={r402.text[:60]}")
store._init_done = False

print("== phase C (reverse): 6 consults then even a zero-cost report MISS 429s ==")
with TestClient(app_mod.app) as c:
    c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-u2")})
    for i in range(6):
        r = c.post("/api/ask", json={"question": f"咨询第{i}问：变更签证流程"})
        print(f"  consult#{i+1}: http={r.status_code} quota={r.json().get('quota')}")
    rmiss = c.post("/api/report/SKU-A/ask", json={"q": MISS_Q})
    rhit = c.post("/api/report/SKU-A/ask", json={"q": HIT_Q})
    print(f"  report MISS after consults: http={rmiss.status_code} body={rmiss.text[:70]}")
    print(f"  report HIT  after consults: http={rhit.status_code} body={rhit.text[:70]}")
    print(f"  zhipu calls total: {calls['n']} (phase A 0 + phase C 0)")
store._init_done = False
