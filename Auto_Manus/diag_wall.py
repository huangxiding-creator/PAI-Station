# -*- coding: utf-8 -*-
"""区域墙判别: 每节点 (真实出口IP + 清cookie后的login态) 分离 H1/H2/H4"""
import io, json, sys, time
from urllib.parse import quote
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
import manus_lib as lib

TEST = ["🇸🇬 新加坡 01", "🇺🇸 美国 04", "🇯🇵 日本 01"]

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

# 0) 组现状: now 选中谁 + 节点名实样 (H4 前置)
g = json.loads(api("/proxies/" + quote("🚀 手动切换")))
print(f"[组] now={g.get('now')} | 全部节点={len(g.get('all', []))}")
print("[组] 前几个节点名实样:", g.get("all", [])[:6])

page = lib.make_page()
lib.ensure_network(page)
for node in TEST:
    api("/proxies/" + quote("🚀 手动切换"), "PUT", {"name": node})
    time.sleep(2)
    # 出口 IP (浏览器级, 同代理路径)
    try:
        page.get("https://api.ip.sb/ip", timeout=15)
        ip = (page.ele("tag:body").text or "").strip()[:40]
    except Exception as e:
        ip = f"ERR:{type(e).__name__}"
    # 清 cookie + 冷加载 login
    try: page.set.cookies.clear()
    except Exception: pass
    page.get(lib.LOGIN_URL)
    time.sleep(7)
    url = page.url or ""
    email = bool(page.ele("#email", timeout=4))
    print(f"[{node}] 出口IP={ip} | login={url} | #email={'在' if email else '缺'}", flush=True)
print("[判读] IP随节点变+仍拦=H1整段封锁; IP不变=H4切换失效")
try: page.browser.quit()
except Exception: pass
