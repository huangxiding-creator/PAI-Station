# -*- coding: utf-8 -*-
"""逆向 manus.im 前端 bundle — 找通知/设置类真实 API 路径 (0922 深夜).

web 页被区域判定拦, 但静态 JS 资源 urllib 直拉不受影响 (恒 200).
路: index html -> script src -> 下载 chunk -> grep api 路径.
"""
import re
import time
import sys
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROXY = {"https": "http://127.0.0.1:7890", "http": "http://127.0.0.1:7890"}
OUT = Path("data/jsbundle")
OUT.mkdir(parents=True, exist_ok=True)


def fetch(url: str, timeout: int = 45, attempts: int = 4) -> bytes:
    last = None
    for i in range(attempts):
        try:
            op = urllib.request.build_opener(urllib.request.ProxyHandler(PROXY))
            req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 Chrome/129"})
            return op.open(req, timeout=timeout).read()
        except Exception as e:
            last = e
            time.sleep(2 + i * 2)
    raise last


def main():
    try:
        html = fetch("https://manus.im/").decode("utf-8", "replace")
    except Exception as e:
        print(f"[index] 拉取失败 ({type(e).__name__}), 仅用本地已存 chunk 挖掘")
        html = ""
    srcs = re.findall(r'src="([^"]+\.js[^"]*)"', html)
    # 页面内嵌的动态 import chunk 名也捞 (webpack/turbopack runtime 里)
    srcs += re.findall(r'["\']([^"\']*chunks/[^"\']+\.js[^"\']*)["\']', html)
    seen = set()
    saved = []
    for s in srcs:
        url = s if s.startswith("http") else "https://manus.im" + s
        name = url.split("/")[-1].split("?")[0][:80]
        if name in seen or (OUT / name).is_file():
            seen.add(name)
            saved.append(name)
            continue
        seen.add(name)
        for attempt in range(2):
            try:
                data = fetch(url)
                (OUT / name).write_bytes(data)
                saved.append(name)
                break
            except Exception as e:
                if attempt == 1:
                    print(f"  x {name}: {type(e).__name__}")
    print(f"[bundle] 累计 {len(saved)}/{len(seen)} chunks")
    # 已知端点词定位 + api 路径挖掘
    api_hits = set()
    notify_hits = set()
    known_markers = ("UserService", "SessionService", "api/chat", "api.manus")
    for name in sorted(OUT.glob("*.js")):
        text = name.read_text(encoding="utf-8", errors="replace")
        if not any(k in text for k in known_markers):
            continue
        print(f"  [API 层 chunk] {name.name} ({len(text)//1024}KB)")
        for m in re.findall(r'["\'](/(?:api|user|notify|session|setting|ws|feed)[^"\']{3,90})["\']', text):
            api_hits.add(m)
        for m in re.findall(r'["\']([^"\']*(?:[Nn]otification|notify|notifyEmail|agentEmail)[^"\']{0,70})["\']', text):
            if len(m) < 90:
                notify_hits.add(m)
    print(f"\n[api paths] {len(api_hits)}")
    for h in sorted(api_hits):
        print(" ", h)
    print(f"\n[notify-ish] {len(notify_hits)}")
    for h in sorted(notify_hits)[:40]:
        print(" ", h)


if __name__ == "__main__":
    main()
