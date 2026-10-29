# -*- coding: utf-8 -*-
"""验收: 5 次独立会话(独立进程内新Session)检索『国际工程 EPC』>=20条题录+摘要质量门。"""
import subprocess, sys, json, io, os
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")

PY = "E:/AI-Station/.venv/Scripts/python.exe"
REPL = "E:/AI-Station/逆向工程/cnki-reverse/replica/cnki_api.py"
CAP = "E:/AI-Station/逆向工程/cnki-reverse/captures"
KW = "国际工程 EPC"

summary = []
for run in range(1, 6):
    out_json = os.path.join(CAP, f"F1_run{run}.json")
    p = subprocess.run([PY, REPL, KW, "--pages", "2", "--abstracts", "3", "--json", out_json],
                       capture_output=True, timeout=180)
    ok = p.returncode == 0
    data = {}
    if ok and os.path.exists(out_json):
        data = json.load(open(out_json, encoding="utf-8"))
    recs = data.get("records", [])
    n = len(recs)
    with_title = sum(1 for r in recs if r.get("title"))
    with_author = sum(1 for r in recs if r.get("authors"))
    with_journal = sum(1 for r in recs if r.get("journal") or r.get("doc_type") == "报纸")
    with_year = sum(1 for r in recs if r.get("year_issue"))
    with_abs = sum(1 for r in recs if (r.get("abstract") or r.get("snippet")))
    with_full_abs = sum(1 for r in recs if r.get("abstract"))
    entry = {"run": run, "rc": p.returncode, "records": n,
             "title": with_title, "authors": with_author, "journal_or_news": with_journal,
             "year": with_year, "abs_or_snippet": with_abs, "detail_abstract": with_full_abs,
             "pass": ok and n >= 20 and with_title == n and with_abs >= 20 and with_year >= 18}
    summary.append(entry)
    print(json.dumps(entry, ensure_ascii=False))
    if p.returncode != 0:
        print("STDERR:", p.stderr.decode("utf-8", "replace")[:500])

passed = sum(1 for e in summary if e["pass"])
res = {"keyword": KW, "sessions": summary, "passed": passed, "total": 5,
       "conclusion": "PASS" if passed == 5 else "FAIL"}
json.dump(res, open(os.path.join(CAP, "acceptance_5sess.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"\n== 5-session acceptance: {passed}/5 PASS ==")
