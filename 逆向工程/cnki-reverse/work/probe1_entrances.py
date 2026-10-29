# -*- coding: utf-8 -*-
"""Phase A recon: probe all CNKI entrances, no redirects, log status/size/redirect."""
import requests, json, time, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
H = {"User-Agent": UA, "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
     "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8", "Accept-Encoding": "gzip, deflate, br"}

targets = [
    ("kns_home",      "https://kns.cnki.net/kns8s"),
    ("search_new",    "https://search.cnki.com/"),
    ("search_old",    "https://search.cnki.com.cn/Search/Result?content=EPC"),
    ("oversea_home",  "https://oversea.cnki.net/"),
    ("chn_oversea",   "https://chn.oversea.cnki.net/"),
    ("cdmd_home",     "https://cdmd.cnki.com.cn/"),
    ("med_home",      "https://med.cnki.net/"),
    ("www_space",     "https://www.cnki.com.cn/"),
    ("wap_home",      "https://wap.cnki.net/"),
    ("fileter_bare",  "https://search.cnki.com/api/fileterresultapi/articlefileter"),
]
log = []
for name, url in targets:
    try:
        t0 = time.time()
        r = requests.get(url, headers=H, timeout=15, allow_redirects=False)
        dt = time.time() - t0
        body = r.content
        # save body
        fn = f"E:/AI-Station/逆向工程/cnki-reverse/captures/A1_{name}.html"
        with open(fn, "wb") as f:
            f.write(body)
        entry = {"name": name, "url": url, "status": r.status_code,
                 "size": len(body), "redirect": r.headers.get("Location", ""),
                 "server": r.headers.get("Server", ""), "dt_s": round(dt, 2),
                 "ctype": r.headers.get("Content-Type", ""),
                 "setcookie": bool(r.headers.get("Set-Cookie"))}
        log.append(entry)
        print(json.dumps(entry, ensure_ascii=False))
    except Exception as e:
        entry = {"name": name, "url": url, "error": repr(e)[:200]}
        log.append(entry)
        print(json.dumps(entry, ensure_ascii=False))
    time.sleep(0.8)

with open("E:/AI-Station/逆向工程/cnki-reverse/captures/probe1_log.json", "w", encoding="utf-8") as f:
    json.dump(log, f, ensure_ascii=False, indent=2)
print("PROBE1 DONE")
