# -*- coding: utf-8 -*-
"""probe7: .shtm→var base→openapi getPreview 页图清单 全链实测（8s 节流）。"""
import json
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "replica"))
from book118_api import Book118Client, Book118ApiError  # noqa: E402

CAP = HERE.parent / "captures"
c = Book118Client()
out = {}
for url in ["https://max.book118.com/html/2026/0722/5011203143013244.shtm",
            "https://max.book118.com/html/2022/1214/6115103231005025.shtm"]:
    try:
        det = c.doc_detail(url)
        pages = c.preview_pages(det, max_batches=2)
        out[url] = {"detail": det | {"view_token": det["view_token"][:16] + "..."},
                    "page_urls_n": len(pages),
                    "first_url": (list(pages.values())[0][:90] if pages else ""),
                    "page_keys": sorted(pages)[:8]}
        print(url, "->", out[url]["page_urls_n"], "pages;",
              out[url]["first_url"])
    except Book118ApiError as e:
        out[url] = {"error": f"{e.kind}: {e.detail}"[:160]}
        print(url, "ERROR", e)
    time.sleep(8)
out["requests"] = c.requests
(CAP / "probe7_openapi_live.json").write_text(
    json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
print("requests:", c.requests, "→ probe7_openapi_live.json")
