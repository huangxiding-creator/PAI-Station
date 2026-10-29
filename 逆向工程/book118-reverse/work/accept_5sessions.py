# -*- coding: utf-8 -*-
"""验收件（v2 配额感知版）：5 次独立会话贯通。

每会话全新 Book118Client（独立 CookieJar）；幂等（session.json ok=true 即跳过，
不重烧配额）；SearchQuota 如实记账 quota_wall 并继续下一会话。
判据（任务书）：题录>0 且 ≥500 字 ≥3 份/会话；S1 附加 detail+页图清单腿。
产物：captures/accept_s1..s5/session.json + 总账 accept_summary.json
（v1 首跑账在 git 历史与 work/accept_5sessions_v1.py.bak）。
"""
import json
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "replica"))
from book118_api import Book118ApiError, Book118Client, SearchQuota  # noqa: E402

CAP = HERE.parent / "captures"
QUERIES = ["国际工程EPC", "EPC总承包合同", "国际工程投标",
           "FIDIC EPC", "海外工程项目管理"]
LIMIT = 10
MIN_CHARS = 500
NEED_DOCS = 3

summary = []
all_ok = True
for i, q in enumerate(QUERIES, 1):
    out = CAP / f"accept_s{i}"
    out.mkdir(parents=True, exist_ok=True)
    sj = out / "session.json"
    rows: list = []
    if sj.is_file():                       # 幂等：已过会话不重跑（配额友好）
        try:
            prev = json.loads(sj.read_text(encoding="utf-8"))
            if prev.get("summary_row", {}).get("ok"):
                summary.append(prev["summary_row"])
                print(f"[s{i}] skip (已过)")
                continue
        except Exception:
            pass
    t0 = time.monotonic()
    row = {"session": i, "query": q,
           "independent": "fresh Book118Client/CookieJar"}
    client = Book118Client()
    try:
        rows = client.search_with_text(q, LIMIT, text_min_chars=0)
        ge500 = [r for r in rows if r["text_chars"] >= MIN_CHARS]
        row.update(hits=len(rows), total=client.last_search_total,
                   ge500_docs=len(ge500),
                   paid_docs=sum(1 for r in rows if r["paid"]),
                   requests=client.requests,
                   text_chars_top3=[r["text_chars"] for r in ge500[:3]],
                   titles=[r["title"][:38] for r in ge500[:3]],
                   ok=bool(rows) and len(ge500) >= NEED_DOCS)
        if i == 1 and rows:
            try:
                det = client.doc_detail(rows[0]["shtm_url"])
                pv = client.preview_pages(det, max_batches=2)
                row["detail_leg"] = {"aid": det["aid"],
                                     "preview_page": det["preview_page"],
                                     "actual_page": det["actual_page"],
                                     "page_urls_n": len(pv),
                                     "ok": bool(det["view_token"]) and len(pv) >= 1}
                row["requests"] = client.requests
            except Book118ApiError as e:
                row["detail_leg"] = {"ok": False,
                                     "error": f"{e.kind}: {e.detail}"[:120]}
    except SearchQuota as e:
        row.update(ok=False, quota_wall=True,
                   reason=f"{e.kind}: {e.detail}"[:160],
                   requests=client.requests)
    except Book118ApiError as e:
        row.update(ok=False, error=f"{e.kind}: {e.detail}"[:160],
                   requests=client.requests)
    row["elapsed_s"] = round(time.monotonic() - t0, 1)
    all_ok = all_ok and row.get("ok")
    summary.append(row)
    sj.write_text(json.dumps({"summary_row": row, "rows": rows},
                             ensure_ascii=False, indent=1), encoding="utf-8")
    print(json.dumps(row, ensure_ascii=False)[:400])
    time.sleep(3.0)

ledger = {"date": "2026-10-24", "sessions": len(summary),
          "ok_sessions": sum(1 for r in summary if r.get("ok")),
          "quota_walled": sum(1 for r in summary if r.get("quota_wall")),
          "criteria": f"每会话: 题录>0 且 ≥{MIN_CHARS}字 ≥{NEED_DOCS} 份",
          "all_ok": all_ok, "rows": summary}
(CAP / "accept_summary.json").write_text(
    json.dumps(ledger, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"\n== {ledger['ok_sessions']}/{ledger['sessions']} pass"
      f"（quota_walled={ledger['quota_walled']}）",
      "ALL PASS" if all_ok else "")
raise SystemExit(0 if all_ok else 1)
