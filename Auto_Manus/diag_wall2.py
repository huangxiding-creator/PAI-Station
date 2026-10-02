# -*- coding: utf-8 -*-
"""H4修复验证: PATCH mode=rule → 逐节点 (出口IP+login)"""
import io, json, sys, time
from urllib.parse import quote
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
import manus_lib as lib

def api(path, method="GET", data=None):
    import urllib.request as u
    secret = lib.CLASH_SECRET
    hdr = {"Authorization": "Bearer " + secret, "Content-Type": "application/json"}
    for p in lib.clash_ports():
        base = f"http://127.0.0.1:{p}"
        try:
            u.urlopen(u.Request(base + "/version", headers=hdr), timeout=2).read()
        except Exception:
            continue
        req = u.Request(base + path, data=json.dumps(data).encode() if data else None,
                        method=method, headers=hdr)
        return u.urlopen(req, timeout=4).read()
    return None

r = api("/configs", "PATCH", {"mode": "rule"})
print("[mode] PATCH rule 完成", r)
TEST = ["🇸🇬 新加坡 01", "🇺🇸 美国 04", "🇯🇵 日本 01"]
page = lib.make_page()
lib.ensure_network(page)
winner = None
for node in TEST:
    api("/proxies/" + quote("🚀 手动切换"), "PUT", {"name": node})
    time.sleep(2)
    try:
        page.get("https://api.ip.sb/ip", timeout=20)
        ip = (page.ele("tag:body").text or "").strip()[:40]
    except Exception as e:
        ip = f"ERR:{type(e).__name__}"
    try: page.set.cookies.clear()
    except Exception: pass
    page.get(lib.LOGIN_URL)
    time.sleep(7)
    url = page.url or ""
    email = bool(page.ele("#email", timeout=4))
    ok = email and "unavailable" not in url
    if ok: winner = node
    print(f"[{node}] 出口IP={ip} | login={url} | #email={'在' if email else '缺'} {'★' if ok else ''}", flush=True)
print(f"[结果] winner={winner}")
try: page.browser.quit()
except Exception: pass
