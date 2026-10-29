# -*- coding: utf-8 -*-
"""backfill_wenku_leads — EPC-OVERSEAS 78条 wenku URL-only 线索回灌 (Phase A: 收全文).

接线 wenku_full_api (纯免登录HTTP): ndview元数据 → 判型(type1/2/3) → type3 BOS文字层直链.
红线: 全局任意两请求间隔>=2.2s (覆盖任务令>=2s); 零Cookie/零secret/零浏览器/不删文件;
数字零造假 — 每文档实测字数/页覆盖如实记录, 截断如实标注.

产物:
  E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/kb_harvest/wenku_full/<docId>.md
  同目录 _backfill_results.jsonl (逐件结果, crash-safe 追加, 幂等续跑)
用法:
  py -X utf8 backfill_wenku_leads.py [--only=<docId>]
"""
from __future__ import annotations
import json, re, sys, time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import wenku_full_api as W

# ---- 全局节流红线: 任意两 HTTP 请求间隔 >= 2.2s (任务令>=2s, 取2.2留裕量) ----
_PACE_MIN = 2.2
_g_last = [0.0]

def _pace_global(self, key, min_interval):
    wait = max(0.0, _PACE_MIN - (time.time() - _g_last[0]))
    if wait > 0:
        time.sleep(wait)
    _g_last[0] = time.time()

W._Ledger.pace = _pace_global

LEADS = json.loads((HERE / "wenku_leads78.json").read_text(encoding="utf-8"))
OUT_DIR = Path(r"E:\AI-Station\ammo_pool\EPC-OVERSEAS\staging\kb_harvest\wenku_full")
RES_F = OUT_DIR / "_backfill_results.jsonl"
OUT_DIR.mkdir(parents=True, exist_ok=True)

_ns = lambda s: len(re.sub(r"\s", "", s or ""))


def md_text(title, lead, pages, nchars, full, cover, kind, extra="") -> str:
    lines = [f"# {title}", "",
             "> 来源: 百度文库（免登录预览层, 纯HTTP采集, 2026-10-24 回灌自 URL-only 线索）",
             f"> doc_id: {lead['doc_id']}",
             f"> URL: {lead['url']}",
             f"> 类型: {kind} | 页覆盖: {cover} | 完整: {'是' if full else '否'}"]
    if extra:
        lines.append(extra)
    lines.append(f"> 实测正文字数(去空白): {nchars} | 采集: {time.strftime('%F %T')}")
    lines.append("")
    if isinstance(pages, dict):
        lines.append("\n\n".join(f"## 第{pn}页\n\n{txt}" for pn, txt in sorted(pages.items())))
    else:
        lines.append("\n\n".join(f"## 块{i+1}\n\n{txt}" for i, txt in enumerate(pages)))
    lines.append("")
    return "\n".join(lines)


def retry_pages(ri, failed, pages, led):
    """对 type3 失败页逐页补试一次 (全局节流下)."""
    entries = {}
    for e in (ri.get("htmlUrls") or {}).get("json") or []:
        pi = W._pos_int((e or {}).get("pageIndex"))
        if pi and e.get("pageLoadUrl"):
            entries[pi] = e
    still = []
    for pn in failed:
        if pn in pages:
            continue
        try:
            led.pace("page", 0.6)
            status, raw = W._http(entries[pn]["pageLoadUrl"],
                                  headers={"Referer": W._ASSET_REFERER})
            pj = W._strip_jsonp(raw.decode("utf-8", "replace"))
            words = [n.get("c") for n in (pj.get("body") or [])
                     if isinstance(n, dict) and n.get("t") == "word"
                     and isinstance(n.get("c"), str)]
            pages[pn] = "".join(words)
            led.add("page3r", pn=pn, http=status, chars=len(pages[pn]))
        except Exception as e:
            still.append(pn)
            led.add("page3r", pn=pn, http=-1, err=repr(e)[:60])
    return still


def main() -> int:
    only = None
    for a in sys.argv[1:]:
        if a.startswith("--only="):
            only = a.split("=", 1)[1]
    saved_done = set()
    if RES_F.is_file():
        for l in RES_F.read_text(encoding="utf-8").splitlines():
            if l.strip():
                try:
                    r = json.loads(l)
                except json.JSONDecodeError:
                    continue
                if str(r.get("status", "")).startswith("saved"):
                    saved_done.add(r["doc_id"])
    led = W._Ledger()
    t0 = time.time()
    n = 0
    for lead in LEADS:
        doc_id = lead["doc_id"]
        if only and doc_id != only:
            continue
        if doc_id in saved_done:
            print(f"[skip-already] {doc_id[:10]}", flush=True)
            continue
        n += 1
        req0 = len(led.rows)
        res_path = ""
        # 腿1: ndview 元数据 (失败一次重试)
        info = W.fetch_reader_info(doc_id, ledger=led)
        if info is None:
            time.sleep(4.0)
            info = W.fetch_reader_info(doc_id, ledger=led)
        if info is None:
            res = {"doc_id": doc_id, "status": "ndview_fail", "url": lead["url"],
                   "title": lead["title"], "n_req": len(led.rows) - req0}
            with RES_F.open("a", encoding="utf-8") as f:
                f.write(json.dumps(res, ensure_ascii=False) + "\n")
            print(f"[{n}/78] {doc_id[:10]} ndview_fail", flush=True)
            continue
        ri, kind = info["reader_info"], info["kind"]
        page, show = info["page"], info["show_page"]
        title = info["title"] or lead["title"]
        if kind == "type3":
            got = W.harvest_type3_text(ri, ledger=led)
            if got["failed"]:
                got["failed"] = retry_pages(ri, got["failed"], got["pages"], led)
            nchars = _ns("".join(got["pages"].values()))
            if not got["pages"]:
                status = "type3_zero_pages"
            elif nchars < 120:
                status = f"thin({nchars})"
            else:
                entries_n = len((ri.get("htmlUrls") or {}).get("json") or [])
                full = bool(page > 0 and show >= page and not got["failed"]
                            and got["covered"])
                status = "saved_full" if full else "saved_partial"
                cover = f"{len(got['pages'])}/{page}页(show={show},avail={entries_n})"
                extra = ("" if full else
                         f"> [截断标注] 免登录层可得页 {sorted(got['pages'])} / 共{page}页 "
                         f"(showPage={show}); 失败页 {got['failed'] or '无'} — 不越额补页/不碰付费墙")
                fmd = OUT_DIR / f"{doc_id}.md"
                fmd.write_text(md_text(title, lead, got["pages"], nchars, full, cover,
                                       kind, extra), encoding="utf-8")
                res_path = str(fmd)
        elif kind == "type1":
            got = W.harvest_type1_text(ri, ledger=led)
            nchars = got["chars"]
            if not got["pages"] or nchars < 120:
                status = "type1_empty" if not got["pages"] else f"thin({nchars})"
            else:
                full = bool(page > 0 and show >= page)
                status = "saved_full" if full else "saved_partial"
                cover = f"{len(got['pages'])}块/{page}页(show={show})"
                extra = ("> [腿标注] type1 getbdjson 桶式腿按SPEC接线, 本件为实弹验证样本; "
                         f"空桶 {got['buckets_empty']}/{got['buckets_ok'] + got['buckets_empty']}")
                fmd = OUT_DIR / f"{doc_id}.md"
                fmd.write_text(md_text(title, lead, got["pages"], nchars, full, cover,
                                       kind, extra if not full else ""), encoding="utf-8")
                res_path = str(fmd)
        else:
            status = f"{kind}_no_textlane"
            nchars = 0
        res = {"doc_id": doc_id, "status": status, "url": lead["url"], "title": title[:80],
               "kind": kind, "page": page, "show_page": show, "chars": nchars,
               "tree_node": lead.get("tree_node", ""), "wall_old": lead.get("wall_old", ""),
               "file": res_path, "n_req": len(led.rows) - req0}
        with RES_F.open("a", encoding="utf-8") as f:
            f.write(json.dumps(res, ensure_ascii=False) + "\n")
        print(f"[{n}/78] {doc_id[:10]} {status} kind={kind} "
              f"p/s={page}/{show} chars={nchars} req={res['n_req']}", flush=True)
    (OUT_DIR / "_backfill_ledger.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in led.rows), encoding="utf-8")
    print(f"[done] docs={n} requests={led.counts()} elapsed={time.time()-t0:.0f}s", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
