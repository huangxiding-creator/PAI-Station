# -*- coding: utf-8 -*-
"""wenku_full_api — 百度文库「检索→选品→全文」纯 HTTP 全链复刻件（零浏览器零CDP）。

接线战役 wenku-search-reverse（2026-10-24）。素材来源（接线不重逆）:
  - 检索: POST wenku.baidu.com/gsula/sula/syncmrecall sceneID=PCSearch（kb_rev/web_search_capture
    1021 实证: 免登录零Cookie, 裸urllib放行; CDP浏览器反被 BFE 403+验证码）
  - 元数据: GET wenku.baidu.com/ndview/{docId}.html 侧门 → var pageData.readerInfo
    （view 页对非浏览器指纹 403; ndview 侧门实证 200 — kb_factory/harvest_engine T18/T38）
  - type3 全文: readerInfo.htmlUrls.json[].pageLoadUrl（BOS docconvert 预签直链, 206 分片,
    JSONP→pageJson.body word 节点=真文字层）——harvest_engine T26 同源
  - type1 全文: wkrtcs.bdimg.com/rtcs/getbdjson 桶式(3项/桶, rsign/md5sum 来自 ndview;
    本战役 EPC 语料 0 遇 type1 → 按 SPEC 接线, 未实弹验证, 如实标注)
  - type2: 纯图片页无文字层 → md/txt 口径如实跳过（OCR 归 harvest_engine T31）

墙（如实, 不破）:
  - ACS 补页墙: ndocview/readerinfo 无签 → status.code=0 + data.tri_cap=true
    (tri_reason=ymg + seccaptcha svcp_url) —— 本战役实证; Acs-Token 生成器
    paris_2030 在 wenku 前端 CDN bundle（伤心文库客户端也只是借页面自身函数）。
  - 选品对策: 只收「免费覆盖足额」文档（showPage>=page, 服务端匿名自给的完整预览）,
    越额补页不做 → 不碰付费墙。

铁律: 免登录(零Cookie)/只读/检索节流>=3s/文档腿>=1.2s/页腿>=0.6s/数字零造假。
用法:
  py -3 wenku_full_api.py --q "国际工程EPC" --out DIR [--need 3] [--scan 12] [--include-partial]
"""
from __future__ import annotations

import argparse
import json
import random
import re
import ssl
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

__all__ = ["wenku_search", "fetch_reader_info", "judge_doc_type", "harvest_type3_text",
           "harvest_type1_text", "full_chain"]

# ---------------------------------------------------------------- 常量（全部实测定型）

_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_SEC_CH_UA = '"Google Chrome";v="129","Chromium";v="129","Not_A Brand";v="24"'
_SEARCH_URL = "https://wenku.baidu.com/gsula/sula/syncmrecall"
_NDVIEW_TMPL = "https://wenku.baidu.com/ndview/{doc_id}.html"
_ASSET_REFERER = "https://wenku.baidu.com/"
_GETBDJSON_BASE = "https://wkrtcs.bdimg.com/rtcs/getbdjson"
_URI_SAFE = "-_.!~*'()"
_FMT = {1: "doc", 2: "pdf", 3: "ppt", 4: "xls", 5: "txt", 7: "epub", 16: "ebook"}

SEARCH_MIN_INTERVAL = 3.0     # 检索腿节流（capture.md §5: 突发 403 迹象 → >=3s）
DOC_MIN_INTERVAL = 1.2        # ndview 腿节流
PAGE_MIN_INTERVAL = 0.6       # 资产腿节流（harvest_engine WENKU_ASSET_MIN_INTERVAL 对齐 0.5s）

_CTX = ssl.create_default_context()
_strip_em = lambda s: re.sub(r"</?em>", "", s or "")


class WenkuHTTPError(RuntimeError):
    """网络腿失败（带 http 状态便于台账归因）。"""

    def __init__(self, leg: str, status: int, detail: str = ""):
        super().__init__(f"{leg} http={status} {detail}")
        self.leg, self.status = leg, status


class _Ledger:
    """请求台账（数字零造假: 每腿一行, 全实测）。"""

    def __init__(self):
        self.rows: list[dict] = []
        self._last: dict[str, float] = {}

    def pace(self, key: str, min_interval: float):
        last = self._last.get(key)
        wait = 0.0
        if last is not None:
            wait = max(0.0, min_interval - (time.time() - last))
            if wait:
                time.sleep(wait)
        self._last[key] = time.time()
        return wait

    def add(self, leg: str, **kw):
        row = {"ts": time.strftime("%H:%M:%S"), "leg": leg, **kw}
        self.rows.append(row)
        print(f"  [{leg}] {json.dumps(kw, ensure_ascii=False)[:200]}", flush=True)
        return row

    def counts(self) -> dict:
        out: dict = {}
        for r in self.rows:
            out[r["leg"]] = out.get(r["leg"], 0) + 1
        return out


def _http(url: str, *, method: str = "GET", body: bytes | None = None,
          headers: dict | None = None, timeout: float = 25.0) -> tuple[int, bytes]:
    h = {"User-Agent": _UA, "Accept-Language": "zh-CN,zh;q=0.9"}
    if headers:
        h.update(headers)
    req = urllib.request.Request(url, data=body, headers=h, method=method)
    with urllib.request.urlopen(req, timeout=timeout, context=_CTX) as r:
        return r.status, r.read()


# ---------------------------------------------------------------- 腿1: 检索（syncmrecall 免登录）

def wenku_search(word: str, pn: int = 1, *, ledger: _Ledger | None = None,
                 timeout: float = 25.0) -> dict:
    """syncmrecall sceneID=PCSearch → {total, items:[{doc_id,title,fmt,pages,sellType,url,abstract}]}。

    免登录零 Cookie（1021 实证配方, 勿改端点）; 12 条/页。
    """
    led = ledger or _Ledger()
    led.pace("search", SEARCH_MIN_INTERVAL)
    payload = json.dumps({"requests": [{"sceneID": "PCSearch", "params": {
        "word": word, "pn": pn, "noCacheMembershipCard": True}}]}, ensure_ascii=False).encode("utf-8")
    try:
        status, raw = _http(_SEARCH_URL, method="POST", body=payload, headers={
            "Content-Type": "application/json;charset=utf-8",
            "Accept": "application/json, text/plain, */*",
            "Referer": "https://wenku.baidu.com/search?word=" + urllib.parse.quote(word),
            "Origin": "https://wenku.baidu.com"})
    except urllib.error.HTTPError as e:
        led.add("search", http=e.code, ok=False, word=word)
        raise WenkuHTTPError("search", e.code)
    j = json.loads(raw.decode("utf-8", "replace"))
    res = (j.get("data", {}).get("items", {}).get("PCSearch") or {}).get("result", {})
    items = []
    for it in res.get("items", []):
        d = it.get("data", {})
        items.append({
            "doc_id": d.get("docID"), "title": _strip_em(d.get("title")),
            "fmt": _FMT.get(d.get("fileType"), str(d.get("fileType"))),
            "pages": d.get("pageNum"), "sellType": d.get("sellType"),
            "url": d.get("url"), "abstract": _strip_em(d.get("content"))[:200],
            "views": d.get("viewCount"), "downloads": d.get("downloadCount"),
        })
    led.add("search", http=status, ok=True, n=len(items),
            total=res.get("extra", {}).get("total"), word=word)
    return {"total": res.get("extra", {}).get("total"), "items": items}


# ---------------------------------------------------------------- 腿2: 元数据（ndview 侧门）

def _extract_pagedata(html: str) -> dict | None:
    """`var pageData` 锚点 → 引号/转义感知花括号配平 → 严格 JSON（harvest_engine 同型）。"""
    anchor = html.find("var pageData")
    if anchor < 0:
        return None
    start = html.find("{", anchor)
    if start < 0:
        return None
    depth, in_str, quote, escaped = 0, False, "", False
    for i in range(start, len(html)):
        ch = html[i]
        if in_str:
            if escaped:
                escaped = False
                continue
            if ch == "\\":
                escaped = True
                continue
            if ch == quote:
                in_str = False
            continue
        if ch in ('"', "'"):
            in_str, quote = True, ch
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                try:
                    return json.loads(html[start:i + 1])
                except json.JSONDecodeError:
                    return None
    return None


def fetch_reader_info(doc_id: str, *, ledger: _Ledger | None = None,
                      timeout: float = 25.0) -> dict | None:
    """ndview 侧门 → {title, reader_info, page, show_page, kind}；失败如实 None。"""
    led = ledger or _Ledger()
    led.pace("doc", DOC_MIN_INTERVAL)
    try:
        status, raw = _http(_NDVIEW_TMPL.format(doc_id=doc_id), headers={
            "Referer": _ASSET_REFERER, "Sec-Ch-Ua": _SEC_CH_UA,
            "Sec-Ch-Ua-Mobile": "?0", "Sec-Ch-Ua-Platform": '"Windows"',
            "Upgrade-Insecure-Requests": "1",
            "Accept": "text/html,application/xhtml+xml,*/*;q=0.8"})
    except urllib.error.HTTPError as e:
        led.add("ndview", http=e.code, ok=False, doc_id=doc_id)
        return None
    except Exception as e:  # 网络抖动/超时 → 如实 None
        led.add("ndview", http=0, ok=False, doc_id=doc_id, err=repr(e)[:80])
        return None
    pd = _extract_pagedata(raw.decode("utf-8", "replace"))
    if not isinstance(pd, dict) or not isinstance(pd.get("readerInfo"), dict):
        led.add("ndview", http=status, ok=False, doc_id=doc_id, bytes=len(raw), no="pageData")
        return None
    ri = pd["readerInfo"]
    page = _pos_int(ri.get("page")) or _pos_int(ri.get("originalPage")) or 0
    show = _pos_int(ri.get("showPage")) or 0
    out = {"title": str(pd.get("title") or ""), "reader_info": ri,
           "page": page, "show_page": show, "kind": judge_doc_type(ri)}
    led.add("ndview", http=status, ok=True, doc_id=doc_id, bytes=len(raw),
            kind=out["kind"], cover=f"{show}/{page}", tpl=ri.get("tplKey"))
    return out


def _pos_int(v) -> int | None:
    if isinstance(v, bool):
        return None
    if isinstance(v, int):
        return v if v > 0 else None
    if isinstance(v, str) and v.strip().isdigit():
        n = int(v)
        return n if n > 0 else None
    return None


def judge_doc_type(ri: dict) -> str:
    """三型判定（§5.2 唯一权威序）: type3 json桶 / type2 图片数组 / type1 rtcsRangeInfo。"""
    hu = ri.get("htmlUrls")
    if isinstance(hu, dict) and len(hu.get("json") or []) > 0:
        return "type3"
    if isinstance(hu, list) and len(hu) > 0:
        return "type2"
    if isinstance(ri.get("rtcsRangeInfo"), list) and ri.get("rtcsRangeInfo"):
        return "type1"
    return "unknown"


# ---------------------------------------------------------------- 腿3: type3 全文（BOS 文字层直链）

def _strip_jsonp(text: str):
    m = re.search(r"^[^(]*\((.*)\)\s*;?\s*$", text.strip(), re.S)
    if not m:
        raise ValueError("no jsonp envelope")
    return json.loads(m.group(1))


def harvest_type3_text(ri: dict, *, max_pages: int = 60,
                       ledger: _Ledger | None = None) -> dict:
    """htmlUrls.json[].pageLoadUrl 逐页 → word 节点真文字。

    返回 {pages: {pn: text}, fetched, failed, covered}。206 分片为正常态。
    """
    led = ledger or _Ledger()
    hu = ri.get("htmlUrls") or {}
    entries = {}
    for e in hu.get("json") or []:
        pi = _pos_int((e or {}).get("pageIndex"))
        if pi and e.get("pageLoadUrl"):
            entries[pi] = e
    pages, failed = {}, []
    for pn in sorted(entries):
        if pn > max_pages:
            break
        led.pace("page", PAGE_MIN_INTERVAL)
        try:
            status, raw = _http(entries[pn]["pageLoadUrl"], headers={"Referer": _ASSET_REFERER})
            pj = _strip_jsonp(raw.decode("utf-8", "replace"))
            words = [n.get("c") for n in (pj.get("body") or [])
                     if isinstance(n, dict) and n.get("t") == "word" and isinstance(n.get("c"), str)]
            pages[pn] = "".join(words)
            led.add("page3", pn=pn, http=status, chars=len(pages[pn]))
        except Exception as e:
            failed.append(pn)
            led.add("page3", pn=pn, http=-1, err=repr(e)[:80])
    return {"pages": pages, "fetched": len(pages), "failed": failed,
            "covered": sorted(pages) == sorted(entries)}


# ---------------------------------------------------------------- 腿3': type1 全文（getbdjson 桶）

def harvest_type1_text(ri: dict, *, max_buckets: int = 40,
                        ledger: _Ledger | None = None) -> dict:
    """rtcsRangeInfo 桶式拉取（3项/桶, rsign/bucketNum/md5sum 直拼 — harvest_engine §6.4）。

    注意: 本战役 EPC 语料 0 遇 type1（18 doc 全 type3）→ 本腿按 SPEC 接线,
    实弹验证状态=未验证（如实）。返回 {pages:[页文本], buckets_ok, buckets_empty, chars}。
    """
    led = ledger or _Ledger()

    def _v(key):
        x = ri.get(key)
        return str(x) if x not in (None, "") else ""

    rtcs = [e for e in (ri.get("rtcsRangeInfo") or []) if isinstance(e, dict)]
    blocks, empty = [], 0
    for i in range(0, min(len(rtcs), max_buckets * 3), 3):
        bucket = rtcs[i:i + 3]
        first = str((bucket[0] or {}).get("page", ""))
        rng = "_".join(str(e.get("range", "")) for e in bucket)
        url = (f"{_GETBDJSON_BASE}?bucketNum={_v('bucketNum')}&pn={first}&rn=3"
               f"&range={urllib.parse.quote(rng, safe=_URI_SAFE)}"
               f"&rsign={_v('rsign')}&dataType=rtcs&isWpNote=false{_v('md5sum')}"
               f"&callback=sf_edu_wenku_rtcs_doc_jsonp_1_{i // 3 + 1}&_={int(time.time() * 1000)}")
        led.pace("page", PAGE_MIN_INTERVAL)
        try:
            status, raw = _http(url, headers={"Referer": _ASSET_REFERER})
            pl = _strip_jsonp(raw.decode("utf-8", "replace"))
            got = pl.get("document.xml")
            if isinstance(got, list) and got:
                blocks.extend(got)
                led.add("bdjson", bucket=i // 3 + 1, http=status, ok=True, n=len(got))
            else:
                empty += 1
                led.add("bdjson", bucket=i // 3 + 1, http=status, ok=False,
                        err=str((pl.get("status") or {}).get("error", ""))[:40])
        except Exception as e:
            empty += 1
            led.add("bdjson", bucket=i // 3 + 1, http=-1, err=repr(e)[:80])

    def _walk(n) -> str:
        if isinstance(n, str):
            return n
        if not isinstance(n, dict):
            return ""
        if n.get("t") == "img":
            return ""
        out = n["c"] if isinstance(n.get("c"), str) else ""
        kids = n.get("c")
        if isinstance(kids, list):
            out += "".join(_walk(k) for k in kids)
        return out

    pages = [_walk(b) for b in blocks if isinstance(b, dict)]
    return {"pages": pages, "buckets_ok": len(blocks), "buckets_empty": empty,
            "chars": len(re.sub(r"\s", "", "".join(pages)))}


# ---------------------------------------------------------------- 全链编排

def _md_text(title: str, meta: dict, pages: dict | list, full: bool, cover: str) -> str:
    if isinstance(pages, dict):
        body = "\n\n".join(f"## 第{pn}页\n\n{txt}" for pn, txt in sorted(pages.items()))
        nchars = len(re.sub(r"\s", "", "".join(pages.values())))
    else:
        body = "\n\n".join(f"## 块{i + 1}\n\n{txt}" for i, txt in enumerate(pages))
        nchars = len(re.sub(r"\s", "", "".join(pages)))
    src_url = meta.get("url") or f"https://wenku.baidu.com/view/{meta.get('doc_id')}.html"
    return (f"# {title}\n\n"
            f"> 来源: 百度文库（免登录预览层, 纯HTTP采集）\n"
            f"> doc_id: {meta.get('doc_id')}\n> URL: {src_url}\n"
            f"> 类型: {meta.get('kind')} | 页覆盖: {cover} | 完整: {'是' if full else '否'}\n"
            f"> 实测正文字数: {nchars} | 采集: {time.strftime('%F %T')}\n\n{body}\n")


def full_chain(query: str, out_dir: Path, *, need: int = 3, scan: int = 12,
               include_partial: bool = False, session: str = "",
               search_pn: int = 1) -> dict:
    """检索→选品→全文→落盘。返回会话汇总（数字零造假）。

    选品序（免费覆盖优先策略, 绕开 ACS 补页墙）:
      ① 检索 items 按 pages 升序（短文档免费覆盖 showPage>=page 概率高）;
      ② ndview 判型+覆盖率; showPage>=page → 全文收割计数;
      ③ type3 文字层直链; type1 getbdjson(未实弹验证腿如实标注); type2/unknown 跳过记账;
      ④ 收满 need 或扫完 scan 止。
    """
    out_dir.mkdir(parents=True, exist_ok=True)
    led = _Ledger()
    print(f"[session{session}] q={query!r} need={need} scan={scan}", flush=True)
    sr = wenku_search(query, pn=search_pn, ledger=led)
    items = [x for x in sr["items"] if x["doc_id"]]
    items.sort(key=lambda x: (x["pages"] is None, x["pages"] if x["pages"] else 999))

    full_docs, partial_saved, skipped = [], [], []
    idx = 0
    for cand in items:
        if len(full_docs) >= need or idx >= scan:
            break
        idx += 1
        doc_id = cand["doc_id"]
        info = fetch_reader_info(doc_id, ledger=led)
        if info is None:
            skipped.append({"doc_id": doc_id, "why": "ndview_fail", "title": cand["title"]})
            continue
        ri, kind = info["reader_info"], info["kind"]
        page, show = info["page"], info["show_page"]
        cover = f"{show}/{page}"
        full = page > 0 and show >= page
        stem = re.sub(r"[\\/:*?\"<>|]", "_", re.sub(r"\s*-\s*百度文库|百度文库", "",
                                                    info["title"]).strip() or doc_id)[:50]
        stem = f"{stem}_{doc_id[:8]}"  # 同名文档防覆盖（s3 实测两篇同题→2文件/3全文事故）
        if kind == "type3":
            got = harvest_type3_text(ri, ledger=led)
            if not got["pages"]:
                skipped.append({"doc_id": doc_id, "why": "type3_zero_pages", "title": cand["title"]})
                continue
            nchars = len(re.sub(r"\s", "", "".join(got["pages"].values())))
            if nchars < 120:  # 真正文门槛: <120 非空白字=疑似封面/水印页, 不计全文
                skipped.append({"doc_id": doc_id, "why": f"thin({nchars}chars)", "title": cand["title"]})
                continue
            if full or include_partial:
                path = out_dir / f"{stem}.md"
                path.write_text(_md_text(info["title"], {**cand, "kind": kind},
                                         got["pages"], full, cover), encoding="utf-8")
            else:
                path = None
            rec = {"doc_id": doc_id, "title": cand["title"], "cover": cover,
                   "full": full, "chars": nchars, "file": str(path) if path else ""}
            (full_docs if full else partial_saved).append(rec)
            led.add("save", doc_id=doc_id[:10], full=full, chars=nchars, file=(path.name if path else "-"))
        elif kind == "type1":
            got = harvest_type1_text(ri, ledger=led)
            if got["chars"] < 120:
                skipped.append({"doc_id": doc_id, "why": f"type1_thin({got['chars']})",
                                "title": cand["title"]})
                continue
            if full or include_partial:
                path = out_dir / f"{stem}.md"
                path.write_text(_md_text(info["title"], {**cand, "kind": kind},
                                         got["pages"], full, cover), encoding="utf-8")
            else:
                path = None
            rec = {"doc_id": doc_id, "title": cand["title"], "cover": cover, "full": full,
                   "chars": got["chars"], "file": str(path) if path else "",
                   "leg_validated": False}
            (full_docs if full else partial_saved).append(rec)
            led.add("save", doc_id=doc_id[:10], full=full, chars=got["chars"], file=(path.name if path else "-"))
        else:
            skipped.append({"doc_id": doc_id, "why": f"kind={kind}_no_textlane",
                            "title": cand["title"], "cover": cover})

    summary = {
        "session": session, "query": query, "ts": time.strftime("%F %T"),
        "search_total": sr["total"], "scanned": idx, "items": len(items),
        "full_docs": full_docs, "full_n": len(full_docs),
        "partial_saved": partial_saved,  # 台账如实记录（默认不落盘文件, --include-partial 才写）
        "skipped": skipped,
        "requests": led.counts(), "ok": len(full_docs) >= need,
        "creds_used": 0,  # 全程免登录零账号态 → 积分成本 0（如实）
        "walls": ["ACS补页墙(tri_cap): 部分覆盖文档不越额补页",
                  f"type1/type2 本会话遇到 {sum(1 for s in skipped if 'kind=type' in str(s.get('why')))} 件"],
    }
    (out_dir / "_session_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    (out_dir / "_ledger.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in led.rows), encoding="utf-8")
    print(f"[session{session}] == full={len(full_docs)}/{need} partial={len(partial_saved)} "
          f"skip={len(skipped)} requests={led.counts()}", flush=True)
    return summary


def main():
    ap = argparse.ArgumentParser(description="百度文库检索→选品→全文 纯HTTP全链")
    ap.add_argument("--q", required=True, help="查询词")
    ap.add_argument("--out", required=True, help="输出目录")
    ap.add_argument("--need", type=int, default=3, help="目标全文数")
    ap.add_argument("--scan", type=int, default=12, help="最多扫描文档数")
    ap.add_argument("--pn", type=int, default=1, help="检索页号")
    ap.add_argument("--session", default="", help="会话标签")
    ns = ap.parse_args()
    s = full_chain(ns.q, Path(ns.out), need=ns.need, scan=ns.scan, session=ns.session,
                   search_pn=ns.pn)
    print(json.dumps({k: s[k] for k in ("full_n", "requests", "ok", "creds_used")},
                     ensure_ascii=False))
    sys.exit(0 if s["ok"] else 1)


if __name__ == "__main__":
    main()
