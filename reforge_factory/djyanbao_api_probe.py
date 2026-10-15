# -*- coding: utf-8 -*-
"""djyanbao_api_probe — 列表 API 网络监听探测 (改版适配 5: 数据面直取)."""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"


def main() -> int:
    q = sys.argv[1] if len(sys.argv) > 1 else "电子招投标"
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)
    page.listen.start("djyanbao.com")               # 全域网络包
    page.get(f"https://www.djyanbao.com/search?q={quote(q)}", timeout=25)
    time.sleep(9)
    hits = []
    for pkt in page.listen.steps(timeout=4, count=40):
        try:
            u = pkt.url or ""
            if any(k in u for k in (".js", ".css", ".png", ".woff", ".ico",
                                    ".svg", ".jpg")):
                continue
            ct = str(pkt.response.headers.get("content-type", ""))
            if "json" not in ct and "text" not in ct:
                continue
            body = pkt.response.body
            body_s = body if isinstance(body, str) else str(body)
            hits.append((u, body_s))
        except Exception:
            continue
    page.listen.stop()
    print(f"[api] 捕获 {len(hits)} 个数据响应:")
    for u, b in hits[:12]:
        print(f"--- {u[:100]}")
        print("    ", b[:220].replace("\n", " "))
    # 找含报告列表的 JSON (title/页数 形)
    for u, b in hits:
        if ("页" in b[:5000] or "title" in b[:2000]) and ("[" in b or "{" in b):
            Path("data/harvest/djyanbao_api_sample.json").write_text(
                b[:200000], encoding="utf-8")
            print(f"[api] 样本落盘: {u[:90]} → data/harvest/djyanbao_api_sample.json")
            break
    return 0


if __name__ == "__main__":
    sys.exit(main())
