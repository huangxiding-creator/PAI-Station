# -*- coding: utf-8 -*-
"""probe1: book118 多面纯 HTTP 侦察（stdlib urllib 直连 + 桌面 UA，wenku 战役同款打法）。

腿（间隔3s，只读GET）：
  A max 首页          → 预期 SafeLine 468 挑战页（T19 实测）
  B search.html?q=    → 匿名检索渲染页（T19 实测 login 弹窗 0 结果）
  C m 站首页          → 移动镜像面（免挑战假设）
  D m 站检索          → 移动检索面
  E static wd.js      → webpreview JS（静态床假设免墙）
  F doclist 分类页    → 静态 .shtm 直链清单（T37 选品口径）
  G sitemap.xml       → SEO 面假设
全部响应体落 captures/probe1_*.bin/.html + 元数据 JSON 账（数字零造假）。
"""
import json
import ssl
import time
import urllib.error
import urllib.request
from pathlib import Path

CAP = Path(r"E:/AI-Station/逆向工程/book118-reverse/captures")
CAP.mkdir(parents=True, exist_ok=True)

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

#: 直连（禁系统代理：本机 Clash 注册表代理常死，T19 实锤同坑）
_ctx = ssl.create_default_context()
_opener = urllib.request.build_opener(
    urllib.request.ProxyHandler({}),
    urllib.request.HTTPSHandler(context=_ctx))

LEGS = [
    ("A_max_home", "https://max.book118.com/", "html"),
    ("B_max_search", "https://max.book118.com/search.html?q=%E5%9B%BD%E9%99%85%E5%B7%A5%E7%A8%8B", "html"),
    ("C_m_home", "https://m.book118.com/", "html"),
    ("D_m_search", "https://m.book118.com/search.html?q=%E5%9B%BD%E9%99%85%E5%B7%A5%E7%A8%8B", "html"),
    ("E_static_wdjs", "https://static.book118.com/open/wd.js?fb04f36f1e0ee36c30fab46eec18d62f&v=7.3.0.2.0.0.4", "bin"),
    ("F_doclist_551", "https://max.book118.com/doclist/list-551.html", "html"),
    ("G_sitemap", "https://max.book118.com/sitemap.xml", "xml"),
]

account = []
for name, url, ext in LEGS:
    req = urllib.request.Request(url, headers={
        "User-Agent": UA, "Accept": "*/*",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "Connection": "close"})
    row = {"leg": name, "url": url}
    t0 = time.monotonic()
    try:
        with _opener.open(req, timeout=30) as r:
            body = r.read()
            row.update(status=r.status, bytes=len(body),
                       ctype=r.headers.get("Content-Type", ""),
                       set_cookie=r.headers.get("Set-Cookie", ""),
                       final_url=r.geturl())
            (CAP / f"probe1_{name}.{ext}").write_bytes(body)
    except urllib.error.HTTPError as e:
        body = e.read()
        row.update(status=e.code, bytes=len(body),
                   ctype=e.headers.get("Content-Type", ""),
                   set_cookie=e.headers.get("Set-Cookie", ""),
                   final_url=e.headers.get("X-Final-URL", url))
        (CAP / f"probe1_{name}_http{e.code}.{ext}").write_bytes(body)
    except Exception as e:
        row.update(status=0, error=f"{type(e).__name__}: {e}"[:200])
    row["elapsed_ms"] = int((time.monotonic() - t0) * 1000)
    head = ""
    if row.get("bytes"):
        try:
            head = body[:300].decode("utf-8", "replace").replace("\n", " ")[:200]
        except Exception:
            head = repr(body[:80])
    row["head"] = head
    account.append(row)
    print(f"[{name}] status={row.get('status')} bytes={row.get('bytes')} "
          f"{row.get('ctype','')[:40]} {row['elapsed_ms']}ms")
    if row.get("set_cookie"):
        print(f"    set-cookie: {row['set_cookie'][:160]}")
    if head:
        print(f"    head: {head[:160]}")
    time.sleep(3.0)

(CAP / "probe1_account.json").write_text(
    json.dumps(account, ensure_ascii=False, indent=1), encoding="utf-8")
print("\n== account written:", CAP / "probe1_account.json")
