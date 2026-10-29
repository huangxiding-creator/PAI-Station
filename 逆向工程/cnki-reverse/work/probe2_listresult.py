# -*- coding: utf-8 -*-
"""Probe2: replay POST /api/search/listresult with handshake (warm cookies + Referer)."""
import requests, json, time, io, sys, urllib.parse
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
BASE = "https://search.cnki.com.cn"
KW = "国际工程 EPC"

def build_param(kw, field="Content", page=1, order=2):
    p = {
        "ArticleType": 0, "Content": "", "Theme": "", "Title": "", "KeyWd": "",
        "Author": "", "SearchFund": "", "Originate": "", "Summary": "",
        "PublishTimeBegin": "", "PublishTimeEnd": "", "MapNumber": "",
        "Name": "", "Issn": "", "Cn": "", "Unit": "", "Public": "",
        "Boss": "", "ExcludeField": "", "Type": "", "ReSearch": "",
        "CrossAreaSearch": "false", "Elite": "", "Subject": "", "SpecialityCode": "",
        "UnitCode": "", "Year": "", "AcefuthorFilter": "", "BossCode": "",
        "Fund": "", "Level": "", "Organization": "", "Smarts": "",
        field: kw, "Order": order, "Page": page,
    }
    return p

s = requests.Session()
s.headers.update({"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"})
# Step 1: warm SERP page (gets cookies)
r1 = s.get(BASE + "/Search/Result?content=" + urllib.parse.quote(KW), timeout=15)
print("warm:", r1.status_code, len(r1.content), "cookies:", "; ".join(f"{c.name}" for c in s.cookies))

# Step 2: POST listresult
for field in ("Content", "Theme"):
    p = build_param(KW, field=field)
    r2 = s.post(BASE + "/api/search/listresult", data=p, timeout=20,
        headers={"Referer": BASE + "/Search/Result?content=" + urllib.parse.quote(KW),
                 "Origin": BASE, "X-Requested-With": "XMLHttpRequest",
                 "Accept": "application/json, text/javascript, */*; q=0.01",
                 "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"})
    print(f"\n=== field={field} status={r2.status_code} len={len(r2.content)} ctype={r2.headers.get('Content-Type')}")
    if r2.status_code == 200:
        try:
            j = r2.json()
            print("keys:", list(j.keys())[:20])
            print("totalCount:", j.get("totalCount"), "pageIndex:", j.get("pageIndex"),
                  "pageSize:", j.get("pageSize"), "totalPageCount:", j.get("totalPageCount"))
            al = j.get("articleList") or []
            print("articleList len:", len(al))
            if al:
                print("item0 keys:", sorted(al[0].keys()))
                print("item0 sample:", json.dumps({k: str(v)[:60] for k, v in list(al[0].items())[:14]}, ensure_ascii=False, indent=1))
            fn = f"E:/AI-Station/逆向工程/cnki-reverse/captures/B1_listresult_{field}.json"
            open(fn, "w", encoding="utf-8").write(json.dumps(j, ensure_ascii=False, indent=1))
            print("saved:", fn)
        except Exception as e:
            print("JSON parse fail:", e, r2.text[:300])
    else:
        print("body head:", r2.text[:300])
    time.sleep(1.0)
