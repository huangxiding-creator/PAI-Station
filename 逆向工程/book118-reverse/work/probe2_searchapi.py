# -*- coding: utf-8 -*-
"""probe2: book118 检索后端端点级实证（newSearchApi/getTxt/tdsearch 匿名直打）。

假设（任务书主假设，wenku syncmrecall 先例）：渲染面 login 弹窗是客户端
表象（base.limit_search=1 + res.data.limit_search 客户端反应），端点本身
匿名可用或部分可用。逐腿实测：
  S1 newSearchApi.html?q=国际工程&page=1        主列表 XHR
  S2 newSearchApi.html 国际工程EPC              换词
  S3 getTxt.html?aid=<实吐aid>&keywords=<词>    结果文字段
  S4 tdsearch.html?q=<词>&page=1                三方追加腿
响应体全落 captures/，信封字段(code/list.docs/total/limit_search/check_code)
逐项记账。
"""
import json
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
REFERER = BASE + "/search.html?q=" + urllib.parse.quote("国际工程")

def get(name, path, params="", referer=REFERER):
    url = BASE + path + (("?" + params) if params else "")
    req = urllib.request.Request(url, headers={
        "User-Agent": UA,
        "Referer": referer,
        "Accept": "application/json, text/javascript, */*; q=0.01",
        "X-Requested-With": "XMLHttpRequest",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "Connection": "close"})
    row = {"leg": name, "url": url}
    t0 = time.monotonic()
    try:
        with _op.open(req, timeout=30) as r:
            body = r.read()
            row.update(status=r.status, bytes=len(body), ctype=r.headers.get("Content-Type",""))
            (CAP / f"probe2_{name}.json").write_bytes(body)
            txt = body.decode("utf-8", "replace")
            row["head"] = txt[:400]
            try:
                j = json.loads(txt)
                row["json"] = {
                    "code": j.get("code"),
                    "keys": list(j.keys())[:12],
                }
                d = j.get("data")
                if isinstance(d, dict):
                    row["json"]["data_keys"] = list(d.keys())[:12]
                    lst = d.get("list")
                    if isinstance(lst, dict):
                        docs = lst.get("docs")
                        row["json"]["total"] = lst.get("total")
                        row["json"]["docs_n"] = len(docs) if isinstance(docs, list) else None
                        if isinstance(docs, list) and docs:
                            row["json"]["doc0"] = {k: docs[0].get(k) for k in
                                                   ("encode_aid","url","title","is_publisher","view_page","money") if k in docs[0]}
                            row["json"]["doc0_keys"] = list(docs[0].keys())
                    for k in ("limit_search","check_code","spider","limit_message"):
                        if k in d:
                            row["json"][k] = d[k]
            except Exception as e:
                row["json_error"] = f"{type(e).__name__}: {e}"[:120]
    except urllib.error.HTTPError as e:
        body = e.read()
        row.update(status=e.code, bytes=len(body), ctype=e.headers.get("Content-Type",""))
        (CAP / f"probe2_{name}_http{e.code}.json").write_bytes(body)
        row["head"] = body[:400].decode("utf-8","replace")
    except Exception as e:
        row.update(status=0, error=f"{type(e).__name__}: {e}"[:200])
    row["elapsed_ms"] = int((time.monotonic()-t0)*1000)
    print(f"[{name}] status={row.get('status')} bytes={row.get('bytes')} {row['elapsed_ms']}ms")
    print("   ", json.dumps(row.get("json", row.get("head","")[:200]), ensure_ascii=False)[:600])
    return row

account = []
q = urllib.parse.quote("国际工程")
account.append(get("S1_newSearchApi", "/user_center_v1/home/Search/newSearchApi.html",
                   f"q={q}&page=1"))
time.sleep(3.0)
account.append(get("S2_newSearchApi_epc", "/user_center_v1/home/Search/newSearchApi.html",
                   "q=" + urllib.parse.quote("国际工程EPC") + "&page=1"))
time.sleep(3.0)
# getTxt 需要 S1 实吐 aid
aid = ""
try:
    j = json.loads((CAP / "probe2_S1_newSearchApi.json").read_text(encoding="utf-8"))
    docs = j["data"]["list"]["docs"]
    aid = docs[0].get("encode_aid") or docs[0].get("aid") or ""
except Exception:
    pass
print("getTxt aid candidate:", aid)
if aid:
    account.append(get("S3_getTxt", "/user_center_v1/home/Search/getTxt.html",
                       f"aid={aid}&detail_id=0&keywords={q}"))
    time.sleep(3.0)
account.append(get("S4_tdsearch", "/user_center_v1/home/Search/tdsearch.html",
                   f"q={q}&page=1"))

(CAP / "probe2_account.json").write_text(
    json.dumps(account, ensure_ascii=False, indent=1), encoding="utf-8")
print("== account written")
