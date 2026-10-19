# -*- coding: utf-8 -*-
"""std.samr 国标全文公开系统 CLI
用法:
  py cli.py search <关键词> [--state 现行] [--ics 43] [--out out.jsonl] [--max N]
  py cli.py industry <ICS: 43|43.道路车辆工程|道路> [--state 现行] [--out out.jsonl] [--all-states]
  py cli.py ics-list
  py cli.py download <关键词> --dir <目录> [--state 现行] [--limit N] [--ics 43]
  py cli.py download-id <std_id> [std_id...] --dir <目录>
  py cli.py detail <std_id>
"""
import argparse
import json
import os
import re
import sys
import time

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

from samr_lib import SamrClient, SamrError, ICS_CATEGORIES


def jdump(rows, path):
    with open(path, "w", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
    print(f"[saved] {path}  rows={len(rows)}")


def cmd_ics_list(a):
    for c in ICS_CATEGORIES:
        print(c)


def cmd_search(a):
    c = SamrClient(delay=(a.min_delay, a.max_delay))
    ics = SamrClient.resolve_ics(a.ics) if a.ics else ""
    rows = []
    try:
        for r in c.search_all(text=a.query, ics=ics, states=a.state or None):
            rows.append(r)
            if len(rows) % 500 == 0:
                print(f"  ...fetched {len(rows)}", file=sys.stderr)
            if a.max and len(rows) >= a.max:
                break
    finally:
        out = a.out or re.sub(r"[^\w]+", "_", a.query or "all") + (f"_ics{a.ics}" if a.ics else "") + ".jsonl"
        jdump(rows, out)
    for r in rows[:10]:
        print(f"{r['C_STD_CODE']:<22} {r['STATE']:<5} {r['ISSUE_DATE']}  {r['C_C_NAME'][:40]}")
    if len(rows) > 10:
        print(f"... 共 {len(rows)} 条")


def cmd_industry(a):
    c = SamrClient(delay=(a.min_delay, a.max_delay))
    ics = SamrClient.resolve_ics(a.ics)
    states = None if a.all_states else (a.state or ["现行"])
    print(f"[industry] {ics} states={states or '全部'}", file=sys.stderr)
    t0 = time.time()
    rows = c.industry(ics, states=states or [])
    out = a.out or f"industry_{ics.split('.')[0]}.jsonl"
    jdump(rows, out)
    n_cur = sum(1 for r in rows if r["STATE"] == "现行")
    print(f"现行 {n_cur} / 总 {len(rows)}  用时 {time.time()-t0:.0f}s")


def cmd_detail(a):
    c = SamrClient()
    d = c.detail(a.std_id)
    print(json.dumps(d, ensure_ascii=False, indent=2))


def _download_rows(c, rows, out_dir, limit, delay_note=""):
    ok, fail, skipped = 0, 0, 0
    manifest = []
    for i, r in enumerate(rows, 1):
        if limit and i > limit:
            break
        code = r["C_STD_CODE"].replace("/", "-")
        d = os.path.join(out_dir, code)
        pdf = os.path.join(d, f"std_{r['id']}.pdf")
        if os.path.exists(pdf):
            print(f"[{i}] SKIP(exists) {code}")
            skipped += 1
            manifest.append({**r, "pdf": pdf, "status": "exists"})
            continue
        try:
            det = c.detail(r["id"])
            if not det.get("hcno"):
                print(f"[{i}] NO-TEXT {code} (无全文公开)")
                skipped += 1
                manifest.append({**r, "status": "no_text"})
                continue
            res = c.harvest(det["hcno"], d, want_pdf=True,
                            progress=lambda pid: None)
            mb = res.get("pdf_bytes", 0) / 1048576
            print(f"[{i}] OK {code} pages={res['n_pages_built']} chunks={res['n_chunks']} pdf={mb:.1f}MB")
            ok += 1
            manifest.append({**r, **{k: det.get(k) for k in ("hcno", "ICS分类", "中国标准分类号", "归口单位", "主管部门", "标准性质") if det.get(k)},
                             "pdf": res["pdf"], "pages": res["n_pages_built"], "status": "ok"})
        except SamrError as e:
            print(f"[{i}] FAIL {code}: {e}")
            fail += 1
            manifest.append({**r, "status": "fail", "error": str(e)})
        with open(os.path.join(out_dir, "manifest.jsonl"), "a", encoding="utf-8") as f:
            f.write(json.dumps(manifest[-1], ensure_ascii=False) + "\n")
    print(f"\n== 完成: ok={ok} fail={fail} skip={skipped} (以落盘 manifest 为准) ==")


def cmd_download(a):
    c = SamrClient(delay=(a.min_delay, a.max_delay))
    ics = SamrClient.resolve_ics(a.ics) if a.ics else ""
    rows = list(c.search_all(text=a.query, ics=ics, states=a.state or None))
    print(f"[download] 命中 {len(rows)} 条, limit={a.limit or '∞'} -> {a.dir}")
    os.makedirs(a.dir, exist_ok=True)
    _download_rows(c, rows, a.dir, a.limit)


def cmd_download_id(a):
    c = SamrClient(delay=(a.min_delay, a.max_delay))
    rows = [{"id": i, "C_STD_CODE": f"ID{i[:8]}", "STATE": "?", "C_C_NAME": ""} for i in a.std_ids]
    os.makedirs(a.dir, exist_ok=True)
    _download_rows(c, rows, a.dir, None)


def main():
    p = argparse.ArgumentParser(description="std.samr 国标全文公开系统客户端")
    sub = p.add_subparsers(dest="cmd", required=True)

    sp = sub.add_parser("ics-list"); sp.set_defaults(fn=cmd_ics_list)

    sp = sub.add_parser("search")
    sp.add_argument("query", nargs="?", default="")
    sp.add_argument("--state", action="append")
    sp.add_argument("--ics")
    sp.add_argument("--out"); sp.add_argument("--max", type=int)
    sp.set_defaults(fn=cmd_search)

    sp = sub.add_parser("industry")
    sp.add_argument("ics")
    sp.add_argument("--state", action="append")
    sp.add_argument("--all-states", action="store_true")
    sp.add_argument("--out")
    sp.set_defaults(fn=cmd_industry)

    sp = sub.add_parser("detail")
    sp.add_argument("std_id")
    sp.set_defaults(fn=cmd_detail)

    sp = sub.add_parser("download")
    sp.add_argument("query", nargs="?", default="")
    sp.add_argument("--dir", required=True)
    sp.add_argument("--state", action="append")
    sp.add_argument("--ics")
    sp.add_argument("--limit", type=int)
    sp.set_defaults(fn=cmd_download)

    sp = sub.add_parser("download-id")
    sp.add_argument("std_ids", nargs="+")
    sp.add_argument("--dir", required=True)
    sp.set_defaults(fn=cmd_download_id)

    for name, sp_ in sub.choices.items():
        sp_.add_argument("--min-delay", type=float, default=0.4)
        sp_.add_argument("--max-delay", type=float, default=1.0)

    a = p.parse_args()
    try:
        a.fn(a)
    except SamrError as e:
        print(f"[SamrError] {e}", file=sys.stderr)
        sys.exit(2)


if __name__ == "__main__":
    main()
