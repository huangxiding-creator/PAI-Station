# -*- coding: utf-8 -*-
"""probe2: ①type1 getbdjson 全文性(免登录) ②BAIDUID 匿名设备cookie对showPage的影响
③无签 ndocview/readerinfo 墙探针(单发)。stdlib-only。"""
import json, re, ssl, sys, time, urllib.request, urllib.parse
from http.cookiejar import CookieJar
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parents[1]
CAP = HERE / "captures"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
      "Chrome/129.0.0.0 Safari/537.36")
CTX = ssl.create_default_context()
URI_SAFE = "-_.!~*'()"

def http_get(url, headers=None, timeout=25, opener=None):
    h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9"}
    if headers: h.update(headers)
    req = urllib.request.Request(url, headers=h, method="GET")
    t0 = time.time()
    op = opener or urllib.request.build_opener(urllib.request.HTTPSHandler(context=CTX))
    with op.open(req, timeout=timeout) as r:
        raw = r.read()
    return r.status, raw, int((time.time()-t0)*1000)

def strip_jsonp(text):
    m = re.search(r"^[^(]*\((.*)\)\s*;?\s*$", text.strip(), re.S)
    if not m: raise ValueError("no jsonp envelope")
    return json.loads(m.group(1))

def extract_pagedata(html):
    anchor = html.find("var pageData")
    if anchor < 0: return None
    start = html.find("{", anchor)
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
                try: return json.loads(html[start:i+1])
                except json.JSONDecodeError: return None
    return None

def judge(ri):
    hu = ri.get("htmlUrls")
    if isinstance(hu, dict) and (hu.get("json") or []): return "type3"
    if isinstance(hu, list) and hu: return "type2"
    if ri.get("rtcsRangeInfo"): return "type1"
    return "unknown"

def ndview(doc_id, headers=None):
    st, raw, ms = http_get(f"https://wenku.baidu.com/ndview/{doc_id}.html",
        {"Referer": "https://wenku.baidu.com/", **(headers or {})})
    pd = extract_pagedata(raw.decode("utf-8", "replace"))
    return st, pd, ms, len(raw)

def main():
    # ① 12页/16页候选 → 判型; type1 → getbdjson 全桶(免登录判定)
    for doc_id, note in [("2b6fb207826fb8", None), ("e44712bc72a200", None)]:
        # docid 需全量 — 从 probe1_search.json 取全
        pass
    items = json.load(open(CAP / "probe1_search.json", encoding="utf-8"))["items"]
    all_ids = [i["doc_id"] for i in items]
    targets = [d for d in all_ids if d.startswith(("2b6fb20782", "e44712bc72", "2d48ea035c"))]
    print("targets:", targets)
    for doc_id in targets:
        st, pd, ms, nb = ndview(doc_id)
        if not pd:
            print(f"[ndview] {doc_id[:10]} http={st} pageData=NO bytes={nb}"); continue
        ri = pd.get("readerInfo") or {}
        kind = judge(ri)
        print(f"[ndview] {doc_id[:10]} http={st} kind={kind} page={ri.get('page')} "
              f"showPage={ri.get('showPage')} tpl={ri.get('tplKey')} "
              f"rtcs={len(ri.get('rtcsRangeInfo') or [])} bytes={nb}")
        if kind == "type1":
            ri_full = ri  # 全 range 在手
            rtcs = [e for e in ri.get("rtcsRangeInfo") or [] if isinstance(e, dict)]
            blocks = []
            for i in range(0, len(rtcs), 3):
                bucket = rtcs[i:i+3]
                def v(k):
                    x = ri_full.get(k); return str(x) if x not in (None, "") else ""
                first = str(bucket[0].get("page", "")) if bucket else ""
                rng = "_".join(str(e.get("range", "")) for e in bucket)
                url = (f"https://wkrtcs.bdimg.com/rtcs/getbdjson?bucketNum={v('bucketNum')}"
                       f"&pn={first}&rn=3&range={urllib.parse.quote(rng, safe=URI_SAFE)}"
                       f"&rsign={v('rsign')}&dataType=rtcs&isWpNote=false{v('md5sum')}"
                       f"&callback=sf_edu_wenku_rtcs_doc_jsonp_1_{i//3+1}&_={int(time.time()*1000)}")
                try:
                    st2, raw2, _ = http_get(url, {"Referer": "https://wenku.baidu.com/"})
                    pl = strip_jsonp(raw2.decode("utf-8", "replace"))
                    got = pl.get("document.xml")
                    ok = isinstance(got, list)
                    print(f"  [getbdjson] bucket{i//3+1}/{(len(rtcs)+2)//3} http={st2} ok={ok} "
                          f"n={len(got) if ok else 0} "
                          f"err={(pl.get('status') or {}).get('error') if not ok else ''}")
                    if ok: blocks.extend(got)
                except Exception as e:
                    print(f"  [getbdjson] bucket{i//3+1} EXC {repr(e)[:90]}")
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
            nchars = len(re.sub(r"\s", "", text))
            print(f"  [type1-sum] blocks={len(blocks)} chars={nchars}")
            if nchars > 100:
                (CAP / f"probe2_type1_{doc_id[:8]}.md").write_text(
                    f"# {pd.get('title','')}\n\n{text}", encoding="utf-8")
        time.sleep(2.5)

    # ② BAIDUID 匿名设备cookie → showPage 变化(同一doc对照)
    print("\n== BAIDUID 对照 ==")
    jar = CookieJar()
    op = urllib.request.build_opener(urllib.request.HTTPSHandler(context=CTX),
                                     urllib.request.HTTPCookieProcessor(jar))
    try:
        st, raw, ms = http_get("https://wenku.baidu.com/", opener=op, timeout=25,
                               headers={"Accept": "text/html,*/*;q=0.8"})
        names = [c.name for c in jar]
        print(f"[warmup] wenku home http={st} cookies={names}")
    except Exception as e:
        print(f"[warmup] EXC {repr(e)[:90]}")
    doc_id = next((d for d in all_ids if d.startswith("00517d2fe1")), None)
    if doc_id:
        st, pd, ms, nb = ndview(doc_id)
        if pd:
            ri = pd.get("readerInfo") or {}
            print(f"[no-cookie ] showPage={ri.get('showPage')}/page={ri.get('page')} "
                  f"jsonEntries={len((ri.get('htmlUrls') or {}).get('json') or [])}")
        time.sleep(2.0)
        st2, raw2, ms2, nb2 = http_get(f"https://wenku.baidu.com/ndview/{doc_id}.html",
            {"Referer": "https://wenku.baidu.com/"}, opener=op)
        pd2 = extract_pagedata(raw2.decode("utf-8", "replace"))
        if pd2:
            ri2 = pd2.get("readerInfo") or {}
            print(f"[with-cookie] http={st2} showPage={ri2.get('showPage')}/page={ri2.get('page')} "
                  f"jsonEntries={len((ri2.get('htmlUrls') or {}).get('json') or [])}")

    # ③ 无签 readerinfo 墙探针（单发, 只定性）
    print("\n== 无签 readerinfo 探针 ==")
    doc_id = next((d for d in all_ids if d.startswith("00517d2fe1")), None)
    if doc_id:
        url = (f"https://wenku.baidu.com/ndocview/readerinfo?doc_id={doc_id}&docId={doc_id}"
               f"&type=html&clientType=1&pn=1&t={int(time.time()*1000)}&isFromBdSearch=0"
               f"&srcRef=&rn=50&powerId=2&bizName=mainPc")
        try:
            st, raw, ms = http_get(url, {"Referer": f"https://wenku.baidu.com/view/{doc_id}.html"})
            print(f"[nosign] http={st} head={raw.decode('utf-8','replace')[:240]}")
        except Exception as e:
            print(f"[nosign] EXC {repr(e)[:120]}")

if __name__ == "__main__":
    main()
