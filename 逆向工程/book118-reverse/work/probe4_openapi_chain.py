# -*- coding: utf-8 -*-
"""probe4: .shtm(纯HTTP) → var base 参数 → openapi getPreview 全链验证。"""
import re
import ssl
import time
import urllib.parse
import urllib.request
from pathlib import Path

CAP = Path(r"E:/AI-Station/逆向工程/book118-reverse/captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
ctx = ssl.create_default_context()
op = urllib.request.build_opener(
    urllib.request.ProxyHandler({}), urllib.request.HTTPSHandler(context=ctx))

def get(url, ref="https://max.book118.com/"):
    try:
        return op.open(urllib.request.Request(url, headers={
            "User-Agent": UA, "Referer": ref, "Accept": "*/*", "Connection": "close"}),
            timeout=30)
    except urllib.error.HTTPError as e:
        body = e.read()
        tag = url.rsplit("/", 1)[-1][:24].replace("?", "_")
        (CAP / f"probe4_http{e.code}_{tag}.html").write_bytes(body)
        print(f"   [challenge] {e.code} {len(body)}B → probe4_http{e.code}_{tag}.html")
        raise

for doc, path in [("5011203143013244", "2026/0722/5011203143013244"),
                  ("6115103231005025", "2022/1214/6115103231005025")]:
    u = f"https://max.book118.com/html/{path}.shtm"
    with get(u) as r:
        b = r.read()
    (CAP / f"probe4_shtm_{doc}.html").write_bytes(b)
    h = b.decode("utf-8", "replace")
    print(f"[{doc}] shtm {r.status} {len(b)}B safeline={'.safeline' in h[:4000]}")
    aid = re.search(r"pic\s*:\s*\{\s*aid\s*:\s*(\d+)", h)
    act = re.search(r"actual_page\s*:\s*(\d+)", h)
    pre = re.search(r"preview_page\s*:\s*(\d+)", h)
    vt = re.search(r"view_token=(1_vf[^'&\s]+)", h)
    t = re.search(r"senddate\s*:\s*'([0-9a-f]{32})'", h)
    print("   aid=%s actual=%s preview=%s t=%s vt=%s" % (
        aid and aid.group(1), act and act.group(1), pre and pre.group(1),
        t and t.group(1)[:16] + "...", vt and vt.group(1)[:24] + "..."))
    if not (aid and vt and t):
        # view_token 无 1_vf 前缀形态兜底
        vt2 = re.search(r"view_token\s*:\s*'([^']*)'", h)
        print("   fallback view_token form:", vt2 and vt2.group(1)[:80])
        continue
    time.sleep(1.0)
    qs = ("project_id=1&aid=%s&t=%s&view_token=%s&page=1&callback=jsonpReturn"
          % (aid.group(1), t.group(1), urllib.parse.quote(vt.group(1), safe="@_")))
    with get("https://openapi.book118.com/getPreview.html?" + qs) as r2:
        b2 = r2.read()
    (CAP / f"probe4_openapi_{doc}.txt").write_bytes(b2)
    print(f"   openapi {r2.status} {len(b2)}B")
    print("   ", b2.decode("utf-8", "replace")[:300])
    time.sleep(3.0)
print("done")
