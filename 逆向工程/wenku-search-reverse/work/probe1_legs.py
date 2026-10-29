# -*- coding: utf-8 -*-
"""probe1: 四腿独立实证（检索/ndview/pageLoadUrl文字层/getbdjson XML + 无签readerinfo墙探针）。
零浏览器、stdlib-only、免登录。节流: 检索3s/资产0.5s。产物落 captures/。
"""
import json, re, ssl, sys, time, urllib.request, urllib.parse
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parents[1]
CAP = HERE / "captures"
CAP.mkdir(exist_ok=True)

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
      "Chrome/129.0.0.0 Safari/537.36")
SEC = '"Google Chrome";v="129","Chromium";v="129","Not_A Brand";v="24"'
CTX = ssl.create_default_context()
LEDGER = []

def http_get(url, headers=None, timeout=25):
    h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9",
         "Accept": "text/html,application/json,*/*;q=0.8"}
    if headers:
        h.update(headers)
    req = urllib.request.Request(url, headers=h, method="GET")
    t0 = time.time()
    with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
        raw = r.read()
    return r.status, raw, int((time.time() - t0) * 1000)

def http_post_json(url, payload, headers=None, timeout=25):
    body = json.dumps(payload, ensure_ascii=False).encode("utf-8")
    h = {"User-Agent": UA, "Content-Type": "application/json;charset=utf-8",
         "Accept": "application/json, text/plain, */*"}
    if headers:
        h.update(headers)
    req = urllib.request.Request(url, data=body, headers=h, method="POST")
    t0 = time.time()
    with urllib.request.urlopen(req, timeout=timeout, context=CTX) as r:
        raw = r.read()
    return r.status, raw, int((time.time() - t0) * 1000)

def log(leg, tag, **kw):
    row = {"leg": leg, "tag": tag, **kw}
    LEDGER.append(row)
    print(f"[{leg}] {tag} {json.dumps(kw, ensure_ascii=False)[:220]}", flush=True)

# ---------- 腿1: 检索 syncmrecall ----------
def search(word, pn=1):
    url = "https://wenku.baidu.com/gsula/sula/syncmrecall"
    ref = "https://wenku.baidu.com/search?word=" + urllib.parse.quote(word)
    st, raw, ms = http_post_json(url, {"requests": [{"sceneID": "PCSearch",
        "params": {"word": word, "pn": pn, "noCacheMembershipCard": True}}]},
        {"Referer": ref, "Origin": "https://wenku.baidu.com"})
    j = json.loads(raw.decode("utf-8", "replace"))
    res = (j.get("data", {}).get("items", {}).get("PCSearch") or {}).get("result", {})
    items = []
    strip = lambda s: re.sub(r"</?em>", "", s or "")
    for it in res.get("items", []):
        d = it.get("data", {})
        items.append({"doc_id": d.get("docID"), "title": strip(d.get("title")),
                      "fileType": d.get("fileType"), "pages": d.get("pageNum"),
                      "sellType": d.get("sellType"), "views": d.get("viewCount"),
                      "downloads": d.get("downloadCount"), "url": d.get("url")})
    log("search", "syncmrecall", http=st, ms=ms, n=len(items),
        total=res.get("extra", {}).get("total"), word=word)
    return items

# ---------- 腿2: ndview pageData ----------
def fetch_pagedata(doc_id):
    url = f"https://wenku.baidu.com/ndview/{doc_id}.html"
    st, raw, ms = http_get(url, {"Referer": "https://wenku.baidu.com/",
                                 "Sec-Ch-Ua": SEC, "Sec-Ch-Ua-Mobile": "?0",
                                 "Sec-Ch-Ua-Platform": '"Windows"',
                                 "Upgrade-Insecure-Requests": "1"})
    html = raw.decode("utf-8", "replace")
    pd = extract_pagedata(html)
    log("ndview", "pageData", http=st, ms=ms, bytes=len(raw),
        ok=pd is not None, doc_id=doc_id[:12])
    return pd

def extract_pagedata(html):
    anchor = html.find("var pageData")
    if anchor < 0:
        return None
    start = html.find("{", anchor)
    if start < 0:
        return None
    depth, in_str, q, esc = 0, False, "", False
    for i in range(start, len(html)):
        ch = html[i]
        if in_str:
            if esc: esc = False; continue
            if ch == "\\": esc = True; continue
            if ch == q: in_str = False
            continue
        if ch in ('"', "'"): in_str, q = True, ch; continue
        if ch == "{": depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                try:
                    return json.loads(html[start:i+1])
                except json.JSONDecodeError:
                    return None
    return None

def strip_jsonp(text):
    if not isinstance(text, str):
        raise ValueError("no body")
    m = re.search(r"^[^(]*\((.*)\)\s*;?\s*$", text.strip(), re.S)
    if not m:
        raise ValueError("no jsonp envelope")
    return json.loads(m.group(1))

# ---------- 腿3: type3 pageLoadUrl 文字层 ----------
def type3_text(ri, doc_id, max_pages=30):
    hu = ri.get("htmlUrls") or {}
    jmap = {}
    for e in hu.get("json") or []:
        if isinstance(e, dict) and e.get("pageIndex"):
            jmap[int(e["pageIndex"])] = e
    pages_txt = {}
    for pn in sorted(jmap):
        if pn > max_pages:
            break
        url = jmap[pn].get("pageLoadUrl")
        if not url:
            continue
        try:
            st, raw, ms = http_get(url, {"Referer": "https://wenku.baidu.com/"})
            pj = strip_jsonp(raw.decode("utf-8", "replace"))
            body = pj.get("body") or []
            words = [n.get("c") for n in body if isinstance(n, dict)
                     and n.get("t") == "word" and isinstance(n.get("c"), str)]
            pages_txt[pn] = "".join(words)
            log("type3", "page", pn=pn, http=st, chars=len(pages_txt[pn]))
        except Exception as e:
            log("type3", "page_fail", pn=pn, err=repr(e)[:80])
        time.sleep(0.6)
    return pages_txt

# ---------- 腿4: type1 getbdjson XML ----------
URI_SAFE = "-_.!~*'()"
def getbdjson_url(ri, bucket, idx):
    def v(k):
        x = ri.get(k)
        return str(x) if x not in (None, "") else ""
    first = str(bucket[0].get("page", "")) if bucket else ""
    rng = "_".join(str(e.get("range", "")) if isinstance(e, dict) else "" for e in bucket)
    return (f"https://wkrtcs.bdimg.com/rtcs/getbdjson?bucketNum={v('bucketNum')}"
            f"&pn={first}&rn=3&range={urllib.parse.quote(rng, safe=URI_SAFE)}"
            f"&rsign={v('rsign')}&dataType=rtcs&isWpNote=false{v('md5sum')}"
            f"&callback=sf_edu_wenku_rtcs_doc_jsonp_1_{idx}&_={int(time.time()*1000)}")

def type1_text(ri, max_buckets=4):
    rtcs = [e for e in (ri.get("rtcsRangeInfo") or []) if isinstance(e, dict)]
    blocks = []
    for i in range(0, min(len(rtcs), max_buckets * 3), 3):
        bucket = rtcs[i:i+3]
        url = getbdjson_url(ri, bucket, i // 3 + 1)
        try:
            st, raw, ms = http_get(url, {"Referer": "https://wenku.baidu.com/"})
            pl = strip_jsonp(raw.decode("utf-8", "replace"))
            got = pl.get("document.xml")
            log("type1", "bucket", idx=i//3+1, http=st,
                ok=isinstance(got, list), n=len(got) if isinstance(got, list) else 0)
            if isinstance(got, list):
                blocks.extend(got)
        except Exception as e:
            log("type1", "bucket_fail", idx=i//3+1, err=repr(e)[:80])
        time.sleep(0.6)
    def walk(n):
        if isinstance(n, str): return n
        if not isinstance(n, dict): return ""
        if n.get("t") == "img": return ""
        out = n["c"] if isinstance(n.get("c"), str) else ""
        kids = n.get("c")
        if isinstance(kids, list): out += "".join(walk(k) for k in kids)
        return out
    text = "\n".join(walk(b) for b in blocks if isinstance(b, dict))
    return blocks, text

# ---------- 腿5(墙探针): 无签 readerinfo ----------
def readerinfo_nosign(doc_id, pn=1, rn=50):
    url = (f"https://wenku.baidu.com/ndocview/readerinfo?doc_id={doc_id}&docId={doc_id}"
           f"&type=html&clientType=1&pn={pn}&t={int(time.time()*1000)}&isFromBdSearch=0"
           f"&srcRef=&rn={rn}&powerId=2&bizName=mainPc")
    st, raw, ms = http_get(url, {"Referer": f"https://wenku.baidu.com/view/{doc_id}.html",
                                 "Accept": "application/json"})
    head = raw.decode("utf-8", "replace")[:300]
    log("readerinfo_nosign", "probe", http=st, ms=ms, bytes=len(raw), head=head)
    return st, raw

def main():
    word = sys.argv[1] if len(sys.argv) > 1 else "国际工程EPC"
    items = search(word)
    (CAP / "probe1_search.json").write_text(
        json.dumps({"word": word, "items": items}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    if not items:
        print("!! search empty"); return
    # 选品: 页数短优先（免费覆盖 showPage>=page 概率高）; sellType 只标注不过滤
    # （1021 capture.md §5: sellType→VIP 是未核验启发式; 真免费覆盖看 ndview showPage/page）
    cand = [x for x in items if x["pages"] and 1 <= x["pages"] <= 16]
    print(f"candidates: {[(c['title'][:18], c['pages'], c['doc_id'][:10]) for c in cand]}")
    for c in cand[:3]:
        time.sleep(3.0)
        pd = fetch_pagedata(c["doc_id"])
        if not pd:
            continue
        ri = pd.get("readerInfo") or {}
        page = ri.get("page") or 0
        show = ri.get("showPage") or 0
        hu = ri.get("htmlUrls")
        kind = ("type3" if isinstance(hu, dict) and (hu.get("json") or [])
                else "type2" if isinstance(hu, list) and hu
                else "type1" if ri.get("rtcsRangeInfo") else "unknown")
        log("judge", "doc", doc=c["doc_id"][:12], title=c["title"][:20],
            kind=kind, page=page, showPage=show, cover=f"{show}/{page}",
            tpl=ri.get("tplKey"))
        if kind == "type3":
            txt = type3_text(ri, c["doc_id"])
            total = sum(len(v) for v in txt.values())
            log("type3", "sum", doc=c["doc_id"][:12], pages=len(txt), chars=total)
            if txt:
                (CAP / f"probe1_type3_{c['doc_id'][:8]}.json").write_text(
                    json.dumps({"title": c["title"], "pages": txt},
                               ensure_ascii=False, indent=1), encoding="utf-8")
        elif kind == "type1":
            blocks, text = type1_text(ri)
            log("type1", "sum", doc=c["doc_id"][:12], blocks=len(blocks), chars=len(text))
            if text:
                (CAP / f"probe1_type1_{c['doc_id'][:8]}.md").write_text(
                    f"# {c['title']}\n\n{text}", encoding="utf-8")
        else:
            log("judge", "skip_kind", kind=kind, doc=c["doc_id"][:12])
    # 墙探针: 挑一个 showPage<page 的文档试无签补页(单发)
    time.sleep(3.0)
    for c in items:
        pass
    (CAP / "probe1_ledger.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in LEDGER), encoding="utf-8")
    print(f"== done {len(LEDGER)} rows")

if __name__ == "__main__":
    main()
