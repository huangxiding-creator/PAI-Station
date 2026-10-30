# -*- coding: utf-8 -*-
"""W3 · 快探三件（2026-10-30 夜）：天翼 H5 匿名 SESSION / 123 域名字典 / 曲奇 Pro 新接口

① GAP A9 天翼：m.cloud.189.cn H5 首访收 Cookie（SSK/SESSION 假设）→ 携入 open api
   getShareInfo，看 InvalidSessionKey 是否消失（消失=匿名 SESSION 突破成立）。
② 123 域名字典：refs_nfd PanDomainTemplate.java L186-207 权威 23 域 → 纯 DNS 解析存活表
   （socket.getaddrinfo，零 HTTP 发）。
③ GAP A2 曲奇 Pro：quqi.com 活性 + AlliotTech/openalist 曲奇驱动源码端点存在性探针。
预算：HTTP ≤10 发（逐发入 w3_probe_ledger.jsonl）；DNS 零发。
产出：analysis/w3_quick_probes.json
"""
from __future__ import annotations

import json
import re
import socket
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from curl_cffi import requests as creq   # noqa: E402

LEDGER = ROOT / "analysis" / "w3_probe_ledger.jsonl"
OUT = ROOT / "analysis" / "w3_quick_probes.json"
UA_PC = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
         "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
UA_MB = ("Mozilla/5.0 (Linux; Android 14; Pixel 8) AppleWebKit/537.36 "
         "(KHTML, like Gecko) Chrome/131.0.0.0 Mobile Safari/537.36")
shots = 0


def _shot(tag, url, note=""):
    global shots
    shots += 1
    with open(LEDGER, "a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%H:%M:%S"), "tag": tag,
                            "url": url[:130], "note": note[:90]}, ensure_ascii=False) + "\n")


def probe_189() -> dict:
    """① 天翼 H5 匿名 SESSION（GAP A9）。"""
    rec: dict = {"name": "tianyi_h5_ssk"}
    jar: dict = {}
    # 1) H5 首访
    _shot("189:h5_home", "https://m.cloud.189.cn/")
    r = creq.get("https://m.cloud.189.cn/", headers={"User-Agent": UA_MB},
                 timeout=15, impersonate="chrome124")
    for c in r.cookies.jar:
        jar[c.name] = c.value
    rec["h5_home"] = {"status": r.status_code, "cookies": sorted(jar),
                      "title": (re.search(r"<title>([^<]*)", r.text or "") or [None, "?"])[1][:40]}
    print(f"  H5 首访 {r.status_code} cookies={sorted(jar)}")
    time.sleep(2)
    # 2) H5 分享页（短链 code 路由）
    _shot("189:h5_share", "https://m.cloud.189.cn/share?code=W3PROBE1")
    r2 = creq.get("https://m.cloud.189.cn/share?code=W3PROBE1",
                  headers={"User-Agent": UA_MB}, timeout=15,
                  impersonate="chrome124", cookies=jar)
    for c in r2.cookies.jar:
        jar[c.name] = c.value
    rec["h5_share"] = {"status": r2.status_code, "cookies_all": sorted(jar)}
    print(f"  H5 分享页 {r2.status_code} 全 cookie={sorted(jar)}")
    time.sleep(2)
    # 3) 携 cookie 打 open api
    _shot("189:open_api", "https://cloud.189.cn/api/open/share/getShareInfo")
    r3 = creq.get("https://cloud.189.cn/api/open/share/getShareInfo"
                  "?shareId=W3PROBE&shareCode=W3PROBE",
                  headers={"User-Agent": UA_MB, "Referer": "https://m.cloud.189.cn/"},
                  timeout=15, impersonate="chrome124", cookies=jar)
    body = (r3.text or "")[:200].replace("\n", " ")
    rec["open_api_with_cookies"] = {"status": r3.status_code, "body_head": body}
    breakthrough = "InvalidSessionKey" not in body and r3.status_code != 403
    rec["verdict"] = ("BREAKTHROUGH: InvalidSessionKey 消失（匿名 SESSION 被 open api 接受）"
                      if breakthrough else
                      "NO: 仍拒（" + body[:80] + "）")
    print(f"  open api（携 H5 cookie）{r3.status_code} :: {body[:120]}")
    print(f"  → {rec['verdict'][:100]}")
    return rec


D_123 = ["123254.com", "123957.com", "123295.com", "123panpay.com", "123860.com",
         "123pan.com", "123245.com", "123278.com", "123842.com", "123294.com",
         "123865.com", "123773.com", "123624.com", "123684.com", "123641.com",
         "123259.com", "123912.com", "123952.com", "123652.com", "123pan.cn",
         "123635.com", "123242.com", "123795.com"]      # PanDomainTemplate.java L186-207 原序


def probe_123_dns() -> dict:
    """② 123 域名字典 23 域 DNS 解析存活表（零 HTTP）。"""
    rows = []
    alive = 0
    for d in D_123:
        try:
            infos = socket.getaddrinfo(d, 443, proto=socket.IPPROTO_TCP)
            ips = sorted({i[4][0] for i in infos})
            rows.append({"domain": d, "dns": "OK", "ips": ips[:3]})
            alive += 1
            print(f"  ✓ {d:16s} {ips[0]}")
        except Exception as e:
            rows.append({"domain": d, "dns": f"FAIL:{type(e).__name__}"})
            print(f"  ✗ {d:16s} {type(e).__name__}")
    return {"name": "123_domain_dict", "source": "refs_nfd PanDomainTemplate.java L186-207",
            "total": len(D_123), "dns_alive": alive,
            "rows": rows, "verdict": f"{alive}/{len(D_123)} 域 DNS 存活"}


def probe_quqi() -> dict:
    """③ 曲奇 Pro 新接口存在性（GAP A2）。"""
    rec: dict = {"name": "quqi_pro"}
    _shot("quqi:home", "https://quqi.com/")
    try:
        r = creq.get("https://quqi.com/", headers={"User-Agent": UA_PC},
                     timeout=15, impersonate="chrome124")
        rec["home"] = {"status": r.status_code,
                       "title": (re.search(r"<title>([^<]*)", r.text or "")
                                 or [None, "?"])[1][:50]}
        print(f"  quqi.com 首页 {r.status_code} title={rec['home']['title']!r}")
    except Exception as e:
        rec["home"] = {"error": f"{type(e).__name__}:{str(e)[:80]}"}
        rec["verdict"] = "站不可达"
        return rec
    time.sleep(2)
    # 驱动源码端点（AlliotTech/openalist 曲奇驱动=唯一现役开源实现）——gh api 拉文件清单+raw 源
    eps = []
    try:
        import subprocess
        _shot("quqi:driver_list", "gh api repos/AlliotTech/openalist/contents/drivers/quqi")
        out = subprocess.run(["gh", "api", "repos/AlliotTech/openalist/contents/drivers/quqi",
                              "--jq", ".[].download_url"],
                             capture_output=True, text=True, timeout=30).stdout.strip().splitlines()
        raw = ""
        for u in out:
            if u.endswith(".go"):
                _shot("quqi:driver_src", u)
                raw += subprocess.run(["curl", "-s", "--max-time", "20", u],
                                      capture_output=True, text=True,
                                      encoding="utf-8", errors="replace").stdout or ""
        eps = sorted(set(re.findall(r'"(/api/[^"{]+\.[a-z]+)"', raw)))
        rec["driver_endpoints"] = eps[:12]
        rec["driver_files"] = [u.rsplit("/", 1)[-1] for u in out]
        print(f"  驱动端点 {len(eps)} 个：{eps[:8]}")
    except Exception as e:
        rec["driver_error"] = f"{type(e).__name__}:{str(e)[:80]}"
        print(f"  驱动源拉取失败 {rec['driver_error']}")
    # 存在性探针：取首个 share 类端点打假码
    if eps:
        ep = next((e for e in eps if "share" in e), eps[0])
        url = "https://quqi.com" + ep
        _shot("quqi:probe_ep", url)
        try:
            r2 = creq.get(url, params={"shareCode": "W3PROBE", "code": "W3PROBE"},
                          headers={"User-Agent": UA_PC, "Referer": "https://quqi.com/"},
                          timeout=15, impersonate="chrome124")
            body = (r2.text or "")[:160].replace("\n", " ")
            rec["probe"] = {"url": url, "status": r2.status_code, "body_head": body}
            rec["verdict"] = (f"Pro 接口活（{ep} → {r2.status_code}）" if r2.status_code < 500
                              else f"Pro 接口死（{ep} → {r2.status_code}）")
            print(f"  {ep} → {r2.status_code} :: {body[:100]}")
        except Exception as e:
            rec["probe"] = {"url": url, "error": f"{type(e).__name__}:{str(e)[:60]}"}
            rec["verdict"] = "端点网络层失败"
    else:
        rec["verdict"] = "驱动端点未取得（站活但接口形态未核）"
    return rec


def main():
    print("== ① 天翼 H5 匿名 SESSION ==")
    a = probe_189()
    print("\n== ② 123 域名字典（DNS，零 HTTP）==")
    b = probe_123_dns()
    print("\n== ③ 曲奇 Pro ==")
    c = probe_quqi()
    OUT.write_text(json.dumps({"run": time.strftime("%Y%m%d_%H%M%S"),
                               "http_shots": shots,
                               "probes": [a, b, c]}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"\n== 快探收官：{shots} HTTP 发（预算 10）→ {OUT.name}")


if __name__ == "__main__":
    main()
