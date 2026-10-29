# -*- coding: utf-8 -*-
"""probe3: book118 分页深度 + .shtm 详情页纯HTTP + getTxt 多件复验。

  P1 newSearchApi page=2/3/5/10/15  匿名翻页深度（limit_search 何时刻起 >=1）
  H1 .shtm 详情页直打（urllib）      SafeLine 是否放行 + var base 可挖性
  T1 getTxt 另一件（is_free/vip_type 不同档）
"""
import json
import re
import ssl
import time
import urllib.parse
import urllib.request
from pathlib import Path

CAP = Path(r"E:/AI-Station/逆向工程/book118-reverse/captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
_ctx = ssl.create_default_context()
_op = urllib.request.build_opener(
    urllib.request.ProxyHandler({}), urllib.request.HTTPSHandler(context=_ctx))
BASE = "https://max.book118.com"
Q = urllib.parse.quote("国际工程")

def fetch(url, referer=BASE + "/search.html?q=" + Q, xhr=True):
    h = {"User-Agent": UA, "Referer": referer, "Accept-Language": "zh-CN,zh;q=0.9",
         "Connection": "close"}
    if xhr:
        h["Accept"] = "application/json, text/javascript, */*; q=0.01"
        h["X-Requested-With"] = "XMLHttpRequest"
    else:
        h["Accept"] = "text/html,application/xhtml+xml,*/*;q=0.8"
    t0 = time.monotonic()
    try:
        with _op.open(urllib.request.Request(url, headers=h), timeout=30) as r:
            return r.status, r.read(), int((time.monotonic()-t0)*1000), dict(r.headers)
    except urllib.error.HTTPError as e:
        return e.code, e.read(), int((time.monotonic()-t0)*1000), dict(e.headers)

account = []

# ---- P1 分页深度 ----
for pg in (2, 3, 5, 10, 15):
    st, b, ms, hdr = fetch(f"{BASE}/user_center_v1/home/Search/newSearchApi.html?q={Q}&page={pg}")
    row = {"leg": f"P1_page{pg}", "status": st, "bytes": len(b), "ms": ms}
    if st == 200:
        (CAP / f"probe3_newSearchApi_p{pg}.json").write_bytes(b)
        try:
            j = json.loads(b.decode("utf-8", "replace"))
            d = j.get("data") or {}
            lst = d.get("list") or {}
            docs = lst.get("docs") or []
            row.update(code=j.get("code"), total=lst.get("total"), docs_n=len(docs),
                       limit_search=d.get("limit_search"), check_code=d.get("check_code"),
                       first_aid=docs[0].get("encode_aid") if docs else None)
        except Exception as e:
            row["parse"] = f"{type(e).__name__}"
    account.append(row)
    print(row)
    time.sleep(3.0)

# ---- H1 .shtm 详情页 ----
st, b, ms, hdr = fetch(f"{BASE}/html/2017/0418/100821230.shtm", xhr=False)
row = {"leg": "H1_shtm", "status": st, "bytes": len(b), "ms": ms,
       "ctype": hdr.get("Content-Type", "")}
if st == 200:
    (CAP / "probe3_shtm_100821230.html").write_bytes(b)
    txt = b.decode("utf-8", "replace")
    row["safeline"] = ".safeline" in txt[:4000]
    row["var_base"] = "var base" in txt
    from_re = {
        "aid": r"(?:office|pic)\s*:\s*\{\s*aid\s*:\s*(\d+)",
        "view_token": r"view_token\s*:\s*'([^']*)'",
        "senddate": r"senddate\s*:\s*'([0-9a-f]{32})'",
        "preview_page": r"preview_page\s*:\s*(\d+)",
        "actual_page": r"actual_page\s*:\s*(\d+)",
        "title": r"title\s*:\s*'([^']{0,80})",
    }
    for k, pat in from_re.items():
        m = re.search(pat, txt)
        row[k] = m.group(1)[:40] if m else None
account.append(row)
print(row)
time.sleep(3.0)

# ---- T1 getTxt 另一件（2026 新件 pptx） ----
st, b, ms, hdr = fetch(f"{BASE}/user_center_v1/home/Search/getTxt.html?aid=5011203143013244&detail_id=0&keywords={Q}")
row = {"leg": "T1_getTxt_pptx", "status": st, "bytes": len(b), "ms": ms}
if st == 200:
    (CAP / "probe3_getTxt_5011203143013244.json").write_bytes(b)
    try:
        j = json.loads(b.decode("utf-8", "replace"))
        row["code"] = j.get("code")
        row["text_chars"] = len((j.get("data") or {}).get("text") or "")
    except Exception as e:
        row["parse"] = f"{type(e).__name__}"
account.append(row)
print(row)

(CAP / "probe3_account.json").write_text(
    json.dumps(account, ensure_ascii=False, indent=1), encoding="utf-8")
print("== done")
